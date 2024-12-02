FROM steamcmd/steamcmd:latest

RUN apt-get update && \
    apt-get install -y libcurl4-gnutls-dev:i386 &&\
    apt-get autoremove --purge -y wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN mkdir -p .klei/DoNotStarveTogether server_dst/mods

# Install Don't Starve Together
RUN steamcmd \
    +@ShutdownOnFailedCommand 1 \
    +@NoPromptForPassword 1 \
    +login anonymous \
    +force_install_dir /root/server_dst \
    +app_update 343050 validate \
    +quit

VOLUME ["/root/.klei/DoNotStarveTogether", "/root/server_dst/mods"]

COPY ["start-container-server.sh", "/root/"]
ENTRYPOINT ["bash", "/root/start-container-server.sh"]
