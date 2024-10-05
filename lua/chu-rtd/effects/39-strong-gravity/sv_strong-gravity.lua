local effect = chuRtd.Effects:Get("strong-gravity")

function effect:OnRolled(context)
    context.oGravity = context.Player:GetGravity()

    context.Player:SetGravity(10)
end

function effect:OnEnded(context)
    context.Player:SetGravity(context.oGravity)
end
