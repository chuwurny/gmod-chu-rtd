local effect = chuRtd.Effects:Get("aimbot")

function effect:CalculcateAimPos(target)
    local headId = target:LookupBone("ValveBiped.Bip01_Head1")

    if headId then
        local headPos = target:GetBonePosition(headId)

        return headPos
    end

    return target:GetShootPos()
end

function effect:CheckIfVisible(attacker, target, customPos)
    customPos = customPos or (target:GetPos() + Vector(0, 0, target:OBBMaxs().z / 2))

    local tr = util.TraceLine({
        start = attacker:GetShootPos(),
        endpos = customPos,
        filter = attacker,
    })

    return tr.Entity == target
end

effect:HookLocalPlayer("CreateMove", function(self, lp, _, cmd)
    local aimPos

    local target = chuRtd.Helpers.FindNearestTarget(lp, function(target)
        aimPos = self:CalculcateAimPos(target)

        return self:CheckIfVisible(lp, target, aimPos)
    end)

    if not IsValid(target) then return end

    -- TODO: seems like rubat broke prediction completely (at least on loopback
    -- server it aims on serverside position rather than predicted interpolated
    -- prettiest clientside position) but it somehow works

    cmd:SetViewAngles((aimPos - lp:GetShootPos()):Angle())
end)
