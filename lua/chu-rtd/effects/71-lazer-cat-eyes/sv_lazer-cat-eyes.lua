local effect = chuRtd.Effects:Get("lazer-cat-eyes")

effect.LAZER_LOOP_SOUND = "weapons/physcannon/superphys_hold_loop.wav"

effect.LAZER_FLESH_BURN_SOUNDS = {
    "physics/cardboard/cardboard_box_strain1.wav",
    "physics/cardboard/cardboard_box_strain2.wav",
    "physics/cardboard/cardboard_box_strain3.wav",
}

function effect:OnRolled(context)
    context.LoopSoundId = context.Player:StartLoopingSound(self.LAZER_LOOP_SOUND)
end

function effect:OnEnded(context)
    context.Player:StopLoopingSound(context.LoopSoundId)
end

function effect:OnTick(context)
    local tr = context.Player:GetEyeTraceNoCursor()

    if not tr.Hit then return end
    if tr.HitWorld then return end

    local target = tr.Entity

    -- TODO: should we make checkings if we can damage this entity?
    target:Ignite(1)

    if context.Player:TimeoutAction("rtd lazer cat eyes", 0.1) then
        target:TakeDamage(5, context.Player)

        target:EmitSound(self.LAZER_FLESH_BURN_SOUNDS[math.random(#self.LAZER_FLESH_BURN_SOUNDS)])
    end
end
