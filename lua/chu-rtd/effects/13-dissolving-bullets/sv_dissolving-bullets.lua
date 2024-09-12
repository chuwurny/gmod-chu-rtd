x.Dependency("chu-rtd/helpers", "sv_bullets.lua")

local effect = chuRtd.Effects:Get("dissolving-bullets")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    target:Dissolve()
end)
