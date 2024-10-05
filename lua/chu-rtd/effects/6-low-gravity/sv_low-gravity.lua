local effect = chuRtd.Effects:Get("low-gravity")

function effect:OnRolled(context)
    context.oGravity = context.Player:GetGravity()

    context.Player:SetGravity(0.2)
end

function effect:OnEnded(context)
    context.Player:SetGravity(context.oGravity)
end
