x.Dependency("chu-rtd", "sh_main.lua")
x.Dependency("chu-rtd", "sh_colors.lua")
x.Dependency("chu-rtd", "sh_effect.lua")
x.Dependency("chu-rtd/effects")

chuRtd.LanguageContext = chuRtd.LanguageContext or x.LanguageContext("chu-rtd")

local ctx = chuRtd.LanguageContext

ctx:DefineLanguagePhrase("rolled-effect")
ctx:DefineLanguagePhrase("with-duration")
ctx:DefineLanguagePhrase("seconds")
ctx:DefineLanguagePhrase("effect-ended")
ctx:DefineLanguagePhrase("died-with-active-effect")

for _, effect in ipairs(chuRtd.Effects.Values) do
    local phrasePrefix = "effect." .. effect.Id .. "."

    ctx:DefineLanguagePhrase(phrasePrefix .. "name")

    for _, phrase in ipairs(effect.LanguagePhrases) do
        ctx:DefineLanguagePhrase(phrasePrefix .. phrase)
    end
end

xorlib.RecursiveInclude(xorlib.SharedIncluder, "chu-rtd/languages")
