local effect = chuRtd.Effect("dizzy", "Слабость")

if CLIENT then
    effect:HookLocalPlayer("CreateMove", function(_, _, cmd)
        local ang = cmd:GetViewAngles()

        if ang.p < 40 then
            ang.p = math.min(90, ang.p + 0.2)
        end

        cmd:SetViewAngles(ang)
    end)
end
