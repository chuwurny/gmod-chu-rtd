local effect = chuRtd.Effects:Get("no-step")

function effect:OnRolled(ply, data)
    data.oStepSize = ply:GetStepSize()

    ply:SetStepSize(0)
end

function effect:OnEnded(ply, data)
    ply:SetStepSize(data.oStepSize)
end
