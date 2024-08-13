local effect = chuRtd.Effects:Get("freeze")

function effect:OnRolled(ply)
    ply:Freeze(true)
end

function effect:OnEnded(ply)
    ply:Freeze(false)
end
