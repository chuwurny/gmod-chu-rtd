local effect = chuRtd.Effects:Get("lets-build")

function effect:OnRolled(ply)
    ply:StripWeapons()

    ply:Give("weapon_physgun")
    ply:Give("gmod_tool")

    ply:RPC("chuRtd.__SayRandomBuildPhrase")
end
