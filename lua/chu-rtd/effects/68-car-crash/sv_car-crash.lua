x.Dependency("chu-rtd/effects/16-explosion")

local explosionEffect = chuRtd.Effects:Get("explosion")

local effect = chuRtd.Effects:Get("car-crash")

effect.DEBRIS_LIVE_TIME = 12

effect.WHEELS = {
    "models/props_vehicles/carparts_wheel01a.mdl",
    "models/props_vehicles/carparts_tire01a.mdl"
}

effect.DESTROYED_CARS = {
    "models/props_vehicles/car001b_hatchback.mdl",
    "models/props_vehicles/car004b_physics.mdl",
    "models/props_vehicles/car005b_physics.mdl",
}

function effect:OnRolled(context)
    local car = ents.Create("prop_physics")

    if not IsValid(car) then
        return context:Stop()
    end

    local normal = context.Player:GetEyeTrace().Normal
    normal.z = 0

    car:SetModel("models/props_vehicles/car005a_physics.mdl")
    car:SetPos(context.Player:GetPos() + Vector(0, 0, 100) + normal * 2000)
    car:SetAngles(Angle(0, context.Player:EyeAngles().y - 180, 0))
    car:Spawn()

    car:EmitSound("vehicles/v8/skid_highfriction.wav")
    context.Player:EmitSound("vo/npc/male01/no02.wav")

    context.Car = car
end

function effect:OnTick(context)
    if not IsValid(context.Car) then
        return context:Stop()
    end

    local phys = context.Car:GetPhysicsObject()

    if not phys then
        return context:Stop()
    end

    phys:SetVelocity((context.Player:GetPos() - context.Car:GetPos()) * 10)
end

function effect:OnEnded(context)
    if not IsValid(context.Car) then
        return
    end

    for _ = 1, math.random(2, 4) do
        local wheel = ents.Create "prop_physics"

        if IsValid(wheel) then
            wheel:SetModel(self.WHEELS[math.random(#self.WHEELS)])
            wheel:SetPos(context.Car:GetPos())
            wheel:SetAngles(context.Car:GetAngles() + Angle(0, math.random(-45, 45), 0))
            wheel:Spawn()
            wheel:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
            wheel:Ignite(self.DEBRIS_LIVE_TIME, 100)

            local phys = context.Car:GetPhysicsObject()

            if IsValid(phys) then
                phys:SetVelocity(context.Car:GetVelocity())
            end

            SafeRemoveEntityDelayed(wheel, self.DEBRIS_LIVE_TIME)
        end
    end

    context.Car:SetModel(self.DESTROYED_CARS[math.random(#self.DESTROYED_CARS)])
    context.Car:SetMaterial "models/props_foliage/tree_deciduous_01a_trunk"
    context.Car:Ignite(10, 200)

    explosionEffect:Explode(context.Car:GetPos(), context.Player, 1000, 300)

    timer.Simple(10, function()
        if not IsValid(context.Car) then
            return
        end

        explosionEffect:Explode(context.Car:GetPos(), context.Player, 2000, 300)

        context.Car:Remove()
    end)
end
