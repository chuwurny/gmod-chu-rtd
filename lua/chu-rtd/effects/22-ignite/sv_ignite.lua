local effect = chuRtd.Effects:Get("ignite")

function effect:OnTick(context)
    if context.Player:TimeoutAction("rtd ignite", 1) then
        context.Player:Ignite(1)
    end
end

function effect:OnEnded(context)
    context.Player:Extinguish()
end
