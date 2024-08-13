local effect = chuRtd.Effects:Get("lags")

function effect:OnTick(ply, data)
    if not ply:TimeoutAction("rtd lag", 0.5) then return end

    if data.LagPos then
        ply:ExitVehicle()
        ply:SetPos(data.LagPos)

        data.LagPos = nil
    else
        data.LagPos = ply:GetPos()
    end
end
