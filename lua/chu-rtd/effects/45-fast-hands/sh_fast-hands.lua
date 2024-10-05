local effect = chuRtd.Effect("fast-hands", chuRtd.TYPE_GOOD)

function effect:OnRolled(context)
    context.NextFireTime = 0
end

function effect:OnTick(context)
    local activeWeapon = context.Player:GetActiveWeapon()

    if not IsValid(activeWeapon) then return end
    if CurTime() < context.NextFireTime then return end

    activeWeapon:SetNextPrimaryFire(0)

    context.NextFireTime = CurTime() + 0.05
end
