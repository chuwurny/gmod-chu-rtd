x.Dependency("chu-rtd/effects/16-explosion")

local explosionEffect = chuRtd.Effects:Get("explosion")

local effect = chuRtd.Effects:Get("timebomb")

effect.CHARGE_SOUND = "weapons/cguard/charging.wav"
effect.BEEP_SOUND   = "buttons/button17.wav"

function effect:OnTick(context)
    local timeLeft = context.EndTime - CurTime()

    if not context.ChargeSound and timeLeft < 1 then
        context.ChargeSound = true

        context.Player:EmitSound(self.CHARGE_SOUND)
    end

    if not context.Player:TimeoutAction("rtd timebomb beep", math.min(1, timeLeft / 10)) then
        return
    end

    context.Player:EmitSound(self.BEEP_SOUND)
end

function effect:OnEnded(context)
    explosionEffect:OnRolled(context)
end
