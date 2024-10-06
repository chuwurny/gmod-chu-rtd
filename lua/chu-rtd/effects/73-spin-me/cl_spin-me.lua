local effect = chuRtd.Effects:Get("spin-me")

effect:HookLocalPlayer("CreateMove", function(_, _, cmd)
    local angles = cmd:GetViewAngles()
    angles.y = angles.y + (FrameTime() * 180)

    cmd:SetViewAngles(angles)
end)
