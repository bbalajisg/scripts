#!/bin/sh
#
# nogginpostgres95 <nogginpostgres95>
#
# chkconfig: 2345 96 2
# description: nogginpostgres95
#
#
# Startup script for the Noggin dbs
#
# Starts the noggin dbs
#
# processname:nogginpostgres95
#
. /etc/rc.d/init.d/functions

cd /home/dev-env/bala/docker/compose

exec /usr/local/bin/docker-compose -f postgres95.yml up -d