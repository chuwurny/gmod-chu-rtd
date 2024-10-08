function chuRtd.Roll(ply, effectId, force)
    local effect

    if type(effectId) == "string" then
        effect = x.Assert(
            chuRtd.Effects:Get(effectId),
            "Effect %s is not valid!",
            effectId
        )
    else
        effect = effectId
        effectId = effect.Id
    end

    if not force then
        if not effect:CanRoll(ply) then
            return false
        end

        if hook.Run("ChuRtdCanRoll", ply, effect) == false then
            return false
        end
    end

    if ply:HasRolledRtdEffect(effect) then
        return false
    end

    for _, context in ipairs(ply.RolledRtdEffects.Values) do
        if
            context.Effect._Conflicts[effectId] or
            effect._Conflicts[context.Effect.Id]
        then
            x.Warn(
                "Tried to roll \"%s\", but it conflicts with \"%s\"",
                effectId,
                context.Effect.Id
            )

            return false
        end
    end

    local context, duration

    if effect._Once then
        context = chuRtd._EffectContextEx(ply, effect, nil, nil)
    else
        if type(effect._Duration) == "number" then
            duration = effect._Duration
        elseif type(effect._Duration) == "table" then
            duration = math.random(effect._Duration.Min, effect._Duration.Max)
        else
            duration = math.random(10, 20)
        end

        context = chuRtd._EffectContext(ply, effect, duration)

        ply.RolledRtdEffects:Set(effectId, context)
    end

    xpcall(effect.OnRolled, ErrorNoHaltWithStack, effect, context)

    x.RPCAll(
        "chuRtd.__OnRolled",
        ply,
        chuRtd.Effects:Index(effectId),
        context.StartTime,
        context.EndTime
    )

    hook.Run("ChuRtdOnRolled", context)

    if effect.FormatMessage ~= effect._NO_FORMAT_MESSAGE then
        x.PrettyPrintLangAll("chu-rtd", effect:FormatMessage(context))
    else
        local msg = {
            team.GetColor(ply:Team()),
            ply:Name(),
            x.ColorLightGray,
            " ",
            { "rolled-effect" },
            effect.Type.Color,
            " ",
            { effect.PhraseName }
        }

        if duration then
            table.insert(msg, x.ColorLightGray)
            table.insert(msg, " ")
            table.insert(msg, { "with-duration" })

            table.insert(msg, x.ColorWhite)
            table.insert(msg, " ")
            table.insert(msg, duration)

            table.insert(msg, x.ColorLightGray)
            table.insert(msg, " ")
            table.insert(msg, { "seconds" })
        end

        x.PrettyPrintLangAll("chu-rtd", unpack(msg))
    end

    return true
end

function chuRtd.RollRandom(ply, luckiness)
    luckiness = luckiness or 0.5

    local findType

    local luck = math.random()

    if luck < luckiness then
        findType = chuRtd.TYPE_GOOD
    else
        -- Roll for luck again
        luck = math.random()

        if luck < luckiness then
            findType = chuRtd.TYPE_NEUTRAL
        else
            findType = chuRtd.TYPE_EVIL
        end
    end

    local effect
    local effects = x.CopySequence(chuRtd.Effects.Values)

    repeat
        if #effects == 0 then
            x.Warn("Cannot pick random effect: no suitable effects")

            return false
        end

        effect = table.remove(effects, math.random(#effects))
    until effect.Type == findType and chuRtd.Roll(ply, effect)

    return true
end

local function processTryRoll(ply)
    if ply:HasAnyRolledRtdEffect() then
        ply:PrettyPrintLang("chu-rtd", x.ColorRed, { "you-already-have-rtd" })

        return false
    end

    if not ply:Alive() then
        ply:PrettyPrintLang("chu-rtd", x.ColorRed, { "cannot-rtd-when-dead" })

        return false
    end

    return true
end

function chuRtd.TryRoll(ply, effectId)
    if not processTryRoll(ply) then
        return false
    end

    return chuRtd.Roll(ply, effectId)
end

function chuRtd.TryRollRandom(ply, luckiness)
    if not processTryRoll(ply) then
        return false
    end

    return chuRtd.RollRandom(ply, luckiness)
end

local function endEffect(context)
    xpcall(
        context.Effect.OnEnded,
        ErrorNoHaltWithStack,
        context.Effect,
        context
    )

    x.RPCAll(
        "chuRtd.__OnEnded",
        context.Player,
        chuRtd.Effects:Index(context.Effect.Id)
    )

    hook.Run("ChuRtdOnEnded", context)
end

function chuRtd.Stop(ply, effectId, reasonPhrase)
    if type(effectId) == "table" then
        effectId = effectId.Id
    end

    if not ply:HasRolledRtdEffect(effectId) then return end

    local context = ply:GetRtdEffectContext(effectId)

    ply.RolledRtdEffects:Delete(effectId)

    endEffect(context)

    x.PrettyPrintLangAll(
        "chu-rtd",
        team.GetColor(ply:Team()),
        ply:Name(),
        context.Effect.Type.Color,
        " ",
        { context.Effect.PhraseName },
        " ",
        x.ColorLightGray,
        { reasonPhrase or "effect-ended" }
    )
end

function chuRtd.StopAll(ply, reasonPhrase)
    if not ply:HasAnyRolledRtdEffect() then return end

    -- correctly stop by order
    ply.RolledRtdEffects:Sort(function(a, b)
        return a.StartTime < b.StartTime
    end)

    for _, context in ipairs(ply.RolledRtdEffects.Values) do
        endEffect(context)
    end

    ply.RolledRtdEffects:Clear()

    x.PrettyPrintLangAll(
        "chu-rtd",
        team.GetColor(ply:Team()),
        ply:Name(),
        x.ColorLightGray,
        " ",
        { reasonPhrase or "effect-ended" }
    )
end
