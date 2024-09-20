local effect = chuRtd.Effects:Get("drunk-movement")

effect.RANDOMIZE_INTERVAL = 1

function effect:RandomizeMovement(data)
    data.DirectionAngle = math.Rand(-math.tau, math.tau)
end

function effect:OnRolled(_, data)
    self:RandomizeMovement(data)
end

effect:HookLocalPlayer("CreateMove", function(_, _, data, cmd)
    if x.TimeoutAction("rtd drunk movement randomize", effect.RANDOMIZE_INTERVAL) then
        effect:RandomizeMovement(data)
    end

    cmd:SetForwardMove(cmd:GetForwardMove() * math.cos(data.DirectionAngle))
    cmd:SetSideMove(cmd:GetSideMove() * math.sin(data.DirectionAngle))
end)
