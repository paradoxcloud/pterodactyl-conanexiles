FROM        ubuntu:16.04

MAINTAINER  paradox.cloud, <support@paradox.network>
ENV         DEBIAN_FRONTEND noninteractive

RUN         apt-get update \
            && apt-get upgrade -y \
            && apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' -y \
            && apt-get install -y --install-recommends xvfb winehq-stable\
            && update-ca-certificates \
            && useradd -m -d /home/container container


software-properties-common
USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
