#!/bin/bash
pkill streamserver.py
nohup ./streamserver.py -s 127.0.0.1 > /dev/null 2>&1 &
pkill index.py
nohup ./index.py > /dev/null 2>&1 &
