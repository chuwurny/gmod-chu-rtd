local effect = chuRtd.Effects:Get("noclip")

function effect:OnRolled(context)
    context.Player:ExitVehicle()
    context.Player:SetMoveType(MOVETYPE_NOCLIP)
end

function effect:OnEnded(context)
    context.Player:SetMoveType(MOVETYPE_WALK)
end
