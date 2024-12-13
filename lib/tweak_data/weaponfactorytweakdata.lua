local ids_unit = Idstring("unit")

-- Lines 21-30
function preload_all()
	for id, part in pairs(tweak_data.weapon.factory.parts) do
		if part.third_unit then
			local ids_unit_name = Idstring(part.third_unit)

			managers.dyn_resource:load(ids_unit, ids_unit_name, "packages/dyn_resources", false)
		else
			print(id, "didn't have third")
		end
	end
end

-- Lines 32-41
function preload_all_units()
	for id, part in pairs(tweak_data.weapon.factory) do
		if part.unit then
			local ids_unit_name = Idstring(part.unit)

			managers.dyn_resource:load(ids_unit, ids_unit_name, "packages/dyn_resources", false)
		else
			print(id, "didn't have unit")
		end
	end
end

-- Lines 43-53
function print_package_strings_unit()
	for id, part in pairs(tweak_data.weapon.factory) do
		if part.unit then
			print("<unit name=\"" .. part.unit .. "\"/>")
		end
	end
end

-- Lines 55-72
function print_package_strings_part_unit()
	for id, part in pairs(tweak_data.weapon.factory.parts) do
		if part.unit then
			local f = SystemFS:open(id .. ".package", "w")

			f:puts("<package>")
			f:puts("\t<units>")
			f:puts("\t\t<unit name=\"" .. part.unit .. "\"/>")
			f:puts("\t</units>")
			f:puts("</package>")
			SystemFS:close(f)
		end
	end
end

-- Lines 74-85
function preload_all_first()
	for id, part in pairs(tweak_data.weapon.factory.parts) do
		if part.unit then
			local ids_unit_name = Idstring(part.unit)

			managers.dyn_resource:load(ids_unit, ids_unit_name, "packages/dyn_resources", false)
		else
			print(id, "didn't have unit")
		end
	end
end

-- Lines 87-97
function print_package_strings()
	for id, part in pairs(tweak_data.weapon.factory.parts) do
		if part.third_unit then
			print("<unit name=\"" .. part.third_unit .. "\"/>")
		end
	end
end

-- Lines 100-118
function print_parts_without_texture()
	Application:debug("print_parts_without_texture")

	for id, part in pairs(tweak_data.weapon.factory.parts) do
		if part.pcs then
			local guis_catalog = "guis/"
			local bundle_folder = part.texture_bundle_folder

			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end

			guis_catalog = guis_catalog .. "textures/pd2/blackmarket/icons/mods/"

			if not DB:has(Idstring("texture"), guis_catalog .. id) then
				print(guis_catalog .. id)
			end
		end
	end

	Application:debug("---------------------------")
end

local is_win_32 = SystemInfo:platform() == Idstring("WIN32")
local is_not_win_32 = not is_win_32
WeaponFactoryTweakData = WeaponFactoryTweakData or class()

-- Lines 125-165
function WeaponFactoryTweakData:init()
	self.parts = {}

	self:_init_base_parts_for_cloning()
	self:_init_silencers()
	self:_init_nozzles()
	self:_init_gadgets()
	self:_init_vertical_grips()
	self:_init_sights()
	self:_init_m1911()
	self:_init_thompson()
	self:_init_sten()
	self:_init_garand()
	self:_init_garand_golden()
	self:_init_m1918()
	self:_init_m1903()
	self:_init_m1912()
	self:_init_mp38()
	self:_init_mp44()
	self:_init_carbine()
	self:_init_welrod()
	self:_init_mg42()
	self:_init_c96()
	self:_init_webley()
	self:_init_mosin()
	self:_init_sterling()
	self:create_ammunition()
	self:_init_content_unfinished()
	self:_cleanup_unfinished_content()
	self:_cleanup_unfinished_parts()
end

-- Lines 169-170
function WeaponFactoryTweakData:_init_silencers()
end

-- Lines 172-173
function WeaponFactoryTweakData:_init_nozzles()
end

-- Lines 175-176
function WeaponFactoryTweakData:_init_gadgets()
end

-- Lines 178-179
function WeaponFactoryTweakData:_init_vertical_grips()
end

-- Lines 181-182
function WeaponFactoryTweakData:_init_sights()
end

-- Lines 184-185
function WeaponFactoryTweakData:_init_content_unfinished()
end

-- Lines 187-188
function WeaponFactoryTweakData:_cleanup_unfinished_content()
end

-- Lines 190-191
function WeaponFactoryTweakData:_cleanup_unfinished_parts()
end

-- Lines 195-196
function WeaponFactoryTweakData:_init_base_parts_for_cloning()
end

-- Lines 199-353
function WeaponFactoryTweakData:_init_thompson()
	self.parts.wpn_fps_smg_thompson_b_standard = {
		a_obj = "a_b",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_b_standard",
		type = "barrel",
		name_id = "bm_wp_smg_thompson_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_b_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_b_m1928 = {
		a_obj = "a_b",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_b_m1928",
		type = "barrel",
		name_id = "bm_wp_smg_thompson_b_m1928",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_b_m1928",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_body_standard = {
		a_obj = "a_body",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_body_standard",
		type = "lower_receiver",
		name_id = "bm_wp_smg_thompson_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_body_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_body_m1928 = {
		a_obj = "a_body",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_body_m1928",
		type = "lower_receiver",
		name_id = "bm_wp_smg_thompson_body_m1928",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_body_m1928",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_o_standard = {
		a_obj = "a_body",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_o_standard",
		type = "sight",
		name_id = "bm_wp_smg_thompson_o_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_o_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_o_m1928 = {
		a_obj = "a_body",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_o_m1928",
		type = "sight",
		name_id = "bm_wp_smg_thompson_o_m1928",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_o_m1928",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_thompson_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_m_standard",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_m_standard",
		bullet_objects = {
			amount = 4,
			prefix = "g_bullet_"
		},
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_m_standard_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_thompson_m_standard_double",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_m_standard_double",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_m_standard_double",
		bullet_objects = {
			amount = 4,
			prefix = "g_bullet_"
		},
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_m_drum = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_thompson_m_drum",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_m_drum",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_m_drum",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_m_short = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_thompson_m_short",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_m_short",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_m_short",
		bullet_objects = {
			amount = 4,
			prefix = "g_bullet_"
		},
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_m_short_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_thompson_m_short_double",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_m_short_double",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_m_short_double",
		bullet_objects = {
			amount = 4,
			prefix = "g_bullet_"
		},
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_dh_standard = {
		a_obj = "a_dh",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_dh_standard",
		type = "drag_handle",
		name_id = "bm_wp_smg_thompson_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_dh_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_dh_m1928 = {
		a_obj = "a_dh",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_dh_m1928",
		type = "drag_handle",
		name_id = "bm_wp_smg_thompson_dh_m1928",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_dh_m1928",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_extra_sling = {
		a_obj = "a_extra",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_extra_sling",
		type = "extra",
		name_id = "bm_wp_smg_thompson_extra_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_extra_sling",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_fg_standard = {
		a_obj = "a_fg",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_fg_standard",
		type = "foregrip",
		name_id = "bm_wp_smg_thompson_fg_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_fg_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_fg_m1928 = {
		a_obj = "a_fg",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_fg_m1928",
		type = "foregrip",
		name_id = "bm_wp_smg_thompson_fg_m1928",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_fg_m1928",
		stats = {
			value = 0
		},
		forbids = {
			"wpn_fps_smg_thompson_extra_sling"
		}
	}
	self.parts.wpn_fps_smg_thompson_release_standard = {
		a_obj = "a_release",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_release_standard",
		type = "extra",
		name_id = "bm_wp_smg_thompson_release_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_release_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_s_standard = {
		a_obj = "a_s",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_s_standard",
		type = "stock",
		name_id = "bm_wp_smg_thompson_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_s_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_g_standard = {
		a_obj = "a_g",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_g_standard",
		type = "grip",
		name_id = "bm_wp_smg_thompson_g_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_g_standard",
		stats = {
			value = 0
		}
	}
	self.parts.wpn_fps_smg_thompson_ns_cutts = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_smg_thompson_g_ns_cutts",
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson_pts/wpn_fps_smg_thompson_ns_cutts",
		third_unit = "units/vanilla/weapons/wpn_third_smg_thompson_pts/wpn_third_smg_thompson_ns_cutts",
		stats = {
			value = 0
		}
	}
	self.wpn_fps_smg_thompson = {
		unit = "units/vanilla/weapons/wpn_fps_smg_thompson/wpn_fps_smg_thompson",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		override = {
			wpn_fps_smg_thompson_ns_cutts = {
				parent = "barrel"
			}
		},
		default_blueprint = {
			"wpn_fps_smg_thompson_body_standard",
			"wpn_fps_smg_thompson_s_standard",
			"wpn_fps_smg_thompson_b_standard",
			"wpn_fps_smg_thompson_m_short",
			"wpn_fps_smg_thompson_dh_standard",
			"wpn_fps_smg_thompson_extra_sling",
			"wpn_fps_smg_thompson_fg_standard",
			"wpn_fps_smg_thompson_release_standard",
			"wpn_fps_smg_thompson_g_standard",
			"wpn_fps_smg_thompson_o_standard"
		},
		uses_parts = {
			"wpn_fps_smg_thompson_body_standard",
			"wpn_fps_smg_thompson_s_standard",
			"wpn_fps_smg_thompson_b_standard",
			"wpn_fps_smg_thompson_m_short",
			"wpn_fps_smg_thompson_dh_standard",
			"wpn_fps_smg_thompson_extra_sling",
			"wpn_fps_smg_thompson_fg_standard",
			"wpn_fps_smg_thompson_release_standard",
			"wpn_fps_smg_thompson_g_standard",
			"wpn_fps_smg_thompson_o_standard",
			"wpn_fps_smg_thompson_b_m1928",
			"wpn_fps_smg_thompson_body_m1928",
			"wpn_fps_smg_thompson_o_m1928",
			"wpn_fps_smg_thompson_m_short_double",
			"wpn_fps_smg_thompson_m_standard",
			"wpn_fps_smg_thompson_m_standard_double",
			"wpn_fps_smg_thompson_m_drum",
			"wpn_fps_smg_thompson_fg_m1928",
			"wpn_fps_smg_thompson_ns_cutts",
			"wpn_fps_smg_thompson_dh_m1928"
		}
	}
	self.wpn_fps_smg_thompson_npc = deep_clone(self.wpn_fps_smg_thompson)
	self.wpn_fps_smg_thompson_npc.unit = "units/vanilla/weapons/wpn_fps_smg_thompson/wpn_fps_smg_thompson_npc"
end

-- Lines 355-495
function WeaponFactoryTweakData:_init_sten()
	self.parts.wpn_fps_smg_sten_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_smg_sten_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_o_lee_enfield = {
		a_obj = "a_b",
		type = "sight",
		name_id = "bm_wp_smg_sten_o_lee_enfield",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_o_lee_enfield",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_ns_slanted = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_smg_sten_ns_slanted",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_ns_slanted",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_body_standard = {
		a_obj = "a_body",
		type = "upper_receiver",
		name_id = "bm_wp_smg_sten_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_body_mk3 = {
		a_obj = "a_body",
		type = "upper_receiver",
		name_id = "bm_wp_smg_sten_body_mk3",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_body_mk3",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_body_mk3_vented = {
		a_obj = "a_body",
		type = "upper_receiver",
		name_id = "bm_wp_smg_sten_body_mk3_vented",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_body_mk3_vented",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_sten_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_m_standard",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_m_standard_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_sten_m_standard_double",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_m_standard_double",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_m_long = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_sten_m_long",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_m_long",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_m_long_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_sten_m_long_double",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_m_long_double",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_m_short = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_sten_m_short",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_m_short",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_smg_sten_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_smg_sten_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_s_wooden = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_smg_sten_s_wooden",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_s_wooden",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_fg_wooden = {
		a_obj = "a_body",
		type = "foregrip",
		name_id = "bm_wp_smg_sten_fg_wooden",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_fg_wooden",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_g_wooden = {
		a_obj = "a_body",
		type = "grip",
		name_id = "bm_wp_smg_sten_g_wooden",
		unit = "units/vanilla/weapons/wpn_fps_smg_sten_pts/wpn_fps_smg_sten_g_wooden",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sten_b_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_b_standard"
	self.parts.wpn_fps_smg_sten_o_lee_enfield.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_o_lee_enfield"
	self.parts.wpn_fps_smg_sten_ns_slanted.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_ns_slanted"
	self.parts.wpn_fps_smg_sten_body_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_body_standard"
	self.parts.wpn_fps_smg_sten_body_mk3.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_body_mk3"
	self.parts.wpn_fps_smg_sten_body_mk3_vented.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_body_mk3_vented"
	self.parts.wpn_fps_smg_sten_m_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_m_standard"
	self.parts.wpn_fps_smg_sten_m_standard_double.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_m_standard_double"
	self.parts.wpn_fps_smg_sten_m_long.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_m_long"
	self.parts.wpn_fps_smg_sten_m_long_double.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_m_long_double"
	self.parts.wpn_fps_smg_sten_m_short.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_m_short"
	self.parts.wpn_fps_smg_sten_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_dh_standard"
	self.parts.wpn_fps_smg_sten_s_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_s_standard"
	self.parts.wpn_fps_smg_sten_s_wooden.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_s_wooden"
	self.parts.wpn_fps_smg_sten_fg_wooden.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_fg_wooden"
	self.parts.wpn_fps_smg_sten_g_wooden.third_unit = "units/vanilla/weapons/wpn_third_smg_sten_pts/wpn_third_smg_sten_g_wooden"
	self.wpn_fps_smg_sten = {
		unit = "units/vanilla/weapons/wpn_fps_smg_sten/wpn_fps_smg_sten",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_smg_sten_body_standard",
			"wpn_fps_smg_sten_b_standard",
			"wpn_fps_smg_sten_m_short",
			"wpn_fps_smg_sten_dh_standard",
			"wpn_fps_smg_sten_s_standard"
		},
		uses_parts = {
			"wpn_fps_smg_sten_body_standard",
			"wpn_fps_smg_sten_b_standard",
			"wpn_fps_smg_sten_m_short",
			"wpn_fps_smg_sten_dh_standard",
			"wpn_fps_smg_sten_s_standard",
			"wpn_fps_smg_sten_m_standard",
			"wpn_fps_smg_sten_m_standard_double",
			"wpn_fps_smg_sten_m_long",
			"wpn_fps_smg_sten_m_long_double",
			"wpn_fps_smg_sten_s_wooden",
			"wpn_fps_smg_sten_fg_wooden",
			"wpn_fps_smg_sten_g_wooden",
			"wpn_fps_smg_sten_ns_slanted",
			"wpn_fps_smg_sten_body_mk3",
			"wpn_fps_smg_sten_body_mk3_vented",
			"wpn_fps_smg_sten_o_lee_enfield"
		}
	}
	self.wpn_fps_smg_sten_npc = deep_clone(self.wpn_fps_smg_sten)
	self.wpn_fps_smg_sten_npc.unit = "units/vanilla/weapons/wpn_fps_smg_sten/wpn_fps_smg_sten_npc"
end

-- Lines 497-633
function WeaponFactoryTweakData:_init_garand()
	self.parts.wpn_fps_ass_garand_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_ass_garand_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_b_tanker = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_ass_garand_b_tanker",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_b_tanker",
		stats = {
			value = 1
		},
		forbids = {
			"wpn_fps_ass_garand_extra_swiwel"
		}
	}
	self.parts.wpn_fps_ass_garand_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_ass_garand_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_ns_conical = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_ass_garand_ns_conical",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_ns_conical",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_garand_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_m_standard",
		bullet_objects = {
			amount = 8,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_m_bar_standard = {
		a_obj = "a_body",
		type = "magazine_ext",
		name_id = "bm_wp_ass_garand_m_bar_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_m_bar_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_m_bar_extended = {
		a_obj = "a_body",
		type = "magazine_ext",
		name_id = "bm_wp_ass_garand_m_bar_extended",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_m_bar_extended",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_bolt_standard = {
		a_obj = "a_bolt",
		type = "custom",
		name_id = "bm_wp_ass_garand_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_ass_garand_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_extra_swiwel = {
		a_obj = "a_extra",
		type = "extra",
		name_id = "bm_wp_ass_garand_extra_swiwel",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_extra_swiwel",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_extra1_swiwel = {
		a_obj = "a_extra1",
		type = "extra",
		name_id = "bm_wp_ass_garand_extra1_swiwel",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_extra1_swiwel",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_ass_garand_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_s_folding = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_ass_garand_s_folding",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_s_folding",
		stats = {
			value = 1
		},
		forbids = {
			"wpn_fps_ass_garand_s_cheek_rest"
		}
	}
	self.parts.wpn_fps_ass_garand_s_cheek_rest = {
		a_obj = "a_s",
		type = "stock_ext",
		name_id = "bm_wp_ass_garand_s_cheek_rest",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_s_cheek_rest",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_strip_standard = {
		a_obj = "a_strip",
		type = "extra",
		name_id = "bm_wp_ass_garand_strip_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_strip_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_b_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_b_standard"
	self.parts.wpn_fps_ass_garand_b_tanker.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_b_tanker"
	self.parts.wpn_fps_ass_garand_body_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_body_standard"
	self.parts.wpn_fps_ass_garand_ns_conical.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_ns_conical"
	self.parts.wpn_fps_ass_garand_m_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_m_standard"
	self.parts.wpn_fps_ass_garand_m_bar_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_m_bar_standard"
	self.parts.wpn_fps_ass_garand_m_bar_extended.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_m_bar_extended"
	self.parts.wpn_fps_ass_garand_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_bolt_standard"
	self.parts.wpn_fps_ass_garand_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_dh_standard"
	self.parts.wpn_fps_ass_garand_extra_swiwel.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_extra_swiwel"
	self.parts.wpn_fps_ass_garand_extra1_swiwel.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_extra1_swiwel"
	self.parts.wpn_fps_ass_garand_s_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_s_standard"
	self.parts.wpn_fps_ass_garand_s_folding.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_s_folding"
	self.parts.wpn_fps_ass_garand_s_cheek_rest.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_s_cheek_rest"
	self.parts.wpn_fps_ass_garand_strip_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_strip_standard"
	self.wpn_fps_ass_garand = {
		unit = "units/vanilla/weapons/wpn_fps_ass_garand/wpn_fps_ass_garand",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_ass_garand_body_standard",
			"wpn_fps_ass_garand_b_standard",
			"wpn_fps_ass_garand_m_standard",
			"wpn_fps_ass_garand_bolt_standard",
			"wpn_fps_ass_garand_dh_standard",
			"wpn_fps_ass_garand_extra_swiwel",
			"wpn_fps_ass_garand_extra1_swiwel",
			"wpn_fps_ass_garand_s_standard",
			"wpn_fps_ass_garand_strip_standard"
		},
		uses_parts = {
			"wpn_fps_ass_garand_body_standard",
			"wpn_fps_ass_garand_b_standard",
			"wpn_fps_ass_garand_m_standard",
			"wpn_fps_ass_garand_bolt_standard",
			"wpn_fps_ass_garand_dh_standard",
			"wpn_fps_ass_garand_extra_swiwel",
			"wpn_fps_ass_garand_extra1_swiwel",
			"wpn_fps_ass_garand_s_standard",
			"wpn_fps_ass_garand_strip_standard",
			"wpn_fps_ass_garand_ns_conical",
			"wpn_fps_ass_garand_b_tanker",
			"wpn_fps_ass_garand_s_cheek_rest",
			"wpn_fps_ass_garand_s_folding",
			"wpn_fps_ass_garand_m_bar_standard",
			"wpn_fps_ass_garand_m_bar_extended"
		}
	}
	self.wpn_fps_ass_garand_npc = deep_clone(self.wpn_fps_ass_garand)
	self.wpn_fps_ass_garand_npc.unit = "units/vanilla/weapons/wpn_fps_ass_garand/wpn_fps_ass_garand_npc"
end

-- Lines 635-771
function WeaponFactoryTweakData:_init_garand_golden()
	self.parts.wpn_fps_ass_garand_golden_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_ass_garand_golden_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_b_tanker = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_ass_garand_golden_b_tanker",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_b_tanker",
		stats = {
			value = 1
		},
		forbids = {
			"wpn_fps_ass_garand_golden_extra_swiwel"
		}
	}
	self.parts.wpn_fps_ass_garand_golden_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_ass_garand_golden_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_ns_conical = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_ass_garand_golden_ns_conical",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_ns_conical",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_garand_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_m_standard",
		bullet_objects = {
			amount = 8,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_m_bar_standard = {
		a_obj = "a_body",
		type = "magazine_ext",
		name_id = "bm_wp_ass_garand_golden_m_bar_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_m_bar_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_m_bar_extended = {
		a_obj = "a_body",
		type = "magazine_ext",
		name_id = "bm_wp_ass_garand_golden_m_bar_extended",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_m_bar_extended",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_bolt_standard = {
		a_obj = "a_bolt",
		type = "custom",
		name_id = "bm_wp_ass_garand_golden_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_ass_garand_golden_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_extra_swiwel = {
		a_obj = "a_extra",
		type = "extra",
		name_id = "bm_wp_ass_garand_golden_extra_swiwel",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_extra_swiwel",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_extra1_swiwel = {
		a_obj = "a_extra1",
		type = "extra",
		name_id = "bm_wp_ass_garand_golden_extra1_swiwel",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_extra1_swiwel",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_ass_garand_golden_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_s_folding = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_ass_garand_golden_s_folding",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_s_folding",
		stats = {
			value = 1
		},
		forbids = {
			"wpn_fps_ass_garand_s_cheek_rest"
		}
	}
	self.parts.wpn_fps_ass_garand_s_cheek_rest = {
		a_obj = "a_s",
		type = "stock_ext",
		name_id = "bm_wp_ass_garand_s_cheek_rest",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_s_cheek_rest",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_strip_standard = {
		a_obj = "a_strip",
		type = "extra",
		name_id = "bm_wp_ass_garand_golden_strip_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_garand_pts/wpn_fps_ass_garand_golden_strip_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_garand_golden_b_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_b_standard"
	self.parts.wpn_fps_ass_garand_golden_b_tanker.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_b_tanker"
	self.parts.wpn_fps_ass_garand_golden_body_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_body_standard"
	self.parts.wpn_fps_ass_garand_golden_ns_conical.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_ns_conical"
	self.parts.wpn_fps_ass_garand_m_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_m_standard"
	self.parts.wpn_fps_ass_garand_golden_m_bar_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_m_bar_standard"
	self.parts.wpn_fps_ass_garand_golden_m_bar_extended.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_m_bar_extended"
	self.parts.wpn_fps_ass_garand_golden_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_bolt_standard"
	self.parts.wpn_fps_ass_garand_golden_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_dh_standard"
	self.parts.wpn_fps_ass_garand_golden_extra_swiwel.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_extra_swiwel"
	self.parts.wpn_fps_ass_garand_golden_extra1_swiwel.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_extra1_swiwel"
	self.parts.wpn_fps_ass_garand_golden_s_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_s_standard"
	self.parts.wpn_fps_ass_garand_golden_s_folding.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_s_folding"
	self.parts.wpn_fps_ass_garand_s_cheek_rest.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_s_cheek_rest"
	self.parts.wpn_fps_ass_garand_golden_strip_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_garand_pts/wpn_third_ass_garand_golden_strip_standard"
	self.wpn_fps_ass_garand_golden = {
		unit = "units/vanilla/weapons/wpn_fps_ass_garand/wpn_fps_ass_garand_golden",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_ass_garand_golden_body_standard",
			"wpn_fps_ass_garand_golden_b_standard",
			"wpn_fps_ass_garand_m_standard",
			"wpn_fps_ass_garand_golden_bolt_standard",
			"wpn_fps_ass_garand_golden_dh_standard",
			"wpn_fps_ass_garand_golden_extra_swiwel",
			"wpn_fps_ass_garand_golden_extra1_swiwel",
			"wpn_fps_ass_garand_golden_s_standard",
			"wpn_fps_ass_garand_golden_strip_standard"
		},
		uses_parts = {
			"wpn_fps_ass_garand_golden_body_standard",
			"wpn_fps_ass_garand_golden_b_standard",
			"wpn_fps_ass_garand_m_standard",
			"wpn_fps_ass_garand_golden_bolt_standard",
			"wpn_fps_ass_garand_golden_dh_standard",
			"wpn_fps_ass_garand_golden_extra_swiwel",
			"wpn_fps_ass_garand_golden_extra1_swiwel",
			"wpn_fps_ass_garand_golden_s_standard",
			"wpn_fps_ass_garand_golden_strip_standard",
			"wpn_fps_ass_garand_golden_ns_conical",
			"wpn_fps_ass_garand_golden_b_tanker",
			"wpn_fps_ass_garand_s_cheek_rest",
			"wpn_fps_ass_garand_golden_s_folding",
			"wpn_fps_ass_garand_golden_m_bar_standard",
			"wpn_fps_ass_garand_golden_m_bar_extended"
		}
	}
	self.wpn_fps_ass_garand_golden_npc = deep_clone(self.wpn_fps_ass_garand_golden)
	self.wpn_fps_ass_garand_golden_npc.unit = "units/vanilla/weapons/wpn_fps_ass_garand/wpn_fps_ass_garand_golden_npc"
end

-- Lines 773-866
function WeaponFactoryTweakData:_init_m1918()
	self.parts.wpn_fps_lmg_m1918_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_lmg_m1918_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_ns_standard = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_lmg_m1918_ns_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_ns_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_ns_cutts = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_lmg_m1918_ns_cutts",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_ns_cutts",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_lmg_m1918_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_carry_handle = {
		a_obj = "a_body",
		type = "handle",
		name_id = "bm_wp_lmg_m1918_carry_handle",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_carry_handle",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_bipod = {
		parent = "barrel",
		a_obj = "a_bp",
		type = "bipod",
		name_id = "bm_wp_lmg_m1918_bipod",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_bipod",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_g_monitor = {
		a_obj = "a_body",
		type = "grip",
		name_id = "bm_wp_lmg_m1918_g_monitor",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_g_monitor",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_lmg_m1918_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_m_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_m_extended = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_lmg_m1918_m_extended",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_m_extended",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_lmg_m1918_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918_pts/wpn_fps_lmg_m1918_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_m1918_b_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_b_standard"
	self.parts.wpn_fps_lmg_m1918_ns_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_ns_standard"
	self.parts.wpn_fps_lmg_m1918_ns_cutts.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_ns_cutts"
	self.parts.wpn_fps_lmg_m1918_body_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_body_standard"
	self.parts.wpn_fps_lmg_m1918_carry_handle.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_carry_handle"
	self.parts.wpn_fps_lmg_m1918_bipod.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_bipod"
	self.parts.wpn_fps_lmg_m1918_g_monitor.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_g_monitor"
	self.parts.wpn_fps_lmg_m1918_m_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_m_standard"
	self.parts.wpn_fps_lmg_m1918_m_extended.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_m_extended"
	self.parts.wpn_fps_lmg_m1918_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_m1918_pts/wpn_third_lmg_m1918_dh_standard"
	self.wpn_fps_lmg_m1918 = {
		unit = "units/vanilla/weapons/wpn_fps_lmg_m1918/wpn_fps_lmg_m1918",
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		default_blueprint = {
			"wpn_fps_lmg_m1918_body_standard",
			"wpn_fps_lmg_m1918_b_standard",
			"wpn_fps_lmg_m1918_ns_standard",
			"wpn_fps_lmg_m1918_m_standard",
			"wpn_fps_lmg_m1918_dh_standard"
		},
		uses_parts = {
			"wpn_fps_lmg_m1918_body_standard",
			"wpn_fps_lmg_m1918_b_standard",
			"wpn_fps_lmg_m1918_ns_standard",
			"wpn_fps_lmg_m1918_m_standard",
			"wpn_fps_lmg_m1918_dh_standard",
			"wpn_fps_lmg_m1918_ns_cutts",
			"wpn_fps_lmg_m1918_g_monitor",
			"wpn_fps_lmg_m1918_m_extended",
			"wpn_fps_lmg_m1918_carry_handle",
			"wpn_fps_lmg_m1918_bipod"
		}
	}
	self.wpn_fps_lmg_m1918_npc = deep_clone(self.wpn_fps_lmg_m1918)
	self.wpn_fps_lmg_m1918_npc.unit = "units/vanilla/weapons/wpn_fps_lmg_m1918/wpn_fps_lmg_m1918_npc"
end

-- Lines 868-980
function WeaponFactoryTweakData:_init_m1903()
	self.parts.wpn_fps_snp_m1903_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_snp_m1903_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_body_type_s = {
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_snp_m1903_body_type_s",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_body_type_s",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_body_type_c = {
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_snp_m1903_body_type_c",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_body_type_c",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_s_cheek_rest = {
		a_obj = "a_body",
		type = "stock_ext",
		name_id = "bm_wp_snp_m1903_s_cheek_rest",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_s_cheek_rest",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_bolt_firepin = {
		a_obj = "a_firepin",
		type = "extra",
		name_id = "bm_wp_snp_m1903_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_bolt_firepin",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_bolt_standard = {
		a_obj = "a_bolt",
		type = "custom",
		name_id = "bm_wp_snp_m1903_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_snp_m1903_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_extra_follower = {
		a_obj = "a_follower",
		type = "extra",
		name_id = "bm_wp_snp_m1903_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_extra_follower",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_snp_m1903_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_m_standard",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		},
		animations = {
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty_exit = "reload_exit",
			reload_exit = "reload_exit",
			reload_enter = "reload_enter"
		}
	}
	self.parts.wpn_fps_snp_m1903_m_extended = {
		parent = "body",
		a_obj = "a_m",
		type = "magazine_ext",
		name_id = "bm_wp_snp_m1903_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_m_extended",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_ns_mclean = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_snp_m1903_ns_mclean",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_ns_mclean",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_m1903_o_scope = {
		reticle_obj = "g_reticle_1",
		a_obj = "a_o",
		type = "scope",
		name_id = "bm_wp_snp_m1903_o_scope",
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903_pts/wpn_fps_snp_m1903_o_scope",
		stats = {
			value = 1,
			zoom = 10
		},
		stance_mod = {
			wpn_fps_snp_m1903 = {
				lens_distortion_power = 1.04,
				translation = Vector3(0.015, -30, -1.665)
			}
		}
	}
	self.parts.wpn_fps_snp_m1903_b_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_b_standard"
	self.parts.wpn_fps_snp_m1903_body_type_s.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_body_type_s"
	self.parts.wpn_fps_snp_m1903_body_type_c.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_body_type_c"
	self.parts.wpn_fps_snp_m1903_s_cheek_rest.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_s_cheek_rest"
	self.parts.wpn_fps_snp_m1903_bolt_firepin.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_bolt_firepin"
	self.parts.wpn_fps_snp_m1903_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_bolt_standard"
	self.parts.wpn_fps_snp_m1903_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_dh_standard"
	self.parts.wpn_fps_snp_m1903_extra_follower.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_extra_follower"
	self.parts.wpn_fps_snp_m1903_m_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_m_standard"
	self.parts.wpn_fps_snp_m1903_m_extended.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_m_extended"
	self.parts.wpn_fps_snp_m1903_ns_mclean.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_ns_mclean"
	self.parts.wpn_fps_snp_m1903_o_scope.third_unit = "units/vanilla/weapons/wpn_third_snp_m1903_pts/wpn_third_snp_m1903_o_scope"
	self.wpn_fps_snp_m1903 = {
		unit = "units/vanilla/weapons/wpn_fps_snp_m1903/wpn_fps_snp_m1903",
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		animations = {
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty_exit = "reload_exit",
			reload_exit = "reload_exit",
			reload_enter = "reload_enter"
		},
		default_blueprint = {
			"wpn_fps_snp_m1903_body_type_s",
			"wpn_fps_snp_m1903_b_standard",
			"wpn_fps_snp_m1903_bolt_firepin",
			"wpn_fps_snp_m1903_bolt_standard",
			"wpn_fps_snp_m1903_dh_standard",
			"wpn_fps_snp_m1903_extra_follower",
			"wpn_fps_snp_m1903_m_standard"
		},
		uses_parts = {
			"wpn_fps_snp_m1903_body_type_s",
			"wpn_fps_snp_m1903_b_standard",
			"wpn_fps_snp_m1903_bolt_firepin",
			"wpn_fps_snp_m1903_bolt_standard",
			"wpn_fps_snp_m1903_dh_standard",
			"wpn_fps_snp_m1903_extra_follower",
			"wpn_fps_snp_m1903_m_standard",
			"wpn_fps_snp_m1903_body_type_c",
			"wpn_fps_snp_m1903_s_cheek_rest",
			"wpn_fps_snp_m1903_ns_mclean",
			"wpn_fps_snp_m1903_o_scope",
			"wpn_fps_snp_m1903_m_extended"
		}
	}
	self.wpn_fps_snp_m1903_npc = deep_clone(self.wpn_fps_snp_m1903)
	self.wpn_fps_snp_m1903_npc.unit = "units/vanilla/weapons/wpn_fps_snp_m1903/wpn_fps_snp_m1903_npc"
end

-- Lines 982-1076
function WeaponFactoryTweakData:_init_m1911()
	self.parts.wpn_fps_pis_m1911_body_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_body_standard",
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_pis_m1911_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_b_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_b_standard",
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_pis_m1911_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_sl_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_sl_standard",
		a_obj = "a_sl",
		type = "custom",
		name_id = "bm_wp_pis_m1911_sl_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_sl_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_m_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_m_standard",
		type = "magazine",
		name_id = "bm_wp_pis_m1911_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_m_standard",
		a_obj = "a_m",
		bullet_objects = {
			amount = 8,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_m_extended = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_m_extended",
		type = "magazine",
		name_id = "bm_wp_pis_m1911_m_extended",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_m_extended",
		a_obj = "a_m",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_m_banana = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_m_banana",
		type = "magazine",
		name_id = "bm_wp_pis_m1911_m_banana",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_m_banana",
		a_obj = "a_m",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_dh_hammer = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_dh_hammer",
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_pis_m1911_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_dh_hammer",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_ns_cutts = {
		parent = "barrel",
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_ns_cutts",
		type = "barrel_ext",
		name_id = "bm_wp_pis_m1911_ns_cutts",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_ns_cutts",
		a_obj = "a_ns",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_fg_tommy = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_fg_tommy",
		a_obj = "a_body",
		type = "foregrip",
		name_id = "bm_wp_pis_m1911_fg_tommy",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_fg_tommy",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_m1911_s_wooden = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_m1911_pts/wpn_third_pis_m1911_s_wooden",
		a_obj = "a_body",
		type = "stock",
		name_id = "bm_wp_pis_m1911_s_wooden",
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911_pts/wpn_fps_pis_m1911_s_wooden",
		stats = {
			value = 1
		}
	}
	self.wpn_fps_pis_m1911 = {
		unit = "units/vanilla/weapons/wpn_fps_pis_m1911/wpn_fps_pis_m1911",
		optional_types = {
			"barrel_ext",
			"gadget"
		},
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		default_blueprint = {
			"wpn_fps_pis_m1911_body_standard",
			"wpn_fps_pis_m1911_b_standard",
			"wpn_fps_pis_m1911_sl_standard",
			"wpn_fps_pis_m1911_m_standard",
			"wpn_fps_pis_m1911_dh_hammer"
		},
		uses_parts = {
			"wpn_fps_pis_m1911_body_standard",
			"wpn_fps_pis_m1911_b_standard",
			"wpn_fps_pis_m1911_sl_standard",
			"wpn_fps_pis_m1911_m_standard",
			"wpn_fps_pis_m1911_dh_hammer",
			"wpn_fps_pis_m1911_m_extended",
			"wpn_fps_pis_m1911_m_banana",
			"wpn_fps_pis_m1911_ns_cutts",
			"wpn_fps_pis_m1911_fg_tommy",
			"wpn_fps_pis_m1911_s_wooden"
		}
	}
	self.wpn_fps_pis_m1911_npc = deep_clone(self.wpn_fps_pis_m1911)
	self.wpn_fps_pis_m1911_npc.unit = "units/vanilla/weapons/wpn_fps_pis_m1911/wpn_fps_pis_m1911_npc"
end

-- Lines 1078-1201
function WeaponFactoryTweakData:_init_m1912()
	self.parts.wpn_fps_sho_m1912_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_sho_m1912_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_b_long = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_sho_m1912_b_long",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_b_long",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_b_short = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_sho_m1912_b_short",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_b_short",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_b_heat_shield = {
		a_obj = "a_b",
		type = "extra",
		name_id = "bm_wp_sho_m1912_b_heat_shield",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_b_heat_shield",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_ns_cutts = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_sho_m1912_ns_cutts",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_ns_cutts",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_sho_m1912_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_bolt_standard = {
		a_obj = "a_bolt",
		type = "custom",
		name_id = "bm_wp_sho_m1912_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_fg_standard = {
		a_obj = "a_fg",
		type = "foregrip",
		name_id = "bm_wp_sho_m1912_fg_standard",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_fg_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_fg_long = {
		a_obj = "a_fg",
		type = "foregrip",
		name_id = "bm_wp_sho_m1912_fg_long",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_fg_long",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_sho_m1912_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_m_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_sho_m1912_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_s_cheek_rest = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_sho_m1912_s_cheek_rest",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_s_cheek_rest",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_s_pad = {
		parent = "stock",
		a_obj = "a_pad",
		type = "stock_ext",
		name_id = "bm_wp_sho_m1912_s_pad",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_s_pad",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_sho_m1912_s_pistol_grip = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_sho_m1912_s_pistol_grip",
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912_pts/wpn_fps_sho_m1912_s_pistol_grip",
		stats = {
			value = 1
		},
		forbids = {
			"wpn_fps_sho_m1912_s_pad"
		}
	}
	self.parts.wpn_fps_sho_m1912_b_standard.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_b_standard"
	self.parts.wpn_fps_sho_m1912_b_long.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_b_long"
	self.parts.wpn_fps_sho_m1912_b_short.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_b_short"
	self.parts.wpn_fps_sho_m1912_b_heat_shield.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_b_heat_shield"
	self.parts.wpn_fps_sho_m1912_ns_cutts.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_ns_cutts"
	self.parts.wpn_fps_sho_m1912_body_standard.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_body_standard"
	self.parts.wpn_fps_sho_m1912_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_bolt_standard"
	self.parts.wpn_fps_sho_m1912_fg_standard.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_fg_standard"
	self.parts.wpn_fps_sho_m1912_fg_long.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_fg_long"
	self.parts.wpn_fps_sho_m1912_m_standard.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_m_standard"
	self.parts.wpn_fps_sho_m1912_s_standard.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_s_standard"
	self.parts.wpn_fps_sho_m1912_s_cheek_rest.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_s_cheek_rest"
	self.parts.wpn_fps_sho_m1912_s_pad.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_s_pad"
	self.parts.wpn_fps_sho_m1912_s_pistol_grip.third_unit = "units/vanilla/weapons/wpn_third_sho_m1912_pts/wpn_third_sho_m1912_s_pistol_grip"
	self.wpn_fps_sho_m1912 = {
		unit = "units/vanilla/weapons/wpn_fps_sho_m1912/wpn_fps_sho_m1912",
		animations = {
			reload_exit = "reload_exit",
			fire = "recoil",
			fire_steelsight = "recoil"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_sho_m1912_b_standard",
			"wpn_fps_sho_m1912_body_standard",
			"wpn_fps_sho_m1912_bolt_standard",
			"wpn_fps_sho_m1912_fg_standard",
			"wpn_fps_sho_m1912_m_standard",
			"wpn_fps_sho_m1912_s_standard"
		},
		uses_parts = {
			"wpn_fps_sho_m1912_b_standard",
			"wpn_fps_sho_m1912_body_standard",
			"wpn_fps_sho_m1912_bolt_standard",
			"wpn_fps_sho_m1912_fg_standard",
			"wpn_fps_sho_m1912_m_standard",
			"wpn_fps_sho_m1912_s_standard",
			"wpn_fps_sho_m1912_b_long",
			"wpn_fps_sho_m1912_b_short",
			"wpn_fps_sho_m1912_ns_cutts",
			"wpn_fps_sho_m1912_s_cheek_rest",
			"wpn_fps_sho_m1912_s_pad",
			"wpn_fps_sho_m1912_s_pistol_grip",
			"wpn_fps_sho_m1912_b_heat_shield",
			"wpn_fps_sho_m1912_fg_long"
		}
	}
	self.wpn_fps_sho_m1912_npc = deep_clone(self.wpn_fps_sho_m1912)
	self.wpn_fps_sho_m1912_npc.unit = "units/vanilla/weapons/wpn_fps_sho_m1912/wpn_fps_sho_m1912_npc"
end

-- Lines 1203-1298
function WeaponFactoryTweakData:_init_mp38()
	self.parts.wpn_fps_smg_mp38_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_smg_mp38_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_b_compensated = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_smg_mp38_b_compensated",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_b_compensated",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_b_fluted = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_smg_mp38_b_fluted",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_b_fluted",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_smg_mp38_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_smg_mp38_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_dh_curved = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_smg_mp38_dh_curved",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_dh_curved",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_mp38_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_m_standard",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_m_standard_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_smg_mp38_m_standard_double",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_m_standard_double",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_smg_mp38_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_s_wooden = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_smg_mp38_s_wooden",
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38_pts/wpn_fps_smg_mp38_s_wooden",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_mp38_b_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_b_standard"
	self.parts.wpn_fps_smg_mp38_b_compensated.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_b_compensated"
	self.parts.wpn_fps_smg_mp38_b_fluted.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_b_fluted"
	self.parts.wpn_fps_smg_mp38_body_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_body_standard"
	self.parts.wpn_fps_smg_mp38_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_dh_standard"
	self.parts.wpn_fps_smg_mp38_dh_curved.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_dh_curved"
	self.parts.wpn_fps_smg_mp38_m_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_m_standard"
	self.parts.wpn_fps_smg_mp38_m_standard_double.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_m_standard_double"
	self.parts.wpn_fps_smg_mp38_s_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_s_standard"
	self.parts.wpn_fps_smg_mp38_s_wooden.third_unit = "units/vanilla/weapons/wpn_third_smg_mp38_pts/wpn_third_smg_mp38_s_wooden"
	self.wpn_fps_smg_mp38 = {
		unit = "units/vanilla/weapons/wpn_fps_smg_mp38/wpn_fps_smg_mp38",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_smg_mp38_b_standard",
			"wpn_fps_smg_mp38_body_standard",
			"wpn_fps_smg_mp38_dh_standard",
			"wpn_fps_smg_mp38_m_standard",
			"wpn_fps_smg_mp38_s_standard"
		},
		uses_parts = {
			"wpn_fps_smg_mp38_b_standard",
			"wpn_fps_smg_mp38_body_standard",
			"wpn_fps_smg_mp38_dh_standard",
			"wpn_fps_smg_mp38_m_standard",
			"wpn_fps_smg_mp38_s_standard",
			"wpn_fps_smg_mp38_m_standard_double",
			"wpn_fps_smg_mp38_dh_curved",
			"wpn_fps_smg_mp38_b_compensated",
			"wpn_fps_smg_mp38_b_fluted",
			"wpn_fps_smg_mp38_s_wooden"
		}
	}
	self.wpn_fps_smg_mp38_npc = deep_clone(self.wpn_fps_smg_mp38)
	self.wpn_fps_smg_mp38_npc.unit = "units/vanilla/weapons/wpn_fps_smg_mp38/wpn_fps_smg_mp38_npc"
end

-- Lines 1300-1399
function WeaponFactoryTweakData:_init_mp44()
	self.parts.wpn_fps_ass_mp44_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_ass_mp44_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_body_standard = {
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_ass_mp44_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_dh_standard = {
		a_obj = "a_dh",
		type = "custom",
		name_id = "bm_wp_ass_mp44_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_m_short = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_mp44_m_short",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_m_short",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_m_short_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_mp44_m_short_double",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_m_short_double",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_mp44_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_m_standard",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_m_standard_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_mp44_m_standard_double",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_m_standard_double",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_fg_standard = {
		a_obj = "a_fg",
		type = "foregrip",
		name_id = "bm_wp_ass_mp44_fg_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_fg_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_ass_mp44_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_mp44_o_scope = {
		parent = "body",
		a_obj = "a_o",
		type = "sight",
		name_id = "bm_wp_ass_mp44_o_scope",
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44_pts/wpn_fps_ass_mp44_o_scope",
		stats = {
			value = 1,
			zoom = 5
		},
		stance_mod = {
			wpn_fps_ass_mp44 = {
				lens_distortion_power = 1.03,
				translation = Vector3(0, -15, -1.64784)
			}
		}
	}
	self.parts.wpn_fps_ass_mp44_b_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_b_standard"
	self.parts.wpn_fps_ass_mp44_body_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_body_standard"
	self.parts.wpn_fps_ass_mp44_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_dh_standard"
	self.parts.wpn_fps_ass_mp44_m_short.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_m_short"
	self.parts.wpn_fps_ass_mp44_m_short_double.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_m_short_double"
	self.parts.wpn_fps_ass_mp44_m_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_m_standard"
	self.parts.wpn_fps_ass_mp44_m_standard_double.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_m_standard_double"
	self.parts.wpn_fps_ass_mp44_fg_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_fg_standard"
	self.parts.wpn_fps_ass_mp44_s_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_s_standard"
	self.parts.wpn_fps_ass_mp44_o_scope.third_unit = "units/vanilla/weapons/wpn_third_ass_mp44_pts/wpn_third_ass_mp44_o_scope"
	self.wpn_fps_ass_mp44 = {
		unit = "units/vanilla/weapons/wpn_fps_ass_mp44/wpn_fps_ass_mp44",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_ass_mp44_b_standard",
			"wpn_fps_ass_mp44_body_standard",
			"wpn_fps_ass_mp44_dh_standard",
			"wpn_fps_ass_mp44_m_short",
			"wpn_fps_ass_mp44_fg_standard",
			"wpn_fps_ass_mp44_s_standard"
		},
		uses_parts = {
			"wpn_fps_ass_mp44_b_standard",
			"wpn_fps_ass_mp44_body_standard",
			"wpn_fps_ass_mp44_dh_standard",
			"wpn_fps_ass_mp44_m_short",
			"wpn_fps_ass_mp44_fg_standard",
			"wpn_fps_ass_mp44_s_standard",
			"wpn_fps_ass_mp44_m_short_double",
			"wpn_fps_ass_mp44_m_standard",
			"wpn_fps_ass_mp44_m_standard_double",
			"wpn_fps_ass_mp44_o_scope"
		}
	}
	self.wpn_fps_ass_mp44_npc = deep_clone(self.wpn_fps_ass_mp44)
	self.wpn_fps_ass_mp44_npc.unit = "units/vanilla/weapons/wpn_fps_ass_mp44/wpn_fps_ass_mp44_npc"
end

-- Lines 1401-1492
function WeaponFactoryTweakData:_init_carbine()
	self.parts.wpn_fps_ass_carbine_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_ass_carbine_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_ass_carbine_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_body_wooden = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_ass_carbine_body_wooden",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_body_wooden",
		stats = {
			value = 1
		},
		forbids = {
			"wpn_fps_ass_carbine_s_standard",
			"wpn_fps_ass_carbine_g_standard"
		}
	}
	self.parts.wpn_fps_ass_carbine_dh_standard = {
		a_obj = "a_dh",
		type = "custom",
		name_id = "bm_wp_ass_carbine_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_bolt_standard = {
		a_obj = "a_bolt",
		type = "custom",
		name_id = "bm_wp_ass_carbine_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_carbine_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_m_standard",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_m_extended = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_ass_carbine_m_extended",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_m_extended",
		bullet_objects = {
			amount = 5,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_g_standard = {
		a_obj = "a_g",
		type = "grip",
		name_id = "bm_wp_ass_carbine_g_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_g_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_ass_carbine_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine_pts/wpn_fps_ass_carbine_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_ass_carbine_b_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_b_standard"
	self.parts.wpn_fps_ass_carbine_body_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_body_standard"
	self.parts.wpn_fps_ass_carbine_body_wooden.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_body_wooden"
	self.parts.wpn_fps_ass_carbine_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_dh_standard"
	self.parts.wpn_fps_ass_carbine_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_bolt_standard"
	self.parts.wpn_fps_ass_carbine_m_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_m_standard"
	self.parts.wpn_fps_ass_carbine_m_extended.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_m_extended"
	self.parts.wpn_fps_ass_carbine_g_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_g_standard"
	self.parts.wpn_fps_ass_carbine_s_standard.third_unit = "units/vanilla/weapons/wpn_third_ass_carbine_pts/wpn_third_ass_carbine_s_standard"
	self.wpn_fps_ass_carbine = {
		unit = "units/vanilla/weapons/wpn_fps_ass_carbine/wpn_fps_ass_carbine",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"barrel",
			"lower_receiver"
		},
		default_blueprint = {
			"wpn_fps_ass_carbine_b_standard",
			"wpn_fps_ass_carbine_body_standard",
			"wpn_fps_ass_carbine_dh_standard",
			"wpn_fps_ass_carbine_bolt_standard",
			"wpn_fps_ass_carbine_m_standard",
			"wpn_fps_ass_carbine_g_standard",
			"wpn_fps_ass_carbine_s_standard"
		},
		uses_parts = {
			"wpn_fps_ass_carbine_b_standard",
			"wpn_fps_ass_carbine_body_standard",
			"wpn_fps_ass_carbine_dh_standard",
			"wpn_fps_ass_carbine_bolt_standard",
			"wpn_fps_ass_carbine_m_standard",
			"wpn_fps_ass_carbine_g_standard",
			"wpn_fps_ass_carbine_s_standard",
			"wpn_fps_ass_carbine_body_wooden",
			"wpn_fps_ass_carbine_m_extended"
		}
	}
	self.wpn_fps_ass_carbine_npc = deep_clone(self.wpn_fps_ass_carbine)
	self.wpn_fps_ass_carbine_npc.unit = "units/vanilla/weapons/wpn_fps_ass_carbine/wpn_fps_ass_carbine_npc"
end

-- Lines 1494-1642
function WeaponFactoryTweakData:_init_mg42()
	self.parts.wpn_fps_lmg_mg42_b_mg42 = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_mg42_b_mg42",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_b_mg42",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_n42 = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_mg42_n42",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_n42",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_b_mg34 = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_mg42_b_mg34",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_b_mg34",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_n34 = {
		parent = "barrel",
		a_obj = "a_ns",
		type = "barrel_ext",
		name_id = "bm_wp_mg42_n34",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_n42",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_receiver = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_mg42_receiver",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_receiver",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_lid_standard = {
		a_obj = "a_lid",
		type = "upper_receiver",
		name_id = "bm_wp_mg42_lid_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_lid_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_lid_mg34 = {
		a_obj = "a_body",
		type = "upper_receiver",
		name_id = "bm_wp_mg42_lid_mg34",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_lid_mg34",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_mg42_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_dh_extra = {
		a_obj = "a_dh_extra",
		type = "dh_ext",
		name_id = "bm_wp_mg42_dh_extra",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_dh_extra",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_bipod = {
		parent = "barrel",
		a_obj = "a_bp",
		type = "bipod",
		name_id = "bm_wp_mg42_bipod",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_bipod",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_dh_mg34 = {
		a_obj = "a_body",
		type = "drag_handle",
		name_id = "bm_wp_mg42_dh_mg34",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_dh_mg34",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_mg42_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_m_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_handle = {
		a_obj = "a_handle",
		type = "custom",
		name_id = "bm_wp_mg42_handle",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_handle",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_band_1 = {
		a_obj = "a_band_1",
		type = "band_1",
		name_id = "bm_wp_mg42_band_1",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_band_1",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_band_2 = {
		a_obj = "a_band_2",
		type = "band_2",
		name_id = "bm_wp_mg42_band_2",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_band_2",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_band_3 = {
		a_obj = "a_band_3",
		type = "band_3",
		name_id = "bm_wp_mg42_band_3",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_band_3",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_m_double = {
		a_obj = "a_body",
		type = "magazine",
		name_id = "bm_wp_mg42_m_double",
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42_pts/wpn_fps_lmg_mg42_m_double",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_lmg_mg42_b_mg42.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_b_mg42"
	self.parts.wpn_fps_lmg_mg42_n42.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_n42"
	self.parts.wpn_fps_lmg_mg42_b_mg34.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_b_mg34"
	self.parts.wpn_fps_lmg_mg42_n34.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_n34"
	self.parts.wpn_fps_lmg_mg42_receiver.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_receiver"
	self.parts.wpn_fps_lmg_mg42_lid_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_lid_standard"
	self.parts.wpn_fps_lmg_mg42_lid_mg34.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_lid_mg34"
	self.parts.wpn_fps_lmg_mg42_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_dh_standard"
	self.parts.wpn_fps_lmg_mg42_dh_extra.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_dh_extra"
	self.parts.wpn_fps_lmg_mg42_bipod.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_bipod"
	self.parts.wpn_fps_lmg_mg42_dh_mg34.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_dh_mg34"
	self.parts.wpn_fps_lmg_mg42_m_standard.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_m_standard"
	self.parts.wpn_fps_lmg_mg42_handle.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_handle"
	self.parts.wpn_fps_lmg_mg42_band_1.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_band_1"
	self.parts.wpn_fps_lmg_mg42_band_2.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_band_2"
	self.parts.wpn_fps_lmg_mg42_band_3.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_band_3"
	self.parts.wpn_fps_lmg_mg42_m_double.third_unit = "units/vanilla/weapons/wpn_third_lmg_mg42_pts/wpn_third_lmg_mg42_m_double"
	self.wpn_fps_lmg_mg42 = {
		unit = "units/vanilla/weapons/wpn_fps_lmg_mg42/wpn_fps_lmg_mg42",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"vertical_grip"
		},
		default_blueprint = {
			"wpn_fps_lmg_mg42_b_mg42",
			"wpn_fps_lmg_mg42_n42",
			"wpn_fps_lmg_mg42_receiver",
			"wpn_fps_lmg_mg42_lid_standard",
			"wpn_fps_lmg_mg42_dh_standard",
			"wpn_fps_lmg_mg42_dh_extra",
			"wpn_fps_lmg_mg42_m_standard",
			"wpn_fps_lmg_mg42_handle",
			"wpn_fps_lmg_mg42_band_1",
			"wpn_fps_lmg_mg42_band_2",
			"wpn_fps_lmg_mg42_band_3"
		},
		uses_parts = {
			"wpn_fps_lmg_mg42_b_mg42",
			"wpn_fps_lmg_mg42_n42",
			"wpn_fps_lmg_mg42_receiver",
			"wpn_fps_lmg_mg42_lid_standard",
			"wpn_fps_lmg_mg42_dh_standard",
			"wpn_fps_lmg_mg42_dh_extra",
			"wpn_fps_lmg_mg42_m_standard",
			"wpn_fps_lmg_mg42_handle",
			"wpn_fps_lmg_mg42_band_1",
			"wpn_fps_lmg_mg42_band_2",
			"wpn_fps_lmg_mg42_band_3",
			"wpn_fps_lmg_mg42_b_mg34",
			"wpn_fps_lmg_mg42_n34",
			"wpn_fps_lmg_mg42_bipod",
			"wpn_fps_lmg_mg42_dh_mg34",
			"wpn_fps_lmg_mg42_m_double",
			"wpn_fps_lmg_mg42_lid_mg34"
		}
	}
	self.wpn_fps_lmg_mg42_npc = deep_clone(self.wpn_fps_lmg_mg42)
	self.wpn_fps_lmg_mg42_npc.unit = "units/vanilla/weapons/wpn_fps_lmg_mg42/wpn_fps_lmg_mg42_npc"
end

-- Lines 1645-1762
function WeaponFactoryTweakData:_init_c96()
	self.parts.wpn_fps_pis_c96_b_long = {
		a_obj = "a_b",
		type = "slide",
		name_id = "bm_wp_c96_b_long",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_b_long",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_b_long_finned = {
		a_obj = "a_b",
		type = "slide",
		name_id = "bm_wp_c96_b_long_finned",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_b_long_finned",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_b_standard = {
		a_obj = "a_b",
		type = "slide",
		name_id = "bm_wp_c96_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_c96_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_g_standard = {
		a_obj = "a_g",
		type = "grip",
		name_id = "bm_wp_c96_g_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_g_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_m_long = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_c96_m_long",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_m_long",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_m_extended = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_c96_m_extended",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_m_extended",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_c96_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_m_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_s_wooden = {
		a_obj = "a_s",
		type = "grip",
		name_id = "bm_wp_c96_s_wooden",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_s_wooden",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_bullets_standard = {
		a_obj = "a_bullets",
		type = "bullets",
		name_id = "bm_wp_c96_bullets_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_bullets_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_strip_standard = {
		a_obj = "a_strip",
		type = "strip",
		name_id = "bm_wp_c96_strip_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_strip_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_bolt_standard = {
		a_obj = "a_bolt",
		type = "bolt",
		name_id = "bm_wp_c96_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_hammer_standard = {
		a_obj = "a_hammer",
		type = "hammer",
		name_id = "bm_wp_c96_hammer_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_c96_pts/wpn_fps_pis_c96_hammer_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_c96_b_long.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_b_long"
	self.parts.wpn_fps_pis_c96_b_long_finned.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_b_long_finned"
	self.parts.wpn_fps_pis_c96_b_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_b_standard"
	self.parts.wpn_fps_pis_c96_body_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_body_standard"
	self.parts.wpn_fps_pis_c96_g_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_g_standard"
	self.parts.wpn_fps_pis_c96_m_long.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_m_long"
	self.parts.wpn_fps_pis_c96_m_extended.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_m_extended"
	self.parts.wpn_fps_pis_c96_m_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_m_standard"
	self.parts.wpn_fps_pis_c96_s_wooden.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_s_wooden"
	self.parts.wpn_fps_pis_c96_bullets_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_bullets_standard"
	self.parts.wpn_fps_pis_c96_strip_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_strip_standard"
	self.parts.wpn_fps_pis_c96_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_bolt_standard"
	self.parts.wpn_fps_pis_c96_hammer_standard.third_unit = "units/vanilla/weapons/wpn_third_pis_c96_pts/wpn_third_pis_c96_hammer_standard"
	self.wpn_fps_pis_c96 = {
		unit = "units/vanilla/weapons/wpn_fps_pis_c96/wpn_fps_pis_c96",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"sight"
		},
		default_blueprint = {
			"wpn_fps_pis_c96_b_standard",
			"wpn_fps_pis_c96_body_standard",
			"wpn_fps_pis_c96_g_standard",
			"wpn_fps_pis_c96_m_standard",
			"wpn_fps_pis_c96_bullets_standard",
			"wpn_fps_pis_c96_strip_standard",
			"wpn_fps_pis_c96_bolt_standard",
			"wpn_fps_pis_c96_hammer_standard"
		},
		uses_parts = {
			"wpn_fps_pis_c96_b_standard",
			"wpn_fps_pis_c96_body_standard",
			"wpn_fps_pis_c96_g_standard",
			"wpn_fps_pis_c96_m_standard",
			"wpn_fps_pis_c96_bullets_standard",
			"wpn_fps_pis_c96_strip_standard",
			"wpn_fps_pis_c96_bolt_standard",
			"wpn_fps_pis_c96_hammer_standard",
			"wpn_fps_pis_c96_b_long",
			"wpn_fps_pis_c96_b_long_finned",
			"wpn_fps_pis_c96_m_long",
			"wpn_fps_pis_c96_m_extended",
			"wpn_fps_pis_c96_s_wooden"
		}
	}
	self.wpn_fps_pis_c96_npc = deep_clone(self.wpn_fps_pis_c96)
	self.wpn_fps_pis_c96_npc.unit = "units/vanilla/weapons/wpn_fps_pis_c96/wpn_fps_pis_c96_npc"
end

-- Lines 1764-1892
function WeaponFactoryTweakData:_init_webley()
	self.parts.wpn_fps_pis_webley_body_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_body_standard",
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_webley_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_lock_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_lock_standard",
		a_obj = "a_lock",
		type = "lock",
		name_id = "bm_wp_webley_lock_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_lock_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_hammer_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_hammer_standard",
		a_obj = "a_hammer",
		type = "hammer",
		name_id = "bm_wp_webley_hammer_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_hammer_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_trigger_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_trigger_standard",
		a_obj = "a_trigger",
		type = "trigger",
		name_id = "bm_wp_webley_trigger_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_trigger_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_b_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_b_standard",
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_webley_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_m_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_m_standard",
		type = "magazine",
		name_id = "bm_wp_webley_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_m_standard",
		a_obj = "a_m",
		bullet_objects = {
			amount = 6,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_ejector_standard = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_ejector_standard",
		a_obj = "a_ejector",
		type = "ejector",
		name_id = "bm_wp_webley_ejector_standard",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_ejector_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_casing_1 = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_casing_1",
		a_obj = "a_casing_1",
		type = "extra_1",
		name_id = "bm_wp_webley_casing_1",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_casing_1",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_casing_2 = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_casing_2",
		a_obj = "a_casing_2",
		type = "extra_2",
		name_id = "bm_wp_webley_casing_2",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_casing_2",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_casing_3 = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_casing_3",
		a_obj = "a_casing_3",
		type = "extra_3",
		name_id = "bm_wp_webley_casing_3",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_casing_3",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_casing_4 = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_casing_4",
		a_obj = "a_casing_4",
		type = "extra_4",
		name_id = "bm_wp_webley_casing_4",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_casing_4",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_casing_5 = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_casing_5",
		a_obj = "a_casing_5",
		type = "extra_5",
		name_id = "bm_wp_webley_casing_5",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_casing_5",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_casing_6 = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_casing_6",
		a_obj = "a_casing_6",
		type = "extra_6",
		name_id = "bm_wp_webley_casing_6",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_casing_6",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_pis_webley_bullet_clip = {
		third_unit = "units/vanilla/weapons/wpn_third_pis_webley_pts/wpn_third_pis_webley_bullet_clip",
		a_obj = "a_clip",
		type = "bullet_clip",
		name_id = "bm_wp_webley_bullet_clip",
		unit = "units/vanilla/weapons/wpn_fps_pis_webley_pts/wpn_fps_pis_webley_bullet_clip",
		stats = {
			value = 1
		}
	}
	self.wpn_fps_pis_webley = {
		unit = "units/vanilla/weapons/wpn_fps_pis_webley/wpn_fps_pis_webley",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"sight"
		},
		default_blueprint = {
			"wpn_fps_pis_webley_body_standard",
			"wpn_fps_pis_webley_lock_standard",
			"wpn_fps_pis_webley_hammer_standard",
			"wpn_fps_pis_webley_trigger_standard",
			"wpn_fps_pis_webley_b_standard",
			"wpn_fps_pis_webley_m_standard",
			"wpn_fps_pis_webley_ejector_standard",
			"wpn_fps_pis_webley_casing_1",
			"wpn_fps_pis_webley_casing_2",
			"wpn_fps_pis_webley_casing_3",
			"wpn_fps_pis_webley_casing_4",
			"wpn_fps_pis_webley_casing_5",
			"wpn_fps_pis_webley_casing_6",
			"wpn_fps_pis_webley_bullet_clip"
		},
		uses_parts = {
			"wpn_fps_pis_webley_body_standard",
			"wpn_fps_pis_webley_lock_standard",
			"wpn_fps_pis_webley_hammer_standard",
			"wpn_fps_pis_webley_trigger_standard",
			"wpn_fps_pis_webley_b_standard",
			"wpn_fps_pis_webley_m_standard",
			"wpn_fps_pis_webley_ejector_standard",
			"wpn_fps_pis_webley_casing_1",
			"wpn_fps_pis_webley_casing_2",
			"wpn_fps_pis_webley_casing_3",
			"wpn_fps_pis_webley_casing_4",
			"wpn_fps_pis_webley_casing_5",
			"wpn_fps_pis_webley_casing_6",
			"wpn_fps_pis_webley_bullet_clip"
		}
	}
	self.wpn_fps_pis_webley_npc = deep_clone(self.wpn_fps_pis_webley)
	self.wpn_fps_pis_webley_npc.unit = "units/vanilla/weapons/wpn_fps_pis_webley/wpn_fps_pis_webley_npc"
end

-- Lines 1894-1997
function WeaponFactoryTweakData:_init_mosin()
	self.parts.wpn_fps_snp_mosin_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_mosin_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_b_long = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_mosin_b_long",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_b_long",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_body_standard = {
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_mosin_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_body_grip = {
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_mosin_body_grip",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_body_grip",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_body_target = {
		a_obj = "a_body",
		type = "body",
		name_id = "bm_wp_mosin_body_target",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_body_target",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_bolt_standard = {
		a_obj = "a_bolt",
		type = "bolt",
		name_id = "bm_wp_mosin_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_dh_standard = {
		a_obj = "a_dh",
		type = "drag_handle",
		name_id = "bm_wp_mosin_dh_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_dh_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_m_standard = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_mosin_m_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_m_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_clip_standard = {
		a_obj = "a_clip",
		type = "clip",
		name_id = "bm_wp_mosin_clip_standard",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_clip_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_bullet = {
		a_obj = "a_bullet",
		type = "bullets",
		name_id = "bm_wp_mosin_bullet",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_bullet",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_snp_mosin_o_scope = {
		parent = "body",
		a_obj = "a_o",
		type = "scope",
		name_id = "bm_wp_mosin_o_scope",
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin_pts/wpn_fps_snp_mosin_o_scope",
		reticle_obj = "g_reticle",
		stats = {
			value = 1,
			zoom = 8
		},
		stance_mod = {
			wpn_fps_snp_mosin = {
				lens_distortion_power = 1.04,
				translation = Vector3(0, -23, -2.323)
			}
		}
	}
	self.parts.wpn_fps_snp_mosin_b_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_b_standard"
	self.parts.wpn_fps_snp_mosin_b_long.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_b_long"
	self.parts.wpn_fps_snp_mosin_body_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_body_standard"
	self.parts.wpn_fps_snp_mosin_body_grip.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_body_grip"
	self.parts.wpn_fps_snp_mosin_body_target.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_body_target"
	self.parts.wpn_fps_snp_mosin_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_bolt_standard"
	self.parts.wpn_fps_snp_mosin_dh_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_dh_standard"
	self.parts.wpn_fps_snp_mosin_m_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_m_standard"
	self.parts.wpn_fps_snp_mosin_clip_standard.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_clip_standard"
	self.parts.wpn_fps_snp_mosin_bullet.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_bullet"
	self.parts.wpn_fps_snp_mosin_o_scope.third_unit = "units/vanilla/weapons/wpn_third_snp_mosin_pts/wpn_third_snp_mosin_o_scope"
	self.wpn_fps_snp_mosin = {
		unit = "units/vanilla/weapons/wpn_fps_snp_mosin/wpn_fps_snp_mosin",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"gadget",
			"sight",
			"bayonet"
		},
		default_blueprint = {
			"wpn_fps_snp_mosin_b_standard",
			"wpn_fps_snp_mosin_body_standard",
			"wpn_fps_snp_mosin_bolt_standard",
			"wpn_fps_snp_mosin_dh_standard",
			"wpn_fps_snp_mosin_m_standard",
			"wpn_fps_snp_mosin_clip_standard",
			"wpn_fps_snp_mosin_bullet"
		},
		uses_parts = {
			"wpn_fps_snp_mosin_b_standard",
			"wpn_fps_snp_mosin_body_standard",
			"wpn_fps_snp_mosin_bolt_standard",
			"wpn_fps_snp_mosin_dh_standard",
			"wpn_fps_snp_mosin_m_standard",
			"wpn_fps_snp_mosin_clip_standard",
			"wpn_fps_snp_mosin_bullet",
			"wpn_fps_snp_mosin_b_long",
			"wpn_fps_snp_mosin_body_grip",
			"wpn_fps_snp_mosin_body_target",
			"wpn_fps_snp_mosin_o_scope"
		}
	}
	self.wpn_fps_snp_mosin_npc = deep_clone(self.wpn_fps_snp_mosin)
	self.wpn_fps_snp_mosin_npc.unit = "units/vanilla/weapons/wpn_fps_snp_mosin/wpn_fps_snp_mosin_npc"
end

-- Lines 2000-2080
function WeaponFactoryTweakData:_init_sterling()
	self.parts.wpn_fps_smg_sterling_b_long = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_sterling_b_long",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_b_long",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_b_standard = {
		a_obj = "a_b",
		type = "barrel",
		name_id = "bm_wp_sterling_b_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_b_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_body_standard = {
		a_obj = "a_body",
		type = "lower_receiver",
		name_id = "bm_wp_sterling_body_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_body_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_bolt_standard = {
		a_obj = "a_bolt",
		type = "bolt",
		name_id = "bm_wp_sterling_bolt_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_bolt_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_m_long = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_sterling_m_long",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_m_long",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_m_long_double = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_sterling_m_long_double",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_m_long_double",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_m_medium = {
		a_obj = "a_m",
		type = "magazine",
		name_id = "bm_wp_sterling_m_medium",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_m_medium",
		bullet_objects = {
			amount = 3,
			prefix = "g_bullet_"
		},
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_s_standard = {
		a_obj = "a_s",
		type = "stock",
		name_id = "bm_wp_sterling_s_standard",
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling_pts/wpn_fps_smg_sterling_s_standard",
		stats = {
			value = 1
		}
	}
	self.parts.wpn_fps_smg_sterling_b_long.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_b_long"
	self.parts.wpn_fps_smg_sterling_b_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_b_standard"
	self.parts.wpn_fps_smg_sterling_body_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_body_standard"
	self.parts.wpn_fps_smg_sterling_bolt_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_bolt_standard"
	self.parts.wpn_fps_smg_sterling_m_long.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_m_long"
	self.parts.wpn_fps_smg_sterling_m_long_double.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_m_long_double"
	self.parts.wpn_fps_smg_sterling_m_medium.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_m_medium"
	self.parts.wpn_fps_smg_sterling_s_standard.third_unit = "units/vanilla/weapons/wpn_third_smg_sterling_pts/wpn_third_smg_sterling_s_standard"
	self.wpn_fps_smg_sterling = {
		unit = "units/vanilla/weapons/wpn_fps_smg_sterling/wpn_fps_smg_sterling",
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		optional_types = {
			"barrel_ext",
			"gadget",
			"vertical_grip"
		},
		default_blueprint = {
			"wpn_fps_smg_sterling_b_standard",
			"wpn_fps_smg_sterling_body_standard",
			"wpn_fps_smg_sterling_bolt_standard",
			"wpn_fps_smg_sterling_m_medium",
			"wpn_fps_smg_sterling_s_standard"
		},
		uses_parts = {
			"wpn_fps_smg_sterling_b_standard",
			"wpn_fps_smg_sterling_body_standard",
			"wpn_fps_smg_sterling_bolt_standard",
			"wpn_fps_smg_sterling_m_medium",
			"wpn_fps_smg_sterling_s_standard",
			"wpn_fps_smg_sterling_b_long",
			"wpn_fps_smg_sterling_m_long",
			"wpn_fps_smg_sterling_m_long_double"
		}
	}
	self.wpn_fps_smg_sterling_npc = deep_clone(self.wpn_fps_smg_sterling)
	self.wpn_fps_smg_sterling_npc.unit = "units/vanilla/weapons/wpn_fps_smg_sterling/wpn_fps_smg_sterling_npc"
end

-- Lines 2082-2107
function WeaponFactoryTweakData:_init_welrod()
	self.wpn_fps_pis_welrod = {
		unit = "units/vanilla/weapons/wpn_fps_pis_welrod/wpn_fps_pis_welrod",
		optional_types = {
			"barrel_ext",
			"gadget"
		},
		animations = {
			reload = "reload",
			fire = "recoil",
			fire_steelsight = "recoil",
			reload_not_empty = "reload_not_empty"
		},
		default_blueprint = {
			"wpn_fps_pis_m1911_body_standard",
			"wpn_fps_pis_m1911_b_standard",
			"wpn_fps_pis_m1911_sl_standard",
			"wpn_fps_pis_m1911_m_standard",
			"wpn_fps_pis_m1911_dh_hammer"
		},
		uses_parts = {
			"wpn_fps_pis_m1911_body_standard",
			"wpn_fps_pis_m1911_b_standard",
			"wpn_fps_pis_m1911_sl_standard",
			"wpn_fps_pis_m1911_m_standard",
			"wpn_fps_pis_m1911_dh_hammer"
		}
	}
	self.wpn_fps_pis_welrod_npc = deep_clone(self.wpn_fps_pis_welrod)
	self.wpn_fps_pis_welrod_npc.unit = "units/vanilla/weapons/wpn_fps_pis_welrod/wpn_fps_pis_welrod_npc"
end

-- Lines 2111-2113
function WeaponFactoryTweakData:is_part_internal(part_id)
	return self.parts[part_id] and self.parts[part_id].internal_part or false
end

-- Lines 2115-2117
function WeaponFactoryTweakData:create_ammunition()
end
