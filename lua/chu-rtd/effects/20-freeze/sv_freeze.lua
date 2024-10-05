local effect = chuRtd.Effects:Get("freeze")

function effect:PlayFreezeSound(ply)
    ply:EmitSound("Canals.d1_canals_01a_wood_strain3")
end

function effect:PlayUnfreezeSound(ply)
    ply:EmitSound("Canals.d1_canals_01a_wood_strain4")
end

function effect:OnRolled(context)
    self:PlayFreezeSound(context.Player)
    context.Player:Freeze(true)

    context.Player:ScreenFade(SCREENFADE.IN, x.ColorBlue, 1, 0)

    context.oMaterial = context.Player:GetMaterial()
    context.Player:SetMaterial("debug/env_cubemap_model")
end

function effect:OnEnded(context)
    self:PlayUnfreezeSound(context.Player)
    context.Player:Freeze(false)

    context.Player:SetMaterial(context.oMaterial)
end
