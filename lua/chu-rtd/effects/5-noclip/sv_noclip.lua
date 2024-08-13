local effect = chuRtd.Effects:Get("noclip")

function effect:OnRolled(ply)
    ply:ExitVehicle()
    ply:SetMoveType(MOVETYPE_NOCLIP)
end

function effect:OnEnded(ply)
    ply:SetMoveType(MOVETYPE_WALK)
end
