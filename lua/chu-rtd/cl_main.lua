function chuRtd.__OnRolled(ply, effectIndex, startTime, endTime)
    if not ply.RolledRtdEffects then return end

    local effect = chuRtd.Effects.Values[effectIndex]
    local context = chuRtd._EffectContextEx(ply, effect, startTime, endTime)

    if not effect._Once then
        ply.RolledRtdEffects:Set(effect.Id, context)
    end

    if ply == LocalPlayer() then
        effect:OnRolled(context)
    end
end

function chuRtd.__OnEnded(ply, effectIndex)
    if not ply.RolledRtdEffects then return end

    local effect = chuRtd.Effects.Values[effectIndex]
    local context = ply.RolledRtdEffects:Get(effect.Id)

    if ply == LocalPlayer() then
        effect:OnEnded(context)
    end

    ply.RolledRtdEffects:Delete(effect.Id)
end

x.EnsureInitPostEntity(function()
    for _, ply in player.Iterator() do
        ply.RolledRtdEffects = ply.RolledRtdEffects or x.Map()
    end

    hook.Add("Tick", "churtd", function()
        for _, ply in player.Iterator() do
            if ply.RolledRtdEffects then
                for _, context in ipairs(ply.RolledRtdEffects.Values) do
                    if not context:IsExpired() then
                        context.Effect:OnTick(context)
                    end
                end
            end
        end
    end)
end)
