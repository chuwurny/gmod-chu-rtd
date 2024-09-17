local effect = chuRtd.Effect("invisibility", chuRtd.COLOR_GOOD)

if CLIENT then
    hook.Add("PrePlayerDraw", "rtd invisibility", function(ply)
        if ply:GetRtdEffectId() == effect.Id then
            return true
        end
    end, HOOK_HIGH)
end
