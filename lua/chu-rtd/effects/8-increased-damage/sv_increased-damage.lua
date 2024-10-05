local effect = chuRtd.Effects:Get("increased-damage")

hook.Add("EntityTakeDamage", "rtd increased damage", function(target, dmg)
    local attacker = dmg:GetAttacker()

    if not IsValid(attacker) or not attacker:IsPlayer() then return end
    if not attacker:HasRolledRtdEffect(effect) then return end

    dmg:ScaleDamage(3)
end)
