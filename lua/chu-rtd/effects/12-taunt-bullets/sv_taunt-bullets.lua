x.Dependency("chu-rtd/effects/28-force-taunt")

local forceTauntEffect = chuRtd.Effects:Get("force-tanut")

local effect = chuRtd.Effects:Get("taunt-bullets")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    forceTauntEffect:OnTick(target)
end)
