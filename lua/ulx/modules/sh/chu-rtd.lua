x.Dependency("chu-rtd", "sh_main.lua")
x.Dependency("chu-rtd", "sh_language.lua")

function ulx.rtd(calling_ply)
    calling_ply:TryRtdRandom()
end

chuRtd.UlxRtdCommand = ulx.command("RTD", "ulx rtd", ulx.rtd, "!rtd")
chuRtd.UlxRtdCommand:defaultAccess(ULib.ACCESS_ALL)
chuRtd.UlxRtdCommand:help(chuRtd.LanguageContext:Phrase("command-help"))
