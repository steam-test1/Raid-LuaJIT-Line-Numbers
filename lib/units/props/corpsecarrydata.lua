CorpseCarryData = CorpseCarryData or class(CarryData)

-- Lines 4-6
function CorpseCarryData:init(...)
	CorpseCarryData.super.init(self, ...)
end

-- Lines 8-21
function CorpseCarryData:on_thrown()
	self._dismembered_parts = self._dismembered_parts or managers.player:carry_temporary_data(self:carry_id())

	for _, dismember_part in ipairs(self._dismembered_parts or {}) do
		if self:_dismember(dismember_part .. "_no_blood", dismember_part) then
			self:_dismember(dismember_part)
		end
	end

	managers.player:clear_carry_temporary_data(self:carry_id())
end

-- Lines 23-44
function CorpseCarryData:_dismember(part_name, decal_name)
	if not self._unit:damage():has_sequence(part_name) then
		return false
	end

	self._unit:damage():run_sequence_simple(part_name)

	local decal_data = tweak_data.character.dismemberment_data.blood_decal_data[decal_name or part_name]

	if decal_data then
		local materials = self._unit:materials()

		for i, material in ipairs(materials) do
			material:set_variable(Idstring("gradient_uv_offset"), Vector3(decal_data[1], decal_data[2], 0))
			material:set_variable(Idstring("gradient_power"), decal_data[3])
		end
	end
end

-- Lines 46-51
function CarryData:on_pickup()
	if self._dismembered_parts then
		managers.player:set_carry_temporary_data(self:carry_id(), self._dismembered_parts)
	end
end
