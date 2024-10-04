local effect = chuRtd.Effect("wallhack", chuRtd.TYPE_GOOD)

if CLIENT then
    effect:HookLocalPlayer("PreDrawHalos", function()
        halo.Add(player.GetAll(), x.ColorRed, 2, 2, 1, true, true)
    end)
end
