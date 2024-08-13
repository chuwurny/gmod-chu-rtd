local effect = chuRtd.Effects:Get("dissolving-bullets")

chuRtd.Helpers.PostDamage(effect, function(target, dmg)
    target:Dissolve()
end)
