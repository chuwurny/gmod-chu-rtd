local effect = chuRtd.Effect("target-me", chuRtd.TYPE_EVIL)

if CLIENT then
    local targetList = x.Set()

    timer.Create("rtd target me", 1, 0, function()
        targetList:Clear()

        for _, ply in player.Iterator() do
            if ply:HasRolledRtdEffect(effect) then
                targetList:Insert(ply)
            end
        end
    end)

    hook.Add("PreDrawHalos", "rtd target me", function()
        if targetList:Length() == 0 then return end

        halo.Add(targetList.Values, x.ColorRed, 2, 2, 1, true, true)
    end)
end
