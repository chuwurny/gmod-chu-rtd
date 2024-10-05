local effect = chuRtd.Effects:Get("homing-projectiles")

local MAX_DISTANCE = 5000

effect.PROJECTILES = effect.PROJECTILES or {}

function effect:HandleProjectile(className, handler)
    self.PROJECTILES[className] = handler
end

function effect:HandleProjectileSameAs(className, deriveClassName)
    local deriveHandler = x.Assert(
        self.PROJECTILES[deriveClassName],
        "No derive classname \"%s\"",
        deriveClassName
    )

    self:HandleProjectile(className, deriveHandler)
end

function effect:OnTick(context)
    local target = context:FindNearestTarget(nil, MAX_DISTANCE)

    if not IsValid(target) then return end

    local destPos = target:GetPos()

    for className, handler in pairs(self.PROJECTILES) do
        for _, projectile in ipairs(ents.FindByClass(className)) do
            if
                projectile:GetInternalVariable("m_hThrower") == context.Player or
                projectile:GetInternalVariable("m_hOwner") == context.Player or
                projectile:GetOwner() == context.Player
            then
                handler(self, projectile, destPos)
            end
        end
    end
end

function effect:VelocityProjectileHandler(projectile, destPos, speed, inertiaDenyAmount)
    inertiaDenyAmount = inertiaDenyAmount or 0

    local dir = (destPos - projectile:GetPos()):GetNormalized()

    projectile:SetVelocity(-(projectile:GetVelocity() * inertiaDenyAmount) + dir * speed)
end

function effect:AngleProjectileHandler(projectile, destPos)
    local destAng = (destPos - projectile:GetPos()):Angle()

    projectile:SetAngles(destAng)
end

function effect:VelocityAngleProjectileHandler(projectile, destPos, speed, inertiaDenyAmount)
    self:VelocityProjectileHandler(projectile, destPos, speed, inertiaDenyAmount)
    self:AngleProjectileHandler(projectile, destPos)
end

function effect:PhysVelocityProjectileHandler(projectile, destPos, speed)
    local phys = projectile:GetPhysicsObject()

    if not IsValid(phys) then
        return
    end

    local dir = (destPos - phys:GetPos()):GetNormalized()

    phys:SetVelocity(dir * speed)
end

function effect:CallProjectileHandler(projectile, destPos)
    local handler = self.PROJECTILES[projectile:GetClass()]

    if not handler then
        return false
    end

    handler(self, projectile, destPos)

    return true
end

effect:HandleProjectile(
    "npc_grenade_frag",
    x.Bind(effect.PhysVelocityProjectileHandler, x._1, x._2, x._3, 1000)
)

effect:HandleProjectileSameAs("npc_satchel", "npc_grenade_frag")

effect:HandleProjectile("prop_combine_ball", effect.VelocityProjectileHandler)

effect:HandleProjectile(
    "crossbow_bolt",
    x.Bind(effect.VelocityAngleProjectileHandler, x._1, x._2, x._3, 1000)
)

effect:HandleProjectile(
    "rpg_missile",
    x.Bind(effect.VelocityAngleProjectileHandler, x._1, x._2, x._3, 1000, 1)
)
