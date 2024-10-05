local effect = chuRtd.Effects:Get("lazer-cat-eyes")

effect.LAZER_MATERIAL = Material("cable/redlaser")

function effect:CalculateEyesPositionFromCoords(pos, direction)
    local right = direction:Angle():Right()

    local leftEye = pos - (right * 2.5)
    local rightEye = pos + (right * 2.5)

    return leftEye, rightEye
end

function effect:CalculateEyesPosition(target)
    local eyePos

    do
        local headId = target:LookupBone("ValveBiped.Bip01_Head1")

        if headId then
            eyePos = target:GetBonePosition(headId)
            eyePos.z = eyePos.z + 2.5
        else
            eyePos = target:GetShootPos()
        end
    end

    return self:CalculateEyesPositionFromCoords(
        eyePos,
        target:GetEyeTraceNoCursor().Normal
    )
end

function effect:DrawLazers(leftEye, rightEye, destPos)
    cam.Start3D()
    render.SetMaterial(effect.LAZER_MATERIAL)
    render.DrawBeam(leftEye, destPos, 10, 0, 1)
    render.DrawBeam(rightEye, destPos, 10, 0, 1)
    cam.End3D()
end

hook.Add("PostPlayerDraw", "rtd lazer cat eyes", function(ply)
    if not ply:HasRolledRtdEffect(effect) then return end

    local leftEye, rightEye = effect:CalculateEyesPosition(ply)
    local destPos = ply:GetEyeTraceNoCursor().HitPos

    effect:DrawLazers(leftEye, rightEye, destPos)
end)

effect:HookLocalPlayer("PostDrawTranslucentRenderables", function(_, context, depth, skybox, skybox3d)
    if skybox or skybox3d then return end
    if context.Player:ShouldDrawLocalPlayer() then return end

    local shootPos = context.Player:GetShootPos()
    shootPos.z = shootPos.z - 5

    local leftEye, rightEye = effect:CalculateEyesPositionFromCoords(
        shootPos,
        context.Player:GetEyeTraceNoCursor().Normal
    )

    local destPos = context.Player:GetEyeTraceNoCursor().HitPos

    effect:DrawLazers(leftEye, rightEye, destPos)
end)
