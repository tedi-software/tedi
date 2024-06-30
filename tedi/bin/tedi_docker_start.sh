#!/usr/bin/env bash
############################################################################
#
# bootstrap tedi docker container
#
############################################################################
#set -e
#set -x

cd $(dirname ${0}) || exit 1

. ./setenv.sh


# make sure docker command exists
command -v docker >/dev/null
if [[ $? -ne 0 ]]
then
    echo "docker command not found"
    exit 1
fi



#--------------------------------------------------------
# wait a bit for the container to startup to see if it exits
#
# docker inspect --format='{{.State.Status}}' tedi
#--------------------------------------------------------
function wait_for_container_startup {
    local l_seconds=1
    local l_max_seconds=30
    local l_return_status=0

    while [[ true ]]
    do
        l_status=$(docker inspect --format='{{.State.Status}}' ${CONTAINER_NAME})

        echo "waiting for container to fully start. status=${l_status}. time=${l_seconds}s"

        if [[ "${l_status}" == "exited" ]]
        then
            echo "the container has exited"
            echo ""
            l_return_status=1
            docker logs ${CONTAINER_NAME}
            echo ""
            echo ""
            break
        fi

        l_seconds=$((l_seconds + 1))

        if [[ ${l_seconds} -gt ${l_max_seconds} ]]
        then
            echo "wait time expired ${l_max_seconds}s. status=${l_status}"
            break
        fi

        sleep 1
    done

    echo ""
    echo "docker ps -a --filter Name=${CONTAINER_NAME}"
    docker ps -a --filter Name=${CONTAINER_NAME}

    if [[ ${l_return_status} -eq 1 ]]
    then
        cleanup
    fi

    return ${l_return_status}
}

#--------------------------------------------------------
# remove the container on startup failure
#--------------------------------------------------------
function cleanup {
    echo ""
    echo "removing container"
    echo "docker rm ${CONTAINER_NAME}"
    docker rm ${CONTAINER_NAME}
    echo ""

    echo "docker ps -a --filter Name=${CONTAINER_NAME}"
    docker ps -a --filter Name=${CONTAINER_NAME}
    echo ""
    echo ""
}



function set_secrets {
    # tedi_mp_20211230_01
    export SYS1=18e4e5649dc6e08427f110e4a2102fca7cbfd65ef254adc2c239e1138204a6a9

    #tedi_mp_20211230_02
    export SYS2=9a79c4adaa49d3a951709cb32f7ba304bb87dba161ef807eb5a9221ca094c0f6

    # tedi_mp_20211230_03
    export SYS3=ec881e560b5a1d83b80da822e91c9449e12c36fd7c8fc1c1003445fa3e72ef87

    # tedi_mp_20220430_0
    export SYS4=eb5591effd7a590cd93c77386f4a8514ba7a9eea5d9d0b4265931d5030deb779

    # tedi_mp_20220430_1
    export SYS5=4c726a8b42d8e26e7498117cae80865538abaca6212077bd9f678f41d5a75322

    export SYS5=38dcc42fdab1ec1b1a77a7ecf59353db9eb6bb96080b76a62c1feeaec8762713
    export SYS6=02b1e76fa5eff95f226655d3aa67df8e0d228c156455e189db5bfd966486e832
}

#--------------------------------------------------------
# start tedi
#-------------------------------------------------------- 
{
    _log "tedi startup"
    _log "environment settings at startup:"
    /usr/bin/env
    echo ""

    purge_logs
    set_secrets

    docker-compose -f ${TEDI_CONF_DIR}/docker-compose.yaml up -d

    l_exit_status=$?
    
    if [[ ${l_exit_status} -ne 0 ]]
    then
        cleanup
    else
        wait_for_container_startup
        l_exit_status=$?
        [[ ${l_exit_status} -ne 0 ]] && cleanup
    fi

    if [[ ${l_exit_status} -eq 0 ]]
    then
        _log "finished tedi startup: success"
    else
        _log "finished tedi startup: failed"
    fi

    _log "exit-status: ${l_exit_status}"

    exit ${l_exit_status}

} 2>&1 | tee -a ${TEDI_START_LOG}

# exit with the subprocess exit code
exit ${PIPESTATUS[0]}