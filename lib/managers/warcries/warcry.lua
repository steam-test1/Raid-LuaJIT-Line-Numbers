Warcry = Warcry or class()
Warcry.BERSERK = "berserk"
Warcry.CLUSTERTRUCK = "clustertruck"
Warcry.GHOST = "ghost"
Warcry.SHARPSHOOTER = "sharpshooter"

-- Lines 8-18
function Warcry.create(warcry_name)
	if warcry_name == "berserk" then
		return WarcryBerserk:new()
	elseif warcry_name == "clustertruck" then
		return WarcryClustertruck:new()
	elseif warcry_name == "ghost" then
		return WarcryGhost:new()
	elseif warcry_name == "sharpshooter" then
		return WarcrySharpshooter:new()
	end
end

-- Lines 20-30
function Warcry.get_metatable(warcry_name)
	if warcry_name == "berserk" then
		return WarcryBerserk
	elseif warcry_name == "clustertruck" then
		return WarcryClustertruck
	elseif warcry_name == "ghost" then
		return WarcryGhost
	elseif warcry_name == "sharpshooter" then
		return WarcrySharpshooter
	end
end

-- Lines 32-34
function Warcry:init()
	self._level = 1
end

-- Lines 37-51
function Warcry:update(dt)
	local remaining = managers.warcry:remaining()
	local duration = managers.warcry:duration()
	local lerp = duration - remaining
	local lerp_duration = self._tweak_data.lerp_duration

	if lerp <= lerp_duration then
		return lerp / lerp_duration
	elseif remaining <= lerp_duration then
		return (duration - lerp) / lerp_duration
	end

	return 1
end

-- Lines 53-55
function Warcry:get_type()
	return self._type
end

-- Lines 57-59
function Warcry:set_level(level)
	self._level = level
end

-- Lines 61-63
function Warcry:get_level()
	return self._level
end

-- Lines 65-83
function Warcry:activate()
	local current_buffs = nil

	if self._level > #self._tweak_data.buffs then
		current_buffs = self._tweak_data.buffs[#self._tweak_data.buffs]
	else
		current_buffs = self._tweak_data.buffs[self._level]
	end

	for index, buff in pairs(current_buffs) do
		self:_acquire_buff(buff)
	end

	self._active = true

	managers.environment_controller:set_last_life_mod(0)
	managers.warcry:set_warcry_post_effect(self._tweak_data.ids_effect_name)
end

-- Lines 85-87
function Warcry:_acquire_buff(buff)
	managers.upgrades:aquire(buff, nil, "warcry_" .. tostring(self._type) .. "_buff_" .. tostring(buff))
end

local ids_empty = Idstring("empty")

-- Lines 90-114
function Warcry:deactivate()
	if not self._active then
		return
	end

	local current_buffs = nil

	if self._level > #self._tweak_data.buffs then
		current_buffs = self._tweak_data.buffs[#self._tweak_data.buffs]
	else
		current_buffs = self._tweak_data.buffs[self._level]
	end

	for index, buff in pairs(current_buffs) do
		self:_unacquire_buff(buff)
	end

	self._active = false

	managers.environment_controller:set_last_life_mod(1)

	if managers.warcry then
		managers.warcry:set_warcry_post_effect(ids_empty)
	end
end

-- Lines 116-118
function Warcry:_unacquire_buff(buff)
	managers.upgrades:unaquire(buff, "warcry_" .. tostring(self._type) .. "_buff_" .. tostring(buff))
end

-- Lines 120-131
function Warcry:_get_upgrade_definition_name(upgrade_definition_name)
	if tweak_data.upgrades:upgrade_has_levels(upgrade_definition_name) then
		local upgrade_level = self._level

		while not tweak_data.upgrades.definitions[upgrade_definition_name .. "_" .. tostring(upgrade_level)] do
			upgrade_level = upgrade_level - 1
		end

		upgrade_definition_name = upgrade_definition_name .. "_" .. tostring(upgrade_level)
	end

	return upgrade_definition_name
end

-- Lines 133-134
function Warcry:duration()
end

-- Lines 136-137
function Warcry:cleanup()
end
