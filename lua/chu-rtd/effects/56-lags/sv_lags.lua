local effect = chuRtd.Effects:Get("lags")

function effect:OnTick(context)
    if not context.Player:TimeoutAction("rtd lag", 0.5) then return end

    if context.LagPos then
        context.Player:ExitVehicle()
        context.Player:SetPos(context.LagPos)

        context.LagPos = nil
    else
        context.LagPos = context.Player:GetPos()
    end
end
