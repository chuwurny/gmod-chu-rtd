local effect = chuRtd.Effects:Get("no-gravity")

function effect:OnRolled(context)
    context.oGravity = context.Player:GetGravity()

    -- HACK: somehow after update value 0 doesn't work
    context.Player:SetGravity(0.0001)
end

function effect:OnEnded(context)
    context.Player:SetGravity(context.oGravity)
end
