#!/bin/bash

# linux=wrap and mac=break
case `uname` in
  Darwin) export l_wrap="break"
    ;;
  *) export l_wrap="wrap"
    ;;
esac

l_key_id=tedi:tedi-nprod-20201211
l_key=tedi


# inputs that vary
l_data_file=/Users/tedi/lbin/tedi.symmetric.key
l_req_url=/sqlintest/admin/reload
l_method_nm=get
l_method_nm_u=GET
l_env_id=ps
l_discard=no
l_simerr=no
l_verno=1
l_accept="application/xml"
l_ctype="application/xml"


# make sure request-id is unique each time
l_ymd=$(/bin/date "+%Y%m%d")
l_req_id="gsit-${l_ymd}-${RANDOM}"

# define the target host
l_host_port="localhost:8443"
 
# get gmt date as of now
l_gmt_dt=$(export TZ=GMT ; /bin/date "+%a, %d %b %Y %T %Z")

# use this to test a future date
[[ "$1" == "future" ]] && l_gmt_dt=$(export TZ=GMT ; /bin/date -v+30M "+%a, %d %b %Y %T %Z")

# use this to test an expired date
[[ "$1" == "past" ]] && l_gmt_dt=$(export TZ=GMT ; /bin/date -v-30M "+%a, %d %b %Y %T %Z")


# compute sha256 digest of input data
l_data_digest64=$(cat ${l_data_file} | openssl dgst -binary -sha256 | base64 --${l_wrap}=0)

# Create the Signing string from the required headers
l_string="(request-target): post ${l_req_url}
date: ${l_gmt_dt}
digest: sha-256=${l_data_digest64}"

echo "raw signing string: ${l_string}"
 
# Sign the string, base64
l_base64_sig=$(echo -n "${l_string}" | openssl dgst -binary -sha256 -hmac "${l_key}" | base64 --${l_wrap}=0)
 
# Signing string sent for debug purposes
l_base64_str=$(echo -n "${l_string}" | base64 --${l_wrap}=0)

l_threads=1
l_requests=1
# -v 9
ab -v 2 \
    -c ${l_threads}                                         \
    -n ${l_requests}                                        \
    -k                                                      \
    -f tls1.2                                               \
    -p ${l_data_file}                                       \
    -T ${l_ctype}                                           \
    -H "Accept:              ${l_accept}"                   \
    -H "Digest:              sha-256=${l_data_digest64}"    \
    -H "X-Signing-String:    ${l_base64_str}"               \
    -H "Date:                ${l_gmt_dt}"                   \
    -H "x-correlation-id:    tedi"                          \
    -H "Authorization: Signature keyId=\"${l_key_id}\",algorithm=\"hmac-sha256\",headers=\"(request-target) date digest\",signature=\"${l_base64_sig}\""    \
    https://${l_host_port}${l_req_url}

exit $?
