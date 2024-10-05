local effect = chuRtd.Effects:Get("1hp")

function effect:OnRolled(context)
    context.Player:SetHealth(1)
end
