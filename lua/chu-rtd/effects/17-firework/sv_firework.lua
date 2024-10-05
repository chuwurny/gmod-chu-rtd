x.Dependency("chu-rtd/effects/16-explosion")

local explosionEffect = chuRtd.Effects:Get("explosion")

local effect = chuRtd.Effects:Get("firework")

effect.LAUNCH_SOUND = "weapons/flaregun/fire.wav"

function effect:OnRolled(context)
    local ply = context.Player

    ply:SetVelocity(Vector(0, 0, 1000))

    ply:EmitSound(self.LAUNCH_SOUND)

    timer.Simple(0.5, function()
        if not IsValid(ply) then return end

        explosionEffect:OnRolled(chuRtd.TempEffectContext(ply))
    end)
end
