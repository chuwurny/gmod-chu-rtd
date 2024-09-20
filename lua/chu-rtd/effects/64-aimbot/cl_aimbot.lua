local effect = chuRtd.Effects:Get("aimbot")

function effect:CalculcateAimPos(target)
    local headId = target:LookupBone("ValveBiped.Bip01_Head1")

    if headId then
        local headPos = target:GetBonePosition(headId)

        return headPos
    end

    return target:GetShootPos()
end

effect:HookLocalPlayer("CreateMove", function(self, lp, _, cmd)
    local target = chuRtd.Helpers.FindNearestTarget(lp)

    if not IsValid(target) then return end

    -- TODO: seems like rubat broke prediction completely (at least on loopback
    -- server it aims on serverside position rather than predicted interpolated
    -- prettiest clientside position) but it somehow works

    local aimPos = self:CalculcateAimPos(target)

    cmd:SetViewAngles((aimPos - lp:GetShootPos()):Angle())
end)
