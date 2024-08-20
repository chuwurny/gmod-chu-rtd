local effect = chuRtd.Effect("lets-build", chuRtd.COLOR_NEUTRAL):Once()

effect.LanguagePhrases = {
    "oh-i-love-building",
    "bob-the-builder-can-we-fix-it",
    "bought-gmod-to-build",
    "i-hate-pvp-lets-build",
    "im-gonna-build-huge-d-i-mean-house",
}

if CLIENT then
    function effect:SayRandomPhrase()
        local phraseId = self.LanguagePhrases[math.random(#self.LanguagePhrases)]

        RunConsoleCommand("say", chuRtd.LanguageContext:Phrase(phraseId))
    end

    function chuRtd.__SayRandomBuildPhrase()
        effect:SayRandomPhrase()
    end
end
