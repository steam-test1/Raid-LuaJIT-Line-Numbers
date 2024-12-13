SmallLootBase = SmallLootBase or class(UnitBase)

-- Lines 5-9
function SmallLootBase:init(unit)
	UnitBase.init(self, unit, false)

	self._unit = unit

	self:_setup()
end

-- Lines 13-14
function SmallLootBase:_setup()
end

-- Lines 18-37
function SmallLootBase:take(unit)
	if self._empty then
		return
	end

	self:taken()

	if Network:is_client() then
		managers.network:session():send_to_host("sync_small_loot_taken", self._unit)
	end

	managers.dialog:queue_dialog("player_gen_loot_" .. tostring(self._unit:loot_drop()._loot_size), {
		skip_idle_check = true,
		instigator = managers.player:local_player()
	})

	local percentage_picked_up = math.clamp(math.ceil(100 * managers.lootdrop:picked_up_current_leg() / managers.lootdrop:loot_spawned_current_leg()), 0, 100)

	managers.notification:add_notification({
		duration = 2,
		shelf_life = 5,
		id = "hud_hint_grabbed_nazi_gold",
		text = managers.localization:text("hud_hint_grabbed_nazi_gold", {
			AMOUNT = string.format("%d", percentage_picked_up)
		})
	})
end

-- Lines 39-46
function SmallLootBase:taken(skip_sync)
	managers.lootdrop:pickup_loot(self._unit:loot_drop():value(), self._unit)

	if Network:is_server() then
		self:_set_empty()
		managers.network:session():send_to_peers_synched("sync_picked_up_loot_values", managers.lootdrop:picked_up_current_leg(), managers.lootdrop:picked_up_total())
	end
end

-- Lines 48-54
function SmallLootBase:_set_empty()
	self._empty = true

	if not self.skip_remove_unit then
		self._unit:set_slot(0)
	end
end

-- Lines 58-60
function SmallLootBase:save(data)
	data.loot_value = self._unit:loot_drop():value()
end

-- Lines 62-64
function SmallLootBase:load(data)
	self._unit:loot_drop():set_value(data.loot_value)
end

-- Lines 66-68
function SmallLootBase:destroy()
end
