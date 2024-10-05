function chuRtd.Helpers.PostDamage(effect, callback)
    hook.Add("PostEntityTakeDamage", "rtd " .. effect.Id, function(target, dmg, took)
        if not took then return end

        if not target:IsPlayer() then return end

        local attacker = dmg:GetAttacker()

        if attacker == target then return end
        if not IsValid(attacker) or not attacker:IsPlayer() then return end
        if not attacker:HasRolledRtdEffect(effect) then return end

        local result = callback(target, dmg)

        if result ~= nil then
            return result
        end
    end)
end
