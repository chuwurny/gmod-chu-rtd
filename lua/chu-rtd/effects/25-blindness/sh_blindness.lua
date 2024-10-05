local effect = chuRtd.Effect("blindness", chuRtd.TYPE_EVIL)

if CLIENT then
    local FADE_TIME = 3

    function effect:OnRolled()
        surface.PlaySound("citadel.mo_sorrygordon")
    end

    effect:HookLocalPlayer("HUDPaint", function(_, context)
        local fadeEndTime = context.StartTime + 1
        local fadeDelta = math.min(1, 1 - ((fadeEndTime - CurTime()) / FADE_TIME))

        surface.SetAlphaMultiplier(fadeDelta)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawRect(0, 0, ScrW(), ScrH())
        surface.SetAlphaMultiplier(1)
    end)
end
