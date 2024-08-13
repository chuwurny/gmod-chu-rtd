local effect = chuRtd.Effect("invisibility", "Невидимость")

if CLIENT then
    hook.Add("PreDrawPlayer", "rtd invisibility", function(ply)
        if ply:GetRtdEffectId() == effect.Id then
            return true
        end
    end, HOOK_HIGH)
end
