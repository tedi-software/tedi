#!/usr/bin/env bash
############################################################################
# 
#  simple utility to generate a JWT (JWS)
#  and make an HTTP request using it as a Bearer token
#
############################################################################
# set -x


# supported alg types
declare -A l_algo_types
l_algo_types["HS256"]="-sha256"
l_algo_types["HS384"]="-sha384"
l_algo_types["HS512"]="-sha512"
l_algo_types["RS256"]="-sha256"
l_algo_types["RS384"]="-sha384"
l_algo_types["RS512"]="-sha512"

l_uuid=$(uuidgen)
l_gmt_dt=$(export TZ=GMT ; /bin/date "+%a, %d %b %Y %T %Z")
l_jwt=""
l_signature=""

l_base64_remove_padding=true
l_create_jwt_and_exit=false

# jwt expiration
printf -v l_expires '%(%s)T\n' -1
l_expires=$((l_expires+120))

# algorithm / sign type: HS256 or RS256
l_algo_type=RS256

# HMAC secret (plain text)
l_hmac_key=middleages

# RSA private key (assumed to be pem) - slurped from disk
# bigdog
l_signing_key="/opt/tedi/keys/key_20220423.key"
l_pub_key="/opt/tedi/keys/key_20220423.pub"


# JWT kid
l_kid=tedi:tedi-nprod-20220709-pub-key
# l_kid=tedi:tedi-nprod-20220709


#
#
# 
function base64URLEncode() {
    local b64="$(echo -n "${*}" | xxd -r -p - | base64)"    
    b64=${b64//\+/\-}
    b64=${b64//\//_}

    [[ ${l_base64_remove_padding} == "true" ]] && b64=${b64//\=/}

    echo ${b64}
}


function sign() {
    local s=""
    local type="${l_algo_type:0:2}"
    local digest=${l_algo_types[${l_algo_type}]}
    
    if [[ "${type}" == "HS" ]]; then
        s="$(echo -n ${1} | openssl dgst ${digest} -hmac ${l_hmac_key} -hex)"
    fi
    
    if [[ "${type}" == "RS" ]]; then
        s="$(echo -n ${1} | openssl dgst -sign ${l_signing_key} -keyform PEM ${digest} -hex)"
    fi

    if [[ -z "${s}" ]]
    then
        echo "unsupported alg: ${l_algo_type}"
        exit 1
    fi

    base64URLEncode "${s}"
}

#--------------------
# by kid alone
#--------------------
# read -r -d '' l_header <<END
# {
#     "alg":"${l_algo_type}",
#     "typ":"JWT",
#     "kid":"${l_kid}"
# }
# END

#--------------------
# jwk
#--------------------
read -r -d '' l_header <<END
{
    "typ":"JWT",
    "jwk": {
        "alg":"${l_algo_type}",
        "kid":"${l_kid}"
    }
}
END

#--------------------
# jwk sets
#--------------------
# read -r -d '' l_header <<END
# {
#     "typ":"JWT",
#     "keys": [
#         {
#             "alg":"HS256",
#             "kid":"${l_kid}"
#         }
#     ]
# }
# END
l_header="$(echo "${l_header}" | xxd -p -)"

read -r -d '' l_body <<END
{
    "iss":"tedi",
    "aud":"tedi",
    "sub":"tedi",
    "exp":"${l_expires}",
    "nbf":"",
    "iad":"${l_gmt_dt}",
    "jti":"${l_uuid}",
    "fluffy":"bunny"
}
END
l_body="$(echo "${l_body}" | xxd -p -)"


l_header="$(base64URLEncode ${l_header})"
l_body="$(base64URLEncode ${l_body})"
l_signing_string=${l_header}.${l_body}
l_signature=$(sign ${l_signing_string})
l_jwt=${l_signing_string}.${l_signature}

echo "generated jwt:"
echo ${l_jwt}
echo ""

if [[ ${l_create_jwt_and_exit} == "true" ]]; then
    exit 0
fi


# HTTP inputs
l_host_port="localhost:8443"
#l_req_url=/sqlintest/admin/reload
l_req_url=/httpintest/invoice/inquiry/100?x=100
l_accept="application/xml"
l_ctype="application/xml"

l_threads=1
l_requests=1
    

ab -v 2 \
    -m GET \
    -c ${l_threads}                                         \
    -n ${l_requests}                                        \
    -k                                                      \
    -f tls1.2                                               \
    -T ${l_ctype}                                           \
    -H "Accept:              ${l_accept}"                   \
    -H "Date:                ${l_gmt_dt}"                   \
    -H "x-correlation-id:    ${l_uuid}"                     \
    -H "x-request-id:        ${l_uuid}"                     \
    -H "Authorization: Bearer ${l_jwt}"                     \
    https://${l_host_port}${l_req_url}

exit $?
