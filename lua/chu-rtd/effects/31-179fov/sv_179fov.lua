local effect = chuRtd.Effects:Get("179fov")

function effect:OnRolled(context)
    context.oFov = context.Player:GetFOV()

    context.Player:SetFOV(179)
end

function effect:OnEnded(context)
    context.Player:SetFOV(context.oFov)
end
