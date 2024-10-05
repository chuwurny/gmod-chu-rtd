x.Dependency("chu-rtd/effects/62-artillery")

local artilleryEffect = chuRtd.Effects:Get("artillery")

local effect = chuRtd.Effects:Get("airstrike")

effect.SPAWN_INTERVAL = 0.2
effect.DAMAGE_AMOUNT  = 100

function effect:OnTick(context)
    if not context.Player:TimeoutAction("rtd airstrike", self.SPAWN_INTERVAL) then
        return
    end

    local tr = context.Player:GetEyeTraceNoCursor()

    if not tr.Hit then
        return
    end

    local spawnPos = tr.HitPos
    spawnPos.z = spawnPos.z + 1000

    local missile = artilleryEffect:CreateMissile(spawnPos, context.Player, self.DAMAGE_AMOUNT)

    if not IsValid(missile) then
        return
    end

    missile:SetAngles((-vector_up):Angle())
end
