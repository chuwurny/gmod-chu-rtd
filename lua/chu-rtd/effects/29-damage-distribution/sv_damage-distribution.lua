local effect = chuRtd.Effects:Get("damage-distribution")

function effect:CanRoll()
    return player.GetCount() > 1
end

hook.Add("EntityTakeDamage", "rtd damage distribution", function(target, dmg)
    if not target:IsPlayer() then return end
    if not target:HasRolledRtdEffect(effect) then return end

    local outputDamage = dmg:GetDamage() / (player.GetCount() - 1)
    local inputDamage  = dmg:GetDamage() / player.GetCount()

    dmg:SetDamage(inputDamage)

    -- apply output damage in next frame
    timer.Simple(0, function()
        for _, ply in player.Iterator() do
            if ply ~= target then
                ply:TakeDamage(outputDamage, target)
            end
        end
    end)
end, HOOK_MONITOR_LOW)
