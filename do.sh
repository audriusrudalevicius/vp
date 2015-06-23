#!/bin/bash

CONFIG_INITED="n"
if [ -f "/home/developer/Visual_Paradigm_12.1/bin/Visual_Paradigm" ] ; then
    CONFIG_INITED="y"
fi

if [ ${CONFIG_INITED} = "n" ] ; then
	sh -c '/opt/vp/vp.sh -c'
fi

exec "$@"