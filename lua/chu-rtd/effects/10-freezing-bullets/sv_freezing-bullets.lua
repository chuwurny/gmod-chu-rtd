x.Dependency("chu-rtd/helpers", "sv_bullets.lua")

x.Dependency("chu-rtd/effects/20-freeze")

local freezeEffect = chuRtd.Effects:Get("freeze")

local effect = chuRtd.Effects:Get("freezing-bullets")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    if not target._rtd_freezeContext then
        target._rtd_freezeContext = chuRtd.FakeEffectContext(target)

        freezeEffect:OnRolled(target._rtd_freezeContext)
    else
        -- don't pass real data, because it will override old material
        freezeEffect:OnRolled(chuRtd.TempEffectContext(target))
    end

    timer.Create("rtd freezing bullets unfreeze " .. target:UserID(), 0.5, 1, function()
        if not IsValid(target) then return end

        freezeEffect:OnEnded(target._rtd_freezeContext)

        target._rtd_freezeContext = nil
    end)
end)
