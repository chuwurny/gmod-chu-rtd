hook.Add("Tick", "churtd process", function()
    for _, ply in player.Iterator() do
        if ply.RtdData then
            local effect = ply:GetRtdEffect()
            local data = ply.RtdData

            if data.EndTime and data.EndTime > CurTime() then
                xpcall(effect.OnTick, ErrorNoHaltWithStack, effect, ply, data)
            else
                chuRtd.Stop(ply)
            end
        end
    end
end)

hook.Add("PlayerDeath", "churtd process", function(ply)
    if not ply.RtdData then return end

    chuRtd.Stop(ply, "died-with-active-effect")
end)
