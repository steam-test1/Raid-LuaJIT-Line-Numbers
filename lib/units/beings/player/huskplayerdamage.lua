HuskPlayerDamage = HuskPlayerDamage or class()

-- Lines 5-10
function HuskPlayerDamage:init(unit)
	self._unit = unit
	self._spine2_obj = unit:get_object(Idstring("Spine2"))
	self._listener_holder = EventListenerHolder:new()
	self._mission_damage_blockers = {}
end

-- Lines 14-16
function HuskPlayerDamage:_call_listeners(damage_info)
	CopDamage._call_listeners(self, damage_info)
end

-- Lines 20-22
function HuskPlayerDamage:add_listener(...)
	CopDamage.add_listener(self, ...)
end

-- Lines 26-28
function HuskPlayerDamage:remove_listener(key)
	CopDamage.remove_listener(self, key)
end

-- Lines 32-40
function HuskPlayerDamage:sync_damage_bullet(attacker_unit, damage, i_body, height_offset)
	local attack_data = {
		attacker_unit = attacker_unit,
		attack_dir = attacker_unit and attacker_unit:movement():m_pos() - self._unit:movement():m_pos() or Vector3(1, 0, 0),
		pos = mvector3.copy(self._unit:movement():m_head_pos()),
		result = {
			variant = "bullet",
			type = "hurt"
		}
	}

	self:_call_listeners(attack_data)
end

-- Lines 44-46
function HuskPlayerDamage:shoot_pos_mid(m_pos)
	self._spine2_obj:m_position(m_pos)
end

-- Lines 50-52
function HuskPlayerDamage:can_attach_projectiles()
	return false
end

-- Lines 56-58
function HuskPlayerDamage:set_last_down_time(down_time)
	self._last_down_time = down_time
end

-- Lines 62-64
function HuskPlayerDamage:down_time()
	return self._last_down_time
end

-- Lines 68-70
function HuskPlayerDamage:arrested()
	return self._unit:movement():current_state_name() == "arrested"
end

-- Lines 74-76
function HuskPlayerDamage:incapacitated()
	return self._unit:movement():current_state_name() == "incapacitated"
end

-- Lines 80-82
function HuskPlayerDamage:set_mission_damage_blockers(type, state)
	self._mission_damage_blockers[type] = state
end

-- Lines 85-87
function HuskPlayerDamage:get_mission_blocker(type)
	return self._mission_damage_blockers[type]
end

-- Lines 91-92
function HuskPlayerDamage:dead()
end
