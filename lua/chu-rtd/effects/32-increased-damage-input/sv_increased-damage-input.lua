local effect = chuRtd.Effects:Get("increased-damage-input")

effect:Hook("EntityTakeDamage", function(target, dmg)
    if not target:IsPlayer() then return end
    if target:GetRtdEffect() ~= effect then return end

    dmg:ScaleDamage(3)
end)
