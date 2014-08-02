# -*- coding:utf-8 -*-
import cherrypy, xmlrpclib, json
apis = ["loginUser", "addThread", "likeThread", "unlikeThread", "followUser", "followThread", "unfollowUser", "unfollowThread", "getFollowing", "getFollower", "getUserProfile", "getUserThread", "getLikeThread", "getThreadInfo", "getFeed", "getRecommandUser", "getRecommandThread", "getCategory", "getCateName", "getCateThreads", "getRelation"]
s = xmlrpclib.ServerProxy("http://localhost:8000")

def wrapper(func, args):
    ret = {}
    ret['data'] = eval(str(func(*args)))
    if ret['data']:
        ret['status'] = 1
        ret['message'] = 'ok'
    else:
        ret['status'] = -1
        if ret['data'] == False:
            ret['message'] = "operation failed"
        if ret['data'] == [] or ret['data'] == {}:
            ret['message'] = "record not found"
        else:
            "undefined error"
    return json.dumps(ret)

class Root(object):
    def index(self):
        return "try newspicks"
    index.exposed = True

    def newspicks(self, *data):
        if data[0] not in apis:
            return "API %s doesn't exist" %data[0]
        return wrapper(eval("s."+data[0]), data[1:])
    newspicks.exposed = True

    def post(self):
        cl = cherrypy.request.headers['Content-Length']
        rawbody = cherrypy.request.body.read(int(cl))
        body = json.loads(rawbody)
        data = []
        for v in ['userid', 'title', 'cateid', 'content', 'threadimage', 'link']:
            if v not in body.keys():
                body[v] = ""
            data.append(body[v])
        return wrapper(s.addThread, data)
    post.exposed = True

cherrypy.config.update('cherrypy.conf')
cherrypy.quickstart(Root())
