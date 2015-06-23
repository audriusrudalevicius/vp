#!/bin/bash
if [ -f ./.instance ] ; then
    eval docker start $(cat ./.instance)
else
	docker build -t vp .
	docker run -i -e DISPLAY -v $HOME/Documents:/home/developer/Documents -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/developer/.Xauthority --net=host vp
	docker ps -l | grep 'vp:latest' | awk '/^[0-9a-f]/{print $1}' > ./.instance
fi
