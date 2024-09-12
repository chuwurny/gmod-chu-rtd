x.Dependency("chu-rtd/helpers", "sv_bullets.lua")

local effect = chuRtd.Effects:Get("freezing-bullets")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    target:EmitSound("Canals.d1_canals_01a_wood_strain3")
    target:Freeze(true)

    target:ScreenFade(SCREENFADE.IN, x.ColorBlue, 1, 0)

    target._rtd_oMaterial = target._rtd_oMaterial or target:GetMaterial()
    target:SetMaterial("debug/env_cubemap_model")

    timer.Create("rtd freezing bullets unfreeze " .. target:UserID(), 0.5, 1, function()
        if not IsValid(target) then return end

        target:EmitSound("Canals.d1_canals_01a_wood_strain4")
        target:Freeze(false)

        target:SetMaterial(target._rtd_oMaterial)
        target._rtd_oMaterial = nil
    end)
end)
