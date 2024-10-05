local effect = chuRtd.Effects:Get("infinity-ammo")

function effect:OnTick(context)
    local weapon = context.Player:GetActiveWeapon()

    if not IsValid(weapon) then return end

    weapon:SetClip1(weapon:GetMaxClip1())
    weapon:SetClip2(weapon:GetMaxClip2())
end
