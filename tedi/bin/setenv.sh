#!/usr/bin/env bash
###############################################################################
#
#
#
#
###############################################################################
# set -e
# set -x


# docker image
export IMAGE="tedi-software/tedi:1.0.0"

# the running container name
export CONTAINER_NAME="tedi"

# match the container user:group to the host so the container has permissions to access files and directories
export USERID=$(id -u)
export GID=$(id -g)

# common files & directories
export TEDI_BASE_DIR="/opt/tedi"
export TEDI_BIN_DIR="${TEDI_BASE_DIR}/bin"
export TEDI_CONF_DIR="${TEDI_BASE_DIR}/conf"
export TEDI_TMP_DIR="${TEDI_BASE_DIR}/tmp"
export TEDI_LOG_DIR="${TEDI_BASE_DIR}/logs"
export TEDI_PID="${TEDI_BIN_DIR}/tedi.pid"

l_start_log_prefix="start_tedi"
export TEDI_START_LOG="${TEDI_LOG_DIR}/${l_start_log_prefix}_$(/bin/date +'%Y%m%d').log"

# make sure the log exists
touch ${TEDI_START_LOG}


#--------------------------------------------------------
# desc: prefixes date/time to given input and echoes it
#
# params:
#  1) in: a message to write to the log thru standard out
#  2) out: none
#--------------------------------------------------------
function _log {
    echo "$(/bin/date +'%m-%d-%y %r') ${*}"
}

#--------------------------------------------------------
# purge logs > 7days
#--------------------------------------------------------
function purge_logs {
    _log "purging logs"

    for f in $(find ${TEDI_LOG_DIR} -type f -name "${l_start_log_prefix}_*.log" -mtime +7)
    do
       _log "purging $f"
       rm -f $f
    done
}
