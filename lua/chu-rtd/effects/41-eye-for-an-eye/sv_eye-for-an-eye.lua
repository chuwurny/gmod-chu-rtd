local effect = chuRtd.Effects:Get("eye-for-an-eye")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    local attacker = dmg:GetAttacker()

    dmg:SetAttacker(target)
    attacker:TakeDamageInfo(dmg)
end)
