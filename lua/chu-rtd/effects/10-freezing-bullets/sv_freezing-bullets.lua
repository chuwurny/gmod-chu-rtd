x.Dependency("chu-rtd/helpers", "sv_bullets.lua")

x.Dependency("chu-rtd/effects/20-freeze")

local freezeEffect = chuRtd.Effects:Get("freeze")

local effect = chuRtd.Effects:Get("freezing-bullets")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    if not target._rtd_freezeData then
        target._rtd_freezeData = {}

        freezeEffect:OnRolled(target, target._rtd_freezeData)
    else
        -- don't pass real data, because it will override old material
        freezeEffect:OnRolled(target, {})
    end

    timer.Create("rtd freezing bullets unfreeze " .. target:UserID(), 0.5, 1, function()
        if not IsValid(target) then return end

        freezeEffect:OnEnded(target, target._rtd_freezeData)

        target._rtd_freezeData = nil
    end)
end)
