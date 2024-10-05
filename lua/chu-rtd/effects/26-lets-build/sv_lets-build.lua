local effect = chuRtd.Effects:Get("lets-build")

function effect:OnRolled(context)
    context.Player:StripWeapons()

    context.Player:Give("weapon_physgun")
    context.Player:Give("gmod_tool")

    context.Player:RPC("chuRtd.__SayRandomBuildPhrase")
end
