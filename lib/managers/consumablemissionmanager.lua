ConsumableMissionManager = ConsumableMissionManager or class()
ConsumableMissionManager.VERSION = 1

-- Lines 16-25
function ConsumableMissionManager:init()
	if not Global.consumable_missions_manager then
		Global.consumable_missions_manager = {
			inventory = {},
			intel_spawn_modifier = 0
		}
	end

	self._registered_intel_documents = {}
	self._peer_document_spawn_chances = {}
end

-- Lines 28-35
function ConsumableMissionManager:reset()
	Global.consumable_missions_manager = {
		inventory = {},
		intel_spawn_modifier = 0
	}
	self._registered_intel_documents = {}
	self._peer_document_spawn_chances = {}
end

-- Lines 38-57
function ConsumableMissionManager:system_start_raid()
	local current_job = managers.raid_job:current_job()

	if not current_job or not current_job.consumable then
		return
	end

	if not self:is_mission_unlocked(current_job.job_id) then
		Application:error("[ConsumableMissionManager][system_start_raid] Attempting to start a consumable a mission that is not unlocked: ", current_job.job_id)

		return
	end

	if Network:is_server() then
		self:consume_mission(current_job.job_id)
		managers.savefile:save_game(SavefileManager.SETTING_SLOT)
	end
end

-- Lines 59-63
function ConsumableMissionManager:register_document(unit, world_id)
	self._registered_intel_documents[world_id] = self._registered_intel_documents[world_id] or {}
	local loot_data = {
		unit = unit,
		world_id = world_id
	}

	table.insert(self._registered_intel_documents[world_id], loot_data)
end

-- Lines 66-111
function ConsumableMissionManager:plant_document_on_level(world_id)
	Application:trace("[ConsumableMissionManager][plant_document_on_level]")

	if not Network:is_server() or Application:editor() or not self._registered_intel_documents[world_id] then
		return
	end

	local difficulty = Global.game_settings and Global.game_settings.difficulty or Global.DEFAULT_DIFFICULTY
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	local document_spawn_chance = -0.1

	if not self:is_any_mission_unlocked() then
		document_spawn_chance = tweak_data.operations.consumable_missions.base_document_spawn_chance[difficulty_index]
		document_spawn_chance = document_spawn_chance + Global.consumable_missions_manager.intel_spawn_modifier
	end

	for index, chance_data in pairs(self._peer_document_spawn_chances) do
		if document_spawn_chance < chance_data.chance then
			document_spawn_chance = chance_data.chance
		end
	end

	local chosen_document_unit = nil

	if math.random() <= math.clamp(document_spawn_chance, -1, 1) then
		math.shuffle(self._registered_intel_documents[world_id])

		chosen_document_unit = self._registered_intel_documents[world_id][1].unit

		self:reset_document_spawn_modifier()
		managers.network:session():send_to_peers("reset_document_spawn_chance_modifier")
	end

	for index, document in pairs(self._registered_intel_documents[world_id]) do
		if alive(document.unit) and document.unit ~= chosen_document_unit then
			document.unit:set_slot(0)
		end
	end

	self._registered_intel_documents[world_id] = nil
end

-- Lines 114-125
function ConsumableMissionManager:sync_document_spawn_chance()
	local document_spawn_chance = 0

	if not self:is_any_mission_unlocked() then
		local difficulty = Global.game_settings and Global.game_settings.difficulty or Global.DEFAULT_DIFFICULTY
		local difficulty_index = tweak_data:difficulty_to_index(difficulty)
		document_spawn_chance = tweak_data.operations.consumable_missions.base_document_spawn_chance[difficulty_index]
		document_spawn_chance = document_spawn_chance + Global.consumable_missions_manager.intel_spawn_modifier
	end

	managers.network:session():send_to_host("sync_document_spawn_chance", document_spawn_chance)
end

-- Lines 127-129
function ConsumableMissionManager:on_document_spawn_chance_received(chance, peer_id)
	table.insert(self._peer_document_spawn_chances, {
		chance = chance,
		peer_id = peer_id
	})
end

-- Lines 132-141
function ConsumableMissionManager:is_any_mission_unlocked()
	local any_mission_unlocked = false

	for index, mission in pairs(Global.consumable_missions_manager.inventory) do
		any_mission_unlocked = true

		break
	end

	return any_mission_unlocked
end

-- Lines 144-146
function ConsumableMissionManager:is_mission_unlocked(mission_name)
	return Global.consumable_missions_manager.inventory[mission_name] ~= nil
end

-- Lines 149-152
function ConsumableMissionManager:pickup_mission(mission_name)
	self._picked_up_missions = self._picked_up_missions or {}

	table.insert(self._picked_up_missions, mission_name)
end

-- Lines 154-157
function ConsumableMissionManager:reset_document_spawn_modifier()
	Global.consumable_missions_manager.intel_spawn_modifier = 0
	self._reset_spawn_modifier = true
end

-- Lines 161-186
function ConsumableMissionManager:on_level_exited(success)
	if self._level_exit_handled then
		return
	end

	if success and self._picked_up_missions then
		if #self._picked_up_missions > 0 then
			for _, mission_name in ipairs(self._picked_up_missions) do
				self:_unlock_mission(mission_name)

				Global.consumable_missions_manager.intel_spawn_modifier = 0
			end
		else
			Global.consumable_missions_manager.intel_spawn_modifier = math.clamp(Global.consumable_missions_manager.intel_spawn_modifier + tweak_data.operations.consumable_missions.spawn_chance_modifier_increase, 0, 1)
		end
	end

	if self._reset_spawn_modifier then
		Global.consumable_missions_manager.intel_spawn_modifier = 0
		self._reset_spawn_modifier = false
	end

	self._picked_up_missions = {}
	self._registered_intel_documents = {}
	self._peer_document_spawn_chances = {}
	self._level_exit_handled = true
end

-- Lines 189-192
function ConsumableMissionManager:on_mission_started()
	self._level_exit_handled = false

	self:system_start_raid()
end

-- Lines 195-197
function ConsumableMissionManager:on_mission_completed(success)
	self._level_exit_handled = false
end

-- Lines 200-221
function ConsumableMissionManager:_unlock_mission(mission_name)
	Application:trace("[ConsumableMissionManager][_unlock_mission] Unlocking the mission: ", mission_name)

	if self:is_mission_unlocked(mission_name) then
		Application:error("[ConsumableMissionManager][_unlock_mission] Attempting to unlock a mission that is already unlocked: ", mission_name)

		return
	end

	local mission_data = tweak_data.operations:mission_data(mission_name)

	if not mission_data.consumable then
		Application:error("[ConsumableMissionManager][_unlock_mission] Attempting to unlock a mission that is not consumable: ", mission_name)

		return
	end

	Global.consumable_missions_manager.inventory[mission_name] = true

	managers.breadcrumb:add_breadcrumb(BreadcrumbManager.CATEGORY_CONSUMABLE_MISSION, {
		mission_name
	})
end

-- Lines 233-237
function ConsumableMissionManager:consume_mission(mission_name)
	Application:trace("[ConsumableMissionManager:consume_mission] Consuming the mission: ", mission_name)

	Global.consumable_missions_manager.inventory[mission_name] = nil
end

-- Lines 241-255
function ConsumableMissionManager:save(data)
	local state = {
		version = ConsumableMissionManager.VERSION,
		inventory = {},
		intel_spawn_modifier = Global.consumable_missions_manager.intel_spawn_modifier
	}

	for mission_name, _ in pairs(Global.consumable_missions_manager.inventory) do
		table.insert(state.inventory, mission_name)
	end

	data.ConsumableMissionManager = state
end

-- Lines 259-293
function ConsumableMissionManager:load(data, version)
	Global.consumable_missions_manager.inventory = {}
	Global.consumable_missions_manager.intel_spawn_modifier = 0
	local state = data.ConsumableMissionManager

	if not state then
		return
	end

	if state.version and state.version ~= ConsumableMissionManager.VERSION then
		Application:error("[ConsumableMissionManager:load] Saved consumable missions version: ", state.version, ", current version: ", ConsumableMissionManager.VERSION, ". Resetting the inventory.")

		return
	end

	Global.consumable_missions_manager.intel_spawn_modifier = state.intel_spawn_modifier or 0

	for _, mission_name in ipairs(state.inventory) do
		local mission_data = tweak_data.operations:mission_data(mission_name)

		if not mission_data or not mission_data.consumable then
			Application:error("[ConsumableMissionManager:load] Mission no longer exists or is not consumable: ", mission_name)
		else
			Global.consumable_missions_manager.inventory[mission_name] = true
		end
	end
end
