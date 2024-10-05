x.Dependency("chu-rtd/effects/14-homing-projectiles")

local homingProjectilesEffect = chuRtd.Effects:Get("homing-projectiles")

local effect = chuRtd.Effects:Get("artillery")

effect.SPAWN_RADIUS   = 200
effect.SPAWN_DELAY    = 0.5
effect.HOVER_DURATION = 1

function effect:CreateMissile(origin, attacker, damage)
    local missile = ents.Create("rpg_missile")
    missile:SetPos(origin)
    missile:SetOwner(attacker)
    missile:SetSaveValue("m_flDamage", damage)
    missile:Spawn()
    missile:Activate()

    return missile
end

function effect:OnRolled(context)
    context.Missiles = {}
end

function effect:OnTick(context)
    local target = context:FindNearestTarget()

    local origin = context.Player:GetShootPos()
    origin.x = origin.x + (math.cos(math.random(-math.tau, math.tau)) * self.SPAWN_RADIUS)
    origin.y = origin.y + (math.sin(math.random(-math.tau, math.tau)) * self.SPAWN_RADIUS)

    if context.Player:TimeoutAction("rtd artillery fire delay", self.SPAWN_DELAY) then
        table.insert(context.Missiles, self:CreateMissile(origin, context.Player, 50))
    end

    x.FilterSequence(context.Missiles, function(missile)
        if not IsValid(missile) then
            return false
        end

        local destPos

        if (missile:GetCreationTime() + self.HOVER_DURATION) > CurTime() then
            -- fly above the air

            destPos = context.Player:GetPos()
            destPos.z = destPos.z + 3000
        elseif IsValid(target) then
            -- TODO: predict position based on velocity?

            destPos = target:GetPos()
        else
            destPos = context.Player:GetPos()
            destPos.x = destPos.x + math.random(-500, 500)
            destPos.y = destPos.y + math.random(-500, 500)
            destPos.z = destPos.z + 400
        end

        homingProjectilesEffect:VelocityAngleProjectileHandler(missile, destPos, 200, 0.1)

        return true
    end)
end

function effect:OnEnded(context)
    x.EachSequence(context.Missiles, SafeRemoveEntity)
end
