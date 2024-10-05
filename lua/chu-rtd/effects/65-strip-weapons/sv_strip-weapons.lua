local effect = chuRtd.Effects:Get("strip-weapons")

function effect:OnRolled(context)
    context.Player:StripWeapons()
end
