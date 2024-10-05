local effect = chuRtd.Effects:Get("drunk")

function effect:Drug(ply)
    local randang = Angle(
        math.Rand(-10, 10),
        math.Rand(-10, 10),
        math.Rand(-10, 10)
    )

    ply:ViewPunch(randang)

    ply:ScreenFade(
        SCREENFADE.PURGE,
        Color(
            math.random(0, 255),
            math.random(0, 255),
            math.random(0, 255),
            100
        ),
        0.1,
        0.1
    )
end

function effect:OnTick(context)
    self:Drug(context.Player)
end
