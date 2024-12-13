CopLogicTurret = class(CopLogicBase)

-- Lines 7-11
function CopLogicTurret.enter(data, new_logic_name, enter_params)
	CopLogicBase.enter(data, new_logic_name, enter_params)
	data.unit:inventory():set_weapon_enabled(false)
end

-- Lines 15-23
function CopLogicTurret.exit(data, new_logic_name, enter_params)
	Application:debug("*** CopLogicTurret.exit")

	local my_data = data.internal_data

	CopLogicBase.cancel_delayed_clbks(my_data)
	CopLogicBase.exit(data, new_logic_name, enter_params)
end

-- Lines 27-30
function CopLogicTurret.is_available_for_assignment(data)
	return false
end

-- Lines 34-42
function CopLogicTurret.on_enemy_weapons_hot(data)
	Application:debug("*** CopLogicTurret.on_enemy_weapons_hot")
end

-- Lines 46-57
function CopLogicTurret._register_attention(data, my_data)
	Application:debug("*** CopLogicTurret._register_attention")
end

-- Lines 61-72
function CopLogicTurret._set_interaction(data, my_data)
	Application:debug("*** CopLogicTurret._set_interaction")
end

-- Lines 90-92
function CopLogicTurret.queued_update(data)
	Application:debug("*** CopLogicTurret.queued_update")
end

-- Lines 96-98
function CopLogicTurret.on_intimidated(data, amount, aggressor_unit)
	Application:debug("*** CopLogicTurret.on_intimidated")
end

-- Lines 101-105
function CopLogicTurret.death_clbk(data, damage_info)
	if data.unit:unit_data().turret_weapon then
		data.unit:unit_data().turret_weapon:on_puppet_death(data, damage_info)
	end
end

-- Lines 109-111
function CopLogicTurret.on_intimidated(data, amount, aggressor_unit)
	Application:debug("*** CopLogicTurret.on_intimidated")
end

-- Lines 115-119
function CopLogicTurret.damage_clbk(data, damage_info)
	if data.unit:unit_data().turret_weapon then
		data.unit:unit_data().turret_weapon:on_puppet_damaged(data, damage_info)
	end
end

-- Lines 123-125
function CopLogicTurret.on_suppressed_state(data)
	Application:debug("*** CopLogicTurret.on_suppressed_state")
end
