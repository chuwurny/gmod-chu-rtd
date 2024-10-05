chuRtd.EFFECT_CONTEXT = chuRtd.EFFECT_CONTEXT or {}

local EFFECT_CONTEXT = chuRtd.EFFECT_CONTEXT
EFFECT_CONTEXT.__index = EFFECT_CONTEXT

function EFFECT_CONTEXT:Duration()
    if self.Effect._Once then
        return 0
    end

    return self.EndTime - self.StartTime
end

function EFFECT_CONTEXT:IsExpired()
    if self.Effect._Once then
        return true
    end

    return CurTime() > self.EndTime
end

function EFFECT_CONTEXT:IsValid()
    return IsValid(self.Player) and not self:IsExpired()
end

if SERVER then
    function EFFECT_CONTEXT:Stop(reasonPhrase)
        return chuRtd.Stop(self.Player, self.Effect.Id, reasonPhrase)
    end
end

--
-- Helpers
--

function EFFECT_CONTEXT:ShouldTarget(target)
    return hook.Run("ChuRtdShouldTarget",
                    self.Effect,
                    self.Player,
                    target) ~= false
end

function EFFECT_CONTEXT:FindNearestTarget(filter, maxDistance)
    return chuRtd.Helpers.FindNearestPlayer(
        self.Player:GetPos(),
        function(target)
            if target == self.Player then
                return false
            end

            if not self:ShouldTarget(target) then
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

function chuRtd._EffectContextEx(ply, effect, startTime, endTime)
    return setmetatable({
        Player    = ply,
        Effect    = effect,
        StartTime = startTime,
        EndTime   = endTime,
    }, EFFECT_CONTEXT)
end

if SERVER then
    function chuRtd._EffectContext(ply, effect, duration)
        return chuRtd._EffectContextEx(
            ply,
            effect,
            CurTime(),
            CurTime() + duration
        )
    end
end

do
    local tempContext = setmetatable({
        StartTime = 0,
        EndTime   = 0,
    }, EFFECT_CONTEXT)

    function chuRtd.TempEffectContext(ply, effect)
        tempContext.Player = ply
        tempContext.Effect = effect

        return tempContext
    end
end

function chuRtd.FakeEffectContext(ply, effect)
    return setmetatable({
        Player    = ply,
        Effect    = effect,
        StartTime = 0,
        EndTime   = 0,
    }, EFFECT_CONTEXT)
end
