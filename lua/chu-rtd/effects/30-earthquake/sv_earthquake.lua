local effect = chuRtd.Effects:Get("earthquake")

effect.EARTHQUAKE_RADIUS   = 1000
effect.DAMAGE_RADIUS       = 800 ^ 2
effect.DAMAGE_INTERVAL     = 0.25
effect.DAMAGE_PER_INTERVAL = 1

effect.SOUNDS = {
    "ambient.rock_slide1",
    "ambient.rock_slide2",
    "ambient.rock_slide3",
    "ambient.rock_slide4",
    "ambient.rock_slide5",
}

function effect:OnTick(context)
    util.ScreenShake(
        context.Player:GetPos(),
        1000,
        1000,
        0.5,
        self.EARTHQUAKE_RADIUS,
        true
    )

    if context.Player:TimeoutAction("rtd earthquake sound", 0.2) then
        context.Player:EmitSound(self.SOUNDS[math.random(#self.SOUNDS)])
    end

    if context.Player:TimeoutAction("rtd earthquake damage", self.DAMAGE_INTERVAL) then
        for _, ply in player.Iterator() do
            if
                ply:Alive() and
                ply:IsOnGround() and
                ply:GetPos():DistToSqr(context.Player:GetPos()) < self.DAMAGE_RADIUS
            then
                ply:TakeDamage(self.DAMAGE_PER_INTERVAL, context.Player)
            end
        end
    end
end
