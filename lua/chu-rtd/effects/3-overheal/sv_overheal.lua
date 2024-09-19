local effect = chuRtd.Effects:Get("overheal")

local OVERHEAL_HP = 1000

function effect:CanRoll(ply)
    return ply:GetMaxHealth() < OVERHEAL_HP
end

function effect:OnRolled(ply, data)
    ply:SetHealth(1000)

    data.HealthLost = 0
    data.HealthLerp = 0
    data.HealthLerpMax = OVERHEAL_HP - ply:GetMaxHealth()
end

function effect:OnTick(ply, data)
    local healthShouldBeLost = math.Round(
        Lerp(
            1 - ((data.EndTime - CurTime()) / self._Duration),
            0,
            data.HealthLerpMax
        )
    )

    local subtractHealth = healthShouldBeLost - data.HealthLerp

    data.HealthLerp = healthShouldBeLost

    local newHealth = ply:Health() - subtractHealth

    if newHealth < ply:GetMaxHealth() then
        ply:StopRtd()

        return
    end

    ply:SetHealth(newHealth)
end

function effect:OnEnded(ply)
    if not ply:Alive() then return end

    ply:SetHealth(math.min(ply:Health(), ply:GetMaxHealth()))
end
