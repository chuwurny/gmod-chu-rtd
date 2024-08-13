local effect = chuRtd.Effects:Get("dissolve")

function effect:OnRolled(ply)
    ply:Dissolve(3, 1)
end
