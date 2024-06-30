
#!/usr/bin/env bash
############################################################################
#
# shutdown tedi running in a docker container and remove the container
#
############################################################################
#set -x

cd $(dirname ${0}) || exit 1

. ./setenv.sh

{
    _log "stopping tedi"

    docker-compose -f ${TEDI_CONF_DIR}/docker-compose.yaml down

    _log "finished stopping tedi"

} 2>&1 | tee -a ${TEDI_START_LOG}