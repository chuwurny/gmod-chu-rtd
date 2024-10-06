local effect = chuRtd.Effects:Get("spin-me")

effect.LOOP_SOUND = "churtd/you_spin_me_right_round.wav"

function effect:OnRolled(context)
    context.LoopSoundId = context.Player:StartLoopingSound(self.LOOP_SOUND)
end

function effect:OnEnded(context)
    context.Player:StopLoopingSound(context.LoopSoundId)
end
