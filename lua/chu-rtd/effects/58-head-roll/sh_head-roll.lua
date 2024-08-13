local effect = chuRtd.Effect("head-roll", "Перевернутая голова")

if CLIENT then
    effect:HookLocalPlayer("CreateMove", function(_, _, cmd)
        local ang = cmd:GetViewAngles()
        ang.r = 180

        cmd:SetViewAngles(ang)
    end)

    function effect:OnEnded(ply)
        ply:SetEyeAngles(Angle())
    end
end
