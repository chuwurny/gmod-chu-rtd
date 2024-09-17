local effect = chuRtd.Effects:Get("ignite")

function effect:OnTick(ply)
    if ply:TimeoutAction("rtd ignite", 1) then
        ply:Ignite(1)
    end
end

function effect:OnEnded(ply)
    ply:Extinguish()
end
