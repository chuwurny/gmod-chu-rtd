local effect = chuRtd.Effects:Get("dissolve")

function effect:OnRolled(context)
    context.Player:Dissolve(3, 1)
end
