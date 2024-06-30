#!/usr/bin/env bash
###############################################################################
#
# start tedi running as a plain binary
#
#
###############################################################################
# set -e
# set -x

cd $(dirname ${0}) || exit 1

. ./setenv.sh

l_cmd="./tedi"



#--------------------------------------------------------
# set system aes keys via enironment variables
#--------------------------------------------------------
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

    # tedi_mp_20211230_05
    export SYS6=38dcc42fdab1ec1b1a77a7ecf59353db9eb6bb96080b76a62c1feeaec8762713

    # tedi_mp_20211230_06
    export SYS7=02b1e76fa5eff95f226655d3aa67df8e0d228c156455e189db5bfd966486e832

    # or read from stdin
    #
    # eval ${l_cmd} <<eof
    # tedi_mp_20211230_01=18e4e5649dc6e08427f110e4a2102fca7cbfd65ef254adc2c239e1138204a6a9;
    # tedi_mp_20211230_02=9a79c4adaa49d3a951709cb32f7ba304bb87dba161ef807eb5a9221ca094c0f6;
    # tedi_mp_20211230_03=ec881e560b5a1d83b80da822e91c9449e12c36fd7c8fc1c1003445fa3e72ef87;
    # tedi_mp_20220430_0=eb5591effd7a590cd93c77386f4a8514ba7a9eea5d9d0b4265931d5030deb779;
    # tedi_mp_20220430_1=4c726a8b42d8e26e7498117cae80865538abaca6212077bd9f678f41d5a75322;
    # eof
}


#--------------------------------------------------------
# start tedi
#-------------------------------------------------------- 
{
    _log "tedi startup"

    if [[ -e ${TEDI_PID} ]]
    then
        echo "existing pid exists: $(<${TEDI_PID})"
        echo "is TEDI already running "?
        exit 1
    fi

    purge_logs
    set_secrets

    _log "environment settings:"
    /usr/bin/env
    echo ""

    ${l_cmd} &
    l_exit=$?

    l_pid=$!
    echo "${l_pid}" > ${TEDI_PID}

    _log "finished tedi startup"
    _log "exit status: ${l_exit}"

    exit ${l_exit}
     
} 2>&1 | tee -a ${TEDI_START_LOG}

# exit with the subprocess exit code
exit ${PIPESTATUS[0]}
