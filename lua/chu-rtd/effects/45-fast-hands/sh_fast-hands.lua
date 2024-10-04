local effect = chuRtd.Effect("fast-hands", chuRtd.TYPE_GOOD)

function effect:OnRolled(ply, data)
    data.NextFireTime = 0
end

function effect:OnTick(ply, data)
    local activeWeapon = ply:GetActiveWeapon()

    if not IsValid(activeWeapon) then return end
    if CurTime() < data.NextFireTime then return end

    activeWeapon:SetNextPrimaryFire(0)

    data.NextFireTime = CurTime() + 0.05
end
