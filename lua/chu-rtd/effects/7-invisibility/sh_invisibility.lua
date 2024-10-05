local effect = chuRtd.Effect("invisibility", chuRtd.TYPE_GOOD)

if CLIENT then
    hook.Add("PrePlayerDraw", "rtd invisibility", function(ply)
        if ply:HasRolledRtdEffect(effect) then
            return true
        end
    end, HOOK_HIGH)
end
