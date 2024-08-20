local effect = chuRtd.Effects:Get("its-raining-nades")

function effect:OnTick(ply)
    if not ply:TimeoutAction("rtd raining nades", 0.5) then return end

    local nade = ents.Create("npc_grenade_frag")
    if not IsValid(nade) then return end

    nade:SetPos(ply:GetShootPos())
    nade:SetOwner(ply)
    nade:Spawn()
    nade:Activate()

    nade:Fire("SetTimer", 2)
end
