local effect = chuRtd.Effects:Get("strip-weapons")

function effect:OnRolled(ply)
    ply:StripWeapons()
end
