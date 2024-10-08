local effect = chuRtd.Effects:Get("trembling-hands")
    :OnlyLocalPlayer()

effect:HookLocalPlayer("CreateMove", function(_, _, cmd)
    local randomAngle = Angle(
        -1 + (math.random() * 2),
        -1 + (math.random() * 2),
        0
    )

    cmd:SetViewAngles(cmd:GetViewAngles() + randomAngle)
end)

