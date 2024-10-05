local effect = chuRtd.Effects:Get("no-step")

function effect:OnRolled(context)
    context.oStepSize = context.Player:GetStepSize()

    context.Player:SetStepSize(0)
end

function effect:OnEnded(context)
    context.Player:SetStepSize(context.oStepSize)
end
