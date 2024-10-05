local PLAYER = FindMetaTable("Player")

local function getEffectId(effectId)
    if type(effectId) == "table" then
        return effectId.Id
    end

    return effectId
end

function PLAYER:HasAnyRolledRtdEffect()
    return self.RolledRtdEffects and self.RolledRtdEffects:Length() ~= 0
end

function PLAYER:HasRolledRtdEffect(effectId)
    effectId = getEffectId(effectId)

    return self.RolledRtdEffects and self.RolledRtdEffects:Has(effectId)
end

function PLAYER:GetRtdEffectContext(effectId)
    effectId = getEffectId(effectId)

    return self.RolledRtdEffects and self.RolledRtdEffects:Get(effectId)
end
