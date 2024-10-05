local effect = chuRtd.Effects:Get("explosion")

function effect:Explode(origin, attacker, damage, radius)
    local explosion = ents.Create("env_explosion")
    explosion:SetPos(origin)
    explosion:SetOwner(attacker)
    explosion:Spawn()
    explosion:SetKeyValue("iMagnitude", damage)
    explosion:SetKeyValue("iRadiusOverride", radius)
    explosion:Fire("Explode")
end

function effect:OnRolled(context)
    self:Explode(context.Player:GetPos(), context.Player, 500, 300)
end
