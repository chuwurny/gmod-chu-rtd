local effect = chuRtd.Effect("head-roll", chuRtd.TYPE_EVIL)

if CLIENT then
    effect:HookLocalPlayer("CreateMove", function(_, _, cmd)
        local ang = cmd:GetViewAngles()
        ang.r = 180

        cmd:SetViewAngles(ang)
    end)

    function effect:OnEnded(context)
        context.Player:SetEyeAngles(Angle())
    end
end
