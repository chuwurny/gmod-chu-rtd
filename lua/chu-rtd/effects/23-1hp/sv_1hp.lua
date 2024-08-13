local effect = chuRtd.Effects:Get("1hp")

function effect:OnRolled(ply)
    ply:SetHealth(1)
end
