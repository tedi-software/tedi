#!/usr/bin/env bash
# *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
#
# utility to perform pgp (gpg2) file encryption and decryption
#
# the script is called from TEDI for pgp services
# *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
#set -x

cd $(dirname ${0}) || exit 1

export PATH=/bin:/sbin:/usr/bin:/usr/local/bin

l_cmd=$(command -v gpg)

if [[ -z "${l_cmd}" ]]
then 
     echo "cannot find gpg program"
     exit 1
fi

l_args="${*}"


# --------------------------------------------
# uncomment for unit test
# --------------------------------------------
# l_args="--always-trust"
# l_args="${l_args} --batch"
# l_args="${l_args} --no-greeting"
# l_args="${l_args} --no-secmem-warning"
# l_args="${l_args} --pinentry-mode loopback"
# l_args="${l_args} --yes"
# l_args="${l_args} --armor"
# l_args="${l_args} --recipient tedi"
# l_args="${l_args} --verbose"
# l_args="${l_args} --textmode"
# l_args="${l_args} --passphrase-fd 0"
# l_args="${l_args} --local-user tedi"
# l_args="${l_args} --encrypt"
# l_args="${l_args} --sign"
# l_args="${l_args} --output /tmp/message.json.pgp"
# l_args="${l_args} /tmp/message.json"

# prompt user for password 
read -s -u 0 -p "enter keystore passphrase: " l_passphrase
if [[ -z "${l_passphrase}" ]]
then
    echo "empty passphrase"
    exit 1
fi
echo ""

eval ${l_cmd} ${l_args} <<eof
${l_passphrase}
eof

l_estatus=$?

exit ${l_estatus}