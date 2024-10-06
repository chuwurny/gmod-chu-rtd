x.Dependency("chu-rtd/effects/16-explosion")

local effect = chuRtd.Effects:Get("explosive-bullets")

local explosionEffect = chuRtd.Effects:Get("explosion")

hook.Add("EntityFireBullets", "rtd explosive bullets", function(ply, bullet)
    if not ply:IsPlayer() then return end
    if not ply:HasRolledRtdEffect(effect) then return end

    local oCallback = bullet.Callback

    local function newCallback(_, tr, dmg)
        local damage = 55 - math.Clamp(dmg:GetDamage(), 0, 50)

        explosionEffect:Explode(tr.HitPos, ply, damage, 400)
    end

    if oCallback then
        bullet.Callback = function(...)
            oCallback(...)
            newCallback(...)
        end
    else
        bullet.Callback = newCallback
    end
end)
