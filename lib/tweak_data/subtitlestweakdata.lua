SubtitlesTweakData = SubtitlesTweakData or class()

-- Lines 3-70
function SubtitlesTweakData:init()
	self:_init_intro_video()
	self:_init_debrief_success_1()
	self:_init_debrief_success_2()
	self:_init_debrief_success_3()
	self:_init_debrief_success_4()
	self:_init_debrief_success_5()
	self:_init_debrief_success_6()
	self:_init_debrief_success_7()
	self:_init_debrief_success_8()
	self:_init_debrief_success_9()
	self:_init_debrief_success_10()
	self:_init_debrief_success_11()
	self:_init_debrief_success_12()
	self:_init_debrief_success_13()
	self:_init_debrief_success_14()
	self:_init_debrief_failure_1()
	self:_init_debrief_failure_2()
	self:_init_debrief_failure_3()
	self:_init_debrief_failure_4()
	self:_init_debrief_failure_5()
	self:_init_debrief_failure_6()
	self:_init_debrief_failure_7()
	self:_init_debrief_failure_8()
	self:_init_debrief_failure_9()
	self:_init_debrief_failure_10()
	self:_init_debrief_failure_11()
end

-- Lines 74-92
function SubtitlesTweakData:get_subtitle(movie, time)
	local split_movie_path = string.split(movie, "/")
	local movie_name = split_movie_path[#split_movie_path]
	local subtitle_data = self[movie_name]

	if not subtitle_data then
		Application:error("[SubtitlesTweakData][get_subtitle] Movie ", movie, " not in SubtitlesTweakData")

		return
	end

	for _, subtitle in ipairs(subtitle_data) do
		if subtitle.time < time and time < subtitle.time + subtitle.length then
			return managers.localization:text(subtitle.id)
		end
	end

	return ""
end

-- Lines 182-266
function SubtitlesTweakData:_init_intro_video()
	self["01_intro_v014"] = {
		{
			id = "01_intro_001",
			time = 6,
			length = 3
		},
		{
			id = "01_intro_002",
			time = 9,
			length = 4
		},
		{
			id = "01_intro_003",
			time = 13,
			length = 4
		},
		{
			id = "01_intro_004",
			time = 20,
			length = 4
		},
		{
			id = "01_intro_005",
			time = 24,
			length = 4
		},
		{
			id = "01_intro_006",
			time = 30,
			length = 4
		},
		{
			id = "01_intro_007",
			time = 35,
			length = 4
		},
		{
			id = "01_intro_008",
			time = 38,
			length = 4
		},
		{
			id = "01_intro_009",
			time = 45,
			length = 4
		},
		{
			id = "01_intro_0010",
			time = 47,
			length = 4
		},
		{
			id = "01_intro_0011",
			time = 51,
			length = 4
		},
		{
			id = "01_intro_0012",
			time = 57,
			length = 4
		},
		{
			id = "01_intro_0013",
			time = 63,
			length = 4
		},
		{
			id = "01_intro_0014",
			time = 70,
			length = 4
		},
		{
			id = "01_intro_0015",
			time = 77,
			length = 4
		},
		{
			id = "01_intro_0016",
			time = 83,
			length = 4
		}
	}
end

-- Lines 494-502
function SubtitlesTweakData:_init_debrief_success_1()
	self.s_01_throws_himself_v007 = {
		{
			id = "s_01_throws_himself_001",
			time = 9.05,
			length = 4
		}
	}
end

-- Lines 504-522
function SubtitlesTweakData:_init_debrief_success_2()
	self.s_02_chickens_out_v007 = {
		{
			id = "S_02_Chickens_out_001",
			time = 1,
			length = 4
		},
		{
			id = "S_02_Chickens_out_002",
			time = 3.02,
			length = 4
		},
		{
			id = "S_02_Chickens_out_003",
			time = 20.07,
			length = 4
		}
	}
end

-- Lines 524-542
function SubtitlesTweakData:_init_debrief_success_3()
	self.s_03_salutes_v006 = {
		{
			id = "S_03_salutes_001",
			time = 1,
			length = 4
		},
		{
			id = "S_03_salutes_002",
			time = 16,
			length = 4
		},
		{
			id = "S_03_salutes_003",
			time = 18.1,
			length = 4
		}
	}
end

-- Lines 544-552
function SubtitlesTweakData:_init_debrief_success_4()
	self.s_04_shoots_and_miss_v008 = {
		{
			id = "S_04_Shoots_and_miss_001",
			time = 1,
			length = 4
		}
	}
end

-- Lines 554-577
function SubtitlesTweakData:_init_debrief_success_5()
	self.s_05_crunches_bones_v006 = {
		{
			id = "S_05_Crunches_bones_001",
			time = 1,
			length = 4
		},
		{
			id = "S_05_Crunches_bones_002",
			time = 3.2,
			length = 4
		},
		{
			id = "S_05_Crunches_bones_003",
			time = 7.01,
			length = 4
		},
		{
			id = "S_05_Crunches_bones_004",
			time = 17,
			length = 4
		}
	}
end

-- Lines 579-597
function SubtitlesTweakData:_init_debrief_success_6()
	self.s_06_plays_with_tin_men_v006 = {
		{
			id = "S_06_Plays_with_tin_men_001",
			time = 3.14,
			length = 4
		},
		{
			id = "S_06_Plays_with_tin_men_002",
			time = 8.13,
			length = 4
		},
		{
			id = "S_06_Plays_with_tin_men_003",
			time = 13.21,
			length = 4
		}
	}
end

-- Lines 599-602
function SubtitlesTweakData:_init_debrief_success_7()
	self.s_07_cries_tannenbaum_v007 = {}
end

-- Lines 604-617
function SubtitlesTweakData:_init_debrief_success_8()
	self.s_08_chess_v008 = {
		{
			id = "S_08_Chess_001",
			time = 4.07,
			length = 4
		},
		{
			id = "S_08_Chess_002",
			time = 15.21,
			length = 4
		}
	}
end

-- Lines 619-637
function SubtitlesTweakData:_init_debrief_success_9()
	self.s_09_is_having_a_reverie_v007 = {
		{
			id = "S_09_is_having_a_reverie_001",
			time = 1,
			length = 4
		},
		{
			id = "S_09_is_having_a_reverie_002",
			time = 2.08,
			length = 4
		},
		{
			id = "S_09_is_having_a_reverie_003",
			time = 17.18,
			length = 4
		}
	}
end

-- Lines 639-642
function SubtitlesTweakData:_init_debrief_success_10()
	self.s_10_colours_a_map_v009 = {}
end

-- Lines 644-652
function SubtitlesTweakData:_init_debrief_success_11()
	self.s_11_swears_v005 = {
		{
			id = "S_11_swears_001",
			time = 8.03,
			length = 4
		}
	}
end

-- Lines 654-662
function SubtitlesTweakData:_init_debrief_success_12()
	self.s_12_plays_with_tanks_v005 = {
		{
			id = "S_12_plays_with_tanks_001",
			time = 15.14,
			length = 4
		}
	}
end

-- Lines 664-677
function SubtitlesTweakData:_init_debrief_success_13()
	self.s_13_flips_a_table_v007 = {
		{
			id = "S_13_flips_a_table_001",
			time = 10.22,
			length = 4
		},
		{
			id = "S_13_flips_a_table_002",
			time = 12.17,
			length = 4
		}
	}
end

-- Lines 679-687
function SubtitlesTweakData:_init_debrief_success_14()
	self.s_14_moustache_v006 = {
		{
			id = "S_14_moustache_001",
			time = 8.05,
			length = 4
		}
	}
end

-- Lines 866-869
function SubtitlesTweakData:_init_debrief_failure_1()
	self.f_01_edelweiss_v007 = {}
end

-- Lines 871-874
function SubtitlesTweakData:_init_debrief_failure_2()
	self.f_02_sizzles_v007 = {}
end

-- Lines 876-884
function SubtitlesTweakData:_init_debrief_failure_3()
	self.f_03_toasts_v008 = {
		{
			id = "F_03_toasts_001",
			time = 5.04,
			length = 4
		}
	}
end

-- Lines 886-894
function SubtitlesTweakData:_init_debrief_failure_4()
	self.f_04_misunderstands_v008 = {
		{
			id = "F_04_misunderstands_001",
			time = 1,
			length = 4
		}
	}
end

-- Lines 896-909
function SubtitlesTweakData:_init_debrief_failure_5()
	self.f_05_hugs_the_world_v008 = {
		{
			id = "F_05_hugs_the_world_001",
			time = 1.12,
			length = 4
		},
		{
			id = "F_05_hugs_the_world_002",
			time = 17.04,
			length = 4
		}
	}
end

-- Lines 911-919
function SubtitlesTweakData:_init_debrief_failure_6()
	self.f_06_tin_soldiers_v008 = {
		{
			id = "F_06_tin_soldiers_001",
			time = 11,
			length = 4
		}
	}
end

-- Lines 921-944
function SubtitlesTweakData:_init_debrief_failure_7()
	self.f_07_told_you_so_v008 = {
		{
			id = "F_07_told_you_so_001",
			time = 1,
			length = 4
		},
		{
			id = "F_07_told_you_so_002",
			time = 6.04,
			length = 4
		},
		{
			id = "F_07_told_you_so_003",
			time = 9.18,
			length = 4
		},
		{
			id = "F_07_told_you_so_004",
			time = 16.17,
			length = 4
		}
	}
end

-- Lines 946-949
function SubtitlesTweakData:_init_debrief_failure_8()
	self.f_08_pumps_his_fists_v008 = {}
end

-- Lines 951-959
function SubtitlesTweakData:_init_debrief_failure_9()
	self.f_09_bras_dhonneur_v008 = {
		{
			id = "F_09_bras_dhonneur_001",
			time = 1,
			length = 4
		}
	}
end

-- Lines 961-974
function SubtitlesTweakData:_init_debrief_failure_10()
	self.f_10_executes_v008 = {
		{
			id = "F_10_executes_001",
			time = 9.01,
			length = 4
		},
		{
			id = "F_10_executes_002",
			time = 12.09,
			length = 4
		}
	}
end

-- Lines 976-989
function SubtitlesTweakData:_init_debrief_failure_11()
	self.f_11_sings_v007 = {
		{
			id = "F_11_sings_001",
			time = 4.22,
			length = 4
		},
		{
			id = "F_11_sings_002",
			time = 10.21,
			length = 4
		}
	}
end