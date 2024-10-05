chuRtd = chuRtd or {}
chuRtd.Helpers = chuRtd.Helpers or {}
chuRtd.Effects = chuRtd.Effects or x.Map()

-- Sort effects to ensure indices are same
x.EnsureInitPostEntity(function()
    chuRtd.Effects:Sort(function(a, b)
        return a.Id > b.Id
    end)
end)

hook.Add("PlayerReady", "churtd init player", function(ply)
    ply.RolledRtdEffects = x.Map()
end)
