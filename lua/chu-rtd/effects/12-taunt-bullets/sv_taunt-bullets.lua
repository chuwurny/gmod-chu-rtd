x.Dependency("chu-rtd/effects/28-force-taunt")

local forceTauntEffect = chuRtd.Effects:Get("force-tanut")

local effect = chuRtd.Effects:Get("taunt-bullets")

function effect:CanRoll()
    -- FIXME: FCVAR_SERVER_CAN_EXECUTE prevented server running command: act (x6)
    return false
end

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    forceTauntEffect:OnTick(target)
end)
