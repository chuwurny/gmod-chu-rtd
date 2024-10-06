local effect = chuRtd.Effect("lets-build", chuRtd.TYPE_NEUTRAL):Once()
    :LanguagePhrase("oh-i-love-building")
    :LanguagePhrase("bob-the-builder-can-we-fix-it")
    :LanguagePhrase("bought-gmod-to-build")
    :LanguagePhrase("i-hate-pvp-lets-build")
    :LanguagePhrase("im-gonna-build-huge-d-i-mean-house")

if CLIENT then
    function effect:SayRandomPhrase()
        local phraseId = self.LanguagePhrases[math.random(#self.LanguagePhrases)]

        RunConsoleCommand("say", chuRtd.LanguageContext:Phrase(phraseId))
    end

    function chuRtd.__SayRandomBuildPhrase()
        effect:SayRandomPhrase()
    end
end
