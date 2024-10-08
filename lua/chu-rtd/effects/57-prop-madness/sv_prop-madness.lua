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

local TAU2 = math.tau * 2

local AMOUNT = 8
local RADIUS = 400
local HEIGHT = 150

function effect:OnRolled(context)
    context.Props = {}

    local origin = context.Player:GetShootPos()
    origin.z = origin.z + 10

    local step = math.tau / AMOUNT

    for i = 1, AMOUNT do
        local ent = ents.Create("prop_physics")
        if not IsValid(ent) then break end

        ent:SetModel(MODELS[math.random(#MODELS)])

        ent:SetPos(
            origin + Vector(
                math.cos(step * i) * RADIUS,
                math.sin(step * i) * RADIUS,
                HEIGHT
            )
        )

        if ent.CPPISetOwner then
            ent:CPPISetOwner(context.Player)
        end

        ent:Spawn()

        context.Props[i] = ent
    end

    -- Print some help
    context.Player:PrettyPrintLang("chu-rtd", x.ColorGreen, { self.LanguagePhrases.help })
end

function effect:OnTick(context)
    if #context.Props == 0 then
        return context:Stop()
    end

    local origin = context.Player:GetShootPos()
    origin.z = origin.z + HEIGHT

    local step = math.tau / #context.Props
    local spin = (CurTime() * 2) % TAU2

    for i, prop in ipairs(context.Props) do
        if IsValid(prop) then
            local phys = prop:GetPhysicsObject()

            if IsValid(phys) then
                local src = prop:GetPos()

                local dest

                local mass = phys:GetMass()
                local vel = phys:GetVelocity()

                if context.Player:Crouching() then
                    dest = context.Player:GetEyeTrace().HitPos

                    vel = vel / 20
                else
                    vel = vel / 3

                    dest = origin + Vector(
                        math.cos((step * i) + spin) * RADIUS,
                        math.sin((step * i) + spin) * RADIUS,
                        0
                    )
                end

                phys:ApplyForceCenter((dest - src) * mass - vel * mass)
            end
        end
    end
end

function effect:OnEnded(context)
    for _, prop in ipairs(context.Props) do
        SafeRemoveEntity(prop)
    end
end
