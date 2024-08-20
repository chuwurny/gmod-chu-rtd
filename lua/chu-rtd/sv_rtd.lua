function chuRtd.Roll(ply, effectId)
    local isRandom = not effectId
    local effect

    repeat
        if isRandom then
            local _
            _, effectId = table.Random(chuRtd.Effects.Indices)
        end

        effect = x.Assert(
            chuRtd.Effects:Get(effectId),
            "Effect %s is not valid!",
            effectId
        )
    until not isRandom or effect:CanRoll(ply)

    if ply:IsRtdActive() then
        chuRtd.Stop(ply)
    end

    local data, duration

    if effect._Once then
    else
        data = {}

        ply.RtdData = data

        if type(effect._Duration) == "number" then
            duration = effect._Duration
        elseif type(effect._Duration) == "table" then
            duration = math.random(effect._Duration.Min, effect._Duration.Max)
        else
            duration = math.random(10, 20)
        end

        data.StartTime = CurTime()
        data.EndTime = data.StartTime + duration
    end

    ply:SetNWInt("churtd effect", chuRtd.Effects:Index(effectId))
    ply:SetNW2Float("churtd starttime", data.StartTime)
    ply:SetNW2Float("churtd endtime", data.EndTime)

    xpcall(effect.OnRolled, ErrorNoHaltWithStack, effect, ply, data)

    ply:RPC("chuRtd.__OnRolled", chuRtd.Effects:Index(effectId))

    if effect.FormatMessage ~= effect._NO_FORMAT_MESSAGE then
        x.PrettyPrintAll(effect:FormatMessage(ply, effect, data))
    else
        local msg = {
            team.GetColor(ply:Team()),
            ply:Name(),
            x.ColorLightGray,
            " ",
            { "rolled-effect" },
            effect.Color,
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
end

function chuRtd.TryRoll(ply, effectId)
    if ply:IsRtdActive() then
        return false
    end

    chuRtd.Roll(ply, effectId)

    return true
end

function chuRtd.Stop(ply, reasonPhrase)
    if not ply.RtdData then return end

    local effect = ply:GetRtdEffect()
    local data = ply.RtdData

    ply.RtdData = nil
    ply:SetNWInt("churtd effect", 0)

    xpcall(effect.OnEnded, ErrorNoHaltWithStack, effect, ply, data)

    ply:RPC("chuRtd.__OnEnded", chuRtd.Effects:Index(effect.Id))

    x.PrettyPrintLangAll(
        "chu-rtd",
        team.GetColor(ply:Team()),
        ply:Name(),
        x.ColorLightGray,
        " ",
        { reasonPhrase or "effect-ended" }
    )
end
