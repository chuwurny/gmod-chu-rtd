local effect = chuRtd.Effects:Get("zombie")

function effect:OnRolled(ply, data)
    data.oRunSpeed = ply:GetRunSpeed()

    ply:SetRunSpeed(data.oRunSpeed + 250)
end

function effect:OnEnded(ply, data)
    ply:SetRunSpeed(data.oRunSpeed)
end

function effect:OnTick(ply)
    local crowbar = ply:GetWeapon("weapon_crowbar")

    if not IsValid(crowbar) then
        crowbar = ply:Give("weapon_crowbar")
    end

    if ply:GetActiveWeapon() ~= crowbar then
        ply:SelectWeapon(crowbar)
    end

    if ply:TimeoutAction("rtd zombie sound", 1) then
        ply:EmitSound("npc/zombie/zombie_voice_idle" .. math.random(1, 14) .. ".wav")
    end
end

effect:Hook("StartCommand", function(ply, cmd)
    if ply:GetRtdEffect() ~= effect then return end

    if ply:TimeoutAction("rtd zombie jump", 2) and cmd:KeyDown(IN_JUMP) then
        ply:EmitSound("player/drown" .. math.random(1, 3) .. ".wav")
    end
end)
