TeamAIBase = TeamAIBase or class(CopBase)

-- Lines 3-18
function TeamAIBase:post_init()
	self._ext_movement = self._unit:movement()
	self._ext_anim = self._unit:anim_data()

	self._ext_movement:post_init(true)
	self._unit:brain():post_init()
	self:set_anim_lod(1)

	self._lod_stage = 1
	self._allow_invisible = true

	self:_register()
	managers.occlusion:remove_occlusion(self._unit)
end

-- Lines 22-25
function TeamAIBase:nick_name()
	local name = self._tweak_table

	return managers.localization:text("menu_" .. name)
end

-- Lines 29-31
function TeamAIBase:default_weapon_name(slot)
	return tweak_data.character[self._tweak_table].weapon.weapons_of_choice[slot or "primary"]
end

-- Lines 35-37
function TeamAIBase:arrest_settings()
	return tweak_data.character[self._tweak_table].arrest
end

-- Lines 41-44
function TeamAIBase:pre_destroy(unit)
	self:unregister()
	UnitBase.pre_destroy(self, unit)
end

-- Lines 48-50
function TeamAIBase:save(data)
	data.base = {
		tweak_table = self._tweak_table
	}
end

-- Lines 54-58
function TeamAIBase:on_death_exit()
	TeamAIBase.super.on_death_exit(self)
	self:unregister()
	self:set_slot(self._unit, 0)
end

-- Lines 62-67
function TeamAIBase:_register()
	if not self._registered then
		managers.groupai:state():register_criminal(self._unit)

		self._registered = true
	end
end

-- Lines 71-82
function TeamAIBase:unregister()
	if self._registered then
		if Network:is_server() then
			self._unit:brain():attention_handler():set_attention(nil)
		end

		if managers.groupai:state():all_AI_criminals()[self._unit:key()] then
			managers.groupai:state():unregister_criminal(self._unit)
		end

		self._char_name = managers.criminals:character_name_by_unit(self._unit)
		self._registered = nil
	end
end

-- Lines 86-87
function TeamAIBase:chk_freeze_anims()
end