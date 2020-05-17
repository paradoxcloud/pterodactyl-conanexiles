FROM        ubuntu:16.04

MAINTAINER  paradox.cloud, <support@paradox.network>
ENV         DEBIAN_FRONTEND noninteractive

RUN         apt-get update \
            && apt-get upgrade -y \
            && dpkg --add-architecture i386 \
            && apt-get install -y lib32gcc1 software-properties-common ca-certificates apt-transport-https wget \
            && wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add \
            && apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' -y \
            && update-ca-certificates \
            && apt-get update \
            && apt-get install -y --install-recommends xvfb winehq-stable\
            && useradd -m -d /home/container container

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
