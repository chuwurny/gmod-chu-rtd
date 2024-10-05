local effect = chuRtd.Effects:Get("death")

function effect:OnRolled(context)
    context.Player:Kill()
end
