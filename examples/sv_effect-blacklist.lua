local blacklist = {
    ["godmode"] = true,
    ["noclip"] = true,
    ["lets-build"] = true,
    ["inside-prop"] = true,
    ["its-raining-nades"] = true,
    ["x2hp"] = true,
    ["prop-madness"] = true,
    ["strip-weapons"] = true,
}

hook.Add("ChuRtdCanRoll", "effect blacklist", function(ply, effect)
    if blacklist[effect.Id] then
        return false
    end
end)
