local effect = chuRtd.Effects:Get("force-taunt")

function effect:CanRoll()
    -- FIXME: FCVAR_SERVER_CAN_EXECUTE prevented server running command: act (x6)
    return false
end

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

function effect:OnTick(context)
    if
        not context.Player:IsPlayingTaunt() and
        context.Player:TimeoutAction("rtd force taunt", 0.1)
    then
        context.Player:ConCommand("act " .. TAUNTS[math.random(#TAUNTS)])
    end
end
