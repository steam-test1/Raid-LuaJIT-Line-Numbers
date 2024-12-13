ProjectilesTweakData = ProjectilesTweakData or class()

-- Lines 3-335
function ProjectilesTweakData:init(tweak_data)
	self.m24 = {
		name_id = "bm_grenade_frag",
		weapon_id = "m24_grenade",
		unit = "units/vanilla/weapons/wpn_gre_m24/wpn_gre_m24",
		unit_hand = "units/vanilla/weapons/wpn_gre_m24/wpn_gre_m24_hand",
		unit_dummy = "units/vanilla/weapons/wpn_gre_m24/wpn_gre_m24_husk",
		icon = "frag_grenade",
		throwable = true,
		max_amount = 3,
		anim_global_param = "projectile_frag",
		throw_allowed_expire_t = 0.1,
		expire_t = 1.1,
		repeat_expire_t = 1.5,
		is_a_grenade = true,
		damage = 500,
		player_damage = 10,
		range = 1000,
		name_id = "bm_grenade_frag",
		init_timer = 4.5,
		animations = {}
	}
	self.m24.animations.equip_id = "equip_welrod"
	self.m24.gui = {
		rotation_offset = 3,
		distance_offset = -80,
		height_offset = -14,
		display_offset = 10,
		initial_rotation = {}
	}
	self.m24.gui.initial_rotation.yaw = -90
	self.m24.gui.initial_rotation.pitch = -30
	self.m24.gui.initial_rotation.roll = 0
	self.cluster = {
		name_id = "bm_grenade_frag",
		unit = "units/vanilla/dev/dev_shrapnel/dev_shrapnel",
		unit_dummy = "units/vanilla/dev/dev_shrapnel/dev_shrapnel_husk",
		throwable = false,
		impact_detonation = true,
		max_amount = 3,
		anim_global_param = "projectile_frag",
		is_a_grenade = true,
		damage = 250,
		launch_speed = 20,
		adjust_z = 5,
		player_damage = 3,
		range = 350,
		name_id = "bm_grenade_cluster",
		animations = {}
	}
	self.cluster.animations.equip_id = "equip_welrod"
	self.ammo_bag = {
		name_id = "bm_grenade_frag",
		unit = "units/vanilla/weapons/wpn_gre_m24/wpn_gre_m24",
		unit_hand = "units/vanilla/weapons/wpn_gre_m24/wpn_gre_m24_hand",
		unit_dummy = "units/vanilla/weapons/wpn_gre_m24/wpn_gre_m24_husk",
		icon = "frag_grenade",
		throwable = true,
		max_amount = 3,
		anim_global_param = "projectile_frag",
		throw_allowed_expire_t = 0.1,
		expire_t = 1.1,
		repeat_expire_t = 1.5,
		is_a_grenade = false,
		damage = 0,
		player_damage = 0,
		range = 1000,
		name_id = "bm_grenade_frag",
		init_timer = 4.5,
		animations = {}
	}
	self.ammo_bag.animations.equip_id = "equip_welrod"
	self.ammo_bag.push_at_body_index = 0
	self.molotov = {
		name_id = "bm_grenade_molotov",
		icon = "molotov_grenade",
		no_cheat_count = true,
		impact_detonation = true,
		time_cheat = 1,
		throwable = false,
		max_amount = 3,
		texture_bundle_folder = "bbq",
		physic_effect = Idstring("physic_effects/molotov_throw"),
		anim_global_param = "projectile_molotov",
		throw_allowed_expire_t = 0.1,
		expire_t = 1.1,
		repeat_expire_t = 1.5,
		is_a_grenade = true,
		init_timer = 10,
		damage = 30,
		player_damage = 2,
		fire_dot_data = {
			dot_trigger_chance = 35,
			dot_damage = 10,
			dot_length = 3,
			dot_trigger_max_distance = 3000,
			dot_tick_period = 0.5
		},
		range = 75,
		burn_duration = 20,
		burn_tick_period = 0.5,
		sound_event_impact_duration = 4,
		name_id = "bm_grenade_molotov",
		alert_radius = 1500,
		fire_alert_radius = 1500,
		animations = {}
	}
	self.molotov.animations.equip_id = "equip_welrod"
	self.mortar_shell = {
		name_id = "bm_mortar_shell",
		unit = "units/vanilla/weapons/wpn_npc_proj_mortar_shell/wpn_npc_proj_mortar_shell",
		unit_dummy = "units/vanilla/weapons/wpn_npc_proj_mortar_shell/wpn_npc_proj_mortar_shell_husk",
		weapon_id = "mortar_shell",
		no_cheat_count = false,
		impact_detonation = true,
		physic_effect = Idstring("physic_effects/anti_gravitate"),
		adjust_z = 0,
		push_at_body_index = 0,
		init_timer = 5,
		damage = 150,
		player_damage = 10,
		range = 1000,
		init_timer = 15,
		effect_name = "effects/vanilla/explosions/exp_artillery_explosion_001",
		sound_event = "grenade_launcher_explosion",
		sound_event_impact_duration = 4
	}
	self.flamer_death_fake = clone(self.molotov)
	self.flamer_death_fake.init_timer = 0.01
	self.flamer_death_fake.adjust_z = 0
	self.flamer_death_fake.throwable = false
	self.flamer_death_fake.unit = "units/vanilla/dev/flamer_death_fake/flamer_death_fake"
	self.flamer_death_fake.unit_dummy = "units/vanilla/dev/flamer_death_fake/flamer_death_fake_husk"
	self._projectiles_index = {
		"m24",
		"cluster",
		"molotov",
		"mortar_shell",
		"flamer_death_fake"
	}

	self:_add_desc_from_name_macro(self)
end

-- Lines 337-339
function BlackMarketTweakData:get_projectiles_index()
	return tweak_data.projectiles._projectiles_index
end

-- Lines 341-348
function BlackMarketTweakData:get_index_from_projectile_id(projectile_id)
	for index, entry_name in ipairs(tweak_data.projectiles._projectiles_index) do
		if entry_name == projectile_id then
			return index
		end
	end

	return 0
end

-- Lines 350-352
function BlackMarketTweakData:get_projectile_name_from_index(index)
	return tweak_data.projectiles._projectiles_index[index]
end

-- Lines 354-363
function ProjectilesTweakData:_add_desc_from_name_macro(tweak_data)
	for id, data in pairs(tweak_data) do
		if data.name_id and not data.desc_id then
			data.desc_id = tostring(data.name_id) .. "_desc"
		end

		if not data.name_id then
			-- Nothing
		end
	end
end
