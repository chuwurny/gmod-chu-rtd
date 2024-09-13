local effect = chuRtd.Effects:Get("magnet")

local MAX_DIST = 800 ^ 2

function effect:OnTick(activator)
    local dest = activator:GetPos()

    for _, ply in player.Iterator() do
        if
            ply ~= activator and
            chuRtd.Helpers.ShouldTarget(activator, ply)
        then
            local src = ply:GetPos()
            local dist = src:DistToSqr(dest)

            if dist < MAX_DIST then
                local fact = 1 - (dist / MAX_DIST)

                ply:SetVelocity((dest - src) * fact)
            end
        end
    end
end
