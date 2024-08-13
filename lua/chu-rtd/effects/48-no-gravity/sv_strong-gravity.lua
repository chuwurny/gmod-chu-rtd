local effect = chuRtd.Effects:Get("no-gravity")

function effect:OnRolled(ply, data)
    data.oGravity = ply:GetGravity()

    ply:SetGravity(0)
end

function effect:OnEnded(ply, data)
    ply:SetGravity(data.oGravity)
end
