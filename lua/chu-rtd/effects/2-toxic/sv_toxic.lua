local effect = chuRtd.Effects:Get("toxic")

effect.MAX_RADIUS              = 500 ^ 2
effect.DAMAGE_INTERVAL         = 0.25
effect.MAX_DAMAGE_PER_INTERVAL = 20

function effect:OnTick(context)
    if not context.Player:TimeoutAction("rtd toxic", self.DAMAGE_INTERVAL) then
        return
    end

    local rtdPos = context.Player:GetPos()

    for _, ply in player.Iterator() do
        if
            ply ~= context.Player and
            ply:Alive() and
            context:ShouldTarget(ply)
        then
            local dist = rtdPos:DistToSqr(ply:GetPos())

            if dist < self.MAX_RADIUS then
                local damage = (1 - (dist / self.MAX_RADIUS)) *
                               self.MAX_DAMAGE_PER_INTERVAL

                local dmgInfo = DamageInfo()
                dmgInfo:SetDamageType(DMG_ACID)
                dmgInfo:SetDamage(damage)
                dmgInfo:SetAttacker(context.Player)
                dmgInfo:SetInflictor(context.Player)
                dmgInfo:SetDamagePosition(ply:GetPos())
                dmgInfo:SetDamageForce(context.Player:GetPos() - ply:GetPos())

                ply:TakeDamageInfo(dmgInfo)
            end
        end
    end
end
