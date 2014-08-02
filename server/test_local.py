#!/usr/bin/python
# -*- coding: utf-8 -*-
import xmlrpclib, os
IP = "127.0.0.1"
loginname = "cacino@facebook.com"
type = loginname.split('@')[1].split('.')[0]
family = "Swifter"
given = "Talor"
company = "Rock"
position = "singer"
description = "The best American country singer"
userimage = "http://tp4.sinaimg.cn/1293220651/180/0"
title = "Music top20"
cateid = 1
content = "HITFM Top 20 Countdown content"
threadimage = "http://pic2.qiyipic.com/image/20140724/bc/86/v_107585230_m_601_128_128.jpg"
link = "http://ww3.sinaimg.cn/bmiddle/66107c33jw1eiqgd0rjuej20dw15ojxy.jpg"
s=xmlrpclib.ServerProxy("http://%s:8000" %IP)

userid = s.loginUser(loginname, type, family, given, company, position, description, userimage)
print "create user:", userid

threadid = s.addThread(userid, title, cateid, content, threadimage, link)
if threadid:
    print "add new thread, tiltle is %s, threadid is %d" %(title, threadid)
else:
    print "Error: add new thread failed"

if s.likeThread(1, threadid):
    print "user 1 liked thread", str(threadid)

if s.followUser(1, 2) and s.followUser(2, 1):
    print "user 1 followed 2, and 2 followed 1"

ul = s.getFollowing(1)
print "user 1 following these users:", str(ul)

if s.followThread(2, threadid):
    print "2 followed the owner of %d" %threadid

ul = s.getFollower(1)
print "user 1 is followed by these users:", str(ul)

ru = s.getRecommandUser()
print "recommad user list is", str(ru)

rv = s.getRecommandThread()
print "recommad thread list is", str(rv)

if s.unfollowUser(1, 2):
    print "user 3 unfollowed 2"

if s.unfollowThread(2, threadid):
    print "1 unfollowed the owner of %d" %threadid

up = s.getUserProfile(userid)
print "retrieved user", userid, "profile", str(up)

vl = s.getUserThread(userid)
print "user", userid, "has uploaded following thread", str(vl)

vl = s.getFeed(2)
print "user 2 feed list is:", str(vl)

if s.unlikeThread(1, threadid):
    print "user 1 unliked thread %d" %threadid

ll = s.getLikeThread(userid)
print "user", userid, "thread like list is:", str(ll)

vi = s.getThreadInfo(threadid)
print "thread", str(threadid), "info is:", str(vi)

print "API testing finished!"
