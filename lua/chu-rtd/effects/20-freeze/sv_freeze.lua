local effect = chuRtd.Effects:Get("freeze")

function effect:PlayFreezeSound(ply)
    ply:EmitSound("Canals.d1_canals_01a_wood_strain3")
end

function effect:PlayUnfreezeSound(ply)
    ply:EmitSound("Canals.d1_canals_01a_wood_strain4")
end

function effect:OnRolled(ply, data)
    self:PlayFreezeSound(ply)
    ply:Freeze(true)

    ply:ScreenFade(SCREENFADE.IN, x.ColorBlue, 1, 0)

    data.oMaterial = ply:GetMaterial()
    ply:SetMaterial("debug/env_cubemap_model")
end

function effect:OnEnded(ply, data)
    self:PlayUnfreezeSound(ply)
    ply:Freeze(false)

    ply:SetMaterial(data.oMaterial)
end
