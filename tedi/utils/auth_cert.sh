#!/usr/bin/env bash

l_client_cert=/opt/tedi/keys/simplehttp.pem
l_client_key=/opt/tedi/keys/simplehttp.key
l_client_ca=/opt/tedi/keys/outside.company.com.pem
l_url=https://localhost:8443/sqlintest/admin/reload

l_ymd=$(/bin/date "+%Y%m%d")
l_xcorid="tedi-${l_ymd}-${RANDOM}"
l_verb="-X POST"


curl -v -k                                   \
        --cert ${l_client_cert}              \
        --key ${l_client_key}                \
        --cacert ${l_client_ca}              \
        -H "x-correlation-id:${l_xcorid}"    \
        ${l_verb}                            \
        ${l_url}
