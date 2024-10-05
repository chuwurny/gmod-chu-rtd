local effect = chuRtd.Effects:Get("invisibility")

function effect:OnRolled(context)
    context.oHadShadow = not context.Player:IsEffectActive(EF_NOSHADOW)

    context.Player:AddEffects(EF_NOSHADOW)
end

function effect:OnEnded(context)
    if context.oHadShadow then
        context.Player:RemoveEffects(EF_NOSHADOW)
    end
end
