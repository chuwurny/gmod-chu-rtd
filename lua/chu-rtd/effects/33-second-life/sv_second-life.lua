local effect = chuRtd.Effects:Get("second-life")

effect.SPAWN_DELAY_SOUND = "hl1/ambience/particle_suck2.wav"
effect.SPAWN_SOUND       = "hl1/ambience/particle_suck1.wav"

effect.REVIVE_MATERIAL = "models/props_combine/tprings_globe"

effect.RESPAWN_DELAY    = 4
effect.GODMODE_DURATION = 5

effect.STAGE_RESPAWN = 0
effect.STAGE_REVIVE  = 1

function effect:OnEnded(ply)
    if ply:Alive() then return end

    ply.rtdSecondLifeStage = self.STAGE_RESPAWN

    ply:EmitSound(self.SPAWN_DELAY_SOUND)

    local deathPos = ply:GetPos()

    local timerId = "rtd second life " .. ply:UserID()

    timer.Create(timerId, self.RESPAWN_DELAY, 1, function()
        if not IsValid(ply) then return end

        ply.rtdSecondLifeStage = self.STAGE_REVIVE

        x.PrettyPrintLangAll(
            "chu-rtd",
            team.GetColor(ply:Team()),
            ply:Nick(),
            " ",
            x.ColorRed,
            { self.LanguagePhrases.revives }
        )

        local eyeAngles = ply:EyeAngles()

        ply:Spawn()

        ply:EmitSound(self.SPAWN_SOUND)

        timer.Create(timerId, 0, 1, function()
            if not IsValid(ply) then return end

            local oMaterial = ply:GetMaterial()

            ply:SetPos(deathPos)
            ply:SetEyeAngles(eyeAngles)
            ply:GodEnable()
            ply:SetMaterial(self.REVIVE_MATERIAL)

            ply:PrettyPrintLang(
                "chu-rtd",
                x.ColorGreen,
                { self.LanguagePhrases.youGotGodmode, self.GODMODE_DURATION }
            )

            timer.Create(timerId, self.GODMODE_DURATION, 1, function()
                if not IsValid(ply) then return end

                ply:GodDisable()
                ply:SetMaterial(oMaterial)
            end)
        end)
    end)
end

effect:Hook("PlayerDeathThink", function(ply)
    if ply.rtdSecondLifeStage == effect.STAGE_RESPAWN then
        return true
    end
end, HOOK_MONITOR_LOW)

effect:Hook("PostPlayerDeath", function(ply)
    if ply.rtdSecondLifeStage == effect.STAGE_REVIVE then
        timer.Remove("rtd second life " .. ply:UserID())

        ply.rtdSecondLifeStage = nil
    end
end)
