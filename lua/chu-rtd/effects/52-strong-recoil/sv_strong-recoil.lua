local effect = chuRtd.Effects:Get("strong-recoil")

hook.Add("PostEntityFireBullets", "rtd strong recoil", function(ply, data)
    if not ply:IsPlayer() then return end
    if ply:GetRtdEffect() ~= effect then return end

    local punchAng = Angle(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))

    ply:ViewPunch(punchAng)

    punchAng.r = 0

    ply:SetEyeAngles(ply:EyeAngles() + (punchAng / 2))
end, HOOK_MONITOR_LOW)
