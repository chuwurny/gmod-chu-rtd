local effect = chuRtd.Effects:Get("godmode")

function effect:OnRolled(context)
    context.Player:GodEnable()
end

function effect:OnEnded(context)
    context.Player:GodDisable()
end
