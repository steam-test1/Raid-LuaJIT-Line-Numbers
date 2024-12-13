TurretInteractionExt = TurretInteractionExt or class(UseInteractionExt)

-- Lines 3-5
function TurretInteractionExt:interact_distance(...)
	return TurretInteractionExt.super.interact_distance(self, ...)
end

-- Lines 7-9
function TurretInteractionExt:can_select(player)
	return TurretInteractionExt.super.can_select(self, player)
end

-- Lines 11-13
function TurretInteractionExt:check_interupt()
	return TurretInteractionExt.super.check_interupt(self)
end

-- Lines 15-21
function TurretInteractionExt:interact(player)
	TurretInteractionExt.super.super.interact(self, player)
	managers.player:use_turret(self._unit)
	managers.player:set_player_state("turret")
end

-- Lines 23-27
function TurretInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	if not self._active then
		return
	end
end

-- Lines 29-31
function TurretInteractionExt:set_contour(color, opacity)
end
