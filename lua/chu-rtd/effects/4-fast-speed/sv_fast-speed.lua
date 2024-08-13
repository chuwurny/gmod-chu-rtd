local effect = chuRtd.Effects:Get("fast-speed")

function effect:OnRolled(ply, data)
    data.oSlowWalkSpeed = ply:GetSlowWalkSpeed()
    data.oWalkSpeed = ply:GetWalkSpeed()
    data.oRunSpeed = ply:GetRunSpeed()

    ply:SetSlowWalkSpeed(data.oSlowWalkSpeed * 3)
    ply:SetWalkSpeed(data.oWalkSpeed * 3)
    ply:SetRunSpeed(data.oRunSpeed * 3)
end

function effect:OnEnded(ply, data)
    ply:SetSlowWalkSpeed(data.oSlowWalkSpeed)
    ply:SetWalkSpeed(data.oWalkSpeed)
    ply:SetRunSpeed(data.oRunSpeed)
end
