local effect = chuRtd.Effect("beacon", chuRtd.COLOR_EVIL)

if CLIENT then
    local SEGMENTS = 18
    local WIDTH = 10
    local START_RADIUS = 10
    local END_RADIUS = 1000

    local PI2 = math.pi * 2

    local beacons = {}

    function effect:AddBeacon(pos, duration, color)
        table.insert(beacons, {
            Pos = pos,
            Duration = duration,
            Color = color,

            StartTime = CurTime(),
            EndTime = CurTime() + duration
        })
    end

    function chuRtd.__AddBeacon(pos, duration, color)
        effect:AddBeacon(pos, duration, color)
    end

    function effect:RenderBeacon(beacon)
        local step = PI2 / (SEGMENTS - 1)

        render.StartBeam(SEGMENTS)

        for i = 1, SEGMENTS do
            local d = 1 - ((beacon.EndTime - CurTime()) / beacon.Duration)
            local r = Lerp(d, START_RADIUS, END_RADIUS)

            local pos = Vector(
                beacon.Pos.x + (math.cos(i * step) * r),
                beacon.Pos.y + (math.sin(i * step) * r),
                beacon.Pos.z
            )

            render.AddBeam(pos, WIDTH, 0, beacon.Color)
        end

        render.EndBeam()
    end

    hook.Add("PostDrawOpaqueRenderables", "rtd beacon", function()
        local t = CurTime()

        render.SetColorMaterial()

        x.FilterSequence(beacons, function(beam)
            if t > beam.EndTime then
                return false
            end

            effect:RenderBeacon(beam)

            return true
        end)
    end)
end
