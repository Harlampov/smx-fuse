#!/bin/sh

### BEGIN INIT INFO
# Provides:          smx-fuse
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: FUSE ESB - Apache ServiceMix
# Description:       FUSE ESB - Apache ServiceMix
### END INIT INFO

# System binaries
SU=/bin/su
TOUCH=/bin/touch

NAME=$( basename -- $0 )
DESC="Apache ServiceMix"

SMX_ROOT=/usr/share/apache-servicemix
SMX_USER=smx-fuse

START_DAEMON=${SMX_ROOT}/bin/start
STOP_DAEMON=${SMX_ROOT}/bin/stop

LOCK_FILE=/var/run/${NAME}.lock

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

do_start()
{
    echo "Starting ${NAME}: ${DESC}"
    
    if [ -f "${LOCK_FILE}" ];
    then
	echo "Lock file exists - ${DESC} is running already?"
	exit 1
    else
	${SU} ${SMX_USER} -c ${START_DAEMON}
	${TOUCH} ${LOCK_FILE}
    fi
}

do_stop()
{
    echo "Stopping ${NAME}: ${DESC}"
    ${SU} ${SMX_USER} -c ${STOP_DAEMON}
    rm -f ${LOCK_FILE}
}

do_restart()
{
    do_stop
    do_start
}

case "$1" in

	start)
		do_start
		;;
	stop)
		do_stop
		;;
	restart)
		do_restart
		;;
	*)
		echo "Usage: ${NAME} {start|stop|restart}"
		exit 1
		;;

esac

exit 0

