local effect = chuRtd.Effects:Get("beacon")

local SOUND = "buttons/blip1.wav"

timer.Create("beacon rtders", 0.5, 0, function()
    for _, ply in player.Iterator() do
        if ply:GetRtdEffect() == effect then
            ply:EmitSound(SOUND)

            x.RPCAll(
                "chuRtd.__AddBeacon",
                ply:GetPos(),
                1.5,
                team.GetColor(ply:Team())
            )
        end
    end
end)
