local effect = chuRtd.Effects:Get("overheal")

local OVERHEAL_HP = 1000

function effect:CanRoll(context)
    return context.Player:GetMaxHealth() < OVERHEAL_HP
end

function effect:OnRolled(context)
    context.Player:SetHealth(1000)

    context.HealthLost = 0
    context.HealthLerp = 0
    context.HealthLerpMax = OVERHEAL_HP - context.Player:GetMaxHealth()
end

function effect:OnTick(context)
    local healthShouldBeLost = math.Round(
        Lerp(
            1 - ((context.EndTime - CurTime()) / context:Duration()),
            0,
            context.HealthLerpMax
        )
    )

    local subtractHealth = healthShouldBeLost - context.HealthLerp

    context.HealthLerp = healthShouldBeLost

    local newHealth = context.Player:Health() - subtractHealth

    if newHealth < context.Player:GetMaxHealth() then
        return context:Stop()
    end

    context.Player:SetHealth(newHealth)
end

function effect:OnEnded(context)
    if not context.Player:Alive() then return end

    context.Player:SetHealth(
        math.min(context.Player:Health(), context.Player:GetMaxHealth())
    )
end
