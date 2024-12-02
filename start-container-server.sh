#!/bin/bash

# Check for game updates before each start. If the game client updates and your server is out of date, you won't be
# able to see it on the server list. If that happens just restart the containers and you should get the latest version
steamcmd +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir /dst/server_dst +app_update 343050 validate +quit

# Copy dedicated_server_mods_setup.lua
ds_mods_setup="/dst/.klei/DoNotStarveTogether/DSTWhalesCluster/mods/dedicated_server_mods_setup.lua"
if [ -f "$ds_mods_setup" ]
then
  cp $ds_mods_setup "/dst/server_dst/mods/"
fi

# Copy modoverrides.lua
modoverrides="/dst/.klei/DoNotStarveTogether/DSTWhalesCluster/mods/modoverrides.lua"
if [ -f "$modoverrides" ]
then
  cp $modoverrides "/dst/.klei/DoNotStarveTogether/DSTWhalesCluster/Master/"
  cp $modoverrides "/dst/.klei/DoNotStarveTogether/DSTWhalesCluster/Caves/"
fi

cd /dst/server_dst/bin
./dontstarve_dedicated_server_nullrenderer -cluster DSTWhalesCluster -shard "$SHARD_NAME"
