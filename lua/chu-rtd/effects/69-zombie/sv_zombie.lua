local effect = chuRtd.Effects:Get("zombie")

function effect:OnRolled(context)
    context.oRunSpeed = context.Player:GetRunSpeed()

    context.Player:SetRunSpeed(context.oRunSpeed + 250)
end

function effect:OnEnded(context)
    context.Player:SetRunSpeed(context.oRunSpeed)
end

function effect:OnTick(context)
    local crowbar = context.Player:GetWeapon("weapon_crowbar")

    if not IsValid(crowbar) then
        crowbar = context.Player:Give("weapon_crowbar")
    end

    if context.Player:GetActiveWeapon() ~= crowbar then
        context.Player:SelectWeapon(crowbar)
    end

    if context.Player:TimeoutAction("rtd zombie sound", 1) then
        context.Player:EmitSound("npc/zombie/zombie_voice_idle" .. math.random(1, 14) .. ".wav")
    end
end

hook.Add("StartCommand", "rtd zombie", function(ply, cmd)
    if not ply:HasRolledRtdEffect(effect) then return end

    if ply:TimeoutAction("rtd zombie jump", 2) and cmd:KeyDown(IN_JUMP) then
        ply:EmitSound("player/drown" .. math.random(1, 3) .. ".wav")
    end
end)
