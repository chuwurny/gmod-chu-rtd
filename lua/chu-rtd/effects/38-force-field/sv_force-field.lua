local effect = chuRtd.Effects:Get("force-field")

local FORCE = 0.2
local MAX_DIST = 800 ^ 2

function effect:OnTick(context)
    local src = context.Player:GetPos()

    for _, ply in player.Iterator() do
        if
            ply ~= context.Player and
            context:ShouldTarget(ply)
        then
            local dest = ply:GetPos()
            local dist = src:DistToSqr(dest)

            if dist < MAX_DIST then
                local fact = 1 - (dist / MAX_DIST)

                ply:SetVelocity((dest - src) * fact * FORCE)
            end
        end
    end
end
