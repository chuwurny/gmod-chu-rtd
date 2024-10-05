local effect = chuRtd.Effects:Get("drunk-movement")

effect.RANDOMIZE_INTERVAL = 1

function effect:RandomizeMovement(context)
    context.DirectionAngle = math.Rand(-math.tau, math.tau)
end

function effect:OnRolled(context)
    self:RandomizeMovement(context)
end

effect:HookLocalPlayer("CreateMove", function(_, context, cmd)
    if x.TimeoutAction("rtd drunk movement randomize", effect.RANDOMIZE_INTERVAL) then
        effect:RandomizeMovement(context)
    end

    cmd:SetForwardMove(cmd:GetForwardMove() * math.cos(context.DirectionAngle))
    cmd:SetSideMove(cmd:GetSideMove() * math.sin(context.DirectionAngle))
end)
