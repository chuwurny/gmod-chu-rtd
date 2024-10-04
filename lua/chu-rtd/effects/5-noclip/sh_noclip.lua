local effect = chuRtd.Effect("noclip", chuRtd.TYPE_GOOD)

hook.Add("PlayerNoclip", "rtd noclip", function(ply, state)
    if not ply.RtdData then return end
    if ply:GetRtdEffect() ~= effect then return end

    if state then
        return true
    end
end, HOOK_MONITOR_HIGH)
