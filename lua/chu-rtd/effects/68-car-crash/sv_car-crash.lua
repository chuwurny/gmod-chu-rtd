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

function effect:OnRolled(ply, data)
    local car = ents.Create("prop_physics")

    if not IsValid(car) then
        return ply:StopRtd()
    end

    local normal = ply:GetEyeTrace().Normal
    normal.z = 0

    car:SetModel("models/props_vehicles/car005a_physics.mdl")
    car:SetPos(ply:GetPos() + Vector(0, 0, 100) + normal * 2000)
    car:SetAngles(Angle(0, ply:EyeAngles().y - 180, 0))
    car:Spawn()

    car:EmitSound("vehicles/v8/skid_highfriction.wav")
    ply:EmitSound("vo/npc/male01/no02.wav")

    data.Car = car
end

function effect:OnTick(ply, data)
    if not IsValid(data.Car) then
        return ply:StopRtd()
    end

    local phys = data.Car:GetPhysicsObject()

    if not phys then
        return ply:StopRtd()
    end

    phys:SetVelocity((ply:GetPos() - data.Car:GetPos()) * 10)
end

function effect:OnEnded(ply, data)
    if not IsValid(data.Car) then
        return
    end

    for _ = 1, math.random(2, 4) do
        local wheel = ents.Create "prop_physics"

        if IsValid(wheel) then
            wheel:SetModel(self.WHEELS[math.random(#self.WHEELS)])
            wheel:SetPos(data.Car:GetPos())
            wheel:SetAngles(data.Car:GetAngles() + Angle(0, math.random(-45, 45), 0))
            wheel:Spawn()
            wheel:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
            wheel:Ignite(self.DEBRIS_LIVE_TIME, 100)

            local phys = data.Car:GetPhysicsObject()

            if IsValid(phys) then
                phys:SetVelocity(data.Car:GetVelocity())
            end

            SafeRemoveEntityDelayed(wheel, self.DEBRIS_LIVE_TIME)
        end
    end

    data.Car:SetModel(self.DESTROYED_CARS[math.random(#self.DESTROYED_CARS)])
    data.Car:SetMaterial "models/props_foliage/tree_deciduous_01a_trunk"
    data.Car:Ignite(10, 200)

    explosionEffect:Explode(data.Car:GetPos(), ply, 1000, 300)

    timer.Simple(10, function()
        if not IsValid(data.Car) then
            return
        end

        explosionEffect:Explode(data.Car:GetPos(), ply, 2000, 300)

        data.Car:Remove()
    end)
end
