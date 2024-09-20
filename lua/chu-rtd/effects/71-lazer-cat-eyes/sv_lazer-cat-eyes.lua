local effect = chuRtd.Effects:Get("lazer-cat-eyes")

effect.LAZER_LOOP_SOUND = "weapons/physcannon/superphys_hold_loop.wav"

effect.LAZER_FLESH_BURN_SOUNDS = {
    "physics/cardboard/cardboard_box_strain1.wav",
    "physics/cardboard/cardboard_box_strain2.wav",
    "physics/cardboard/cardboard_box_strain3.wav",
}

function effect:OnRolled(ply, data)
    data.LoopSoundId = ply:StartLoopingSound(self.LAZER_LOOP_SOUND)
end

function effect:OnEnded(ply, data)
    ply:StopLoopingSound(data.LoopSoundId)
end

function effect:OnTick(ply)
    local tr = ply:GetEyeTraceNoCursor()

    if not tr.Hit then return end

    local target = tr.Entity

    target:Ignite(1)

    if ply:TimeoutAction("rtd lazer cat eyes", 0.1) then
        target:TakeDamage(5, ply)

        target:EmitSound(self.LAZER_FLESH_BURN_SOUNDS[math.random(#self.LAZER_FLESH_BURN_SOUNDS)])
    end
end
