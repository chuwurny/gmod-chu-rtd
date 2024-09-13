local effect = chuRtd.Effects:Get("force-taunt")

local TAUNTS = {
    "dance",
    "muscle",
    "wave",
    "salute",
    "bow",
    "laugh",
    "pers",
    "cheer",
    "agree",
    "disagree",
    "zombie",
    "robot",
    "halt",
    "group",
    "forward",
    "becon",
}

function effect:OnTick(ply)
    if not ply:IsPlayingTaunt() and ply:TimeoutAction("rtd force taunt", 0.1) then
        ply:ConCommand("act " .. TAUNTS[math.random(#TAUNTS)])
    end
end
