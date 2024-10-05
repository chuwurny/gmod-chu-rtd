local effect = chuRtd.Effects:Get("x2hp")

function effect:OnRolled(context)
    context.Player:SetMaxHealth(context.Player:GetMaxHealth() * 2)
    context.Player:SetHealth(context.Player:GetMaxHealth())
end
