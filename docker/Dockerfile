FROM cm2network/steamcmd:root

RUN apt-get update && apt-get install -y gosu wget python3 libfreetype6

ARG APPID=2728330

ENV STEAM_HOME="/home/${USER}" \
    STEAM_USER="${USER}" \
    STEAM_PATH="/home/${USER}/.steam/steam" \
    APPID=$APPID

RUN mkdir -p ${STEAM_PATH}
WORKDIR ${STEAM_PATH}

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
COPY start.sh /start.sh 
RUN chmod +x /start.sh

EXPOSE 7777/udp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
