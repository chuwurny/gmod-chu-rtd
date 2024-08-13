local effect = chuRtd.Effects:Get("godmode")

function effect:OnRolled(ply)
    ply:GodEnable()
end

function effect:OnEnded(ply)
    ply:GodDisable()
end
