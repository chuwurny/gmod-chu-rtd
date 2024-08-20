local effect = chuRtd.Effect("beam", chuRtd.COLOR_EVIL)

if CLIENT then
    local SEGMENTS = 18
    local WIDTH = 10
    local START_RADIUS = 10
    local END_RADIUS = 1000

    local PI2 = math.pi * 2

    local beams = {}

    function effect:AddBeam(pos, duration, color)
        table.insert(beams, {
            Pos = pos,
            Duration = duration,
            Color = color,

            StartTime = CurTime(),
            EndTime = CurTime() + duration
        })
    end

    function chuRtd.__AddBeam(pos, duration, color)
        effect:AddBeam(pos, duration, color)
    end

    function effect:RenderBeam(beamData)
        local step = PI2 / (SEGMENTS - 1)

        render.StartBeam(SEGMENTS)

        for i = 1, SEGMENTS do
            local d = 1 - ((beamData.EndTime - CurTime()) / beamData.Duration)
            local r = Lerp(d, START_RADIUS, END_RADIUS)

            local pos = Vector(
                beamData.Pos.x + (math.cos(i * step) * r),
                beamData.Pos.y + (math.sin(i * step) * r),
                beamData.Pos.z
            )

            render.AddBeam(pos, WIDTH, 0, beamData.Color)
        end

        render.EndBeam()
    end

    effect:Hook("PostDrawOpaqueRenderables", function()
        local t = CurTime()

        render.SetColorMaterial()

        x.FilterSequence(beams, function(beam)
            if t > beam.EndTime then
                return false
            end

            effect:RenderBeam(beam)

            return true
        end)
    end)
end
