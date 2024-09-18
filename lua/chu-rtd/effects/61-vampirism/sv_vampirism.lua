local effect = chuRtd.Effects:Get("vampirism")

effect.HEAL_MULTIPLIER = 0.2

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    local attacker = dmg:GetAttacker()

    local healAmount = dmg:GetDamage()

    if target:Health() < 0 then
        healAmount = healAmount - math.abs(target:Health())
    end

    healAmount = math.ceil(healAmount * effect.HEAL_MULTIPLIER)

    if healAmount <= 0 then
        return
    end

    attacker:SetHealth(attacker:Health() + healAmount)
end)
