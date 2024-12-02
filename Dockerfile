FROM steamcmd/steamcmd:latest

# Create specific user to run DST server
RUN useradd -ms /bin/bash/ dst
WORKDIR /home/dst

USER dst
RUN mkdir -p .klei/DoNotStarveTogether server_dst/mods

# Install Don't Starve Together
RUN steamcmd \
    +@ShutdownOnFailedCommand 1 \
    +@NoPromptForPassword 1 \
    +login anonymous \
    +force_install_dir /home/dst/server_dst \
    +app_update 343050 validate \
    +quit

VOLUME ["/home/dst/.klei/DoNotStarveTogether", "/home/dst/server_dst/mods"]

COPY ["start-container-server.sh", "/home/dst/"]
ENTRYPOINT ["/home/dst/start-container-server.sh"]
