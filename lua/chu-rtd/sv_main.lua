hook.Add("Tick", "churtd process", function()
    for _, ply in player.Iterator() do
        if ply.RolledRtdEffects then
            for _, context in ipairs(ply.RolledRtdEffects.Values) do
                if not context:IsExpired() then
                    xpcall(
                        context.Effect.OnTick,
                        ErrorNoHaltWithStack,
                        context.Effect,
                        context
                    )
                else
                    context:Stop()
                end
            end
        end
    end
end)

hook.Add("PlayerDeath", "churtd process", function(ply)
    if not ply:HasAnyRolledRtdEffect() then return end

    chuRtd.StopAll(ply, "died-with-active-effect")
end)
