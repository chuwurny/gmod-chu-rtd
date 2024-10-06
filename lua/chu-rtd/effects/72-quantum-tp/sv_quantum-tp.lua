local effect = chuRtd.Effects:Get("quantum-tp")

effect.TELEPORT_INTERVAL = 0.4
effect.MAX_DISTANCE      = 800

effect.TELEPORT_SOUNDS = {
    "ambient.electrical_random_zap_1",
    "ambient.electrical_random_zap_2",
}

function effect:OnTick(context)
    if not context.Player:TimeoutAction("rtd quantum tp", self.TELEPORT_INTERVAL) then
        return
    end

    local tr = util.TraceEntityHull({
        start  = context.Player:GetShootPos(),
        endpos = context.Player:GetShootPos() +
                 (context.Player:GetAimVector() * self.MAX_DISTANCE),
        filter = context.Player,
    }, context.Player)

    context.Player:SetPos(tr.HitPos)

    context.Player:SetVelocity(
        Vector(0, 0, -context.Player:GetVelocity().z)
    )

    context.Player:EmitSound(self.TELEPORT_SOUNDS[math.random(#self.TELEPORT_SOUNDS)])
end
