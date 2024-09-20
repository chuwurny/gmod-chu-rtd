function chuRtd.__OnRolled(effectIndex, data)
    local effect = chuRtd.Effects.Values[effectIndex]

    LocalPlayer().RtdData = data

    effect:OnRolled(LocalPlayer(), data)
end

function chuRtd.__OnEnded(effectIndex)
    local effect = chuRtd.Effects.Values[effectIndex]

    local data

    if not effect._Once then
        data = LocalPlayer().RtdData
        LocalPlayer().RtdData = nil
    end

    effect:OnEnded(LocalPlayer(), data)
end

x.EnsureHasLocalPlayer(function(lp)
    hook.Add("Tick", "churtd", function()
        if not lp.RtdData then return end
        if CurTime() > lp:GetRtdEndTime() then return end

        lp:GetRtdEffect():OnTick(lp, lp.RtdData)
    end)
end)
