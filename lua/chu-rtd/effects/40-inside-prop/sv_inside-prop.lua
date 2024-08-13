local effect = chuRtd.Effects:Get("inside-prop")

local MODELS =
{
    "models/props_c17/chair02a.mdl",
    "models/props_c17/oildrum001.mdl",
    "models/props_c17/oildrum001_explosive.mdl",
    "models/props_junk/TrashBin01a.mdl",
    "models/props_junk/wood_crate001a.mdl",
    "models/props_junk/wood_crate002a.mdl",
    "models/props_junk/TrafficCone001a.mdl",
    "models/props_interiors/VendingMachineSoda01a.mdl",
    "models/props_borealis/bluebarrel001.mdl",
    "models/props_wasteland/laundry_dryer002.mdl"
}

function effect:OnRolled(ply, data)
    local ent = ents.Create("prop_physics")

    if not IsValid(ent) then
        return ply:StopRtd()
    end

    data.oMoveType = ply:GetMoveType()

    ply:ExitVehicle()
    ply:SetMoveType(MOVETYPE_NONE)

    data.Prop = ent

    ent:SetPos(ply:GetPos())
    ent:SetModel(MODELS[math.random(#MODELS)])
    ent:SetPos(ply:GetPos())
    ply:SetParent(ent)
    ent:Spawn()
end

function effect:OnTick(ply, data)
    if not IsValid(data.Prop) then
        return ply:StopRtd()
    end
end

function effect:OnEnded(ply, data)
    SafeRemoveEntity(data.Prop)

    if data.oMoveType then
        ply:SetMoveType(data.oMoveType)
    end

    ply:SetEyeAngles(Angle())
end
