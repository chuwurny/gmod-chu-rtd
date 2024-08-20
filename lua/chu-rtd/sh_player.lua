local PLAYER = FindMetaTable("Player")

function PLAYER:GetRtdEffect()
    local idx = self:GetNWInt("churtd effect", 0)

    if idx == 0 then
        return nil
    end

    local effect = chuRtd.Effects.Values[idx]

    x.Assert(effect, "Player has unknown rtd effect? Index: %d", idx)

    return effect
end

function PLAYER:GetRtdEffectId()
    local effect = self:GetRtdEffect()

    if not effect then
        return nil
    end

    return effect.Id
end

function PLAYER:IsRtdActive()
    return self:GetNWInt("churtd effect", 0) ~= 0
end

function PLAYER:GetRtdStartTime()
    if not self:IsRtdActive() then
        return 0
    end

    return self:GetNW2Float("churtd starttime", 0)
end

function PLAYER:GetRtdEndTime()
    if not self:IsRtdActive() then
        return 0
    end

    return self:GetNW2Float("churtd endtime", 0)
end
