local effect = chuRtd.Effects:Get("scary")

effect.MIN_ANGLE_TO_TRIGGER = 3.00

effect.SCARE_DURATION = 0.5

effect.GASP_SOUNDS = {
    "citadel.al_gasp01",
}

function effect:Scare(target, dirToAvoid)
    target:RPC(
        "chuRtd.__Scare",
        dirToAvoid,
        CurTime() + self.SCARE_DURATION,
        1
    )

    target:EmitSound(self.GASP_SOUNDS[math.random(#self.GASP_SOUNDS)])
end

function effect:OnTick(context)
    for _, ply in player.Iterator() do
        if ply ~= context.Player then
            local tr = ply:GetEyeTraceNoCursor()

            local dir = (ply:GetShootPos() - context.Player:GetShootPos()):GetNormalized()

            if tr.Entity ~= context.Player then
                local lookDir = tr.Normal
                local dotAmount = lookDir:Dot(dir)
                local lookAngle = math.acos(dotAmount)

                if lookAngle > self.MIN_ANGLE_TO_TRIGGER then
                    self:Scare(ply, dir)
                end
            else
                self:Scare(ply, dir)
            end
        end
    end
end
