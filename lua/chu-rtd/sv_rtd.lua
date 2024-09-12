function chuRtd.Roll(ply, effectId)
    local isRandom = not effectId
    local effect

    if isRandom then
        local effects = x.CopySequence(chuRtd.Effects.Values)

        repeat
            x.Assert(#effects ~= 0,
                     "Cannot pick random effect: no suitable effects")

            effect = table.remove(effects, math.random(#effects))
        until effect:CanRoll(ply) and
              hook.Run("ChuRtdCanRoll", ply, effect) ~= false

        effectId = effect.Id
    else
        effect = x.Assert(
            chuRtd.Effects:Get(effectId),
            "Effect %s is not valid!",
            effectId
        )
    end

    if ply:IsRtdActive() then
        chuRtd.Stop(ply)
    end

    local data, duration

    if not effect._Once then
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

        ply:SetNWInt("churtd effect", chuRtd.Effects:Index(effectId))

        ply:SetNW2Float("churtd starttime", data.StartTime)
        ply:SetNW2Float("churtd endtime", data.EndTime)
    end

    xpcall(effect.OnRolled, ErrorNoHaltWithStack, effect, ply, data)

    ply:RPC("chuRtd.__OnRolled", chuRtd.Effects:Index(effectId))

    if effect.FormatMessage ~= effect._NO_FORMAT_MESSAGE then
        x.PrettyPrintLangAll("chu-rtd", effect:FormatMessage(ply, effect, data))
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
