local effect = chuRtd.Effects:Get("artillery")

local SPAWN_RADIUS = 200

function effect:CreateMissile(origin, attacker, damage, direction)
    local missile = ents.Create("rpg_missile")
    missile:SetPos(origin)
    missile:SetAngles(direction:Angle())
    missile:SetOwner(attacker)
    missile:SetSaveValue("m_flDamage", damage)
    missile:Spawn()
    missile:Activate()

    return missile
end

function effect:OnTick(ply)
    if not ply:TimeoutAction("rtd artillery fire delay", 0.5) then
        return
    end

    local target = chuRtd.Helpers.FindNearestTarget(ply)

    local origin, direction

    origin = ply:GetShootPos()
    origin.x = origin.x + (math.cos(math.random(-math.tau, math.tau)) * SPAWN_RADIUS)
    origin.y = origin.y + (math.sin(math.random(-math.tau, math.tau)) * SPAWN_RADIUS)

    if IsValid(target) then
        -- TODO: predict position based on velocity?

        direction = (target:GetShootPos() - origin):GetNormalized()
    else
        direction = VectorRand()
    end

    self:CreateMissile(origin, ply, 50, direction)
end
