local effect = chuRtd.Effects:Get("death")

function effect:OnRolled(ply)
    ply:Kill()
end
