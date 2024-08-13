local effect = chuRtd.Effects:Get("low-gravity")

function effect:OnRolled(ply, data)
    data.oGravity = ply:GetGravity()

    ply:SetGravity(0.2)
end

function effect:OnEnded(ply, data)
    ply:SetGravity(data.oGravity)
end
