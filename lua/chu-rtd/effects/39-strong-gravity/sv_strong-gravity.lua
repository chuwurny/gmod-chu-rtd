local effect = chuRtd.Effects:Get("strong-gravity")

function effect:OnRolled(ply, data)
    data.oGravity = ply:GetGravity()

    ply:SetGravity(10)
end

function effect:OnEnded(ply, data)
    ply:SetGravity(data.oGravity)
end
