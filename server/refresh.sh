#!/bin/bash
pkill streamserver.py
nohup ./streamserver.py -s 10.146.27.163 -p liveshooter.cn.mu > /dev/null 2>&1 &
