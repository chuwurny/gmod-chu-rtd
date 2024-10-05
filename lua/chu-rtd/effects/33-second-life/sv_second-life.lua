local effect = chuRtd.Effects:Get("second-life")

effect.SPAWN_DELAY_SOUND = "hl1/ambience/particle_suck2.wav"
effect.SPAWN_SOUND       = "hl1/ambience/particle_suck1.wav"

effect.REVIVE_MATERIAL = "models/props_combine/tprings_globe"

effect.RESPAWN_DELAY    = 4
effect.GODMODE_DURATION = 5

effect.STAGE_RESPAWN = 0
effect.STAGE_REVIVE  = 1

function effect:OnEnded(context)
    if context.Player:Alive() then return end

    context.Player.rtdSecondLifeStage = self.STAGE_RESPAWN

    context.Player:EmitSound(self.SPAWN_DELAY_SOUND)

    local deathPos = context.Player:GetPos()

    local timerId = "rtd second life " .. context.Player:UserID()

    timer.Create(timerId, self.RESPAWN_DELAY, 1, function()
        if not IsValid(context.Player) then return end

        context.Player.rtdSecondLifeStage = self.STAGE_REVIVE

        x.PrettyPrintLangAll(
            "chu-rtd",
            team.GetColor(context.Player:Team()),
            context.Player:Nick(),
            " ",
            x.ColorRed,
            { self.LanguagePhrases.revives }
        )

        local eyeAngles = context.Player:EyeAngles()

        context.Player:Spawn()

        context.Player:EmitSound(self.SPAWN_SOUND)

        timer.Create(timerId, 0, 1, function()
            if not IsValid(context.Player) then return end

            local oMaterial = context.Player:GetMaterial()

            context.Player:SetPos(deathPos)
            context.Player:SetEyeAngles(eyeAngles)
            context.Player:GodEnable()
            context.Player:SetMaterial(self.REVIVE_MATERIAL)

            context.Player:PrettyPrintLang(
                "chu-rtd",
                x.ColorGreen,
                { self.LanguagePhrases.youGotGodmode, self.GODMODE_DURATION }
            )

            timer.Create(timerId, self.GODMODE_DURATION, 1, function()
                if not IsValid(context.Player) then return end

                context.Player:GodDisable()
                context.Player:SetMaterial(oMaterial)
            end)
        end)
    end)
end

hook.Add("PlayerDeathThink", "rtd second life", function(ply)
    if ply.rtdSecondLifeStage == effect.STAGE_RESPAWN then
        return true
    end
end, HOOK_MONITOR_LOW)

hook.Add("PostPlayerDeath", "rtd second life", function(ply)
    if ply.rtdSecondLifeStage == effect.STAGE_REVIVE then
        timer.Remove("rtd second life " .. ply:UserID())

        ply.rtdSecondLifeStage = nil
    end
end)
