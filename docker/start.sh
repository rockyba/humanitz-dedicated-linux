#!/bin/bash

die() {
    echo "$0 script failed, hanging forever..."
    while [ 1 ]; do sleep 10;done
    # exit 1
}

if [ "$(id -u)" != "1000" ];then
    echo "script must run as steam"
    die
fi

steamcmd=${STEAM_HOME}/steamcmd/steamcmd.sh

ACTUAL_PORT=7777
if [ "${PORT}" != "" ];then
    ACTUAL_PORT=${PORT}
fi

if [ "${SERVER_NAME}" != "" ];then
    ARGS="${ARGS} -SteamServerName=${SERVER_NAME}"
fi
if [ "${PLAYERS}" != "" ];then
    ARGS="${ARGS} -MaxPlayers=${PLAYERS}"
fi
ARGS="${ARGS} -Port=${ACTUAL_PORT} -QueryPort=27015"

if [ "${SERVER_PASSWORD}" != "" ];then
    ARGS="${ARGS} -PSW=${SERVER_PASSWORD}"
fi

HumanitZServerDir=/app/Humanitz_Dedicated_Server

mkdir -p ${HumanitZServerDir}
DirPerm=$(stat -c "%u:%g:%a" ${HumanitZServerDir})
if [ "${DirPerm}" != "1000:1000:755" ];then
    echo "${HumanitZServerDir} has unexpected permission ${DirPerm} != 1000:1000:755"
    die
fi

set -x
$steamcmd +force_install_dir ${HumanitZServerDir} +login anonymous +app_update ${APPID} -beta linuxbranch validate +quit || die
set +x

HumanitZServerExe="${HumanitZServerDir}/TSSGameServer.sh"

echo "starting server with: ${CMD}"
exec ${HumanitZServerExe} ${ARGS}
