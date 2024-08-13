local effect = chuRtd.Effects:Get("x2hp")

function effect:OnRolled(ply)
    ply:SetMaxHealth(ply:GetMaxHealth() * 2)
    ply:SetHealth(ply:GetMaxHealth())
end
