#!/usr/bin/python
# -*- coding: utf-8 -*-
from SimpleXMLRPCServer import SimpleXMLRPCServer
import os, sys, string, optparse, logging, lsdb, json, datetime, urllib2

u = """./%prog -s <internal_ip> -p <public_dns>\nDebug: ./%prog -s 127.0.0.1"""
parser = optparse.OptionParser(u)
parser.add_option('-s', '--server', help='stream server internal ip address', dest='serverip')
parser.add_option('-p', '--public', help='public DNS', dest='publicdns')
(options, leftargs) = parser.parse_args()
if options.serverip == None:
    parser.print_help()
    sys.exit()
if options.publicdns == None:
    options.publicdns = options.serverip
print "Starting service on", options.serverip, "with public address:", options.publicdns
server = SimpleXMLRPCServer((options.serverip, 8000))
server.register_introspection_functions()

refresh_days = 100
perpage = 5
logfile = "/var/log/newspicks"
logger = logging.getLogger('Newspicks')
hdlr = logging.FileHandler(logfile)
formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
hdlr.setFormatter(formatter)
logger.addHandler(hdlr)
logger.setLevel(logging.INFO)

class TimeEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.isoformat()
        return json.JSONEncoder.default(self, obj)

class StreamServer:
    def loginUser(self, loginname, type, family="", given="", company="", position="", description="", userimage=""):
        db = lsdb.DB()
        ret = db.selectUserID(loginname, type)
        if not ret:
            ret = db.createUser(loginname, type, family, given, company, position, description, userimage)
            logger.info("User %s at %s is 1st time of using our app, created userid %d" %(loginname, type, ret))
        else:
            db.updateUser(ret, family, given, company, position, description, userimage)
            logger.info("User %s at %s already has userid %d, updated its nickname and icon" %(loginname, type, ret))
        return ret

    def addThread(self, userid, title, cateid, content="", threadimage="", link=""):
        logger.info("user %s create new thread %s" %(userid, title))
        db = lsdb.DB()
        return db.addThread(int(userid), title, int(cateid), content, threadimage, link)

    def likeThread(self, userid, threadid):
        logger.info("user %s like thread %s, try add feed and score" % (userid, threadid))
        db = lsdb.DB()
        return db.likeThread(int(userid), int(threadid))

    def unlikeThread(self, userid, threadid):
        logger.info("user %s unlike thread %s, remove feed and score" % (userid, threadid))
        db = lsdb.DB()
        return db.unlikeThread(int(userid), int(threadid))

    def followUser(self, userid, targetid):
        if userid == targetid:
            logger.warning("invalid operation - %s follow himself" %userid)
            return False
        logger.info("user %s followed user %s" %(userid, targetid))
        db = lsdb.DB()
        return db.followUser(int(userid), int(targetid))

    def followThread(self, userid, threadid):
        logger.info("user %s followed the owner of thread %s" %(userid, threadid))
        db = lsdb.DB()
        targetid = db.getThreadInfo(int(threadid))[0]['userid']
        if userid == targetid:
            logger.warning("invalid operation - %s follow himself" %userid)
            return False
        return db.followUser(int(userid), int(targetid))

    def unfollowUser(self, userid, targetid):
        logger.info("user %s unfollowed user %s" %(userid, targetid))
        db = lsdb.DB()
        return db.unfollowUser(int(userid), int(targetid))

    def unfollowThread(self, userid, threadid):
        logger.info("user %s unfollowed the owner of thread %s" %(userid, threadid))
        db = lsdb.DB()
        targetid = db.getThreadInfo(int(threadid))[0]['userid']
        if targetid:
            return db.unfollowUser(int(userid), int(targetid))

    def getFollowing(self, userid, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logger.debug("get user %s following list" %userid)
        db = lsdb.DB()
        ret = db.getFollowing(int(userid))[start:end]
        if nojson:
            return ret
        return json.dumps(ret)

    def getFollower(self, userid, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logger.debug("get user %s follower list" %userid)
        db = lsdb.DB()
        ret = db.getFollower(int(userid))[start:end]
        if nojson:
            return ret
        return json.dumps(ret)

    def getRelation(self, userid, targetid, nojson=False):
        logger.debug("get relationship between user %s and user %s" %(userid, targetid))
        db = lsdb.DB()
        ret = db.getRelation(int(userid), int(targetid))
        if nojson:
            return ret
        return json.dumps(ret)

    def getUserProfile(self, targetid, nojson=False):
        logger.debug("retrieving user %s's profile" %targetid)
        db = lsdb.DB()
        ret = db.getUserProfile(int(targetid))
        if nojson:
            return ret
        return json.dumps(ret)

    def getUserThread(self, userid, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logger.debug("retrieving user %s's thread list" %userid)
        db = lsdb.DB()
        ret = db.getUserThread(int(userid))[start:end]
        if nojson:
            return ret
        return json.dumps(ret, cls=TimeEncoder)

    def getLikeThread(self, userid, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logge.debug("return like list of user %s" %userid)
        db = lsdb.DB()
        fl = db.getLikeThread(int(userid))[start:end]
        if nojson:
            return fl
        return json.dumps(fl, cls=TimeEncoder)

    def getThreadInfo(self, threadid, nojson=False):
        logger.debug("return thread info for thread %s" %threadid)
        db = lsdb.DB()
        vi = db.getThreadInfo(int(threadid))
        if nojson:
            return vi
        return json.dumps(vi, cls=TimeEncoder)

    def getFeed(self, userid, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logger.debug("return feed list of user %s" %userid)
        db = lsdb.DB()
        fl = db.getFeed(int(userid))[start:end]
        if nojson:
            return fl
        return json.dumps(fl, cls=TimeEncoder)

    def getRecommandUser(self, type="", perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logger.debug("return top users")
        db = lsdb.DB()
        ru = db.getTopUser(type)[start:end]
        if nojson:
            return ru
        return json.dumps(ru)

    def getRecommandThread(self, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        logger.debug("return top 100 thread of this week")
        d = datetime.timedelta(days=refresh_days)
        db = lsdb.DB()
        ret = db.getTopThread(datetime.date.today()-d)[start:end]
        if nojson:
            return ret
        return json.dumps(ret, cls=TimeEncoder)

    def getCategory(self, nojson=False):
        db = lsdb.DB()
        ret = db.getCategory()
        if nojson:
            return ret
        return json.dumps(ret)

    def getCateName(self, cateid):
        db = lsdb.DB()
        return db.getCateName(int(cateid))

    def getCateThreads(self, cateid, perpage=perpage, pagenum=1, nojson=False):
        end = int(perpage)*int(pagenum)
        start = end - int(perpage)
        db = lsdb.DB()
        ret = db.getCateThreads(int(cateid))[start:end]
        if nojson:
            return ret
        return json.dumps(ret)

# Run the server's main loop
server.register_instance(StreamServer())
server.serve_forever()
