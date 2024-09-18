x.Dependency("chu-rtd", "sh_main.lua")
x.Dependency("chu-rtd", "sh_colors.lua")
x.Dependency("chu-rtd", "sh_effect.lua")
x.Dependency("chu-rtd/effects")

chuRtd.LanguageContext = chuRtd.LanguageContext or x.LanguageContext("chu-rtd")

function chuRtd.LanguageContext:OnLanguageChanged()
    if chuRtd.UlxRtdCommand then
        chuRtd.UlxRtdCommand:help(self:Phrase("command-help"))
    end
end

local ctx = chuRtd.LanguageContext

ctx:DefineLanguagePhrase("rolled-effect")
ctx:DefineLanguagePhrase("with-duration")
ctx:DefineLanguagePhrase("seconds")
ctx:DefineLanguagePhrase("effect-ended")
ctx:DefineLanguagePhrase("died-with-active-effect")
ctx:DefineLanguagePhrase("you-already-have-rtd")
ctx:DefineLanguagePhrase("command-help")

for _, effect in ipairs(chuRtd.Effects.Values) do
    local phrasePrefix = "effect." .. effect.Id .. "."

    ctx:DefineLanguagePhrase(phrasePrefix .. "name")

    if not effect._LanguagePhrasesAltered then
        effect._LanguagePhrasesAltered = true

        for k, phrase in pairs(effect.LanguagePhrases) do
            phrase = phrasePrefix .. phrase

            effect.LanguagePhrases[k] = phrase

            ctx:DefineLanguagePhrase(phrase)
        end
    end
end

xorlib.RecursiveInclude(xorlib.SharedIncluder, "chu-rtd/languages")
