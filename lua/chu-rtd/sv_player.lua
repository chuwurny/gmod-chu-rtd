x.Dependency("chu-rtd", "sv_rtd.lua")

local PLAYER = FindMetaTable("Player")

PLAYER.Rtd = chuRtd.Roll
PLAYER.TryRtd = chuRtd.TryRoll
PLAYER.StopRtd = chuRtd.Stop
