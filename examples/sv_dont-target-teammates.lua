hook.Add("ChuRtdShouldTarget", "dont target teamm8's", function(effect, attacker, target)
    if effect.Id == "zombie" then
        return -- allow zombie to target teammates, because it's fun!
    end

    if attacker:Team() == target:Team() then
        return false
    end
end)
