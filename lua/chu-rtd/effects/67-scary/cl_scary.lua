local effect = chuRtd.Effects:Get("scary")

effect.SCARY_SOUNDS = {
    "Canals.d1_canals_11_wood_creak1",
    "Crane_magnet_creak",
    "eli_lab.attack_creak_1",
    "Canals.d1_canals_01a_wood_creak3",
    "canals_05a_rope_creak",
    "NPC_dog.Ravendoor_Creak",
}

local SCARE_UNTIL_TIME = 0

function effect:Scare(cmd, dirToAvoid, endTime, multiplier)
    local deltaAngles = cmd:GetViewAngles() - dirToAvoid:Angle()

    cmd:SetViewAngles(cmd:GetViewAngles() + (deltaAngles * multiplier))

    surface.PlaySound(self.SCARY_SOUNDS[math.random(#self.SCARY_SOUNDS)])

    SCARE_UNTIL_TIME = endTime
end

hook.Add("HUDPaint", "rtd scary", function()
    if CurTime() > SCARE_UNTIL_TIME then
        return
    end

    surface.SetDrawColor(x.ColorBlack)
    surface.DrawRect(0, 0, ScrW(), ScrH())
end)

function chuRtd.__Scare(dirToAvoid, endTime, multiplier)
    hook.Once("CreateMove", "rtd rpc scare", function(cmd)
        effect:Scare(cmd, dirToAvoid, endTime, multiplier)
    end)
end
