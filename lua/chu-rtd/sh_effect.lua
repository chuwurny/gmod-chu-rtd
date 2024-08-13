chuRtd.EFFECT = chuRtd.EFFECT or {}

local EFFECT = chuRtd.EFFECT
EFFECT.__index = EFFECT

function EFFECT:Once()
    self._Once = true

    return self
end

function EFFECT:Duration(seconds)
    self._Duration = seconds

    return self
end

function EFFECT:RandDuration(min, max)
    return self:Duration({ Min = min, Max = max })
end

function EFFECT._NO_FORMAT_MESSAGE()
end

function EFFECT:CanRoll(ply)
    -- for override

    return true
end

-- for override
EFFECT.FormatMessage = EFFECT._NO_FORMAT_MESSAGE

function EFFECT:OnRolled(ply, data)
    -- for override
end

function EFFECT:OnTick(ply, data)
    -- for override
end

function EFFECT:OnEnded(ply, data)
    -- for override
end

function EFFECT:Hook(event, callback)
    hook.Add(event, "rtd effect " .. self.Id, function(...)
        callback(...)
    end)
end

if CLIENT then
    function EFFECT:HookLocalPlayer(event, callback)
        hook.Add(event, "rtd effect " .. self.Id, function(...)
            local lp = LocalPlayer()

            if not IsValid(lp) then return end
            if lp:GetRtdEffect() ~= self then return end

            local data = lp.RtdData

            callback(lp, data, ...)
        end)
    end
end

function chuRtd.Effect(id, name)
    local effect = setmetatable({
        Id = id,
        Name = name,

        _Once = false,
        _Duration = nil,
    }, EFFECT)

    chuRtd.Effects:Set(id, effect)

    return effect
end
