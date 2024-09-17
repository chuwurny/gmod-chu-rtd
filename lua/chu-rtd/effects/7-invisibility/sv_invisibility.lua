local effect = chuRtd.Effects:Get("invisibility")

function effect:OnRolled(ply, data)
    data.oHadShadow = not ply:IsEffectActive(EF_NOSHADOW)

    ply:AddEffects(EF_NOSHADOW)
end

function effect:OnEnded(ply, data)
    if data.oHadShadow then
        ply:RemoveEffects(EF_NOSHADOW)
    end
end
