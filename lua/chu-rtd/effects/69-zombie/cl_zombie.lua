x.Dependency("chu-rtd/helpers", "sh_find.lua")

local cl_forwardspeed = GetConVar("cl_forwardspeed")

local effect = chuRtd.Effects:Get("zombie")

local MAX_DISTANCE = 1000

effect:HookLocalPlayer("CreateMove", function(_, context, cmd)
    cmd:ClearButtons()
    cmd:ClearMovement()

    cmd:AddKey(IN_ATTACK)
    cmd:AddKey(IN_SPEED)

    cmd:SetForwardMove(cl_forwardspeed:GetFloat())

    local target = context:FindNearestTarget(nil, MAX_DISTANCE)

    if IsValid(target) then
        local targetAngle = (target:GetShootPos() - context.Player:GetShootPos()):Angle()
        targetAngle.p = 0

        cmd:SetViewAngles(targetAngle)
    end

    if
        context.Player:TimeoutAction("rtd zombie unstuck", 1) and
        context.Player:GetVelocity():Length() < (context.Player:GetRunSpeed() / 2)
    then
        cmd:SetViewAngles(Angle(0, math.random(-180, 180), 0))
    end

    if context.Player:TimeoutAction("rtd zombie jump", 0.5) then
        cmd:AddKey(IN_JUMP)
        cmd:AddKey(IN_DUCK)
    else
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_DUCK)
    end
end)

effect:HookLocalPlayer("InputMouseApply", function(_, _, cmd)
    cmd:SetMouseX(0)
    cmd:SetMouseY(0)

    return true
end)
