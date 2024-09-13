local effect = chuRtd.Effect("noclip", chuRtd.COLOR_GOOD)

effect:Hook("PlayerNoclip", function(ply, state)
    if not ply.RtdData then return end
    if ply:GetRtdEffect() ~= effect then return end

    if state then
        return true
    end
end, HOOK_MONITOR_HIGH)
