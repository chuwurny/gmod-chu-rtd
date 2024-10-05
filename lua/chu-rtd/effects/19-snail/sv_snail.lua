local effect = chuRtd.Effects:Get("snail")

function effect:OnRolled(context)
    context.oSlowWalkSpeed = context.Player:GetSlowWalkSpeed()
    context.oWalkSpeed = context.Player:GetWalkSpeed()
    context.oRunSpeed = context.Player:GetRunSpeed()

    context.Player:SetSlowWalkSpeed(context.oSlowWalkSpeed / 3)
    context.Player:SetWalkSpeed(context.oWalkSpeed / 3)
    context.Player:SetRunSpeed(context.oRunSpeed / 3)
end

function effect:OnEnded(context)
    context.Player:SetSlowWalkSpeed(context.oSlowWalkSpeed)
    context.Player:SetWalkSpeed(context.oWalkSpeed)
    context.Player:SetRunSpeed(context.oRunSpeed)
end
