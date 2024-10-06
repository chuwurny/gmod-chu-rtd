x.Dependency("chu-rtd", "sh_main.lua")
x.Dependency("chu-rtd", "sh_colors.lua")
x.Dependency("chu-rtd", "sh_effect.lua")

chuRtd.LanguageContext = chuRtd.LanguageContext or x.LanguageContext("chu-rtd")

x.Dependency("chu-rtd/effects")

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
ctx:DefineLanguagePhrase("cannot-rtd-when-dead")
ctx:DefineLanguagePhrase("command-help")


xorlib.RecursiveInclude(xorlib.SharedIncluder, "chu-rtd/languages")
