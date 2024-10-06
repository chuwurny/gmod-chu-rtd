local effect = chuRtd.Effect("noclip", chuRtd.TYPE_GOOD)
    :Conflicts("inside-prop")

hook.Add("PlayerNoclip", "rtd noclip", function(ply, state)
    if not ply:HasRolledRtdEffect(effect) then return end

    if state then
        return true
    end
end, HOOK_MONITOR_HIGH)
