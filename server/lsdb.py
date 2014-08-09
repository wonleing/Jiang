# -*- coding: utf-8 -*-
DB_type = 'sqlite'

class DB:
    def __init__(self):
        try:
            DB_type == 'mysql'
            import MySQLdb
            self.cx = MySQLdb.connect('localhost', 'live', 'shooter@123', 'liveshooter')
            self.cx.set_character_set('utf8')
        except:
            import sqlite3
            self.cx = sqlite3.connect("./newspicks.db")
        self.cu = self.cx.cursor()

    def __del__(self):
        try:
            self.cx.close()
        except:
            pass

    def query_db(self, query):
        self.cu.execute(query)
        return [dict((self.cu.description[i][0], value) for i, value in enumerate(row)) for row in self.cu.fetchall()]

    def selectUserID(self, loginname, type):
        self.cu.execute("select userid from user where loginname='%s' and type='%s'" %(loginname, type))
        ret = self.cu.fetchall()
        if ret:
            return ret[0][0]
        return False

    def createUser(self, loginname, type, family, given, company, position, description, userimage):
        try:
            self.cu.execute("insert into user (loginname, type, family, given, company, position, description, userimage) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" %(loginname, type, family, given, company, position, description, userimage))
            self.cx.commit()
        except:
            return False
        return self.selectUserID(loginname, type)

    def updateUser(self, userid, family, given, company, position, description, userimage):
        self.cu.execute("update user set family='%s', given='%s', company='%s', position='%s', description='%s', userimage='%s' where userid=%d" %(family, given, company, position, description, userimage, userid))
        self.cx.commit()
        return True

    def addThread(self, userid, title, cateid, content, threadimage, link):
        try:
            self.cu.execute("insert into thread (title, cateid, content, threadimage, link, score) values ('%s', %d, '%s', '%s', '%s', 0)" \
            %(title, cateid, content, threadimage, link))
            self.cx.commit()
            threadid = self.cu.lastrowid
            self.cu.execute("insert into userthread (userid, threadid) values (%d, %d)" %(userid, threadid))
            self.cx.commit()
        except:
            return False
        return threadid

    def likeThread(self, userid, threadid):
        try:
            self.cu.execute("insert into userlike (userid, threadid) values (%d, %d)" %(userid, threadid))
            self.cx.commit()
        except:
            return False
        self.cu.execute("update thread set score=score+1 where threadid=%d" %threadid)
        self.cx.commit()
        return True

    def unlikeThread(self, userid, threadid):
        try:
            self.cu.execute("delete from userlike where userid=%d and threadid=%d" %(userid, threadid))
            self.cx.commit()
        except:
            return False
        self.cu.execute("update thread set score=score-1 where threadid=%d" %threadid)
        self.cx.commit()
        return True

    def followUser(self, userid, targetid):
        try:
            self.cu.execute("insert into followship (userid, following) values (%d, %d)" %(userid, targetid))
            self.cx.commit()
        except:
            return False
        return True

    def unfollowUser(self, userid, targetid):
        self.cu.execute("delete from followship where userid=%d and following=%d" %(userid, targetid))
        self.cx.commit()
        return True

    def getThreadInfo(self, threadid):
        return self.query_db("select v.*, u.* from thread as v, userthread as uv, user as u where uv.threadid=v.threadid and \
        uv.userid=u.userid and v.threadid=%d" %threadid)

    def getUserThread(self, userid):
        return self.query_db("select v.* from thread as v,userthread as uv where uv.threadid=v.threadid and uv.userid=%d \
        order by createdate desc limit 100" %userid)

    def getUserProfile(self, userid):
        return self.query_db("select * from user where userid=%d" %userid)

    def getLikeThread(self, userid):
        return self.query_db("select v.* from thread as v,userlike as ul where ul.threadid=v.threadid and ul.userid=%d \
        order by createdate desc limit 100" %userid)

    def getFollowing(self, userid):
        return self.query_db("select u.* from followship as f, user as u where f.userid=%d and f.following=u.userid" %userid)

    def getFollower(self, userid):
        return self.query_db("select u.* from followship as f, user as u where f.following=%d and f.userid=u.userid" %userid)

    def getRelation(self, userid, targetid):
        self.cu.execute("select count(*) from followship where userid=%d" %targetid)
        following = self.cu.fetchall()[0][0]
        self.cu.execute("select count(*) from followship where following=%d" %targetid)
        follower = self.cu.fetchall()[0][0]
        self.cu.execute("select count(*) from followship where userid=%d and following=%d" %(userid, targetid))
        isfollower = self.cu.fetchall()[0][0]
        return {'following':following, 'follower':follower, 'isfollower':isfollower}

    def getFeed(self, userid):
        #mysql has a bug, cannot order by createdate here
        return self.query_db("select v.*, u.* from thread as v, userlike as ul, user as u, userthread as uv where ul.userid=%d and \
        ul.threadid=v.threadid and uv.threadid=v.threadid and u.userid=uv.userid union \
        select v.*, u.* from thread as v, userthread as uv, user as u where uv.threadid=v.threadid and u.userid=uv.userid and uv.userid in \
        (select following from followship where userid=%d) limit 100" %(userid, userid))

    def getTopUser(self, type):
        if type != '0':
            return self.query_db("select u.*, count(*) from user as u, followship as f where f.following in (select userid from user \
            where type='%s') and u.userid=f.following group by f.following order by count(*) desc" %type)
        else:
            return self.query_db("select u.*, count(*) from user as u, followship as f where u.userid=f.following \
            group by f.following order by count(*) desc")

    def getTopThread(self, date):
        return self.query_db("select v.*, u.* from thread as v, user as u, userthread as uv where v.threadid=uv.threadid and \
        u.userid=uv.userid and v.createdate>'%s' order by v.score desc, v.createdate desc limit 100" %date)

    def getCategory(self):
        return self.query_db("select * from category")

    def getCateName(self, cateid):
        return self.query_db("select catename from category where cateid=%d" %cateid)

    def getCateThreads(self, cateid):
        return self.query_db("select v.*, u.* from thread as v, user as u, userthread as uv where v.threadid=uv.threadid and \
        u.userid=uv.userid and v.cateid=%d order by v.score desc, v.createdate desc limit 100" %cateid)
