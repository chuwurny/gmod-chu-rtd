local effect = chuRtd.Effects:Get("179fov")

function effect:OnRolled(ply, data)
    data.oFov = ply:GetFOV()

    ply:SetFOV(179)
end

function effect:OnEnded(ply, data)
    ply:SetFOV(data.oFov)
end
