local tmp_rot1 = Rotation()
UnitNetworkHandler = UnitNetworkHandler or class(BaseNetworkHandler)

-- Lines 5-42
function UnitNetworkHandler:set_unit(unit, character_name, outfit_string, outfit_version, peer_id, team_id)
	Application:trace("[UnitNetworkHandler:set_unit]", unit, character_name, peer_id)

	if peer_id == 0 then
		local crim_data = managers.criminals:character_data_by_name(character_name)

		if alive(unit) then
			if not crim_data or not crim_data.ai then
				managers.criminals:add_character(character_name, unit, nil, true)
			else
				managers.criminals:set_unit(character_name, unit)
			end

			unit:movement():set_character_anim_variables()
		elseif not crim_data or not crim_data.ai then
			managers.criminals:add_character(character_name, nil, nil, true)
		end

		return
	end

	if not alive(unit) then
		return
	end

	local peer = managers.network:session():peer(peer_id)

	if not peer then
		return
	end

	if peer ~= managers.network:session():local_peer() then
		peer:set_outfit_string(outfit_string, outfit_version)
	end

	peer:set_unit(unit, character_name)
	self:_chk_flush_unit_too_early_packets(unit)
end

-- Lines 46-65
function UnitNetworkHandler:set_character_customization(unit, outfit_string, outfit_version, peer_id)
	if not alive(unit) then
		return
	end

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local peer = managers.network:session():peer(peer_id)

	if not peer then
		return
	end

	if peer ~= managers.network:session():local_peer() then
		peer:set_outfit_string(outfit_string, outfit_version)
	end

	peer:set_character_customization()
end

-- Lines 69-84
function UnitNetworkHandler:set_equipped_weapon(unit, send_equipped_weapon_type, equipped_weapon_category_id, equipped_weapon_identifier, blueprint_string, cosmetics_string, sender)
	if not self._verify_character(unit) then
		return
	end

	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	if not unit:inventory() or not unit:inventory().synch_equipped_weapon then
		Application:error("[UnitNetworkHandler:set_equipped_weapon] unit umable to sync equipped weapon:  ", inspect(unit), "    ", inspect(unit:inventory()), "      ", type(unit:inventory()))

		return
	end

	unit:inventory():synch_equipped_weapon(send_equipped_weapon_type, equipped_weapon_category_id, equipped_weapon_identifier, blueprint_string, cosmetics_string, peer)
end

-- Lines 86-91
function UnitNetworkHandler:set_weapon_gadget_state(unit, gadget_state, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end

	unit:inventory():synch_weapon_gadget_state(gadget_state)
end

-- Lines 95-106
function UnitNetworkHandler:set_look_dir(unit, yaw_in, pitch_in, sender)
	if not self._verify_character_and_sender(unit, sender) then
		return
	end

	local dir = Vector3()
	local yaw = 360 * yaw_in / 255
	local pitch = math.lerp(-85, 85, pitch_in / 127)
	local rot = Rotation(yaw, pitch, 0)

	mrotation.y(rot, dir)
	unit:movement():sync_look_dir(dir)
end

-- Lines 110-164
function UnitNetworkHandler:action_walk_start(unit, first_nav_point, nav_link_yaw, nav_link_act_index, from_idle, haste_code, end_yaw, no_walk, no_strafe, end_pose_code)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local end_rot = nil

	if end_yaw ~= 0 then
		end_rot = Rotation(360 * (end_yaw - 1) / 254, 0, 0)
	end

	local nav_path = {}

	if nav_link_act_index ~= 0 then
		local nav_link_rot = 360 * nav_link_yaw / 255
		local nav_link = unit:movement()._actions.walk.synthesize_nav_link(first_nav_point, nav_link_rot, unit:movement()._actions.act:_get_act_name_from_index(nav_link_act_index), from_idle)

		-- Lines 124-124
		function nav_link.element.value(element, name)
			return element[name]
		end

		nav_link.element.nav_link_wants_align_pos = nav_link.element.nav_link_wants_align_pos or function (element)
			Application:debug("[CopActionWalk:action_walk_start] Appending something that is not nav_link", inspect(self))

			return true
		end

		table.insert(nav_path, nav_link)
	else
		table.insert(nav_path, first_nav_point)
	end

	local end_pose = nil

	if end_pose_code == 1 then
		end_pose = "stand"
	elseif end_pose_code == 2 then
		end_pose = "crouch"
	end

	local action_desc = {
		path_simplified = true,
		type = "walk",
		persistent = true,
		body_part = 2,
		variant = haste_code == 1 and "walk" or "run",
		end_rot = end_rot,
		nav_path = nav_path,
		no_walk = no_walk,
		no_strafe = no_strafe,
		end_pose = end_pose,
		blocks = {
			act = -1,
			idle = -1,
			turn = -1,
			walk = -1
		}
	}

	unit:movement():action_request(action_desc)
end

-- Lines 168-173
function UnitNetworkHandler:action_walk_nav_point(unit, nav_point, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:movement():sync_action_walk_nav_point(nav_point)
end

-- Lines 177-182
function UnitNetworkHandler:action_walk_stop(unit)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:movement():sync_action_walk_stop()
end

-- Lines 186-192
function UnitNetworkHandler:action_walk_nav_link(unit, pos, yaw, anim_index, from_idle)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local rot = 360 * yaw / 255

	unit:movement():sync_action_walk_nav_link(pos, rot, anim_index, from_idle)
end

-- Lines 196-201
function UnitNetworkHandler:action_change_pose(unit, pose_code, pos)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:movement():sync_action_change_pose(pose_code, pos)
end

-- Lines 203-209
function UnitNetworkHandler:skill_action_knockdown(unit, hit_position, direction, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	CopDamage.skill_action_knockdown(unit, hit_position, direction)
end

-- Lines 212-224
function UnitNetworkHandler:action_warp_start(unit, has_pos, pos, has_rot, yaw, sender)
	if not self._verify_character(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local action_desc = {
		body_part = 1,
		type = "warp",
		position = has_pos and pos,
		rotation = has_rot and Rotation(360 * (yaw - 1) / 254, 0, 0)
	}

	unit:movement():action_request(action_desc)
end

-- Lines 228-233
function UnitNetworkHandler:friendly_fire_hit(subject_unit)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	subject_unit:character_damage():friendly_fire_hit()
end

-- Lines 237-245
function UnitNetworkHandler:damage_bullet(subject_unit, attacker_unit, damage, i_body, height_offset, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_bullet(attacker_unit, damage, i_body, height_offset, death)
end

-- Lines 247-255
function UnitNetworkHandler:damage_knockdown(subject_unit, attacker_unit, damage, i_body, height_offset, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_knockdown(attacker_unit, damage, i_body, height_offset, death)
end

-- Lines 258-273
function UnitNetworkHandler:damage_explosion_fire(subject_unit, attacker_unit, damage, i_attack_variant, death, direction, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	if i_attack_variant == 3 then
		subject_unit:character_damage():sync_damage_fire(attacker_unit, damage, i_attack_variant, death, direction)
	else
		subject_unit:character_damage():sync_damage_explosion(attacker_unit, damage, i_attack_variant, death, direction)
	end
end

-- Lines 275-284
function UnitNetworkHandler:damage_fire(subject_unit, attacker_unit, damage, start_dot_dance_antimation, death, direction, weapon_type, weapon_unit, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_fire(attacker_unit, damage, start_dot_dance_antimation, death, direction, weapon_type, weapon_unit)
end

-- Lines 288-296
function UnitNetworkHandler:damage_dot(subject_unit, attacker_unit, damage, death, variant, hurt_animation, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_dot(attacker_unit, damage, death, variant, hurt_animation)
end

-- Lines 300-308
function UnitNetworkHandler:damage_tase(subject_unit, attacker_unit, damage, variant, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_tase(attacker_unit, damage, variant, death)
end

-- Lines 313-321
function UnitNetworkHandler:damage_melee(subject_unit, attacker_unit, damage, damage_effect, i_body, height_offset, variant, death, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_melee(attacker_unit, damage, damage_effect, i_body, height_offset, variant, death)
end

-- Lines 325-333
function UnitNetworkHandler:from_server_damage_bullet(subject_unit, attacker_unit, hit_offset_height, result_index, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_bullet(attacker_unit, hit_offset_height, result_index)
end

-- Lines 337-351
function UnitNetworkHandler:from_server_damage_explosion_fire(subject_unit, attacker_unit, result_index, i_attack_variant, sender)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	if i_attack_variant == 3 then
		subject_unit:character_damage():sync_damage_fire(attacker_unit, result_index, i_attack_variant)
	else
		subject_unit:character_damage():sync_damage_explosion(attacker_unit, result_index, i_attack_variant)
	end
end

-- Lines 355-363
function UnitNetworkHandler:from_server_damage_melee(subject_unit, attacker_unit, hit_offset_height, result_index, sender)
	if not self._verify_character(subject_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(attacker_unit) or attacker_unit:key() == subject_unit:key() then
		attacker_unit = nil
	end

	subject_unit:character_damage():sync_damage_melee(attacker_unit, attacker_unit, hit_offset_height, result_index)
end

-- Lines 367-372
function UnitNetworkHandler:from_server_damage_incapacitated(subject_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end

	subject_unit:character_damage():sync_damage_incapacitated()
end

-- Lines 376-381
function UnitNetworkHandler:from_server_damage_bleeding(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end

	subject_unit:character_damage():sync_damage_bleeding()
end

-- Lines 385-390
function UnitNetworkHandler:from_server_damage_tase(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end

	subject_unit:character_damage():sync_damage_tase()
end

-- Lines 394-399
function UnitNetworkHandler:from_server_unit_recovered(subject_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(subject_unit) then
		return
	end

	subject_unit:character_damage():sync_unit_recovered()
end

-- Lines 403-408
function UnitNetworkHandler:shot_blank(shooting_unit, impact, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end

	shooting_unit:movement():sync_shot_blank(impact)
end

-- Lines 411-416
function UnitNetworkHandler:sync_start_auto_fire_sound(shooting_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end

	shooting_unit:movement():sync_start_auto_fire_sound()
end

-- Lines 418-423
function UnitNetworkHandler:sync_stop_auto_fire_sound(shooting_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end

	shooting_unit:movement():sync_stop_auto_fire_sound()
end

-- Lines 427-432
function UnitNetworkHandler:shot_blank_reliable(shooting_unit, impact, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(shooting_unit, sender) then
		return
	end

	shooting_unit:movement():sync_shot_blank(impact)
end

-- Lines 436-441
function UnitNetworkHandler:reload_weapon(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	unit:movement():sync_reload_weapon()
end

-- Lines 445-456
function UnitNetworkHandler:run_mission_element(mission_id, id, unit, orientation_element_index)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		if self._verify_gamestate(self._gamestate_filter.any_end_game) then
			managers.mission:client_run_mission_element_end_screen(mission_id, id, unit, orientation_element_index)

			return
		end

		print("UnitNetworkHandler:run_mission_element discarded id:", mission_id, id)

		return
	end

	managers.mission:client_run_mission_element(mission_id, id, unit, orientation_element_index)
end

-- Lines 458-469
function UnitNetworkHandler:run_mission_element_no_instigator(mission_id, id, orientation_element_index)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		if self._verify_gamestate(self._gamestate_filter.any_end_game) then
			managers.mission:client_run_mission_element_end_screen(mission_id, id, nil, orientation_element_index)

			return
		end

		print("UnitNetworkHandler:run_mission_element discarded id:", mission_id, id)

		return
	end

	managers.mission:client_run_mission_element(mission_id, id, nil, orientation_element_index)
end

-- Lines 471-473
function UnitNetworkHandler:sync_client_hud_timer_command(mission_id, id, orientation_element_index, command, command_value)
	managers.mission:sync_client_hud_timer_command(mission_id, id, orientation_element_index, command, command_value)
end

-- Lines 477-482
function UnitNetworkHandler:to_server_mission_element_trigger(mission_id, id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.mission:server_run_mission_element_trigger(mission_id, id, unit)
end

-- Lines 484-489
function UnitNetworkHandler:to_server_area_event(event_id, mission_id, id, unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.mission:to_server_area_event(event_id, mission_id, id, unit)
end

-- Lines 505-511
function UnitNetworkHandler:to_server_access_camera_trigger(mission_id, id, trigger, instigator)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.mission:to_server_access_camera_trigger(mission_id, id, trigger, instigator)
end

-- Lines 515-545
function UnitNetworkHandler:sync_body_damage_bullet(body, attacker, normal_yaw, normal_pitch, position, direction_yaw, direction_pitch, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(body) then
		return
	end

	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage.damage_bullet then
		print("[UnitNetworkHandler:sync_body_damage_bullet] body has no damage damage_bullet function", body:name(), body:unit():name())

		return
	end

	local normal = Vector3()

	mrotation.set_yaw_pitch_roll(tmp_rot1, math.lerp(-180, 180, normal_yaw / 127), math.lerp(-90, 90, normal_pitch / 63), 0)
	mrotation.y(tmp_rot1, normal)

	local direction = Vector3()

	mrotation.set_yaw_pitch_roll(tmp_rot1, math.lerp(-180, 180, direction_yaw / 127), math.lerp(-90, 90, direction_pitch / 63), 0)
	mrotation.y(tmp_rot1, direction)
	body:extension().damage:damage_bullet(attacker, normal, position, direction, 1)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage / 163.84)
end

-- Lines 549-570
function UnitNetworkHandler:sync_body_damage_lock(body, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(body) then
		return
	end

	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_lock] body has no extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_lock] body has no damage extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage.damage_lock then
		print("[UnitNetworkHandler:sync_body_damage_lock] body has no damage damage_lock function", body:name(), body:unit():name())

		return
	end

	body:extension().damage:damage_lock(nil, nil, nil, nil, damage)
end

-- Lines 574-595
function UnitNetworkHandler:sync_body_damage_explosion(body, attacker, normal, position, direction, damage, armor_piercing, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(body) then
		return
	end

	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no damage extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage.damage_explosion then
		print("[UnitNetworkHandler:sync_body_damage_explosion] body has no damage damage_explosion function", body:name(), body:unit():name())

		return
	end

	body:extension().damage:damage_explosion(attacker, normal, position, direction, damage / 163.84, armor_piercing)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage / 163.84)
end

-- Lines 599-601
function UnitNetworkHandler:sync_body_damage_explosion_no_attacker(body, normal, position, direction, damage, armor_piercing, sender)
	self:sync_body_damage_explosion(body, nil, normal, position, direction, damage, armor_piercing, sender)
end

-- Lines 605-626
function UnitNetworkHandler:sync_body_damage_fire(body, attacker, normal, position, direction, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(body) then
		return
	end

	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_fire] body has no extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_fire] body has no damage extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage.damage_fire then
		print("[UnitNetworkHandler:sync_body_damage_fire] body has no damage damage_fire function", body:name(), body:unit():name())

		return
	end

	body:extension().damage:damage_fire(attacker, normal, position, direction, damage / 163.84)
	body:extension().damage:damage_damage(attacker, normal, position, direction, damage / 163.84)
end

-- Lines 630-632
function UnitNetworkHandler:sync_body_damage_fire_no_attacker(body, normal, position, direction, damage, sender)
	self:sync_body_damage_fire(body, nil, normal, position, direction, damage, sender)
end

-- Lines 636-656
function UnitNetworkHandler:sync_body_damage_melee(body, attacker, normal, position, direction, damage, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(body) then
		return
	end

	if not body:extension() then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no damage extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage.damage_melee then
		print("[UnitNetworkHandler:sync_body_damage_melee] body has no damage damage_melee function", body:name(), body:unit():name())

		return
	end

	body:extension().damage:damage_melee(attacker, normal, position, direction, damage)
end

-- Lines 660-684
function UnitNetworkHandler:sync_interacted(unit, unit_id, tweak_setting, status, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	if Network:is_server() and unit_id ~= -2 then
		if alive(unit) and unit:interaction().tweak_data == tweak_setting and unit:interaction():active() then
			sender:sync_interaction_reply(true)
		else
			sender:sync_interaction_reply(false)

			return
		end
	end

	if alive(unit) then
		unit:interaction():sync_interacted(peer, nil, status)
	end
end

-- Lines 688-701
function UnitNetworkHandler:sync_multiple_equipment_bag_interacted(unit, amount_wanted, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	if unit and alive(unit) and unit:interaction() then
		unit:interaction():sync_interacted(peer, nil, amount_wanted)
	end
end

-- Lines 705-718
function UnitNetworkHandler:sync_interaction_info_id(unit, info_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	if alive(unit) and unit:interaction().set_info_id then
		unit:interaction():set_info_id(info_id)
	end
end

-- Lines 722-733
function UnitNetworkHandler:sync_interacted_by_id(unit_id, tweak_setting, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) and not self._verify_sender(sender) then
		return
	end

	local u_data = managers.enemy:get_corpse_unit_data_from_id(unit_id)

	if not u_data then
		sender:sync_interaction_reply(false)

		return
	end

	self:sync_interacted(u_data.unit, unit_id, tweak_setting, 1, sender)
end

-- Lines 737-747
function UnitNetworkHandler:sync_interaction_reply(status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(managers.player:player_unit()) then
		return
	end

	managers.player:from_server_interaction_reply(status)
end

-- Lines 751-771
function UnitNetworkHandler:interaction_set_active(unit, u_id, active, tweak_data, flash, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(unit) then
		local u_data = managers.enemy:get_corpse_unit_data_from_id(u_id)

		if not u_data then
			return
		end

		unit = u_data.unit
	end

	unit:interaction():set_tweak_data(tweak_data)
	unit:interaction():set_active(active)

	if flash then
		unit:interaction():set_outline_flash_state(true, nil)
	end
end

-- Lines 775-784
function UnitNetworkHandler:sync_teammate_start_progress(timer, interact_unit, sender)
	local sender_peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end

	local teammate_panel_id = sender_peer:unit():unit_data().teammate_panel_id
	local name_label_id = interact_unit ~= managers.player:player_unit() and sender_peer:unit():unit_data().name_label_id or nil

	managers.hud:teammate_start_progress(teammate_panel_id, name_label_id, timer)
end

-- Lines 786-795
function UnitNetworkHandler:sync_teammate_cancel_progress(sender)
	local sender_peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end

	local teammate_panel_id = sender_peer:unit():unit_data().teammate_panel_id
	local name_label_id = sender_peer:unit():unit_data().name_label_id

	managers.hud:teammate_cancel_progress(teammate_panel_id, name_label_id)
end

-- Lines 797-806
function UnitNetworkHandler:sync_teammate_complete_progress(sender)
	local sender_peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end

	local teammate_panel_id = sender_peer:unit():unit_data().teammate_panel_id
	local name_label_id = sender_peer:unit():unit_data().name_label_id

	managers.hud:teammate_complete_progress(teammate_panel_id, name_label_id)
end

-- Lines 810-820
function UnitNetworkHandler:action_aim_state(cop)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
		return
	end

	local shoot_action = {
		block_type = "action",
		body_part = 3,
		type = "shoot"
	}

	cop:movement():action_request(shoot_action)
end

-- Lines 824-829
function UnitNetworkHandler:action_aim_end(cop)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
		return
	end

	cop:movement():sync_action_aim_end()
end

-- Lines 833-838
function UnitNetworkHandler:action_hurt_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():sync_action_hurt_end()
end

-- Lines 842-868
function UnitNetworkHandler:set_attention(unit, target_unit, reaction, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	if not alive(target_unit) then
		unit:movement():synch_attention()

		return
	end

	local handler = nil

	if target_unit:attention() then
		handler = target_unit:attention()
	elseif target_unit:brain() and target_unit:brain().attention_handler then
		handler = target_unit:brain():attention_handler()
	elseif target_unit:movement() and target_unit:movement().attention_handler then
		handler = target_unit:movement():attention_handler()
	elseif target_unit:base() and target_unit:base().attention_handler then
		handler = target_unit:base():attention_handler()
	end

	if not handler and (not target_unit:movement() or not target_unit:movement().m_head_pos) then
		debug_pause_unit(target_unit, "[UnitNetworkHandler:set_attention] no attention handler or m_head_pos", target_unit)

		return
	end

	unit:movement():synch_attention({
		unit = target_unit,
		u_key = target_unit:key(),
		handler = handler,
		reaction = reaction
	})
end

-- Lines 872-877
function UnitNetworkHandler:cop_set_attention_pos(unit, pos)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():synch_attention({
		pos = pos,
		reaction = AIAttentionObject.REACT_IDLE
	})
end

-- Lines 881-886
function UnitNetworkHandler:set_allow_fire(unit, state)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():synch_allow_fire(state)
end

-- Lines 890-895
function UnitNetworkHandler:set_stance(unit, stance_code, instant, execute_queued, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	unit:movement():sync_stance(stance_code, instant, execute_queued)
end

-- Lines 899-904
function UnitNetworkHandler:set_pose(unit, pose_code, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	unit:movement():sync_pose(pose_code)
end

-- Lines 908-940
function UnitNetworkHandler:long_dis_interaction(target_unit, amount, aggressor_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(target_unit) or not self._verify_character(aggressor_unit) then
		return
	end

	local target_is_criminal = target_unit:in_slot(managers.slot:get_mask("criminals")) or target_unit:in_slot(managers.slot:get_mask("harmless_criminals"))
	local target_is_civilian = not target_is_criminal and target_unit:in_slot(21)
	local aggressor_is_criminal = aggressor_unit:in_slot(managers.slot:get_mask("criminals")) or aggressor_unit:in_slot(managers.slot:get_mask("harmless_criminals"))

	if target_is_criminal then
		if aggressor_is_criminal then
			if target_unit:brain() then
				if target_unit:brain().on_long_dis_interacted then
					target_unit:movement():set_cool(false)
					target_unit:brain():on_long_dis_interacted(amount, aggressor_unit)
				end
			elseif amount == 1 then
				target_unit:movement():on_morale_boost(aggressor_unit)
			end
		else
			target_unit:brain():on_intimidated(amount / 10, aggressor_unit)
		end
	elseif amount == 0 and target_is_civilian and aggressor_is_criminal then
		if self._verify_in_server_session() then
			aggressor_unit:movement():sync_call_civilian(target_unit)
		end
	elseif target_unit:brain() then
		target_unit:brain():on_intimidated(amount / 10, aggressor_unit)
	end
end

-- Lines 944-966
function UnitNetworkHandler:alarm_pager_interaction(u_id, tweak_table, status, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local unit_data = managers.enemy:get_corpse_unit_data_from_id(u_id)

	if unit_data and unit_data.unit:interaction():active() and unit_data.unit:interaction().tweak_data == tweak_table then
		local peer = self._verify_sender(sender)

		if peer then
			local status_str = nil

			if status == 1 then
				status_str = "started"
			elseif status == 2 then
				status_str = "interrupted"
			else
				status_str = "complete"
			end

			unit_data.unit:interaction():sync_interacted(peer, nil, status_str)
		end
	end
end

-- Lines 970-976
function UnitNetworkHandler:remove_corpse_by_id(u_id, carry_bodybag, peer_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.enemy:remove_corpse_by_id(u_id)
end

-- Lines 980-985
function UnitNetworkHandler:unit_tied(unit, aggressor)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:brain():on_tied(aggressor)
end

-- Lines 989-994
function UnitNetworkHandler:unit_traded(unit, trader)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:brain():on_trade(trader)
end

-- Lines 998-1003
function UnitNetworkHandler:hostage_trade(unit, enable, trade_success)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	CopLogicTrade.hostage_trade(unit, enable, trade_success)
end

-- Lines 1005-1010
function UnitNetworkHandler:set_unit_invulnerable(unit, enable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:character_damage():set_invulnerable(enable)
end

-- Lines 1012-1017
function UnitNetworkHandler:set_trade_countdown(enable)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.trade:set_trade_countdown(enable)
end

-- Lines 1019-1024
function UnitNetworkHandler:set_trade_death(criminal_name, respawn_penalty, hostages_killed)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.trade:sync_set_trade_death(criminal_name, respawn_penalty, hostages_killed)
end

-- Lines 1026-1031
function UnitNetworkHandler:set_trade_spawn(criminal_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.trade:sync_set_trade_spawn(criminal_name)
end

-- Lines 1033-1038
function UnitNetworkHandler:set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.trade:sync_set_trade_replace(replace_ai, criminal_name1, criminal_name2, respawn_penalty)
end

-- Lines 1042-1047
function UnitNetworkHandler:action_idle_start(unit, body_part, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():action_request({
		type = "idle",
		body_part = body_part
	})
end

-- Lines 1051-1053
function UnitNetworkHandler:action_act_start(unit, act_index, blocks_hurt, clamp_to_graph, needs_full_blend)
	self:action_act_start_align(unit, act_index, blocks_hurt, clamp_to_graph, needs_full_blend, nil, nil)
end

-- Lines 1057-1068
function UnitNetworkHandler:action_act_start_align(unit, act_index, blocks_hurt, clamp_to_graph, needs_full_blend, start_yaw, start_pos)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	local start_rot = nil

	if start_yaw and start_yaw ~= 0 then
		start_rot = Rotation(360 * (start_yaw - 1) / 254, 0, 0)
	end

	unit:movement():sync_action_act_start(act_index, blocks_hurt, clamp_to_graph, needs_full_blend, start_rot, start_pos)
end

-- Lines 1070-1075
function UnitNetworkHandler:action_act_end(unit)
	if not alive(unit) or unit:character_damage():dead() then
		return
	end

	unit:movement():sync_action_act_end()
end

-- Lines 1079-1084
function UnitNetworkHandler:action_dodge_start(unit, body_part, variation, side, rotation, speed, shoot_acc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():sync_action_dodge_start(body_part, variation, side, rotation, speed, shoot_acc)
end

-- Lines 1086-1091
function UnitNetworkHandler:action_dodge_end(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():sync_action_dodge_end()
end

-- Lines 1095-1124
function UnitNetworkHandler:action_tase_event(taser_unit, event_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(taser_unit) then
		return
	end

	local sender_peer = self._verify_sender(sender)

	if not sender_peer then
		return
	end

	if event_id == 1 then
		if not managers.network:session():is_client() or managers.network:session():server_peer() ~= sender_peer then
			return
		end

		local tase_action = {
			body_part = 3,
			type = "tase"
		}

		taser_unit:movement():action_request(tase_action)
	elseif event_id == 2 then
		if not managers.network:session():is_client() or managers.network:session():server_peer() ~= sender_peer then
			return
		end

		taser_unit:movement():sync_action_tase_end()
	else
		taser_unit:movement():sync_taser_fire()
	end
end

-- Lines 1128-1146
function UnitNetworkHandler:alert(alerted_unit, aggressor)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(alerted_unit) or not self._verify_character(aggressor) then
		return
	end

	local record = managers.groupai:state():criminal_record(aggressor:key())

	if not record then
		return
	end

	local aggressor_pos = nil

	if aggressor:movement() and aggressor:movement().m_head_pos then
		aggressor_pos = aggressor:movement():m_head_pos()
	else
		aggressor_pos = aggressor:position()
	end

	alerted_unit:brain():on_alert({
		"aggression",
		aggressor_pos,
		false,
		[5] = aggressor
	})
end

-- Lines 1150-1170
function UnitNetworkHandler:revive_player(revive_health_level, revive_damage_reduction, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.need_revive) or not peer then
		return
	end

	local player = managers.player:player_unit()

	if revive_health_level > 0 and alive(player) then
		player:character_damage():set_revive_boost(revive_health_level)
	end

	if revive_damage_reduction > 0 then
		managers.player:activate_temporary_upgrade_by_level("temporary", "passive_revive_damage_reduction", revive_damage_reduction)
	end

	if alive(player) then
		player:character_damage():revive()
	end
end

-- Lines 1172-1182
function UnitNetworkHandler:start_revive_player(timer, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.downed) or not peer then
		return
	end

	local player = managers.player:player_unit()

	if alive(player) then
		player:character_damage():pause_downed_timer(timer, peer:id())
	end
end

-- Lines 1184-1194
function UnitNetworkHandler:interupt_revive_player(sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.downed) or not peer then
		return
	end

	local player = managers.player:player_unit()

	if alive(player) then
		player:character_damage():unpause_downed_timer(peer:id())
	end
end

-- Lines 1196-1206
function UnitNetworkHandler:start_free_player(sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.arrested) or not peer then
		return
	end

	local player = managers.player:player_unit()

	if alive(player) then
		player:character_damage():pause_arrested_timer(peer:id())
	end
end

-- Lines 1208-1218
function UnitNetworkHandler:interupt_free_player(sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.arrested) or not peer then
		return
	end

	local player = managers.player:player_unit()

	if alive(player) then
		player:character_damage():unpause_arrested_timer(peer:id())
	end
end

-- Lines 1220-1226
function UnitNetworkHandler:pause_arrested_timer(unit, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end

	unit:character_damage():pause_arrested_timer(peer:id())
end

-- Lines 1228-1234
function UnitNetworkHandler:unpause_arrested_timer(unit, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end

	unit:character_damage():unpause_arrested_timer(peer:id())
end

-- Lines 1238-1243
function UnitNetworkHandler:revive_unit(unit, reviving_unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) or not alive(reviving_unit) then
		return
	end

	unit:interaction():interact(reviving_unit)
end

-- Lines 1245-1251
function UnitNetworkHandler:pause_bleed_out(unit, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end

	unit:character_damage():pause_bleed_out(peer:id())
end

-- Lines 1253-1259
function UnitNetworkHandler:unpause_bleed_out(unit, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer or not self._verify_character(unit) then
		return
	end

	unit:character_damage():unpause_bleed_out(peer:id())
end

-- Lines 1261-1273
function UnitNetworkHandler:interaction_set_waypoint_paused(unit, paused, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if not alive(unit) then
		return
	end

	if not unit:interaction() then
		return
	end

	unit:interaction():set_waypoint_paused(paused)
end

-- Lines 1277-1293
function UnitNetworkHandler:from_server_ecm_jammer_place_result(unit, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit = alive(unit) and unit or nil

	if alive(managers.player:player_unit()) then
		managers.player:player_unit():equipment():from_server_ecm_jammer_placement_result(unit and true or false)
	end

	if not unit then
		return
	end

	unit:base():set_owner(managers.player:player_unit())
end

-- Lines 1297-1305
function UnitNetworkHandler:from_server_ecm_jammer_rejected(rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(managers.player:player_unit()) then
		managers.player:player_unit():equipment():from_server_ecm_jammer_placement_result(false)
	end
end

-- Lines 1309-1322
function UnitNetworkHandler:sync_unit_event_id_16(unit, ext_name, event_id, rpc)
	local peer = self._verify_sender(rpc)

	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local extension = unit[ext_name](unit)

	if not extension then
		debug_pause("[UnitNetworkHandler:sync_unit_event_id_16] unit", unit, "does not have extension", ext_name)

		return
	end

	extension:sync_net_event(event_id, peer)
end

-- Lines 1326-1335
function UnitNetworkHandler:sync_tank_cannon_explosion(unit, position, range, damage, player_damage, curve_pow, rpc)
	local peer = self._verify_sender(rpc)

	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:mounted_weapon():_tank_main_cannon_hit_explosion_on_client(position, range, damage, player_damage, curve_pow)
end

-- Lines 1339-1348
function UnitNetworkHandler:sync_ai_tank_singleshot_blank(unit, position, normal, rpc)
	local peer = self._verify_sender(rpc)

	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:weapon():play_singleshot_sound_and_effect(position, normal)
end

-- Lines 1352-1361
function UnitNetworkHandler:sync_ai_tank_grenade_explosion(unit, position, range, damage, player_damage, curve_pow, rpc)
	local peer = self._verify_sender(rpc)

	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:weapon():_hit_explosion_on_client(position, range, damage, player_damage, curve_pow)
end

-- Lines 1365-1371
function UnitNetworkHandler:m79grenade_explode_on_client(position, normal, user, damage, range, curve_pow, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(user, sender) then
		return
	end

	ProjectileBase._explode_on_client(position, normal, user, damage, range, curve_pow)
end

-- Lines 1374-1380
function UnitNetworkHandler:element_explode_on_client(position, normal, damage, range, curve_pow, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.explosion:client_damage_and_push(position, normal, nil, damage, range, curve_pow)
end

-- Lines 1384-1396
function UnitNetworkHandler:place_sentry_gun(pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, equipment_selection_index, user_unit, rpc)
	local peer = self._verify_sender(rpc)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	local unit = SentryGunBase.spawn(user_unit, pos, rot, ammo_multiplier, armor_multiplier, damage_multiplier, peer:id(), true)

	if unit then
		unit:base():set_server_information(peer:id())
	end

	managers.network:session():send_to_peers_synched("from_server_sentry_gun_place_result", peer:id(), unit and equipment_selection_index or 0, unit, unit and unit:movement()._rot_speed_mul, unit and unit:weapon()._setup.spread_mul, unit and unit:base():has_shield() and true or false)
end

-- Lines 1400-1428
function UnitNetworkHandler:from_server_sentry_gun_place_result(owner_peer_id, equipment_selection_index, sentry_gun_unit, rot_speed_mul, spread_mul, shield, rpc)
	local local_peer = managers.network:session():local_peer()

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) or not alive(sentry_gun_unit) or not managers.network:session():peer(owner_peer_id) then
		if alive(local_peer:unit()) then
			local_peer:unit():equipment():from_server_sentry_gun_place_result()
		end

		return
	end

	sentry_gun_unit:base():set_owner_id(owner_peer_id)

	if owner_peer_id == local_peer:id() and alive(local_peer:unit()) then
		managers.player:from_server_equipment_place_result(equipment_selection_index, local_peer:unit())
	end

	if shield then
		sentry_gun_unit:base():enable_shield()
	end

	sentry_gun_unit:movement():setup(rot_speed_mul)
	sentry_gun_unit:brain():setup(1 / rot_speed_mul)

	local setup_data = {
		spread_mul = spread_mul,
		ignore_units = {
			sentry_gun_unit
		}
	}

	sentry_gun_unit:weapon():setup(setup_data, 1)
end

-- Lines 1432-1439
function UnitNetworkHandler:place_ammo_bag(pos, rot, ammo_upgrade_lvl, rpc)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(rpc) then
		return
	end

	local peer = self._verify_sender(rpc)
	local unit = AmmoBagBase.spawn(pos, rot, ammo_upgrade_lvl)

	unit:base():set_server_information(peer:id())
end

-- Lines 1443-1451
function UnitNetworkHandler:special_interaction_done(unit)
	Application:trace("[UnitNetworkHandler:special_interaction_done] unit ", unit)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if unit then
		unit:interaction():set_special_interaction_done()
	end
end

-- Lines 1455-1460
function UnitNetworkHandler:sentrygun_ammo(unit, ammo_ratio)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:weapon():sync_ammo(ammo_ratio)
end

-- Lines 1464-1469
function UnitNetworkHandler:sentrygun_health(unit, health_ratio)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:character_damage():sync_health(health_ratio)
end

-- Lines 1473-1478
function UnitNetworkHandler:turret_idle_state(unit, state)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:brain():set_idle(state)
end

-- Lines 1482-1487
function UnitNetworkHandler:turret_update_shield_smoke_level(unit, ratio, up)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:character_damage():update_shield_smoke_level(ratio, up)
end

-- Lines 1491-1497
function UnitNetworkHandler:turret_repair(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:movement():repair()
end

-- Lines 1501-1507
function UnitNetworkHandler:turret_complete_repairing(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:movement():complete_repairing()
end

-- Lines 1511-1516
function UnitNetworkHandler:turret_repair_shield(unit)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:character_damage():repair_shield()
end

-- Lines 1520-1530
function UnitNetworkHandler:sync_unit_module(parent_unit, module_unit, align_obj_name, module_id, parent_extension_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(parent_unit) or not alive(module_unit) then
		return
	end

	parent_unit[parent_extension_name](parent_unit):spawn_module(module_unit, align_obj_name, module_id)
end

-- Lines 1534-1545
function UnitNetworkHandler:run_unit_module_function(parent_unit, module_id, parent_extension_name, module_extension_name, func_name, params)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(parent_unit) then
		return
	end

	local params_split = string.split(params, " ")

	parent_unit[parent_extension_name](parent_unit):run_module_function_unsafe(module_id, module_extension_name, func_name, params_split[1], params_split[2])
end

-- Lines 1549-1555
function UnitNetworkHandler:sync_equipment_setup(unit, upgrade_lvl, peer_id)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:base():sync_setup(upgrade_lvl, peer_id)
end

-- Lines 1559-1564
function UnitNetworkHandler:sync_ammo_bag_ammo_taken(unit, amount, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:base():sync_ammo_taken(amount)
end

-- Lines 1568-1573
function UnitNetworkHandler:sync_grenade_crate_grenade_taken(unit, amount, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:base():sync_grenade_taken(amount)
end

-- Lines 1577-1594
function UnitNetworkHandler:place_deployable_bag(class_name, pos, rot, upgrade_lvl, rpc)
	local peer = self._verify_sender(rpc)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	local class_name_to_deployable_id = tweak_data.equipments.class_name_to_deployable_id

	if not managers.player:verify_equipment(peer:id(), class_name_to_deployable_id[class_name]) then
		return
	end

	local class = CoreSerialize.string_to_classtable(class_name)

	if class then
		local unit = class.spawn(pos, rot, upgrade_lvl, peer:id())

		unit:base():set_server_information(peer:id())
	end
end

-- Lines 1598-1605
function UnitNetworkHandler:used_deployable(rpc)
	local peer = self._verify_sender(rpc)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	peer:set_used_deployable(true)
end

-- Lines 1609-1614
function UnitNetworkHandler:sync_doctor_bag_taken(unit, amount, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:base():sync_taken(amount)
end

-- Lines 1618-1623
function UnitNetworkHandler:sync_money_wrap_money_taken(unit, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:base():sync_money_taken()
end

-- Lines 1627-1640
function UnitNetworkHandler:sync_pickup(unit, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local pickup_extension = unit:base()

	if not pickup_extension or not pickup_extension.sync_pickup then
		pickup_extension = unit:pickup()
	end

	if pickup_extension and pickup_extension.sync_pickup then
		pickup_extension:sync_pickup(self._verify_sender(sender))
	end
end

-- Lines 1644-1654
function UnitNetworkHandler:unit_sound_play(unit, event_id, source, sender)
	if not alive(unit) or not self._verify_sender(sender) then
		return
	end

	if source == "" then
		source = nil
	end

	unit:sound():play(event_id, source, false)
end

-- Lines 1658-1679
function UnitNetworkHandler:corpse_sound_play(unit_id, event_id, source)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local u_data = managers.enemy:get_corpse_unit_data_from_id(unit_id)

	if not u_data then
		return
	end

	if not u_data.unit then
		debug_pause("[UnitNetworkHandler:corpse_sound_play] u_data without unit", inspect(u_data))

		return
	end

	if not u_data.unit:sound() then
		return
	end

	u_data.unit:sound():play(event_id, source, false)
end

-- Lines 1683-1692
function UnitNetworkHandler:say(unit, event_id, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if unit:in_slot(managers.slot:get_mask("all_criminals")) and not managers.groupai:state():is_enemy_converted_to_criminal(unit) then
		unit:sound():say(event_id, true, nil)
	else
		unit:sound():say(event_id, nil, true)
	end
end

-- Lines 1696-1701
function UnitNetworkHandler:sync_remove_one_teamAI(name, replace_with_player)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_remove_one_teamAI(name, replace_with_player)
end

-- Lines 1705-1710
function UnitNetworkHandler:sync_smoke_grenade(detonate_pos, shooter_pos, duration, flashbang)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_smoke_grenade(detonate_pos, shooter_pos, duration, flashbang)
end

-- Lines 1714-1719
function UnitNetworkHandler:sync_smoke_grenade_kill()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_smoke_grenade_kill()
end

-- Lines 1723-1728
function UnitNetworkHandler:sync_cs_grenade(detonate_pos, shooter_pos, duration)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_cs_grenade(detonate_pos, shooter_pos, duration)
end

-- Lines 1732-1737
function UnitNetworkHandler:sync_cs_grenade_kill()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_cs_grenade_kill()
end

-- Lines 1741-1746
function UnitNetworkHandler:sync_hostage_headcount(value)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_hostage_headcount(value)
end

-- Lines 1750-1756
function UnitNetworkHandler:play_distance_interact_redirect(unit, redirect, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:movement():play_redirect(redirect)
end

-- Lines 1760-1765
function UnitNetworkHandler:start_timer_gui(unit, timer, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:timer_gui():sync_start(timer)
end

-- Lines 1778-1783
function UnitNetworkHandler:give_equipment(equipment, amount, transfer, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.player:add_special({
		name = equipment,
		amount = amount,
		transfer = transfer
	})
end

-- Lines 1788-1793
function UnitNetworkHandler:killzone_set_unit(type)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.killzone:set_unit(managers.player:player_unit(), type)
end

-- Lines 1797-1802
function UnitNetworkHandler:dangerzone_set_level(level)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.player:player_unit():character_damage():set_danger_level(level)
end

-- Lines 1806-1890
function UnitNetworkHandler:sync_player_movement_state(unit, state, down_time, unit_id_str)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	self:_chk_unit_too_early(unit, unit_id_str, "sync_player_movement_state", 1, unit, state, down_time, unit_id_str)

	if not alive(unit) then
		return
	end

	local local_peer = managers.network:session():local_peer()

	if local_peer:unit() and unit:key() == local_peer:unit():key() then
		local valid_transitions = {
			standard = {
				arrested = true,
				incapacitated = true,
				carry = true,
				bleed_out = true,
				tased = true
			},
			carry = {
				arrested = true,
				incapacitated = true,
				standard = true,
				bleed_out = true,
				tased = true
			},
			mask_off = {
				arrested = true,
				carry = true,
				standard = true
			},
			bleed_out = {
				carry = true,
				fatal = true,
				standard = true
			},
			fatal = {
				carry = true,
				standard = true
			},
			arrested = {
				carry = true,
				standard = true
			},
			tased = {
				incapacitated = true,
				carry = true,
				standard = true
			},
			incapacitated = {
				carry = true,
				standard = true
			},
			clean = {
				arrested = true,
				carry = true,
				mask_off = true,
				standard = true,
				civilian = true
			},
			civilian = {
				arrested = true,
				carry = true,
				clean = true,
				standard = true,
				mask_off = true
			}
		}

		if unit:movement():current_state_name() == state then
			return
		end

		if unit:movement():current_state_name() and valid_transitions[unit:movement():current_state_name()][state] then
			managers.player:set_player_state(state)
		else
			debug_pause_unit(unit, "[UnitNetworkHandler:sync_player_movement_state] received invalid transition", unit, unit:movement():current_state_name(), "->", state)
		end
	else
		unit:movement():sync_movement_state(state, down_time)
	end
end

-- Lines 1895-1900
function UnitNetworkHandler:sync_waiting_for_player_start(variant, soundtrack)
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_players) then
		return
	end

	game_state_machine:current_state():sync_start(variant, soundtrack)
end

-- Lines 1902-1907
function UnitNetworkHandler:sync_waiting_for_player_skip()
	if not self._verify_gamestate(self._gamestate_filter.waiting_for_players) then
		return
	end

	game_state_machine:current_state():sync_skip()
end

-- Lines 1911-1920
function UnitNetworkHandler:criminal_hurt(criminal_unit, attacker_unit, damage_ratio, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(criminal_unit, sender) then
		return
	end

	if not alive(attacker_unit) or criminal_unit:key() == attacker_unit:key() then
		attacker_unit = nil
	end

	managers.groupai:state():criminal_hurt_drama(criminal_unit, attacker_unit, damage_ratio * 0.01)
end

-- Lines 1924-1929
function UnitNetworkHandler:arrested(unit)
	if not alive(unit) then
		return
	end

	unit:movement():sync_arrested()
end

-- Lines 1933-1945
function UnitNetworkHandler:suspect_uncovered(enemy_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local suspect_member = managers.network:session():local_peer()
	local suspect_unit = suspect_member and suspect_member:unit()

	if not suspect_unit then
		return
	end

	suspect_unit:movement():on_uncovered(enemy_unit)
end

-- Lines 1949-1957
function UnitNetworkHandler:clear_synced_team_upgrades(sender)
	local sender_peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end

	local peer_id = sender_peer:id()

	managers.player:clear_synced_team_upgrades(peer_id)
end

-- Lines 1961-1969
function UnitNetworkHandler:add_synced_team_upgrade(category, upgrade, level, sender)
	local sender_peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not sender_peer then
		return
	end

	local peer_id = sender_peer:id()

	managers.player:add_synced_team_upgrade(peer_id, category, upgrade, level)
end

-- Lines 1972-1979
function UnitNetworkHandler:sync_deployable_equipment(deployable, amount, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_deployable_equipment(peer, deployable, amount)
end

-- Lines 1982-1992
function UnitNetworkHandler:sync_peer_world_data(world_id, stage_prepare, stage_load, stage_load_finished, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	Application:debug("[UnitNetworkHandler:sync_peer_world_data]", peer:id(), world_id, stage_prepare, stage_load, stage_load_finished)

	peer._synced_worlds[world_id] = peer._synced_worlds[world_id] or {}
	peer._synced_worlds[world_id][CoreWorldCollection.STAGE_LOAD] = stage_load
	peer._synced_worlds[world_id][CoreWorldCollection.STAGE_PREPARE] = stage_prepare
	peer._synced_worlds[world_id][CoreWorldCollection.STAGE_LOAD_FINISHED] = stage_load_finished
end

-- Lines 1995-2002
function UnitNetworkHandler:sync_cable_ties(amount, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_cable_ties(peer:id(), amount)
end

-- Lines 2005-2012
function UnitNetworkHandler:sync_grenades(grenade, amount, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_grenades(peer:id(), grenade, amount)
end

-- Lines 2015-2022
function UnitNetworkHandler:sync_ammo_amount(selection_index, max_clip, current_clip, current_left, max, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_ammo_info(peer:id(), selection_index, max_clip, current_clip, current_left, max)
end

-- Lines 2025-2032
function UnitNetworkHandler:sync_bipod(bipod_pos, body_pos, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_bipod(peer, bipod_pos, body_pos)
end

-- Lines 2035-2042
function UnitNetworkHandler:sync_carry(carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_carry(peer, carry_id, multiplier, dye_initiated, has_dye_pack, dye_value_multiplier)
end

-- Lines 2044-2051
function UnitNetworkHandler:sync_remove_carry(sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:remove_synced_carry(peer)
end

-- Lines 2053-2060
function UnitNetworkHandler:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, zipline_unit, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer)
end

-- Lines 2062-2070
function UnitNetworkHandler:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer_id, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.player:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer_id)
end

-- Lines 2084-2101
function UnitNetworkHandler:request_throw_projectile(projectile_type, position, dir, cooking_t, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	local peer_id = peer:id()
	local projectile_entry = tweak_data.blackmarket:get_projectile_name_from_index(projectile_type)
	local no_cheat_count = tweak_data.projectiles[projectile_entry].no_cheat_count

	if not no_cheat_count and not managers.player:verify_grenade(peer_id) then
		return
	end

	ProjectileBase.throw_projectile(projectile_type, position, dir, peer_id, cooking_t)
end

-- Lines 2104-2160
function UnitNetworkHandler:sync_throw_projectile(unit, pos, dir, projectile_type, peer_id, parent_projectile_id, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		print("_verify failed!!!")

		return
	end

	local projectile_entry = tweak_data.blackmarket:get_projectile_name_from_index(projectile_type)
	local tweak_entry = tweak_data.projectiles[projectile_entry]

	if tweak_entry.client_authoritative then
		if not unit then
			local unit_name = Idstring(tweak_entry.local_unit)
			unit = World:spawn_unit(unit_name, pos, Rotation(dir, math.UP))
		end

		unit:base():set_owner_peer_id(peer_id)
	end

	if not alive(unit) then
		print("unit is not alive!!!")

		return
	end

	local server_peer = managers.network:session():server_peer()

	if tweak_entry.throwable and not peer == server_peer then
		print("projectile is throwable, should not be thrown by client!!!")

		return
	end

	local no_cheat_count = tweak_entry.no_cheat_count

	if not no_cheat_count then
		managers.player:verify_grenade(peer_id)
	end

	local member = managers.network:session():peer(peer_id)
	local thrower_unit = member and member:unit()

	if thrower_unit then
		unit:base():set_thrower_unit(thrower_unit)
		unit:base():set_thrower_peer_id(peer_id)

		if not tweak_entry.throwable and thrower_unit:movement() and thrower_unit:movement():current_state() then
			unit:base():set_weapon_unit(thrower_unit:movement():current_state()._equipped_unit)
		end
	end

	if parent_projectile_id then
		unit:base():set_parent_projectile_id(parent_projectile_id)
	end

	unit:base():sync_throw_projectile(dir, projectile_type)
end

-- Lines 2162-2175
function UnitNetworkHandler:sync_detonate_molotov_grenade(unit, ext_name, event_id, normal, rpc)
	local peer = self._verify_sender(rpc)

	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local extension = unit[ext_name](unit)

	if not extension then
		debug_pause("[UnitNetworkHandler:sync_detonate_molotov_grenade] unit", unit, "does not have extension", ext_name)

		return
	end

	extension:sync_detonate_molotov_grenade(event_id, normal, peer)
end

-- Lines 2179-2186
function UnitNetworkHandler:sync_fall_position(unit, pos, rot)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		unit:movement():sync_fall_position(pos, rot)
	end
end

-- Lines 2190-2195
function UnitNetworkHandler:sync_add_doted_enemy(enemy_unit, fire_damage_received_time, weapon_unit, dot_length, dot_damage, rpc)
	local peer = self._verify_sender(rpc)

	managers.fire:sync_add_fire_dot(enemy_unit, fire_damage_received_time, weapon_unit, dot_length, dot_damage, peer)
end

-- Lines 2199-2206
function UnitNetworkHandler:server_secure_loot(carry_id, multiplier_level, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.loot:server_secure_loot(carry_id, multiplier_level)
end

-- Lines 2208-2214
function UnitNetworkHandler:sync_secure_loot(carry_id, multiplier_level, silent, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) and not self._verify_gamestate(self._gamestate_filter.any_end_game) or not self._verify_sender(sender) then
		return
	end

	managers.loot:sync_secure_loot(carry_id, multiplier_level, silent)
end

-- Lines 2216-2222
function UnitNetworkHandler:sync_small_loot_taken(unit, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	unit:base():taken()
end

-- Lines 2226-2232
function UnitNetworkHandler:sync_heist_time(time, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.game_play_central:sync_heist_time(time)
end

-- Lines 2236-2274
function UnitNetworkHandler:set_teammate_hud(unit, percent, id, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) or not PlayerDamage then
		return
	end

	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)

	if id == PlayerDamage.HUD_NET_EVENTS.health then
		if character_data and character_data.panel_id then
			managers.hud:set_teammate_health(character_data.panel_id, {
				total = 1,
				max = 1,
				current = percent / 100
			})
		else
			managers.hud:set_mugshot_health(unit:unit_data().mugshot_id, percent / 100)
		end

		if percent ~= 100 then
			managers.mission:call_global_event("player_damaged")
		end
	elseif id == PlayerDamage.HUD_NET_EVENTS.armor then
		if character_data and character_data.panel_id then
			managers.hud:set_teammate_armor(character_data.panel_id, {
				total = 1,
				max = 1,
				current = percent / 100
			})
		else
			managers.hud:set_mugshot_armor(unit:unit_data().mugshot_id, percent / 100)
		end
	elseif id == PlayerDamage.HUD_NET_EVENTS.stored_health then
		if character_data and character_data.panel_id then
			managers.hud:set_teammate_stored_health(character_data.panel_id, percent / 100)
		else
			managers.hud:set_mugshot_stored_health(unit:unit_data().mugshot_id, percent / 100)
		end
	elseif id == PlayerDamage.HUD_NET_EVENTS.stored_health_max then
		if character_data and character_data.panel_id then
			managers.hud:set_teammate_stored_health_max(character_data.panel_id, percent / 100)
		else
			managers.hud:set_mugshot_stored_health_max(unit:unit_data().mugshot_id, percent / 100)
		end
	end
end

-- Lines 2276-2290
function UnitNetworkHandler:set_armor(unit, percent, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)

	if character_data and character_data.panel_id then
		managers.hud:set_teammate_armor(character_data.panel_id, {
			total = 1,
			max = 1,
			current = percent / 100
		})
	else
		managers.hud:set_mugshot_armor(unit:unit_data().mugshot_id, percent / 100)
	end
end

-- Lines 2292-2309
function UnitNetworkHandler:set_health(unit, percent, sender)
	if not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	local peer = self._verify_sender(sender)
	local peer_id = peer:id()
	local character_data = managers.criminals:character_data_by_peer_id(peer_id)

	if character_data and character_data.panel_id then
		managers.hud:set_teammate_health(character_data.panel_id, {
			total = 1,
			max = 1,
			current = percent / 100
		})
	else
		managers.hud:set_mugshot_health(unit:unit_data().mugshot_id, percent / 100)
	end

	if percent ~= 100 then
		managers.mission:call_global_event("player_damaged")
	end
end

-- Lines 2311-2316
function UnitNetworkHandler:sync_equipment_possession(peer_id, equipment, amount, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.player:set_synced_equipment_possession(peer_id, equipment, amount)
end

-- Lines 2318-2328
function UnitNetworkHandler:sync_remove_equipment_possession(peer_id, equipment, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	local equipment_peer = managers.network:session():peer(peer_id)

	if not equipment_peer then
		print("[UnitNetworkHandler:sync_remove_equipment_possession] unknown peer", peer_id)

		return
	end

	managers.player:remove_equipment_possession(peer_id, equipment)
end

-- Lines 2332-2337
function UnitNetworkHandler:sync_start_anticipation()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.hud:sync_start_anticipation()
end

-- Lines 2339-2344
function UnitNetworkHandler:sync_start_anticipation_music()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.hud:sync_start_anticipation_music()
end

-- Lines 2346-2351
function UnitNetworkHandler:sync_start_assault()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.hud:sync_start_assault()
end

-- Lines 2353-2358
function UnitNetworkHandler:sync_end_assault(result)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.hud:sync_end_assault(result)
end

-- Lines 2362-2387
function UnitNetworkHandler:sync_contour_state(unit, u_id, type, state, multiplier, damage_multiplier, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	local contour_unit = nil

	if alive(unit) and unit:id() ~= -1 then
		contour_unit = unit
	else
		local unit_data = managers.enemy:get_corpse_unit_data_from_id(u_id)

		if unit_data then
			contour_unit = unit_data.unit
		end
	end

	if not contour_unit then
		Application:error("[UnitNetworkHandler:sync_contour_state] Unit is missing")

		return
	end

	if state then
		contour_unit:contour():add(ContourExt.indexed_types[type], false, multiplier, damage_multiplier)
	else
		contour_unit:contour():remove(ContourExt.indexed_types[type], nil)
	end
end

-- Lines 2391-2411
function UnitNetworkHandler:mark_minion(unit, minion_owner_peer_id, convert_enemies_health_multiplier_level, passive_convert_enemies_health_multiplier_level, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	local health_multiplier = 1

	if convert_enemies_health_multiplier_level > 0 then
		health_multiplier = health_multiplier * tweak_data.upgrades.values.player.convert_enemies_health_multiplier[convert_enemies_health_multiplier_level]
	end

	if passive_convert_enemies_health_multiplier_level > 0 then
		health_multiplier = health_multiplier * tweak_data.upgrades.values.player.passive_convert_enemies_health_multiplier[passive_convert_enemies_health_multiplier_level]
	end

	unit:character_damage():convert_to_criminal(health_multiplier)
	unit:contour():add("friendly", false)
	managers.groupai:state():sync_converted_enemy(unit)

	if minion_owner_peer_id == managers.network:session():local_peer():id() then
		managers.player:count_up_player_minions()
	end
end

-- Lines 2413-2418
function UnitNetworkHandler:count_down_player_minions()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.player:count_down_player_minions()
end

-- Lines 2422-2427
function UnitNetworkHandler:sync_teammate_helped_hint(hint, helped_unit, helping_unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(helped_unit, sender) or not self._verify_character(helping_unit, sender) then
		return
	end

	managers.trade:sync_teammate_helped_hint(helped_unit, helping_unit, hint)
end

-- Lines 2431-2436
function UnitNetworkHandler:sync_assault_mode(enabled)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_assault_mode(enabled)
end

-- Lines 2440-2445
function UnitNetworkHandler:sync_hostage_killed_warning(warning)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_hostage_killed_warning(warning)
end

-- Lines 2449-2455
function UnitNetworkHandler:set_interaction_voice(unit, voice, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	unit:brain():set_interaction_voice(voice ~= "" and voice or nil)
end

-- Lines 2459-2464
function UnitNetworkHandler:sync_teammate_comment(message, pos, pos_based, radius, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.groupai:state():sync_teammate_comment(message, pos, pos_based, radius)
end

-- Lines 2466-2471
function UnitNetworkHandler:sync_teammate_comment_instigator(unit, message)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.groupai:state():sync_teammate_comment_instigator(unit, message)
end

-- Lines 2475-2480
function UnitNetworkHandler:begin_gameover_fadeout()
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():begin_gameover_fadeout()
end

-- Lines 2484-2496
function UnitNetworkHandler:send_statistics(total_kills, total_specials_kills, total_head_shots, accuracy, downs, revives, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_end_game) then
		return
	end

	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	managers.statistics:on_statistics_recieved(peer:id(), total_kills, total_specials_kills, total_head_shots, accuracy, downs, revives)
end

-- Lines 2500-2517
function UnitNetworkHandler:sync_statistics_result(top_stat_1_id, top_stat_1_peer_id, top_stat_1_peer_name, top_stat_1_score, top_stat_2_id, top_stat_2_peer_id, top_stat_2_peer_name, top_stat_2_score, top_stat_3_id, top_stat_3_peer_id, top_stat_3_peer_name, top_stat_3_score, bottom_stat_1_id, bottom_stat_1_peer_id, bottom_stat_1_peer_name, bottom_stat_1_score, bottom_stat_2_id, bottom_stat_2_peer_id, bottom_stat_2_peer_name, bottom_stat_2_score, bottom_stat_3_id, bottom_stat_3_peer_id, bottom_stat_3_peer_name, bottom_stat_3_score)
	managers.statistics:set_top_stats(top_stat_1_id, top_stat_1_peer_id, top_stat_1_peer_name, top_stat_1_score, top_stat_2_id, top_stat_2_peer_id, top_stat_2_peer_name, top_stat_2_score, top_stat_3_id, top_stat_3_peer_id, top_stat_3_peer_name, top_stat_3_score)
	managers.statistics:set_bottom_stats(bottom_stat_1_id, bottom_stat_1_peer_id, bottom_stat_1_peer_name, bottom_stat_1_score, bottom_stat_2_id, bottom_stat_2_peer_id, bottom_stat_2_peer_name, bottom_stat_2_score, bottom_stat_3_id, bottom_stat_3_peer_id, bottom_stat_3_peer_name, bottom_stat_3_score)
	managers.system_event_listener:call_listeners(CoreSystemEventListenerManager.SystemEventListenerManager.TOP_STATS_READY)
end

-- Lines 2521-2526
function UnitNetworkHandler:statistics_tied(name, sender)
end

-- Lines 2530-2538
function UnitNetworkHandler:bain_comment(bain_line, sender)
	if not self._verify_sender(sender) then
		return
	end

	if managers.dialog and managers.groupai and managers.groupai:state():bain_state() then
		managers.dialog:queue_dialog(bain_line, {})
	end
end

-- Lines 2542-2549
function UnitNetworkHandler:is_inside_point_of_no_return(is_inside, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.groupai:state():set_is_inside_point_of_no_return(peer:id(), is_inside)
end

-- Lines 2553-2566
function UnitNetworkHandler:mission_ended(win, num_is_inside, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	if managers.platform:presence() == "Playing" then
		if win then
			game_state_machine:change_state_by_name("victoryscreen", {
				num_winners = num_is_inside,
				personal_win = not managers.groupai:state()._failed_point_of_no_return and alive(managers.player:player_unit())
			})
		else
			game_state_machine:change_state_by_name("gameoverscreen")
		end
	end
end

-- Lines 2570-2577
function UnitNetworkHandler:sync_character_level(level, sender)
	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	peer:set_level(level)
end

-- Lines 2579-2586
function UnitNetworkHandler:sync_character_class_nationality(character_class_name, character_nation_name, sender)
	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	peer:set_class_nation(character_class_name, character_nation_name)
end

-- Lines 2589-2598
function UnitNetworkHandler:update_matchmake_attributes(sender)
	local peer = self._verify_sender(sender)

	if not peer then
		return
	end

	if Network:is_server() then
		managers.network:update_matchmake_attributes()
	end
end

-- Lines 2611-2617
function UnitNetworkHandler:sync_disable_shout(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	ElementDisableShout.sync_function(unit, state)
end

-- Lines 2619-2625
function UnitNetworkHandler:sync_run_sequence_char(unit, seq, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	ElementSequenceCharacter.sync_function(unit, seq)
end

-- Lines 2627-2636
function UnitNetworkHandler:sync_player_kill_statistic(tweak_table_name, is_headshot, weapon_unit, variant, stats_name, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) or not alive(weapon_unit) then
		return
	end

	local data = {
		name = tweak_table_name,
		stats_name = stats_name,
		head_shot = is_headshot,
		weapon_unit = weapon_unit,
		variant = variant
	}

	managers.statistics:killed_by_anyone(data)

	local attacker_state = managers.player:current_state()
	data.attacker_state = attacker_state

	managers.statistics:killed(data)
end

-- Lines 2640-2651
function UnitNetworkHandler:set_attention_enabled(unit, setting_index, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character_and_sender(unit, sender) then
		return
	end

	if unit:in_slot(managers.slot:get_mask("players")) and unit:base().is_husk_player then
		local setting_name = tweak_data.attention:get_attention_name(setting_index)

		unit:movement():sync_attention_setting(setting_name, state, false)
	else
		debug_pause_unit(unit, "[UnitNetworkHandler:set_attention_enabled] invalid unit", unit)
	end
end

-- Lines 2655-2661
function UnitNetworkHandler:link_attention_no_rot(parent_unit, attention_object, parent_object, local_pos, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(parent_unit) or not alive(attention_object) then
		return
	end

	attention_object:attention():link(parent_unit, parent_object, local_pos)
end

-- Lines 2665-2671
function UnitNetworkHandler:unlink_attention(attention_object, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(attention_object) then
		return
	end

	attention_object:attention():link(nil)
end

-- Lines 2675-2699
function UnitNetworkHandler:suspicion(suspect_peer_id, susp_value, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local suspect_member = managers.network:session():peer(suspect_peer_id)

	if not suspect_member then
		return
	end

	local suspect_unit = suspect_member:unit()

	if not suspect_unit then
		return
	end

	if susp_value == 0 then
		susp_value = false
	elseif susp_value == 255 then
		susp_value = true
	else
		susp_value = susp_value / 254
	end

	suspect_unit:movement():on_suspicion(nil, susp_value)
end

-- Lines 2703-2721
function UnitNetworkHandler:suspicion_hud(suspect_unit, observer_unit, status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(observer_unit) then
		return
	end

	if status == 0 then
		status = false
	elseif status == 2 then
		status = true
	elseif status == 3 then
		status = "calling"
	elseif status == 4 then
		status = "called"
	elseif status == 5 then
		status = "call_interrupted"
	end

	managers.groupai:state():on_criminal_suspicion_progress(suspect_unit, observer_unit, status)
end

-- Lines 2723-2737
function UnitNetworkHandler:spotter_hud(suspect_unit, observer_unit, status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not alive(observer_unit) then
		return
	end

	if status == 0 then
		status = "remove"
	elseif status == 2 then
		status = "barrage"
	elseif status == 3 then
		status = "empty"
	end

	managers.groupai:state():on_spotter_detection_progress(suspect_unit, observer_unit, status)
end

-- Lines 2739-2754
function UnitNetworkHandler:sync_suspicion_icon(unit, icon_type, status)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local waypoint = managers.hud:get_waypoint_for_unit(unit)

	if waypoint then
		if icon_type == "aim" then
			managers.hud:set_aiming_icon(waypoint, status)
		elseif icon_type == "investigate" then
			managers.hud:set_investigate_icon(waypoint, status)
		end
	else
		Application:error("[UnitNetworkHandler:sync_suspicion_icon] Waypoint not found for unit", unit)
	end
end

-- Lines 2758-2764
function UnitNetworkHandler:group_ai_event(event_id, blame_id, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():sync_event(event_id, blame_id)
end

-- Lines 2768-2788
function UnitNetworkHandler:start_timespeed_effect(effect_id, timer_name, affect_timer_names_str, speed, fade_in, sustain, fade_out, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	local affect_timer_names = nil

	if affect_timer_names_str ~= "" then
		affect_timer_names = string.split(affect_timer_names_str, ";")
	end

	local effect_desc = {
		timer = timer_name,
		affect_timer = affect_timer_names,
		speed = speed,
		fade_in = fade_in,
		sustain = sustain,
		fade_out = fade_out
	}

	managers.time_speed:play_effect(effect_id, effect_desc)
end

-- Lines 2792-2798
function UnitNetworkHandler:stop_timespeed_effect(effect_id, fade_out_duration, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_sender(sender) then
		return
	end

	managers.time_speed:stop_effect(effect_id, fade_out_duration)
end

-- Lines 2802-2816
function UnitNetworkHandler:sync_upgrade(upgrade_category, upgrade_name, upgrade_level, sender)
	local peer = self._verify_sender(sender)

	if not peer then
		Application:error("[UnitNetworkHandler:sync_upgrade] missing peer", upgrade_category, upgrade_name, upgrade_level, sender:ip_at_index(0))

		return
	end

	local unit = peer:unit()

	if not unit then
		Application:error("[UnitNetworkHandler:sync_upgrade] missing unit", upgrade_category, upgrade_name, upgrade_level, sender:ip_at_index(0))

		return
	end

	unit:base():set_upgrade_value(upgrade_category, upgrade_name, upgrade_level)
end

-- Lines 2820-2844
function UnitNetworkHandler:suppression(unit, ratio, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	local sup_tweak = unit:base():char_tweak().suppression

	if not sup_tweak then
		debug_pause_unit(unit, "[UnitNetworkHandler:suppression] husk missing suppression settings", unit)

		return
	end

	local amount_max = (sup_tweak.brown_point or sup_tweak.react_point)[2]
	local amount, panic_chance = nil

	if ratio == 16 then
		amount = "max"
		panic_chance = -1
	else
		amount = ratio == 15 and "max" or amount_max > 0 and amount_max * ratio / 15 or "max"
	end

	unit:character_damage():build_suppression(amount, panic_chance)
end

-- Lines 2848-2854
function UnitNetworkHandler:suppressed_state(unit, state, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(unit) then
		return
	end

	unit:movement():on_suppressed(state)
end

-- Lines 2858-2866
function UnitNetworkHandler:camera_yaw_pitch(cam_unit, yaw_255, pitch_255)
	if not alive(cam_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local yaw = 360 * yaw_255 / 255 - 180
	local pitch = 180 * pitch_255 / 255 - 90

	cam_unit:base():apply_rotations(yaw, pitch)
end

-- Lines 2870-2880
function UnitNetworkHandler:loot_link(loot_unit, parent_unit, sender)
	if not alive(loot_unit) or not alive(parent_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if loot_unit == parent_unit then
		loot_unit:carry_data():unlink()
	else
		loot_unit:carry_data():link_to(parent_unit)
	end
end

-- Lines 2884-2894
function UnitNetworkHandler:remove_unit(unit, sender)
	if not alive(unit) then
		return
	end

	if unit:id() ~= -1 then
		Network:detach_unit(unit)
	end

	unit:set_slot(0)
end

-- Lines 2898-2904
function UnitNetworkHandler:sync_gui_net_event(unit, event_id, value, sender)
	if not alive(unit) or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:digital_gui():sync_gui_net_event(event_id, value)
end

-- Lines 2908-2914
function UnitNetworkHandler:sync_proximity_activation(unit, proximity_name, range_data_string, sender)
	if not alive(unit) or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:damage():sync_proximity_activation(proximity_name, range_data_string)
end

-- Lines 2916-2936
function UnitNetworkHandler:sync_inflict_body_damage(body, unit, normal, position, direction, damage, velocity, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(body) then
		return
	end

	if not body:extension() then
		print("[UnitNetworkHandler:sync_inflict_body_damage] body has no extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage then
		print("[UnitNetworkHandler:sync_inflict_body_damage] body has no damage extension", body:name(), body:unit():name())

		return
	end

	if not body:extension().damage.damage_fire then
		print("[UnitNetworkHandler:sync_inflict_body_damage] body has no damage damage_bullet function", body:name(), body:unit():name())

		return
	end

	body:extension().damage:damage_fire(unit, normal, position, direction, damage, velocity)
end

-- Lines 2941-2956
function UnitNetworkHandler:sync_team_relation(team_index_1, team_index_2, relation_code)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	local team_id_1 = tweak_data.levels:get_team_names_indexed()[team_index_1]
	local team_id_2 = tweak_data.levels:get_team_names_indexed()[team_index_2]
	local relation = relation_code == 1 and "neutral" or relation_code == 2 and "friend" or "foe"

	if not team_id_1 or not team_id_2 or relation_code < 1 or relation_code > 3 then
		debug_pause("[UnitNetworkHandler:sync_team_relation] invalid params", team_index_1, team_index_2, relation_code, Global.level_data.level_id)

		return
	end

	managers.groupai:state():set_team_relation(team_id_1, team_id_2, relation, nil)
end

-- Lines 2960-2972
function UnitNetworkHandler:sync_char_team(unit, team_index, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not self._verify_character(unit) then
		return
	end

	local team_id = tweak_data.levels:get_team_names_indexed()[team_index]
	local team_data = managers.groupai:state():team_data(team_id)

	unit:movement():set_team(team_data)
end

-- Lines 2976-2992
function UnitNetworkHandler:sync_vehicle_driving(action, unit, player)
	Application:debug("[DRIVING_NET] sync_vehicle_driving " .. action)

	if not alive(unit) then
		return
	end

	local ext = unit:npc_vehicle_driving()
	ext = ext or unit:vehicle_driving()

	if action == "start" then
		ext:sync_start(player)
	elseif action == "stop" then
		ext:sync_stop()
	end
end

-- Lines 2995-3001
function UnitNetworkHandler:sync_vehicle_set_input(unit, accelerate, steer, brake, handbrake, gear_up, gear_down, forced_gear)
	if not alive(unit) then
		return
	end

	unit:vehicle_driving():sync_set_input(accelerate, steer, brake, handbrake, gear_up, gear_down, forced_gear)
end

-- Lines 3003-3009
function UnitNetworkHandler:sync_vehicle_state(unit, position, rotation, velocity)
	if not alive(unit) then
		return
	end

	unit:vehicle_driving():sync_state(position, rotation, velocity)
end

-- Lines 3012-3018
function UnitNetworkHandler:sync_enter_vehicle_host(vehicle, seat_name, peer_id, player)
	Application:debug("[DRIVING_NET] sync_enter_vehicle_host", seat_name)

	if not alive(vehicle) then
		return
	end

	managers.player:server_enter_vehicle(vehicle, peer_id, player, seat_name)
end

-- Lines 3020-3029
function UnitNetworkHandler:sync_vehicle_player(action, vehicle, peer_id, player, seat_name, prev_seat_name)
	Application:debug("[DRIVING_NET] sync_vehicle_player " .. action)

	if action == "enter" then
		managers.player:sync_enter_vehicle(vehicle, peer_id, player, seat_name)
	elseif action == "exit" then
		managers.player:sync_exit_vehicle(peer_id, player)
	elseif action == "next_seat" then
		managers.player:sync_move_to_next_seat(vehicle, peer_id, player, seat_name, prev_seat_name)
	end
end

-- Lines 3031-3033
function UnitNetworkHandler:sync_vehicle_player_swithc_seat(action, vehicle, peer_id, player, seat_name, previous_seat_name, previous_occupant)
	managers.player:sync_move_to_next_seat(vehicle, peer_id, player, seat_name, previous_seat_name, previous_occupant)
end

-- Lines 3035-3038
function UnitNetworkHandler:sync_move_to_next_seat(vehicle, peer_id, player, seat_name)
	Application:debug("[DRIVING_NET] sync_move_to_next_seat " .. seat_name)
	managers.player:server_move_to_next_seat(vehicle, peer_id, player, seat_name)
end

-- Lines 3040-3046
function UnitNetworkHandler:sync_vehicle_data(vehicle, state_name, occupant_driver, occupant_left, occupant_back_left, occupant_back_right, is_trunk_open, vehicle_health)
	Application:debug("[DRIVING_NET] sync_vehicles_data", vehicle, state_name)

	if not alive(vehicle) then
		return
	end

	managers.vehicle:sync_vehicle_data(vehicle, state_name, occupant_driver, occupant_left, occupant_back_left, occupant_back_right, is_trunk_open, vehicle_health)
end

-- Lines 3048-3054
function UnitNetworkHandler:sync_npc_vehicle_data(vehicle, state_name, target_unit)
	Application:debug("[DRIVING_NET] sync_npc_vehicle_data", vehicle, state_name)

	if not alive(vehicle) then
		return
	end

	managers.vehicle:sync_npc_vehicle_data(vehicle, state_name, target_unit)
end

-- Lines 3057-3063
function UnitNetworkHandler:sync_vehicle_loot(vehicle, carry_id1, multiplier1, carry_id2, multiplier2, carry_id3, multiplier3)
	Application:debug("[DRIVING_NET] sync_vehicle_loot")

	if not alive(vehicle) then
		return
	end

	managers.vehicle:sync_vehicle_loot(vehicle, carry_id1, multiplier1, carry_id2, multiplier2, carry_id3, multiplier3)
end

-- Lines 3065-3082
function UnitNetworkHandler:sync_ai_vehicle_action(action, vehicle, data, unit)
	Application:debug("[DRIVING_NET] sync_ai_vehicle_action: ", action, data)

	if not alive(vehicle) then
		return
	end

	if action == "health" then
		vehicle:character_damage():sync_vehicle_health(data)
	elseif action == "revive" then
		vehicle:character_damage():sync_vehicle_revive(data)
	elseif action == "state" then
		vehicle:vehicle_driving():sync_vehicle_state(data)
	else
		if not alive(unit) then
			return
		end

		vehicle:vehicle_driving():sync_ai_vehicle_action(action, data, unit)
	end
end

-- Lines 3084-3090
function UnitNetworkHandler:server_store_loot_in_vehicle(vehicle, loot_bag)
	Application:debug("[DRIVING_NET] server_store_loot_in_vehicle")

	if not alive(vehicle) or not alive(loot_bag) then
		return
	end

	vehicle:vehicle_driving():server_store_loot_in_vehicle(loot_bag)
end

-- Lines 3092-3098
function UnitNetworkHandler:sync_vehicle_change_stance(shooting_unit, stance)
	Application:debug("[DRIVING_NET] sync_vehicle_change_stance")

	if not alive(shooting_unit) then
		return
	end

	shooting_unit:movement():sync_vehicle_change_stance(stance)
end

-- Lines 3100-3106
function UnitNetworkHandler:sync_store_loot_in_vehicle(vehicle, loot_bag, carry_id, multiplier)
	Application:debug("[DRIVING_NET] sync_store_loot_in_vehicle")

	if not alive(vehicle) or not alive(loot_bag) then
		return
	end

	vehicle:vehicle_driving():sync_store_loot_in_vehicle(loot_bag, carry_id, multiplier)
end

-- Lines 3108-3111
function UnitNetworkHandler:server_give_vehicle_loot_to_player(vehicle, peer_id)
	Application:debug("[DRIVING_NET] server_give_vehicle_loot_to_player")
	vehicle:vehicle_driving():server_give_vehicle_loot_to_player(peer_id)
end

-- Lines 3113-3116
function UnitNetworkHandler:sync_give_vehicle_loot_to_player(vehicle, carry_id, multiplier, peer_id)
	Application:debug("[DRIVING_NET] sync_give_vehicle_loot_to_player")
	vehicle:vehicle_driving():sync_give_vehicle_loot_to_player(carry_id, multiplier, peer_id)
end

-- Lines 3118-3121
function UnitNetworkHandler:sync_vehicle_interact_trunk(vehicle, peer_id)
	Application:debug("[DRIVING_NET] sync_vehicle_interact_trunk")
	vehicle:vehicle_driving():_interact_trunk(vehicle)
end

-- Lines 3123-3126
function UnitNetworkHandler:sync_remote_position(unit, head_pos, pos)
	unit:movement():sync_remote_position(head_pos, pos)
end

-- Lines 3128-3138
function UnitNetworkHandler:sync_vehicle_loot_enabled(vehicle, enabled)
	if not vehicle then
		return
	end

	if enabled then
		vehicle:vehicle_driving():enable_loot_interaction()
	else
		vehicle:vehicle_driving():disable_loot_interaction()
	end
end

-- Lines 3140-3150
function UnitNetworkHandler:sync_vehicle_accepting_loot(vehicle, enabled)
	if not vehicle then
		return
	end

	if enabled then
		vehicle:vehicle_driving():enable_accepting_loot()
	else
		vehicle:vehicle_driving():disable_accepting_loot()
	end
end

-- Lines 3155-3163
function UnitNetworkHandler:sync_unit_data(unit, world_id, editor_id)
	local world = managers.worldcollection:worlddefinition_by_id(world_id)

	if world then
		world:sync_unit_data(unit, editor_id)
	else
		debug_pause("[UnitNetworkHandler:sync_unit_data] Network message arrived for non existant world (unit, world_id, editor_id).", unit, world_id, editor_id, inspect(managers.worldcollection._world_definitions))
	end
end

-- Lines 3165-3171
function UnitNetworkHandler:sync_vehicle_turret_rot(vehicle, rotation)
	Application:debug("[UnitNetworkHandler] sync_vehicle_turret_rot", vehicle)

	if alive(vehicle) then
		vehicle:mounted_weapon():set_turret_target_rot(rotation, false)
	end
end

-- Lines 3173-3184
function UnitNetworkHandler:sync_damage_reduction_buff(damage_reduction)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not damage_reduction then
		debug_pause("[UnitNetworkHandler:sync_damage_reduction_buff] invalid params", damage_reduction)

		return
	end

	managers.groupai:state():set_phalanx_damage_reduction_buff(damage_reduction)
end

-- Lines 3188-3194
function UnitNetworkHandler:sync_assault_endless(enabled)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.groupai:state():set_assault_endless(enabled)
end

-- Lines 3198-3206
function UnitNetworkHandler:action_jump(unit, pos, jump_vec, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(unit) then
		return
	end

	unit:movement():sync_action_jump(pos, jump_vec)
end

-- Lines 3208-3216
function UnitNetworkHandler:action_jump_middle(unit, pos, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(unit) then
		return
	end

	unit:movement():sync_action_jump_middle(pos)
end

-- Lines 3218-3226
function UnitNetworkHandler:action_land(unit, pos, sender)
	if not self._verify_character_and_sender(unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(unit) then
		return
	end

	unit:movement():sync_action_land(pos)
end

-- Lines 3228-3235
function UnitNetworkHandler:sync_fall_position(unit, pos, rot)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		unit:movement():sync_fall_position(pos, rot)
	end
end

-- Lines 3239-3246
function UnitNetworkHandler:sync_ground_turret_rot(player_rotation, turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():sync_turret_rotation(player_rotation)
	end
end

-- Lines 3248-3255
function UnitNetworkHandler:sync_ground_turret_activate(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():set_active(true)
	end
end

-- Lines 3257-3264
function UnitNetworkHandler:sync_ground_turret_start_autofire(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():start_autofire()
	end
end

-- Lines 3266-3273
function UnitNetworkHandler:sync_ground_turret_stop_autofire(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():stop_autofire()
	end
end

-- Lines 3275-3282
function UnitNetworkHandler:sync_ground_turret_trigger_held(turret_unit, blanks, expend_ammo, shoot_player, target_unit, damage_multiplier, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():trigger_held(blanks, expend_ammo, shoot_player, target_unit, damage_multiplier)
	end
end

-- Lines 3284-3291
function UnitNetworkHandler:sync_ground_turret_activate_as_module(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:base():activate_as_module("combatant", "turret_m2")
	end
end

-- Lines 3293-3300
function UnitNetworkHandler:sync_ground_turret_husk(husk_pos, turret_rot, enter_animation, exit_animation, turret_unit, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		return
	end

	managers.player:set_synced_turret(peer, husk_pos, turret_rot, enter_animation, exit_animation, turret_unit)
end

-- Lines 3302-3313
function UnitNetworkHandler:sync_ground_turret_SO_completed(turret_unit, puppet_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) and alive(puppet_unit) then
		if turret_unit:weapon()._SO_object then
			puppet_unit:warp_to(turret_unit:weapon()._SO_object:rotation(), turret_unit:weapon()._SO_object:position())
		end

		turret_unit:weapon():sync_SO_completed(puppet_unit)
	end
end

-- Lines 3315-3322
function UnitNetworkHandler:sync_ground_turret_SO_administered(turret_unit, administered_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():sync_administered_unit(administered_unit)
	end
end

-- Lines 3324-3331
function UnitNetworkHandler:sync_ground_turret_create_SO(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():sync_create_SO()
	end
end

-- Lines 3333-3340
function UnitNetworkHandler:sync_ground_turret_cancel_SO(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():sync_cancel_SO()
	end
end

-- Lines 3342-3349
function UnitNetworkHandler:sync_ground_turret_activate_triggers(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():sync_activate_triggers()
	end
end

-- Lines 3351-3358
function UnitNetworkHandler:sync_ground_turret_exit_triggers(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():sync_exit_triggers()
	end
end

-- Lines 3360-3367
function UnitNetworkHandler:sync_ground_turret_puppet_damaged(turret_unit, attacker_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():on_puppet_damaged_client(attacker_unit)
	end
end

-- Lines 3369-3376
function UnitNetworkHandler:sync_ground_turret_puppet_death(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():on_puppet_death_client()
	end
end

-- Lines 3379-3386
function UnitNetworkHandler:sync_ground_turret_deactivate(turret_unit, sender)
	if not self._verify_sender(sender) then
		return
	end

	if alive(turret_unit) then
		turret_unit:weapon():deactivate_client()
	end
end

-- Lines 3389-3396
function UnitNetworkHandler:sync_ground_turret_shell_explosion(unit, position, range, damage, player_damage, curve_pow, rpc)
	local peer = self._verify_sender(rpc)

	if not peer or not alive(unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	unit:weapon():_shell_explosion_on_client(position, range, damage, player_damage, curve_pow)
end

-- Lines 3401-3407
function UnitNetworkHandler:airdrop_trigger_drop_sequence(plane_unit, sequence_name, sender)
	if not self._verify_sender(sender) then
		return
	end

	managers.airdrop:set_plane_sequence(plane_unit, sequence_name)
end

-- Lines 3412-3419
function UnitNetworkHandler:register_grenades_pickup(pickup_unit, number_of_grenades, sender)
	local peer = self._verify_sender(sender)

	if not peer or not alive(pickup_unit) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	pickup_unit:pickup():register_grenades(number_of_grenades, peer)
end

-- Lines 3423-3437
function UnitNetworkHandler:sync_character_nationality_switch(unit, character_nationality, sender)
	local peer = self._verify_sender(sender)

	if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not peer then
		print("_verify failed!!!")

		return
	end

	if unit and alive(unit) then
		unit:damage():run_sequence_simple(character_nationality)
	end
end

-- Lines 3440-3444
function UnitNetworkHandler:sync_distance_to_target(unit, distance)
	if alive(unit) then
		unit:brain():set_distance_to_target(distance)
	end
end

-- Lines 3446-3455
function UnitNetworkHandler:sync_loot_value(unit, value, sender)
	if not self._verify_sender(sender) then
		return
	end

	if unit and alive(unit) then
		unit:loot_drop():set_value(value)
	end
end

-- Lines 3457-3464
function UnitNetworkHandler:sync_warp_position(unit, pos, rot)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		unit:movement():sync_warp_position(pos, rot)
	end
end

-- Lines 3466-3473
function UnitNetworkHandler:sync_stored_pos(unit, allow_sync, pos, rot)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		unit:base():sync_stored_pos(allow_sync, pos, rot)
	end
end

-- Lines 3475-3478
function UnitNetworkHandler:sync_spawn_ammo_bag(pos, dir, level_idx, sender)
	local peer = self._verify_sender(sender)

	ThrowableAmmoBag.spawn(pos, dir, level_idx, peer:unit())
end

-- Lines 3480-3482
function UnitNetworkHandler:sync_throw_ammo_bag(unit, dir, sender)
	ThrowableAmmoBag.throw_bag(unit, dir)
end

-- Lines 3484-3486
function UnitNetworkHandler:sync_ammo_bag_level(unit, level_index, sender)
	ThrowableAmmoBag.set_level(unit, level_index)
end

-- Lines 3488-3491
function UnitNetworkHandler:sync_ammo_bag_hit_player(player_unit, ammo_bag_unit, bag_owner_peer_id, sender)
	local picked_up = ThrowableAmmoBag.interact_pickup(ammo_bag_unit, player_unit, bag_owner_peer_id)

	managers.network:session():send_to_host("ammo_bag_pickup_response", ammo_bag_unit, picked_up)
end

-- Lines 3493-3498
function UnitNetworkHandler:ammo_bag_pickup_response(ammo_bag_unit, picked_up, sender)
	if alive(ammo_bag_unit) then
		local peer = self._verify_sender(sender)

		ammo_bag_unit:base():from_client_response(picked_up, peer:name())
	end
end

-- Lines 3500-3512
local function warcry_dmg_func(peer_name, data)
	local percent = Utl.mul_to_string_percent(data)
	local notification_data = {
		priority = 1,
		duration = 5,
		id = "skill_ammo_warcry_from",
		icon = "test_icon",
		force = true,
		notification_type = HUDNotification.ICON,
		text = managers.localization:text("skill_ammo_warcry_from", {
			NAME = peer_name,
			PERCENT = percent
		})
	}

	managers.notification:add_notification(notification_data)
end

local gui_notification = {
	warcry_dmg_func
}

-- Lines 3519-3537
function UnitNetworkHandler:sync_warcry(source_unit, radius_idx, effect_name_idx, effect_data_idx, time_idx, gui_notification_idx, sender)
	if alive(source_unit) then
		local pm = managers.player
		local player_unit = pm:player_unit()

		if player_unit and alive(player_unit) then
			local source_pos = source_unit:position()
			local player_pos = player_unit:position()
			local radius = UpgradesTweakData.WARCRY_RADIUS[radius_idx]

			if mvector3.distance_sq(source_pos, player_pos) < radius * radius then
				local effect_name = UpgradesTweakData.WARCRY_EFFECT_NAME[effect_name_idx]
				local effect_data = UpgradesTweakData.WARCRY_EFFECT_DATA[effect_data_idx]
				local time = UpgradesTweakData.WARCRY_TIME[time_idx]

				pm:activate_temporary_property(effect_name, time, effect_data)

				local peer = self._verify_sender(sender)

				gui_notification[gui_notification_idx](peer:name(), effect_data)
			end
		end
	end
end

-- Lines 3541-3552
function UnitNetworkHandler:sync_unit_spawn(parent_unit, spawn_unit, align_obj_name, unit_id, parent_extension_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(parent_unit) or not alive(spawn_unit) then
		return
	end

	parent_unit[parent_extension_name](parent_unit):spawn_unit(unit_id, align_obj_name, spawn_unit)
	parent_unit[parent_extension_name](parent_unit):sync_unit_spawn(unit_id)
end

-- Lines 3556-3566
function UnitNetworkHandler:run_spawn_unit_sequence(parent_unit, parent_extension_name, unit_id, sequence_name)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(parent_unit) then
		return
	end

	parent_unit[parent_extension_name](parent_unit):_spawn_run_sequence(unit_id, sequence_name)
end

-- Lines 3570-3580
function UnitNetworkHandler:run_local_push_child_unit(parent_unit, parent_extension_name, unit_id, mass, pow, vec3_a, vec3_b)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if not alive(parent_unit) then
		return
	end

	parent_unit[parent_extension_name](parent_unit):local_push_child_unit(unit_id, mass, pow, vec3_a, vec3_b)
end

-- Lines 3584-3589
function UnitNetworkHandler:leave_flamethrower_patch(subject_unit, sender)
	if not self._verify_character_and_sender(subject_unit, sender) or not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	managers.fire:leave_flamethrower_patch(subject_unit)
end

-- Lines 3591-3598
function UnitNetworkHandler:sync_camp_asset(unit, level, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		unit:gold_asset():apply_upgrade_level(level)
	end
end

-- Lines 3602-3610
function UnitNetworkHandler:sync_foxhole_state(unit, foxhole, state)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) and unit:movement() then
		unit:movement():set_foxhole_state(state, foxhole)
	end
end

-- Lines 3614-3622
function UnitNetworkHandler:set_escort_active(unit, active)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) and unit:escort() then
		unit:escort():set_active(active)
	end
end

-- Lines 3624-3635
function UnitNetworkHandler:sync_ai_interaction_start(unit, duration, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		local teammate_panel_id = unit:unit_data().teammate_panel_id
		local name_label_id = unit:unit_data().name_label_id

		managers.hud:teammate_start_progress(teammate_panel_id, name_label_id, duration)
	end
end

-- Lines 3637-3648
function UnitNetworkHandler:sync_ai_interaction_cancel(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		local teammate_panel_id = unit:unit_data().teammate_panel_id
		local name_label_id = unit:unit_data().name_label_id

		managers.hud:teammate_cancel_progress(teammate_panel_id, name_label_id)
	end
end

-- Lines 3650-3661
function UnitNetworkHandler:sync_ai_interaction_complete(unit, sender)
	if not self._verify_gamestate(self._gamestate_filter.any_ingame) then
		return
	end

	if alive(unit) then
		local teammate_panel_id = unit:unit_data().teammate_panel_id
		local name_label_id = unit:unit_data().name_label_id

		managers.hud:teammate_complete_progress(teammate_panel_id, name_label_id)
	end
end