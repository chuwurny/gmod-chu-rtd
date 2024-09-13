function chuRtd.Helpers.ShouldTarget(attacker, target)
    local effect = x.Assert(
        attacker:GetRtdEffect(),
        "ShouldTarget can't be called when attacker has no active rtd effect"
    )

    return hook.Run("ChuRtdShouldTarget", effect, attacker, target) ~= false
end
