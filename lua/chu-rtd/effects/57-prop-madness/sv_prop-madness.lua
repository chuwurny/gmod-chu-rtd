local effect = chuRtd.Effects:Get("prop-madness")

local MODELS = {
    "models/props_c17/oildrum001.mdl",
    "models/props_junk/TrashBin01a.mdl",
    "models/props_c17/gravestone003a.mdl",
    "models/props_c17/FurnitureWashingmachine001a.mdl",
    "models/props_lab/monitor01a.mdl",
    "models/props_c17/furniturecouch002a.mdl",
    "models/props_c17/furniturestove001a.mdl",
    "models/props_c17/trappropeller_engine.mdl",
    "models/props_vehicles/car005b_physics.mdl",
    "models/props_wasteland/rockgranite02c.mdl",
}

local AMOUNT = 8

function effect:OnRolled(ply, data)
    data.Props = {}

    local origin = ply:GetShootPos()
    origin.z = origin.z + 10

    local step = (math.pi * 2) / AMOUNT

    for i = 1, AMOUNT do
        local ent = ents.Create("prop_physics")
        if not IsValid(ent) then break end

        ent:SetModel(MODELS[math.random(#MODELS)])

        ent:SetPos(
            origin + Vector(
                math.cos(step * i) * 300,
                math.sin(step * i) * 300,
                0
            )
        )

        if ent.CPPISetOwner then
            ent:CPPISetOwner(ply)
        end

        ent:Spawn()

        data.Props[i] = ent
    end
end

function effect:OnTick(ply, data)
    if #data.Props == 0 then
        return chuRtd.Stop(ply)
    end

    local origin = ply:GetShootPos()
    origin.z = origin.z + 80

    local step = (math.pi * 2) / #data.Props
    local spin = (CurTime() * 2) % (math.pi * 4)

    for i, prop in ipairs(data.Props) do
        if IsValid(prop) then
            local phys = prop:GetPhysicsObject()

            if IsValid(phys) then
                local src = prop:GetPos()

                local dest

                local mass = phys:GetMass()
                local vel = phys:GetVelocity()

                if ply:Crouching() then
                    dest = ply:GetEyeTrace().HitPos

                    vel = vel / 20
                else
                    vel = vel / 3

                    dest = origin + Vector(
                        math.cos((step * i) + spin) * 400,
                        math.sin((step * i) + spin) * 400,
                        0
                    )
                end

                phys:ApplyForceCenter((dest - src) * mass - vel * mass)
            end
        end
    end
end

function effect:OnEnded(ply, data)
    for _, prop in ipairs(data.Props) do
        SafeRemoveEntity(prop)
    end
end
