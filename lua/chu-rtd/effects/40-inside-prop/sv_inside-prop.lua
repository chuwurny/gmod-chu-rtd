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

function effect:OnRolled(context)
    local ent = ents.Create("prop_physics")

    if not IsValid(ent) then
        return context.Player:StopRtd()
    end

    context.oMoveType = context.Player:GetMoveType()

    context.Player:ExitVehicle()
    context.Player:SetMoveType(MOVETYPE_NONE)

    context.Prop = ent

    ent:SetPos(context.Player:GetPos())
    ent:SetModel(MODELS[math.random(#MODELS)])
    ent:SetPos(context.Player:GetPos())
    context.Player:SetParent(ent)
    ent:Spawn()
end

function effect:OnTick(context)
    if not IsValid(context.Prop) then
        return context:Stop()
    end
end

function effect:OnEnded(context)
    SafeRemoveEntity(context.Prop)

    if context.oMoveType then
        context.Player:SetMoveType(context.oMoveType)
    end

    context.Player:SetEyeAngles(Angle())
end
