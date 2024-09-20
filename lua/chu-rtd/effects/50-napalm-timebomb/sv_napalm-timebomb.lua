x.Dependency("chu-rtd/effects/21-timebomb")

local timebombEffect = chuRtd.Effects:Get("timebomb")

local effect = chuRtd.Effects:Get("napalm-timebomb")

effect.IGNITE_RADIUS = 400
effect.IGNITE_DURATION = 10

effect.CHARGE_SOUND = "weapons/cguard/charging.wav"
effect.BEEP_SOUND   = "buttons/button17.wav"

effect.OnTick = timebombEffect.OnTick

function effect:OnEnded(rtdPlayer)
    rtdPlayer:EmitSound("Explo.ww2bomb")

    for _, ply in player.Iterator() do
        if ply:GetPos():Distance(rtdPlayer:GetPos()) < self.IGNITE_RADIUS then
            ply:Ignite(self.IGNITE_DURATION)
        end
    end
end
