function chuRtd.Helpers.FindNearestPlayer(origin, filter, maxDistance)
    if filter then
        if type(filter) == "table" then
            local filterSet = x.SetFromSequence(filter)

            filter = function(ent)
                return not filterSet:Has(ent)
            end
        elseif isentity(filter) then
            local filterEnt = filter

            filter = function(ent)
                return ent ~= filterEnt
            end
        end
    end

    local target = nil
    local targetDist = math.huge

    for _, ply in player.Iterator() do
        local dist = ply:GetPos():Distance(origin)

        if
            -- check if distance is within max distance (if set)
            (not maxDistance or dist < maxDistance) and
            -- check if ply is closer to origin
            targetDist > dist and
            -- check if it's not filtered (if set)
            (not filter or filter(ply)) and
            -- check if player is alive
            ply:Alive()
        then
            target = ply
            targetDist = dist
        end
    end

    return target, targetDist
end

function chuRtd.Helpers.FindNearestTarget(attacker, filter, maxDistance)
    return chuRtd.Helpers.FindNearestPlayer(
        attacker:GetPos(),
        function(target)
            if target == attacker then
                return false
            end

            if not chuRtd.Helpers.ShouldTarget(attacker, target) then
                return false
            end

            if filter and not filter(target) then
                return false
            end

            return true
        end,
        maxDistance
    )
end
