x.Dependency("chu-rtd/effects/16-explosion")

local explosionEffect = chuRtd.Effects:Get("explosion")

local effect = chuRtd.Effects:Get("timebomb")

effect.CHARGE_SOUND = "weapons/cguard/charging.wav"
effect.BEEP_SOUND   = "buttons/button17.wav"

function effect:OnTick(ply, data)
    local timeLeft = data.EndTime - CurTime()

    if not data.ChargeSound and timeLeft < 1 then
        data.ChargeSound = true

        ply:EmitSound(self.CHARGE_SOUND)
    end

    if not ply:TimeoutAction("rtd timebomb beep", math.min(1, timeLeft / 10)) then
        return
    end

    ply:EmitSound(self.BEEP_SOUND)
end

function effect:OnEnded(ply)
    explosionEffect:OnRolled(ply)
end
