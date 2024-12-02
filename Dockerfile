FROM steamcmd/steamcmd:latest

WORKDIR /dst

RUN mkdir -p .klei/DoNotStarveTogether server_dst/mods

# Install Don't Starve Together
RUN steamcmd \
    +@ShutdownOnFailedCommand 1 \
    +@NoPromptForPassword 1 \
    +login anonymous \
    +force_install_dir /dst/server_dst \
    +app_update 343050 validate \
    +quit

VOLUME ["/dst/.klei/DoNotStarveTogether", "/dst/server_dst/mods"]

COPY ["start-container-server.sh", "/dst/"]
ENTRYPOINT ["bash", "/dst/start-container-server.sh"]
