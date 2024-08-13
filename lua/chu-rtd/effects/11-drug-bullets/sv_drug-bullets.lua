x.Dependency("chu-rtd/effects/24-drunk")

local effect = chuRtd.Effects:Get("drug-bullets")

local drunkEffect = chuRtd.Effects:Get("drunk")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    timer.Create("rtd drug bullets unfreeze " .. target:UserID(), engine.TickInterval(), 5, function()
        if not IsValid(target) then return end

        drunkEffect:Drug(target)
    end)
end)
