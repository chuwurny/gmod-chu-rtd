x.Dependency("chu-rtd", "sv_rtd.lua")

local PLAYER = FindMetaTable("Player")

PLAYER.Rtd = chuRtd.Roll
PLAYER.RtdRandom = chuRtd.RollRandom
PLAYER.TryRtd = chuRtd.TryRoll
PLAYER.TryRtdRandom = chuRtd.TryRollRandom
PLAYER.StopRtd = chuRtd.Stop
