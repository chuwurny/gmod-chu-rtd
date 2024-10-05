local effect = chuRtd.Effects:Get("its-raining-nades")

function effect:OnTick(context)
    if not context.Player:TimeoutAction("rtd raining nades", 0.5) then return end

    local nade = ents.Create("npc_grenade_frag")
    if not IsValid(nade) then return end

    nade:SetPos(context.Player:GetShootPos())
    nade:SetOwner(context.Player)
    nade:Spawn()
    nade:Activate()

    nade:Fire("SetTimer", 2)
end
