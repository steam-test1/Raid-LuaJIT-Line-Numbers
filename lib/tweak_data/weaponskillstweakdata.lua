WeaponSkillsTweakData = WeaponSkillsTweakData or class()
WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE = "increase_damage"
WeaponSkillsTweakData.SKILL_DECREASE_RECOIL = "decrease_recoil"
WeaponSkillsTweakData.SKILL_FASTER_RELOAD = "faster_reload"
WeaponSkillsTweakData.SKILL_FASTER_ADS = "faster_ads"
WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD = "tighter_spread"
WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE = "increase_magazine"
WeaponSkillsTweakData.MAX_SKILLS_IN_TIER = 4
WeaponSkillsTweakData.MAX_TIERS = 4

-- Lines 13-85
function WeaponSkillsTweakData:init()
	self.skills = {}
	self.skill_trees = {}

	self:_init_skills()
	self:_init_m1911_skill_tree()
	self:_init_c96_skill_tree()
	self:_init_thompson_skill_tree()
	self:_init_mp38_skill_tree()
	self:_init_sterling_skill_tree()
	self:_init_sten_skill_tree()
	self:_init_m1903_skill_tree()
	self:_init_mosin_skill_tree()
	self:_init_garand_skill_tree()
	self:_init_garand_golden_skill_tree()
	self:_init_m1918_skill_tree()
	self:_init_mg42_skill_tree()
	self:_init_mp44_skill_tree()
	self:_init_m1912_skill_tree()
	self:_init_carbine_skill_tree()
	self:_init_webley_skill_tree()
	self:_init_geco_skill_tree()
	self:_init_reedem_xp_values()
end

-- Lines 90-123
function WeaponSkillsTweakData:_init_skills()
	self.skills[WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE] = {
		name_id = "weapon_skill_increase_damage_name",
		icon = "wpn_skill_damage",
		desc_id = "weapon_skill_increase_damage_desc"
	}
	self.skills[WeaponSkillsTweakData.SKILL_DECREASE_RECOIL] = {
		name_id = "weapon_skill_decrease_recoil_name",
		icon = "wpn_skill_stability",
		desc_id = "weapon_skill_decrease_recoil_desc"
	}
	self.skills[WeaponSkillsTweakData.SKILL_FASTER_RELOAD] = {
		name_id = "weapon_skill_faster_reload_name",
		icon = "wpn_skill_blank",
		desc_id = "weapon_skill_faster_reload_desc"
	}
	self.skills[WeaponSkillsTweakData.SKILL_FASTER_ADS] = {
		name_id = "weapon_skill_faster_ads_name",
		icon = "wpn_skill_blank",
		desc_id = "weapon_skill_faster_ads_desc"
	}
	self.skills[WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD] = {
		name_id = "weapon_skill_tighter_spread_name",
		icon = "wpn_skill_accuracy",
		desc_id = "weapon_skill_tighter_spread_desc"
	}
	self.skills[WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE] = {
		name_id = "weapon_skill_increase_magazine_name",
		icon = "wpn_skill_mag_size",
		desc_id = "weapon_skill_increase_magazine_desc"
	}
end

-- Lines 132-152
function WeaponSkillsTweakData:_init_m1911_skill_tree()
	self.skill_trees.m1911 = {
		{}
	}
	self.skill_trees.m1911[1][4] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 25,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						10,
						20
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_pis_m1911_ns_cutts"
			}
		}
	}
	self.skill_trees.m1911[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_collect_ammo_completed",
			challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
			challenge_tasks = {
				{
					target = 175,
					type = ChallengeTweakData.TASK_COLLECT_AMMO,
					reminders = {
						100,
						150
					}
				}
			},
			weapon_parts = {
				"wpn_fps_pis_m1911_m_extended"
			}
		}
	}
	self.skill_trees.m1911[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 125,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						40,
						70,
						100
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.m1911[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						60,
						125,
						180,
						225
					}
				}
			}
		}
	}
	self.skill_trees.m1911[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							125,
							250,
							375,
							450
						}
					}
				}
			}
		},
		[4] = {
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							35,
							45
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_m1911_fg_tommy"
				}
			}
		},
		[2] = {
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 525,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							200,
							400
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_m1911_m_banana"
				}
			}
		},
		[3] = {
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							125,
							200,
							225
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_m1911_s_wooden"
				}
			}
		}
	}
	self.skill_trees.m1911[3] = {
		{
			{
				cost = 7,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							185,
							375,
							550,
							700
						}
					}
				}
			}
		},
		[4] = {
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 75,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							25,
							50,
							65
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_m1911_fg_tommy"
				}
			}
		},
		[2] = {
			{
				cost = 3,
				value = 5,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 1050,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							300,
							600,
							900
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_m1911_m_banana"
				}
			}
		},
		[3] = {
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 375,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							200,
							300,
							350
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_m1911_s_wooden"
				}
			}
		}
	}
	self.skill_trees.m1911.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 155-169
function WeaponSkillsTweakData:_init_c96_skill_tree()
	self.skill_trees.c96 = {
		{}
	}
	self.skill_trees.c96[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						60,
						125,
						180,
						225
					}
				}
			},
			weapon_parts = {
				"wpn_fps_pis_c96_b_long"
			}
		}
	}
	self.skill_trees.c96[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 125,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						40,
						70,
						100
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.c96[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_collect_ammo_completed",
			challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_COLLECT_AMMO,
					reminders = {
						100,
						200
					}
				}
			},
			weapon_parts = {
				"wpn_fps_pis_c96_m_extended"
			}
		}
	}
	self.skill_trees.c96[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							125,
							250,
							375,
							450
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_c96_b_long_finned"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							125,
							200,
							225
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_c96_s_wooden"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							300,
							600
						}
					}
				},
				weapon_parts = {
					"wpn_fps_pis_c96_m_long"
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							35,
							45
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		}
	}
	self.skill_trees.c96.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 172-185
function WeaponSkillsTweakData:_init_webley_skill_tree()
	self.skill_trees.webley = {
		{}
	}
	self.skill_trees.webley[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						60,
						125,
						185,
						225
					}
				}
			}
		}
	}
	self.skill_trees.webley[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 25,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						10,
						20
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.webley[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							125,
							250,
							375,
							450
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							35,
							45
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							125,
							200,
							225
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		}
	}
	self.skill_trees.webley.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 232-250
function WeaponSkillsTweakData:_init_geco_skill_tree()
	self.skill_trees.geco = {
		{}
	}
	self.skill_trees.geco[1][1] = {
		{
			cost = 2,
			value = 5,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.geco[2] = {
		{
			{
				cost = 2,
				value = 6,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_geco_b_short"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		}
	}
	self.skill_trees.geco[3] = {
		{
			{
				cost = 4,
				value = 7,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_geco_s_cheek_rest"
				}
			}
		}
	}
	self.skill_trees.geco[4] = {
		{
			{
				value = 8,
				challenge_done_text_id = "weapon_skill_headshot_ss_completed",
				challenge_briefing_id = "weapon_skill_headshot_ss_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							40
						},
						modifiers = {
							headshot = true,
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_COMMANDER
							},
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 4,
				challenge_done_text_id = "weapon_skill_kill_flamers_completed",
				challenge_briefing_id = "weapon_skill_kill_flamers_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 30,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							10,
							20
						},
						modifiers = {
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_FLAMER
							}
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 4,
				challenge_done_text_id = "weapon_skill_hip_fire_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							50,
							80
						},
						modifiers = {
							headshot = true,
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		}
	}
	self.skill_trees.geco.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"demolitions_tier_4_unlocked"
	}
end

-- Lines 297-321
function WeaponSkillsTweakData:_init_thompson_skill_tree()
	self.skill_trees.thompson = {
		{}
	}
	self.skill_trees.thompson[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.thompson[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.thompson[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_collect_ammo_completed",
			challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
			challenge_tasks = {
				{
					target = 1000,
					type = ChallengeTweakData.TASK_COLLECT_AMMO,
					reminders = {
						450,
						900
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_thompson_m_short_double"
			}
		}
	}
	self.skill_trees.thompson[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 3000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							2000,
							2750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_m_standard"
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_fg_m1928"
				}
			}
		}
	}
	self.skill_trees.thompson[3] = {
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_ns_cutts"
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 6000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							2000,
							4000,
							5750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_m_standard_double"
				}
			}
		},
		{
			{
				cost = 6,
				value = 3,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_body_m1928",
					"wpn_fps_smg_thompson_dh_m1928"
				}
			}
		}
	}
	self.skill_trees.thompson[4] = {
		{
			{
				cost = 4,
				value = 4,
				challenge_done_text_id = "weapon_skill_kill_flamers_completed",
				challenge_briefing_id = "weapon_skill_kill_flamers_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 30,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							10,
							20
						},
						modifiers = {
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_FLAMER
							}
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 4,
				challenge_done_text_id = "weapon_skill_hip_fire_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							50,
							80
						},
						modifiers = {
							headshot = true,
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_b_m1928"
				}
			}
		},
		{
			{
				cost = 6,
				value = 5,
				challenge_done_text_id = "weapon_skill_last_round_kill_completed",
				challenge_briefing_id = "weapon_skill_last_round_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							80,
							160,
							220
						},
						modifiers = {
							last_round_in_magazine = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_m_drum"
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_headshot_ss_completed",
				challenge_briefing_id = "weapon_skill_headshot_ss_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							40
						},
						modifiers = {
							headshot = true,
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_COMMANDER
							},
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_thompson_o_m1928"
				}
			}
		}
	}
	self.skill_trees.thompson.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"infiltrator_tier_4_unlocked"
	}
end

-- Lines 324-338
function WeaponSkillsTweakData:_init_mp38_skill_tree()
	self.skill_trees.mp38 = {
		{}
	}
	self.skill_trees.mp38[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.mp38[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_mp38_dh_curved"
			}
		}
	}
	self.skill_trees.mp38[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_mp38_b_compensated"
			}
		}
	}
	self.skill_trees.mp38[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_mp38_s_wooden"
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_mp38_b_fluted"
				}
			}
		},
		{
			{
				cost = 6,
				value = 5,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 3000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							2000,
							2750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_mp38_m_standard_double"
				}
			}
		}
	}
	self.skill_trees.mp38.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 341-355
function WeaponSkillsTweakData:_init_sterling_skill_tree()
	self.skill_trees.sterling = {
		{}
	}
	self.skill_trees.sterling[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.sterling[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_collect_ammo_completed",
			challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
			challenge_tasks = {
				{
					target = 1000,
					type = ChallengeTweakData.TASK_COLLECT_AMMO,
					reminders = {
						400,
						800
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_sterling_m_long"
			}
		}
	}
	self.skill_trees.sterling[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.sterling[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sterling_b_long"
				}
			}
		},
		{
			{
				cost = 6,
				value = 5,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 3000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							2000,
							2750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sterling_m_long_double"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		}
	}
	self.skill_trees.sterling.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 358-383
function WeaponSkillsTweakData:_init_sten_skill_tree()
	self.skill_trees.sten = {
		{}
	}
	self.skill_trees.sten[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_sten_s_wooden"
			}
		}
	}
	self.skill_trees.sten[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.sten[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_sten_body_mk3"
			}
		}
	}
	self.skill_trees.sten[1][4] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_collect_ammo_completed",
			challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
			challenge_tasks = {
				{
					target = 1000,
					type = ChallengeTweakData.TASK_COLLECT_AMMO,
					reminders = {
						400,
						800
					}
				}
			},
			weapon_parts = {
				"wpn_fps_smg_sten_m_standard"
			}
		}
	}
	self.skill_trees.sten[2] = {
		{
			{
				cost = 1,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_ns_slanted"
				}
			}
		},
		{
			{
				cost = 1,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 1,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_fg_wooden"
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 3000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							2000,
							2750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_m_standard_double"
				}
			}
		}
	}
	self.skill_trees.sten[3] = {
		{
			{
				cost = 1,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_g_wooden"
				}
			}
		},
		{
			{
				cost = 1,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 1,
				value = 3,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_o_lee_enfield"
				}
			}
		},
		{
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 6000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							2000,
							4000,
							5750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_m_long"
				}
			}
		}
	}
	self.skill_trees.sten[4] = {
		{
			{
				cost = 1,
				value = 4,
				challenge_done_text_id = "weapon_skill_hip_fire_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							50,
							80
						},
						modifiers = {
							headshot = true,
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 1,
				value = 4,
				challenge_done_text_id = "weapon_skill_kill_flamers_completed",
				challenge_briefing_id = "weapon_skill_kill_flamers_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 30,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							10,
							20
						},
						modifiers = {
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_FLAMER
							}
						}
					}
				}
			}
		},
		{
			{
				cost = 1,
				value = 4,
				challenge_done_text_id = "weapon_skill_headshot_ss_completed",
				challenge_briefing_id = "weapon_skill_headshot_ss_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							40
						},
						modifiers = {
							headshot = true,
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_COMMANDER
							},
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_body_mk3_vented"
				}
			}
		},
		{
			{
				cost = 6,
				value = 5,
				challenge_done_text_id = "weapon_skill_last_round_kill_completed",
				challenge_briefing_id = "weapon_skill_last_round_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							80,
							160,
							220
						},
						modifiers = {
							last_round_in_magazine = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_smg_sten_m_long_double"
				}
			}
		}
	}
	self.skill_trees.sten.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"infiltrator_tier_4_unlocked"
	}
end

-- Lines 386-399
function WeaponSkillsTweakData:_init_m1903_skill_tree()
	self.skill_trees.m1903 = {
		{}
	}
	self.skill_trees.m1903[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_kill_beyond_range_completed",
			challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						min_range = 2000,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_snp_m1903_body_type_c"
			}
		}
	}
	self.skill_trees.m1903[1][2] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.m1903[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
				challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							min_range = 3000,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_snp_m1903_s_cheek_rest"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_snp_m1903_ns_mclean"
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 1,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							250,
							500
						}
					}
				},
				weapon_parts = {
					"wpn_fps_snp_m1903_m_extended"
				}
			}
		}
	}
	self.skill_trees.m1903.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 402-414
function WeaponSkillsTweakData:_init_mosin_skill_tree()
	self.skill_trees.mosin = {
		{}
	}
	self.skill_trees.mosin[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
			challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						min_range = 2000,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_snp_mosin_body_grip"
			}
		}
	}
	self.skill_trees.mosin[1][2] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.mosin[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
				challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							min_range = 3000,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_snp_mosin_body_target"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_snp_mosin_b_long"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		}
	}
	self.skill_trees.mosin.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 417-439
function WeaponSkillsTweakData:_init_garand_skill_tree()
	self.skill_trees.garand = {
		{}
	}
	self.skill_trees.garand[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.garand[1][2] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
			challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						min_range = 2000,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_ass_garand_s_cheek_rest"
			}
		}
	}
	self.skill_trees.garand[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
				challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							min_range = 2000,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		}
	}
	self.skill_trees.garand[3] = {
		{
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
				challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							min_range = 2500,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_ns_conical"
				}
			}
		},
		{
			{
				cost = 6,
				value = 1,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 2400,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							1500,
							2000
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_m_bar_standard"
				}
			}
		}
	}
	self.skill_trees.garand[4] = {
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_kill_flamers_completed",
				challenge_briefing_id = "weapon_skill_kill_flamers_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 30,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							10,
							20
						},
						modifiers = {
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_FLAMER
							}
						}
					}
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_headshots_beyond_range_completed",
				challenge_briefing_id = "weapon_skill_headshots_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							50,
							80
						},
						modifiers = {
							min_range = 2500,
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_b_tanker"
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_headshot_ss_completed",
				challenge_briefing_id = "weapon_skill_headshot_ss_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							40
						},
						modifiers = {
							headshot = true,
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_COMMANDER
							},
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_s_folding"
				}
			}
		},
		{
			{
				cost = 8,
				value = 2,
				challenge_done_text_id = "weapon_skill_last_round_kill_completed",
				challenge_briefing_id = "weapon_skill_last_round_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							80,
							160,
							220
						},
						modifiers = {
							last_round_in_magazine = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_m_bar_extended"
				}
			}
		}
	}
	self.skill_trees.garand.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"assault_tier_4_unlocked"
	}
end

-- Lines 442-464
function WeaponSkillsTweakData:_init_garand_golden_skill_tree()
	self.skill_trees.garand_golden = {
		{}
	}
	self.skill_trees.garand_golden[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.garand_golden[1][2] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
			challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						min_range = 2000,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_ass_garand_s_cheek_rest"
			}
		}
	}
	self.skill_trees.garand_golden[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
				challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							min_range = 2000,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		}
	}
	self.skill_trees.garand_golden[3] = {
		{
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_kill_beyond_range_briefing",
				challenge_briefing_id = "weapon_skill_kill_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							min_range = 2500,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_golden_ns_conical"
				}
			}
		},
		{
			{
				cost = 6,
				value = 1,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 2400,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							1500,
							2000
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_golden_m_bar_standard"
				}
			}
		}
	}
	self.skill_trees.garand_golden[4] = {
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_kill_flamers_completed",
				challenge_briefing_id = "weapon_skill_kill_flamers_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 30,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							10,
							20
						},
						modifiers = {
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_FLAMER
							}
						}
					}
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_headshots_beyond_range_completed",
				challenge_briefing_id = "weapon_skill_headshots_beyond_range_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							50,
							80
						},
						modifiers = {
							min_range = 2500,
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_golden_b_tanker"
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_headshot_ss_completed",
				challenge_briefing_id = "weapon_skill_headshot_ss_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							40
						},
						modifiers = {
							headshot = true,
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_COMMANDER
							},
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_golden_s_folding"
				}
			}
		},
		{
			{
				cost = 8,
				value = 2,
				challenge_done_text_id = "weapon_skill_last_round_kill_completed",
				challenge_briefing_id = "weapon_skill_last_round_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 250,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							80,
							160,
							220
						},
						modifiers = {
							last_round_in_magazine = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_garand_golden_m_bar_extended"
				}
			}
		}
	}
	self.skill_trees.garand_golden.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"assault_tier_4_unlocked"
	}
end

-- Lines 467-481
function WeaponSkillsTweakData:_init_m1918_skill_tree()
	self.skill_trees.m1918 = {
		{}
	}
	self.skill_trees.m1918[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_lmg_m1918_ns_cutts"
			}
		}
	}
	self.skill_trees.m1918[1][2] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.m1918[1][3] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_lmg_m1918_g_monitor"
			}
		}
	}
	self.skill_trees.m1918[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_lmg_m1918_carry_handle"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 3,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_lmg_m1918_bipod"
				}
			}
		},
		{
			{
				cost = 6,
				value = 4,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 3000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							750,
							1500,
							2750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_lmg_m1918_m_extended"
				}
			}
		}
	}
	self.skill_trees.m1918.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 484-501
function WeaponSkillsTweakData:_init_mg42_skill_tree()
	self.skill_trees.mg42 = {
		{}
	}
	self.skill_trees.mg42[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.mg42[1][2] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_lmg_mg42_b_mg34",
				"wpn_fps_lmg_mg42_n34"
			}
		}
	}
	self.skill_trees.mg42[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_lmg_mg42_dh_mg34"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		}
	}
	self.skill_trees.mg42[3] = {
		{
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_lmg_mg42_bipod"
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 6,
				value = 5,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 6000,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							2000,
							4000,
							5750
						}
					}
				},
				weapon_parts = {
					"wpn_fps_lmg_mg42_m_double",
					"wpn_fps_lmg_mg42_lid_mg34"
				}
			}
		}
	}
	self.skill_trees.mg42.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 504-518
function WeaponSkillsTweakData:_init_mp44_skill_tree()
	self.skill_trees.mp44 = {
		{}
	}
	self.skill_trees.mp44[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.mp44[1][2] = {
		{
			cost = 2,
			value = 1,
			challenge_done_text_id = "weapon_skill_collect_ammo_completed",
			challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
			challenge_tasks = {
				{
					target = 750,
					type = ChallengeTweakData.TASK_COLLECT_AMMO,
					reminders = {
						250,
						500,
						700
					}
				}
			},
			weapon_parts = {
				"wpn_fps_ass_mp44_m_short_double"
			}
		}
	}
	self.skill_trees.mp44[1][3] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			}
		}
	}
	self.skill_trees.mp44[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 4,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 2250,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							750,
							1500,
							2000
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_mp44_m_standard_double"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_mp44_o_scope"
				}
			}
		}
	}
	self.skill_trees.mp44.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 521-541
function WeaponSkillsTweakData:_init_m1912_skill_tree()
	self.skill_trees.m1912 = {
		{}
	}
	self.skill_trees.m1912[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
			challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
			challenge_tasks = {
				{
					target = 250,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						80,
						160,
						220
					},
					modifiers = {
						hip_fire = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_sho_m1912_s_cheek_rest"
			}
		}
	}
	self.skill_trees.m1912[1][2] = {
		{
			cost = 2,
			value = 5,
			challenge_done_text_id = "weapon_skill_headshot_kill_completed",
			challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
			challenge_tasks = {
				{
					target = 50,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						25,
						40
					},
					modifiers = {
						headshot = true,
						damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
					}
				}
			},
			weapon_parts = {
				"wpn_fps_sho_m1912_fg_long"
			}
		}
	}
	self.skill_trees.m1912[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_m1912_ns_cutts"
				}
			}
		},
		{
			{
				cost = 2,
				value = 6,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							40,
							70,
							90
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_m1912_b_long"
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		}
	}
	self.skill_trees.m1912[3] = {
		{
			{
				cost = 3,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_m1912_s_pad"
				}
			}
		},
		{
			{
				cost = 4,
				value = 7,
				challenge_done_text_id = "weapon_skill_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 150,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							50,
							100,
							130
						},
						modifiers = {
							headshot = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_m1912_b_short"
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		}
	}
	self.skill_trees.m1912[4] = {
		{
			{
				cost = 3,
				value = 4,
				challenge_done_text_id = "weapon_skill_hip_fire_headshot_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_headshot_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 100,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							50,
							80
						},
						modifiers = {
							headshot = true,
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_m1912_s_pistol_grip"
				}
			}
		},
		{
			{
				cost = 4,
				value = 8,
				challenge_done_text_id = "weapon_skill_headshot_ss_completed",
				challenge_briefing_id = "weapon_skill_headshot_ss_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_TIGHTER_SPREAD,
				challenge_tasks = {
					{
						target = 50,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							20,
							40
						},
						modifiers = {
							headshot = true,
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_COMMANDER
							},
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_sho_m1912_b_heat_shield"
				}
			}
		},
		{
			{
				cost = 4,
				value = 4,
				challenge_done_text_id = "weapon_skill_kill_flamers_completed",
				challenge_briefing_id = "weapon_skill_kill_flamers_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 30,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							10,
							20
						},
						modifiers = {
							enemy_type = {
								CharacterTweakData.SPECIAL_UNIT_TYPE_FLAMER
							}
						}
					}
				}
			}
		}
	}
	self.skill_trees.m1912.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"demolitions_tier_4_unlocked"
	}
end

-- Lines 543-557
function WeaponSkillsTweakData:_init_carbine_skill_tree()
	self.skill_trees.carbine = {
		{}
	}
	self.skill_trees.carbine[1][1] = {
		{
			cost = 1,
			value = 1,
			challenge_done_text_id = "weapon_skill_generic_kill_completed",
			challenge_briefing_id = "weapon_skill_generic_kill_briefing",
			skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
			challenge_tasks = {
				{
					target = 500,
					type = ChallengeTweakData.TASK_KILL_ENEMIES,
					reminders = {
						125,
						250,
						375,
						450
					}
				}
			}
		}
	}
	self.skill_trees.carbine[2] = {
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1000,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							250,
							500,
							750,
							900
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 2,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							100,
							250,
							400,
							450
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_carbine_body_wooden"
				}
			}
		}
	}
	self.skill_trees.carbine[3] = {
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_generic_kill_completed",
				challenge_briefing_id = "weapon_skill_generic_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_DAMAGE,
				challenge_tasks = {
					{
						target = 1500,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							375,
							750,
							1125,
							1400
						}
					}
				}
			}
		},
		{
			{
				cost = 2,
				value = 3,
				challenge_done_text_id = "weapon_skill_hip_fire_kill_completed",
				challenge_briefing_id = "weapon_skill_hip_fire_kill_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_DECREASE_RECOIL,
				challenge_tasks = {
					{
						target = 750,
						type = ChallengeTweakData.TASK_KILL_ENEMIES,
						reminders = {
							200,
							400,
							600,
							700
						},
						modifiers = {
							hip_fire = true,
							damage_type = WeaponTweakData.DAMAGE_TYPE_BULLET
						}
					}
				}
			}
		},
		{
			{
				cost = 4,
				value = 3,
				challenge_done_text_id = "weapon_skill_collect_ammo_completed",
				challenge_briefing_id = "weapon_skill_collect_ammo_briefing",
				skill_name = WeaponSkillsTweakData.SKILL_INCREASE_MAGAZINE,
				challenge_tasks = {
					{
						target = 4500,
						type = ChallengeTweakData.TASK_COLLECT_AMMO,
						reminders = {
							1000,
							3000,
							4000
						}
					}
				},
				weapon_parts = {
					"wpn_fps_ass_carbine_m_extended"
				}
			}
		}
	}
	self.skill_trees.carbine.tier_unlock = {
		"weapon_tier_unlocked",
		"weapon_tier_unlocked",
		"weapon_tier_unlocked"
	}
end

-- Lines 559-561
function WeaponSkillsTweakData:_init_reedem_xp_values()
	self.weapon_point_reedemed_xp = 50
end
