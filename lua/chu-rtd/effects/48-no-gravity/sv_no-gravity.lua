local effect = chuRtd.Effects:Get("no-gravity")

function effect:OnRolled(ply, data)
    data.oGravity = ply:GetGravity()

    -- HACK: somehow after update value 0 doesn't work
    ply:SetGravity(0.0001)
end

function effect:OnEnded(ply, data)
    ply:SetGravity(data.oGravity)
end
