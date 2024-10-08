x.Dependency("chu-rtd", "sh_types.lua")
x.Dependency("chu-rtd", "cl_rtd.lua")
x.Dependency("chu-rtd", "sh_language.lua")

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

function EFFECT:LanguagePhrase(phraseId, customKey)
    phraseId = "effect." .. self.Id .. "." .. phraseId

    if customKey ~= nil then
        self.LanguagePhrases[customKey] = phraseId
    else
        table.insert(self.LanguagePhrases, phraseId)
    end

    chuRtd.LanguageContext:DefineLanguagePhrase(phraseId)

    return self
end

function EFFECT:Conflicts(effectId, ...)
    if effectId == nil then
        return self
    end

    self._Conflicts[effectId] = true

    return self:Conflicts(...)
end

function EFFECT:DisconnectAware()
    self._DisconnectAware = true

    return self
end

function EFFECT:OnlyLocalPlayer()
    if CLIENT then
        self._OnlyLocalPlayer = true
    end

    return self
end

function EFFECT._NO_FORMAT_MESSAGE(context)
end

function EFFECT:CanRoll(ply)
    -- for override

    return true
end

-- for override
EFFECT.FormatMessage = EFFECT._NO_FORMAT_MESSAGE

function EFFECT:OnRolled(context)
    -- for override
end

function EFFECT:OnTick(context)
    -- for override
end

function EFFECT:OnEnded(context)
    -- for override
end

if CLIENT then
    function EFFECT:HookLocalPlayer(event, callback, priority)
        hook.Add(event, "rtd " .. self.Id, function(...)
            local lp = LocalPlayer()

            if not IsValid(lp) then return end
            if not lp:HasRolledRtdEffect(self) then return end

            local context = lp.RolledRtdEffects:Get(self.Id)

            return callback(self, context, ...)
        end, priority)
    end
end

function chuRtd.Effect(id, type)
    local effect = setmetatable({
        Id = id,

        PhraseName = "effect." .. id .. ".name",
        Type = type,

        _Once = false,
        _Duration = nil,

        LanguagePhrases = {},
        _Conflicts = {},

        _DisconnectAware = false,
        _OnlyLocalPlayer = false,
    }, EFFECT)

    chuRtd.Effects:Set(id, effect)

    chuRtd.LanguageContext:DefineLanguagePhrase(effect.PhraseName)

    return effect
end
