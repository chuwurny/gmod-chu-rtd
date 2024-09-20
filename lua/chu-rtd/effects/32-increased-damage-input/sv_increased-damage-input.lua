local effect = chuRtd.Effects:Get("increased-damage-input")

hook.Add("EntityTakeDamage", "rtd increased damage input", function(target, dmg)
    if not target:IsPlayer() then return end
    if target:GetRtdEffect() ~= effect then return end

    dmg:ScaleDamage(3)
end)
