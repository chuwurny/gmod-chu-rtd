local effect = chuRtd.Effects:Get("toxic")

effect.MATERIAL = Material("particles/smokey")

function effect:OnTick(context)
    if context.Player:TimeoutAction("rtd toxic render", 0.25) then
        return
    end

    local rtdCenter = context.Player:LocalToWorld(context.Player:OBBCenter())

    local emitter = ParticleEmitter(rtdCenter, false)

    local particle = emitter:Add(self.MATERIAL, rtdCenter)

    if particle then
        particle:SetDieTime(1)

        particle:SetAngles(AngleRand())

        particle:SetStartAlpha(55)
        particle:SetEndAlpha(0)

        particle:SetStartSize(100)
        particle:SetEndSize(90)

        particle:SetColor(0, 255, 0)

        particle:SetVelocity(VectorRand() * 100)
    end

    emitter:Finish()
end
