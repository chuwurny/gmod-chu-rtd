local effect = chuRtd.Effects:Get("bouncy")

effect.BOUNCE_SPEED = 500

function effect:Bounce(ply, direction)
    ply:SetVelocity(direction * self.BOUNCE_SPEED)
end

function effect:OnTick(context)
    -- TODO: recode this crap.
    --
    -- This code is disgusting because i cannot add PhysicsCollide callback to
    -- player nor add ShouldCollide hook and watch player.

    local function trace(dir)
        local tr = util.TraceLine({
            start = context.Player:GetPos(),
            endpos = context.Player:GetPos() + dir,
            filter = context.Player,
        })

        if tr.Hit then
            self:Bounce(context.Player, tr.HitNormal)

            return true
        end

        return false
    end

    local mins = context.Player:OBBMins()
    local maxs = context.Player:OBBMaxs()

    if
        trace(Vector(0, 0, -5)) or
        trace(Vector(0, 0, maxs.z + 5)) or
        trace(Vector(mins.x - 5, 0, 0)) or
        trace(Vector(maxs.x + 5, 0, 0)) or
        trace(Vector(0, mins.y - 5, 0)) or
        trace(Vector(0, maxs.y + 5, 0))
    then
        return
    end
end

hook.Add("EntityTakeDamage", "rtd bouncy", function(ply, dmg)
    if not ply:IsPlayer() then return end
    if not dmg:IsFallDamage() then return end
    if not ply:HasRolledRtdEffect(effect) then return end

    return true
end)
