x.Dependency("chu-rtd/effects/62-artillery")

local artilleryEffect = chuRtd.Effects:Get("artillery")

local effect = chuRtd.Effects:Get("airstrike")

effect.SPAWN_INTERVAL = 0.2
effect.DAMAGE_AMOUNT  = 100

function effect:OnTick(ply)
    if not ply:TimeoutAction("rtd airstrike", self.SPAWN_INTERVAL) then
        return
    end

    local tr = ply:GetEyeTraceNoCursor()

    if not tr.Hit then
        return
    end

    local spawnPos = tr.HitPos
    spawnPos.z = spawnPos.z + 1000

    local missile = artilleryEffect:CreateMissile(spawnPos, ply, self.DAMAGE_AMOUNT)

    if not IsValid(missile) then
        return
    end

    missile:SetAngles((-vector_up):Angle())
end
