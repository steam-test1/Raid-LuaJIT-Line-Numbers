RaidGUIItemAvailabilityFlag = RaidGUIItemAvailabilityFlag or {}
RaidGUIItemAvailabilityFlag.ALWAYS_HIDE = "always_hide"
RaidGUIItemAvailabilityFlag.CAN_SAVE_GAME = "can_save_game"
RaidGUIItemAvailabilityFlag.CUSTOMIZE_CONTROLLER_ENABLED = "customize_controller_enabled"
RaidGUIItemAvailabilityFlag.DEBUG_MENU_ENABLED = "debug_menu_enabled"
RaidGUIItemAvailabilityFlag.HAS_INSTALLED_MODS = "has_installed_mods"
RaidGUIItemAvailabilityFlag.IS_CASH_SAFE_BACK_VISIBLE = "is_cash_safe_back_visible"
RaidGUIItemAvailabilityFlag.IS_FULLSCREEN = "is_fullscreen"
RaidGUIItemAvailabilityFlag.IS_IN_CAMP = "is_in_camp"
RaidGUIItemAvailabilityFlag.IS_MULTIPLAYER = "is_multiplayer"
RaidGUIItemAvailabilityFlag.IS_SINGLEPLAYER = "is_singleplayer"
RaidGUIItemAvailabilityFlag.IS_NOT_EDITOR = "is_not_editor"
RaidGUIItemAvailabilityFlag.IS_NOT_IN_CAMP = "is_not_in_camp"
RaidGUIItemAvailabilityFlag.IS_NOT_MULTIPLAYER = "is_not_multiplayer"
RaidGUIItemAvailabilityFlag.IS_NOT_PC_CONTROLLER = "is_not_pc_controller"
RaidGUIItemAvailabilityFlag.IS_NOT_XBOX = "is_not_xbox"
RaidGUIItemAvailabilityFlag.IS_PC_CONTROLLER = "is_pc_controller"
RaidGUIItemAvailabilityFlag.IS_SERVER = "is_server"
RaidGUIItemAvailabilityFlag.IS_WIN32 = "is_win32"
RaidGUIItemAvailabilityFlag.IS_X360 = "is_x360"
RaidGUIItemAvailabilityFlag.KICK_PLAYER_VISIBLE = "kick_player_visible"
RaidGUIItemAvailabilityFlag.KICK_VOTE_VISIBLE = "kick_vote_visible"
RaidGUIItemAvailabilityFlag.NON_OVERKILL_145 = "non_overkill_145"
RaidGUIItemAvailabilityFlag.REPUTATION_CHECK = "reputation_check"
RaidGUIItemAvailabilityFlag.RESTART_LEVEL_VISIBLE = "restart_level_visible"
RaidGUIItemAvailabilityFlag.RESTART_VOTE_VISIBLE = "restart_vote_visible"
RaidGUIItemAvailabilityFlag.SINGLEPLAYER_RESTART = "singleplayer_restart"
RaidGUIItemAvailabilityFlag.VOICE_ENABLED = "voice_enabled"
RaidGUIItemAvailabilityFlag.IS_IN_MAIN_MENU = "is_in_main_menu"
RaidGUIItemAvailabilityFlag.IS_NOT_IN_MAIN_MENU = "is_not_in_main_menu"
RaidGUIItemAvailabilityFlag.SHOULD_SHOW_TUTORIAL = "should_show_tutorial"
RaidMenuCallbackHandler = RaidMenuCallbackHandler or class(CoreMenuCallbackHandler.CallbackHandler)

-- Lines 40-43
function RaidMenuCallbackHandler:menu_options_on_click_controls()
	managers.raid_menu:open_menu("raid_menu_options_controls")
end

-- Lines 45-48
function RaidMenuCallbackHandler:menu_options_on_click_video()
	managers.raid_menu:open_menu("raid_menu_options_video")
end

-- Lines 50-53
function RaidMenuCallbackHandler:menu_options_on_click_sound()
	managers.raid_menu:open_menu("raid_menu_options_sound")
end

-- Lines 55-58
function RaidMenuCallbackHandler:menu_options_on_click_network()
	managers.raid_menu:open_menu("raid_menu_options_network")
end

-- Lines 60-94
function RaidMenuCallbackHandler:menu_options_on_click_default()
	local params = {
		title = managers.localization:text("dialog_reset_all_options_title"),
		message = managers.localization:text("dialog_reset_all_options_message"),
		callback = function ()
			managers.user:reset_controls_setting_map()
			managers.controller:load_settings("settings/controller_settings")
			managers.controller:clear_user_mod("normal", MenuCustomizeControllerCreator.CONTROLS_INFO)
			managers.user:reset_video_setting_map()
			managers.menu:active_menu().callback_handler:set_fullscreen_default_raid_no_dialog()

			local resolution = Vector3(tweak_data.gui.base_resolution.x, tweak_data.gui.base_resolution.y, tweak_data.gui.base_resolution.z)

			managers.menu:active_menu().callback_handler:set_resolution_default_raid_no_dialog(resolution)
			managers.menu:active_menu().callback_handler:_refresh_brightness()
			managers.user:reset_advanced_video_setting_map()

			RenderSettings.texture_quality_default = "high"
			RenderSettings.shadow_quality_default = "high"
			RenderSettings.max_anisotropy = 16
			RenderSettings.v_sync = false

			managers.menu:active_menu().callback_handler:apply_and_save_render_settings()
			managers.menu:active_menu().callback_handler:_refresh_brightness()
			managers.user:reset_sound_setting_map()
			managers.menu:active_menu().callback_handler:_reset_mainmusic()
			managers.user:reset_network_setting_map()
		end
	}

	managers.menu:show_option_dialog(params)
end

-- Lines 96-114
function RaidMenuCallbackHandler:menu_options_on_click_reset_progress()
	local dialog_data = {
		title = managers.localization:text("dialog_warning_title"),
		text = managers.localization:text("dialog_are_you_sure_you_want_to_clear_progress")
	}
	local yes_button = {
		text = managers.localization:text("dialog_yes"),
		callback_func = callback(self, self, "_dialog_clear_progress_yes")
	}
	local no_button = {
		text = managers.localization:text("dialog_no"),
		class = RaidGUIControlButtonShortSecondary
	}
	dialog_data.button_list = {
		yes_button,
		no_button
	}

	managers.system_menu:show(dialog_data)
end

-- Lines 116-129
function RaidMenuCallbackHandler:_dialog_clear_progress_yes()
	if game_state_machine:current_state_name() == "menu_main" then
		managers.savefile:clear_progress_data()
	else
		Global.reset_progress = true

		MenuCallbackHandler:_dialog_end_game_yes()
	end
end

-- Lines 131-133
function RaidMenuCallbackHandler:init()
	RaidMenuCallbackHandler.super.init(self)
end

-- Lines 135-137
function RaidMenuCallbackHandler:debug_menu_enabled()
	return managers.menu:debug_menu_enabled()
end

-- Lines 139-141
function RaidMenuCallbackHandler:is_in_camp()
	return managers.raid_job:is_camp_loaded()
end

-- Lines 143-145
function RaidMenuCallbackHandler:is_not_in_camp()
	return not managers.raid_job:is_camp_loaded()
end

-- Lines 147-149
function RaidMenuCallbackHandler:is_not_editor()
	return not Application:editor()
end

-- Lines 151-153
function RaidMenuCallbackHandler:on_multiplayer_clicked()
	managers.raid_menu:open_menu("mission_join_menu")
end

-- Lines 155-157
function RaidMenuCallbackHandler:on_select_character_profile_clicked()
	managers.raid_menu:open_menu("profile_selection_menu")
end

-- Lines 159-161
function RaidMenuCallbackHandler:on_weapon_select_clicked()
	managers.raid_menu:open_menu("raid_menu_weapon_select")
end

-- Lines 163-165
function RaidMenuCallbackHandler:on_select_character_skills_clicked()
	managers.raid_menu:open_menu("raid_menu_xp")
end

-- Lines 167-169
function RaidMenuCallbackHandler:on_select_challenge_cards_view_clicked()
	managers.raid_menu:open_menu("challenge_cards_view_menu")
end

-- Lines 171-173
function RaidMenuCallbackHandler:on_mission_selection_clicked()
	managers.raid_menu:open_menu("mission_selection_menu")
end

-- Lines 175-177
function RaidMenuCallbackHandler:on_options_clicked()
	managers.raid_menu:open_menu("raid_options_menu")
end

-- Lines 179-181
function RaidMenuCallbackHandler:on_gold_asset_store_clicked()
	managers.raid_menu:open_menu("gold_asset_store_menu")
end

-- Lines 183-187
function RaidMenuCallbackHandler:show_credits()
	RaidMenuCreditsGui.FILE = nil
	RaidMenuCreditsGui.INTRO_VIDEO = "movies/vanilla/credits/05_credits_v003"

	managers.raid_menu:open_menu("raid_credits_menu")
end

-- Lines 189-206
function RaidMenuCallbackHandler:end_game()
	local dialog_data = {
		title = managers.localization:text("dialog_warning_title"),
		text = managers.localization:text("dialog_are_you_sure_you_want_to_leave_game")
	}
	local yes_button = {
		text = managers.localization:text("dialog_yes"),
		callback_func = callback(self, self, "_dialog_end_game_yes")
	}
	local no_button = {
		text = managers.localization:text("dialog_no"),
		callback_func = callback(self, self, "_dialog_end_game_no"),
		class = RaidGUIControlButtonShortSecondary,
		cancel_button = true
	}
	dialog_data.button_list = {
		yes_button,
		no_button
	}

	managers.system_menu:show(dialog_data)
end

-- Lines 208-211
function RaidMenuCallbackHandler:_dialog_end_game_yes()
	setup.exit_to_main_menu = true

	setup:quit_to_main_menu()
end

-- Lines 213-214
function RaidMenuCallbackHandler:_dialog_end_game_no()
end

-- Lines 216-218
function RaidMenuCallbackHandler:debug_camp()
	managers.menu:open_node("debug_camp")
end

-- Lines 220-222
function RaidMenuCallbackHandler:debug_ingame()
	managers.menu:open_node("debug_ingame")
end

-- Lines 224-226
function RaidMenuCallbackHandler:debug_main()
	managers.menu:open_node("debug")
end

-- Lines 228-241
function RaidMenuCallbackHandler:singleplayer_restart()
	local visible = true
	local state = game_state_machine:current_state_name()
	visible = visible and state ~= "menu_main"
	visible = visible and not managers.raid_job:is_camp_loaded()
	visible = visible and not managers.raid_job:is_in_tutorial()
	visible = visible and self:is_singleplayer()
	visible = visible and self:has_full_game()

	return visible
end

-- Lines 243-245
function RaidMenuCallbackHandler:is_singleplayer()
	return Global.game_settings.single_player
end

-- Lines 247-249
function RaidMenuCallbackHandler:has_full_game()
	return managers.dlc:has_full_game()
end

-- Lines 251-253
function RaidMenuCallbackHandler:always_hide()
	return false
end

-- Lines 255-257
function RaidMenuCallbackHandler:is_server()
	return Network:is_server()
end

-- Lines 259-261
function RaidMenuCallbackHandler:is_multiplayer()
	return not Global.game_settings.single_player
end

-- Lines 263-265
function RaidMenuCallbackHandler:kick_player_visible()
	return self:is_server() and self:is_multiplayer() and managers.platform:presence() ~= "Mission_end" and managers.vote:option_host_kick()
end

-- Lines 267-269
function RaidMenuCallbackHandler:kick_vote_visible()
	return self:is_multiplayer() and managers.platform:presence() ~= "Mission_end" and managers.vote:option_vote_kick()
end

-- Lines 271-273
function RaidMenuCallbackHandler:voice_enabled()
	return self:is_ps3() or self:is_win32() and managers.network and managers.network.voice_chat and managers.network.voice_chat:enabled()
end

-- Lines 275-277
function RaidMenuCallbackHandler:is_in_main_menu()
	return game_state_machine:current_state_name() == "menu_main"
end

-- Lines 279-281
function RaidMenuCallbackHandler:is_not_in_main_menu()
	return game_state_machine:current_state_name() ~= "menu_main"
end

-- Lines 284-286
function RaidMenuCallbackHandler:should_show_tutorial()
	return game_state_machine:current_state_name() == "menu_main" and managers.raid_job:played_tutorial()
end

-- Lines 288-290
function RaidMenuCallbackHandler:is_ps3()
	return SystemInfo:platform() == Idstring("PS3")
end

-- Lines 292-294
function RaidMenuCallbackHandler:is_win32()
	return SystemInfo:platform() == Idstring("WIN32")
end

-- Lines 296-298
function RaidMenuCallbackHandler:restart_vote_visible()
	return self:_restart_level_visible() and managers.vote:option_vote_restart()
end

-- Lines 300-303
function RaidMenuCallbackHandler:restart_level_visible()
	local res = self:is_server() and self:_restart_level_visible() and managers.vote:option_host_restart()

	return res
end

-- Lines 305-312
function RaidMenuCallbackHandler:_restart_level_visible()
	if not self:is_multiplayer() or managers.raid_job:is_camp_loaded() or managers.raid_job:is_in_tutorial() then
		return false
	end

	local state = game_state_machine:current_state_name()

	return state ~= "ingame_waiting_for_players" and state ~= "ingame_lobby_menu" and state ~= "menu_main" and state ~= "empty"
end

-- Lines 314-316
function RaidMenuCallbackHandler:resume_game_raid()
	managers.raid_menu:on_escape()
end

-- Lines 318-320
function RaidMenuCallbackHandler:edit_game_settings()
	managers.menu:open_node("edit_game_settings")
end

-- Lines 323-350
function RaidMenuCallbackHandler:restart_mission(item)
	if not managers.vote:available() or managers.vote:is_restarting() then
		return
	end

	local dialog_data = {
		title = managers.localization:text("dialog_mp_restart_mission_title"),
		text = managers.localization:text(managers.vote:option_vote_restart() and "dialog_mp_restart_level_message" or "dialog_mp_restart_mission_host_message")
	}
	local yes_button = {
		text = managers.localization:text("dialog_yes"),
		callback_func = function ()
			if managers.vote:option_vote_restart() then
				managers.vote:restart_mission()
			else
				managers.vote:restart_mission_auto()
			end

			managers.raid_menu:on_escape()
		end
	}
	local no_button = {
		text = managers.localization:text("dialog_no"),
		class = RaidGUIControlButtonShortSecondary,
		cancel_button = true
	}
	dialog_data.button_list = {
		yes_button,
		no_button
	}

	managers.system_menu:show(dialog_data)
end

-- Lines 352-379
function RaidMenuCallbackHandler:restart_to_camp(item)
	if not managers.vote:available() or managers.vote:is_restarting() then
		return
	end

	local dialog_data = {
		title = managers.localization:text("dialog_mp_restart_level_title"),
		text = managers.localization:text(managers.vote:option_vote_restart() and "dialog_mp_restart_level_message" or "dialog_mp_restart_level_host_message")
	}
	local yes_button = {
		text = managers.localization:text("dialog_yes"),
		callback_func = function ()
			if managers.vote:option_vote_restart() then
				managers.vote:restart()
			else
				managers.vote:restart_auto()
			end

			managers.raid_menu:on_escape()
		end
	}
	local no_button = {
		text = managers.localization:text("dialog_no"),
		class = RaidGUIControlButtonShortSecondary,
		cancel_button = true
	}
	dialog_data.button_list = {
		yes_button,
		no_button
	}

	managers.system_menu:show(dialog_data)
end

-- Lines 381-383
function RaidMenuCallbackHandler:singleplayer_restart_mission(item)
	managers.menu:show_restart_mission_dialog({
		yes_func = RaidMenuCallbackHandler.singleplayer_restart_restart_mission_yes
	})
end

-- Lines 385-388
function RaidMenuCallbackHandler:singleplayer_restart_restart_mission_yes(item)
	Application:set_pause(false)
	managers.game_play_central:restart_the_mission()
end

-- Lines 390-392
function RaidMenuCallbackHandler:singleplayer_restart_game_to_camp(item)
	managers.menu:show_return_to_camp_dialog({
		yes_func = RaidMenuCallbackHandler.singleplayer_restart_game_to_camp_yes
	})
end

-- Lines 394-397
function RaidMenuCallbackHandler:singleplayer_restart_game_to_camp_yes(item)
	Application:set_pause(false)
	managers.game_play_central:restart_the_game()
end

-- Lines 399-406
function RaidMenuCallbackHandler:quit_game()
	self:_quit_game(managers.localization:text("dialog_are_you_sure_you_want_to_quit"))
end

-- Lines 408-410
function RaidMenuCallbackHandler:quit_game_pause_menu()
	self:_quit_game(managers.localization:text("dialog_are_you_sure_you_want_to_quit"))
end

-- Lines 412-429
function RaidMenuCallbackHandler:_quit_game(dialog_text)
	local dialog_data = {
		title = managers.localization:text("dialog_warning_title"),
		text = dialog_text
	}
	local yes_button = {
		text = managers.localization:text("dialog_yes"),
		callback_func = callback(self, self, "_dialog_quit_yes")
	}
	local no_button = {
		text = managers.localization:text("dialog_no"),
		callback_func = callback(self, self, "_dialog_quit_no"),
		class = RaidGUIControlButtonShortSecondary,
		cancel_button = true
	}
	dialog_data.button_list = {
		yes_button,
		no_button
	}

	managers.system_menu:show(dialog_data)
end

-- Lines 431-450
function RaidMenuCallbackHandler:_dialog_quit_yes()
	self:_dialog_save_progress_backup_no()
end

-- Lines 452-454
function RaidMenuCallbackHandler:_dialog_save_progress_backup_no()
	setup:quit()
end

-- Lines 456-457
function RaidMenuCallbackHandler:_dialog_quit_no()
end

-- Lines 459-463
function RaidMenuCallbackHandler:raid_play_online()
	Global.exe_argument_level = "streaming_level"
	Global.exe_argument_difficulty = Global.exe_argument_difficulty or Global.DEFAULT_DIFFICULTY

	MenuCallbackHandler:start_job({
		job_id = Global.exe_argument_level,
		difficulty = Global.exe_argument_difficulty
	})
end

-- Lines 465-481
function RaidMenuCallbackHandler:raid_play_offline()
	Global.exe_argument_level = "streaming_level"
	Global.exe_argument_difficulty = Global.exe_argument_difficulty or Global.DEFAULT_DIFFICULTY
	local mission = nil

	if managers.raid_job:played_tutorial() then
		mission = tweak_data.operations:mission_data(RaidJobManager.CAMP_ID)
	else
		mission = tweak_data.operations:mission_data(RaidJobManager.TUTORIAL_ID)
	end

	local data = {
		background = mission.loading.image,
		loading_text = mission.loading.text,
		mission = mission
	}

	managers.menu:show_loading_screen(data, callback(self, self, "_do_play_offline"))
end

-- Lines 483-486
function RaidMenuCallbackHandler:_do_play_offline()
	MenuCallbackHandler:play_single_player()
	MenuCallbackHandler:start_single_player_job({
		job_id = Global.exe_argument_level,
		difficulty = Global.exe_argument_difficulty
	})
end

-- Lines 488-492
function RaidMenuCallbackHandler:raid_play_tutorial()
	Application:debug("[RaidMenuCallbackHandler][raid_play_tutorial] Starting tutorial")
	managers.raid_job:set_temp_play_flag()
	self:raid_play_offline()
end

-- Lines 496-499
function MenuCallbackHandler:on_play_clicked()
	managers.raid_menu:open_menu("mission_selection_menu")
end

-- Lines 501-504
function MenuCallbackHandler:on_multiplayer_clicked()
	managers.raid_menu:open_menu("mission_join_menu")
end

-- Lines 506-509
function MenuCallbackHandler:on_mission_selection_clicked()
	managers.raid_menu:open_menu("mission_selection_menu")
end

-- Lines 511-514
function MenuCallbackHandler:on_select_character_profile_clicked()
	managers.raid_menu:open_menu("profile_selection_menu")
end

-- Lines 516-519
function MenuCallbackHandler:on_select_character_customization_clicked()
	managers.raid_menu:open_menu("character_customization_menu")
end

-- Lines 521-524
function MenuCallbackHandler:on_select_challenge_cards_clicked()
	managers.raid_menu:open_menu("challenge_cards_menu")
end

-- Lines 526-529
function MenuCallbackHandler:on_select_challenge_cards_view_clicked()
	managers.raid_menu:open_menu("challenge_cards_view_menu")
end

-- Lines 531-534
function MenuCallbackHandler:on_select_character_skills_clicked()
	managers.raid_menu:open_menu("raid_menu_xp")
end

-- Lines 536-539
function MenuCallbackHandler:choice_choose_raid_permission(item)
	local value = item:value()
	Global.game_settings.permission = value
end

-- Lines 541-548
function MenuCallbackHandler:choice_choose_raid_mission_zone(item)
	local value = item:value()
	Global.game_settings.raid_zone = value

	if managers.menu_component._raid_menu_mission_selection_gui then
		managers.menu_component._raid_menu_mission_selection_gui:_show_jobs()
	end
end

-- Lines 550-554
function MenuCallbackHandler:is_in_camp()
	return managers.raid_job:is_camp_loaded()
end

-- Lines 556-560
function MenuCallbackHandler:is_not_in_camp()
	return not managers.raid_job:is_camp_loaded()
end

-- Lines 564-567
function RaidMenuCallbackHandler.invite_friend()
	Application:trace("[RaidMenuCallbackHandler:invite_friend]")
end

-- Lines 571-576
function RaidMenuCallbackHandler:view_gamer_card(xuid)
	Application:trace("[RaidMenuCallbackHandler:view_gamer_card] xuid:", tostring(xuid))

	if SystemInfo:platform() == Idstring("XB1") or SystemInfo:platform() == Idstring("X360") then
		XboxLive:show_gamer_card_ui(managers.user:get_platform_id(), xuid)
	end
end

-- Lines 583-585
function MenuCallbackHandler:set_camera_sensitivity_x_raid(value)
	managers.user:set_setting("camera_sensitivity_x", value)
end

-- Lines 587-589
function MenuCallbackHandler:set_camera_sensitivity_y_raid(value)
	managers.user:set_setting("camera_sensitivity_y", value)
end

-- Lines 591-593
function MenuCallbackHandler:set_camera_zoom_sensitivity_x_raid(value)
	managers.user:set_setting("camera_zoom_sensitivity_x", value)
end

-- Lines 595-597
function MenuCallbackHandler:set_camera_zoom_sensitivity_y_raid(value)
	managers.user:set_setting("camera_zoom_sensitivity_y", value)
end

-- Lines 599-601
function MenuCallbackHandler:toggle_zoom_sensitivity_raid(value)
	managers.user:set_setting("enable_camera_zoom_sensitivity", value)
end

-- Lines 603-605
function MenuCallbackHandler:invert_camera_vertically_raid(value)
	managers.user:set_setting("invert_camera_y", value)
end

-- Lines 607-609
function MenuCallbackHandler:hold_to_steelsight_raid(value)
	managers.user:set_setting("hold_to_steelsight", value)
end

-- Lines 611-613
function MenuCallbackHandler:hold_to_run_raid(value)
	managers.user:set_setting("hold_to_run", value)
end

-- Lines 615-617
function MenuCallbackHandler:hold_to_duck_raid(value)
	managers.user:set_setting("hold_to_duck", value)
end

-- Lines 621-623
function MenuCallbackHandler:toggle_rumble(value)
	managers.user:set_setting("rumble", value)
end

-- Lines 625-627
function MenuCallbackHandler:toggle_aim_assist(value)
	managers.user:set_setting("aim_assist", value)
end

-- Lines 629-631
function MenuCallbackHandler:toggle_sticky_aim(value)
	managers.user:set_setting("sticky_aim", value)
end

-- Lines 633-635
function MenuCallbackHandler:toggle_southpaw(value)
	managers.user:set_setting("southpaw", value)
end

-- Lines 639-641
function MenuCallbackHandler:toggle_net_throttling_raid(value)
	managers.user:set_setting("net_packet_throttling", value)
end

-- Lines 643-645
function MenuCallbackHandler:toggle_net_forwarding_raid(value)
	managers.user:set_setting("net_forwarding", value)
end

-- Lines 647-649
function MenuCallbackHandler:toggle_net_use_compression_raid(value)
	managers.user:set_setting("net_use_compression", value)
end

-- Lines 653-664
function MenuCallbackHandler:set_master_volume_raid(volume)
	local old_volume = managers.user:get_setting("master_volume")

	managers.user:set_setting("master_volume", volume)
	managers.video:volume_changed(volume / 100)

	if old_volume < volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

-- Lines 666-676
function MenuCallbackHandler:set_music_volume_raid(volume)
	local old_volume = managers.user:get_setting("music_volume")

	managers.user:set_setting("music_volume", volume)

	if old_volume < volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

-- Lines 678-688
function MenuCallbackHandler:set_sfx_volume_raid(volume)
	local old_volume = managers.user:get_setting("sfx_volume")

	managers.user:set_setting("sfx_volume", volume)

	if old_volume < volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

-- Lines 690-700
function MenuCallbackHandler:set_voice_volume_raid(volume)
	local old_volume = managers.user:get_setting("voice_volume")

	managers.user:set_setting("voice_volume", volume)

	if old_volume < volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

-- Lines 702-712
function MenuCallbackHandler:set_voice_over_volume_raid(volume)
	local old_volume = managers.user:get_setting("voice_over_volume")

	managers.user:set_setting("voice_over_volume", volume)

	if old_volume < volume then
		self._sound_source:post_event("slider_increase")
	elseif volume < old_volume then
		self._sound_source:post_event("slider_decrease")
	end
end

-- Lines 714-716
function MenuCallbackHandler:toggle_voicechat_raid(value)
	managers.user:set_setting("voice_chat", value)
end

-- Lines 718-720
function MenuCallbackHandler:toggle_push_to_talk_raid(value)
	managers.user:set_setting("push_to_talk", value)
end

-- Lines 724-755
function MenuCallbackHandler:change_resolution_raid(resolution)
	local old_resolution = RenderSettings.resolution

	if resolution == old_resolution then
		return
	end

	managers.viewport:set_resolution(resolution)
	managers.viewport:set_aspect_ratio(resolution.x / resolution.y)
	managers.worldcamera:scale_worldcamera_fov(resolution.x / resolution.y)

	RenderSettings.resolution = resolution

	Application:apply_render_settings()

	local blackborder_workspace = MenuRenderer.get_blackborder_workspace_instance()

	blackborder_workspace:set_screen(resolution.x, resolution.y, 0, 0, resolution.x, resolution.y, resolution.x, resolution.y)
	managers.menu:show_accept_gfx_settings_dialog(function ()
		managers.viewport:set_resolution(old_resolution)
		managers.viewport:set_aspect_ratio(old_resolution.x / old_resolution.y)
		managers.worldcamera:scale_worldcamera_fov(old_resolution.x / old_resolution.y)

		local blackborder_workspace = MenuRenderer.get_blackborder_workspace_instance()

		blackborder_workspace:set_screen(old_resolution.x, old_resolution.y, 0, 0, old_resolution.x, old_resolution.y, old_resolution.x, old_resolution.y)
	end)
	self:_refresh_brightness()
end

-- Lines 757-768
function MenuCallbackHandler:set_resolution_default_raid_no_dialog(resolution)
	local old_resolution = RenderSettings.resolution

	if resolution == old_resolution then
		return
	end

	managers.viewport:set_resolution(resolution)
	managers.viewport:set_aspect_ratio(resolution.x / resolution.y)
	managers.worldcamera:scale_worldcamera_fov(resolution.x / resolution.y)

	local blackborder_workspace = MenuRenderer.get_blackborder_workspace_instance()

	blackborder_workspace:set_screen(resolution.x, resolution.y, 0, 0, resolution.x, resolution.y, resolution.x, resolution.y)
end

-- Lines 770-802
function MenuCallbackHandler:toggle_fullscreen_raid(value, callback)
	local fullscreen = value

	if managers.viewport:is_fullscreen() == fullscreen then
		return
	end

	if fullscreen then
		managers.mouse_pointer:acquire_input()
	else
		managers.mouse_pointer:unacquire_input()
	end

	managers.viewport:set_fullscreen(fullscreen)
	managers.menu:show_accept_gfx_settings_dialog(function ()
		managers.viewport:set_fullscreen(not fullscreen)

		if managers.viewport:is_fullscreen() then
			managers.mouse_pointer:acquire_input()
		else
			managers.mouse_pointer:unacquire_input()
		end

		self:refresh_node()
		callback()
	end)
	self:refresh_node()
	self:_refresh_brightness()
end

-- Lines 804-821
function MenuCallbackHandler:set_fullscreen_default_raid_no_dialog()
	local fullscreen = true

	if managers.viewport:is_fullscreen() == fullscreen then
		return
	end

	if fullscreen then
		managers.mouse_pointer:acquire_input()
	else
		managers.mouse_pointer:unacquire_input()
	end

	managers.viewport:set_fullscreen(fullscreen)
	self:refresh_node()
	self:_refresh_brightness()
end

-- Lines 823-825
function MenuCallbackHandler:toggle_subtitle_raid(value)
	managers.user:set_setting("subtitle", value)
end

-- Lines 827-829
function MenuCallbackHandler:toggle_hit_indicator_raid(value)
	managers.user:set_setting("hit_indicator", value)
end

-- Lines 831-833
function MenuCallbackHandler:toggle_objective_reminder_raid(value)
	managers.user:set_setting("objective_reminder", value)
end

-- Lines 835-837
function MenuCallbackHandler:toggle_headbob_raid(value)
	managers.user:set_setting("use_headbob", value)
end

-- Lines 839-841
function MenuCallbackHandler:set_effect_quality_raid(value)
	managers.user:set_setting("effect_quality", value)
end

-- Lines 843-846
function MenuCallbackHandler:set_brightness_raid(value)
	managers.user:set_setting("brightness", value)
end

-- Lines 850-852
function MenuCallbackHandler:toggle_dof_setting_raid(value)
	managers.user:set_setting("dof_setting", value and "standard" or "none")
end

-- Lines 854-856
function MenuCallbackHandler:toggle_ssao_setting_raid(value)
	managers.user:set_setting("ssao_setting", value and "standard" or "none")
end

-- Lines 858-860
function MenuCallbackHandler:set_use_parallax_raid(value)
	managers.user:set_setting("use_parallax", value)
end

-- Lines 862-864
function MenuCallbackHandler:toggle_motion_blur_setting_raid(value)
	managers.user:set_setting("motion_blur_setting", value and "standard" or "none")
end

-- Lines 866-868
function MenuCallbackHandler:toggle_volumetric_light_scattering_setting_raid(value)
	managers.user:set_setting("vls_setting", value and "standard" or "none")
end

-- Lines 870-872
function MenuCallbackHandler:toggle_gpu_flush_setting_raid(value)
	managers.user:set_setting("flush_gpu_command_queue", value)
end

-- Lines 874-876
function MenuCallbackHandler:toggle_lightfx_raid(value)
	managers.user:set_setting("use_lightfx", value)
end

-- Lines 878-882
function MenuCallbackHandler:toggle_vsync_raid(vsync_value, buffer_count)
	managers.viewport:set_vsync(vsync_value)
	managers.viewport:set_buffer_count(buffer_count)
	self:_refresh_brightness()
end

-- Lines 884-890
function MenuCallbackHandler:set_fov_multiplier_raid(value)
	managers.user:set_setting("fov_multiplier", value)

	if alive(managers.player:player_unit()) then
		managers.player:player_unit():movement():current_state():update_fov_external()
	end
end

-- Lines 892-901
function MenuCallbackHandler:set_detail_distance_raid(detail_distance)
	managers.user:set_setting("detail_distance", detail_distance)

	local min_maps = 0.01
	local max_maps = 0.04
	local maps = min_maps * detail_distance + max_maps * (1 - detail_distance)

	World:set_min_allowed_projected_size(maps)
end

-- Lines 903-905
function MenuCallbackHandler:choice_choose_anti_alias_raid(value)
	managers.user:set_setting("AA_setting", value)
end

-- Lines 907-913
function MenuCallbackHandler:choice_choose_texture_quality_raid(value)
	RenderSettings.texture_quality_default = value

	self:apply_and_save_render_settings()
	self:_refresh_brightness()
end

-- Lines 915-921
function MenuCallbackHandler:choice_choose_shadow_quality_raid(value)
	RenderSettings.shadow_quality_default = value

	self:apply_and_save_render_settings()
	self:_refresh_brightness()
end

-- Lines 923-929
function MenuCallbackHandler:choice_choose_anisotropic_raid(value)
	RenderSettings.max_anisotropy = value

	self:apply_and_save_render_settings()
	self:_refresh_brightness()
end

-- Lines 931-933
function MenuCallbackHandler:choice_choose_anim_lod_raid(value)
	managers.user:set_setting("video_animation_lod", value)
end

-- Lines 935-938
function MenuCallbackHandler:choice_fps_cap_raid(value)
	setup:set_fps_cap(value)
	managers.user:set_setting("fps_cap", value)
end

-- Lines 940-942
function MenuCallbackHandler:choice_max_streaming_chunk_raid(value)
	managers.user:set_setting("max_streaming_chunk", value)
end

-- Lines 944-946
function MenuCallbackHandler:choice_choose_cb_mode_raid(value)
	managers.user:set_setting("colorblind_setting", value)
end

-- Lines 950-965
function MenuCallbackHandler:set_default_options_raid(node_component)
	local params = {
		text = managers.localization:text("dialog_default_options_message"),
		callback = function ()
			managers.user:reset_setting_map()
			self:_reset_mainmusic()
			node_component:_load_controls_values()
			node_component:_load_video_values()
			node_component:_load_advanced_video_values()
			node_component:_load_sound_values()
			node_component:_load_network_values()
		end
	}

	managers.menu:show_default_option_dialog(params)
end

-- Lines 967-974
function MenuCallbackHandler:set_default_control_options_raid(node_component)
	local params = {
		text = managers.localization:text("dialog_default_controls_options_message"),
		callback = function ()
			managers.user:reset_controls_setting_map()
			node_component:_load_controls_values()
		end
	}

	managers.menu:show_default_option_dialog(params)
end

-- Lines 976-987
function MenuCallbackHandler:set_default_keybinds_raid(node_component)
	local params = {
		text = managers.localization:text("dialog_use_default_keys_message"),
		callback = function ()
			managers.controller:load_settings("settings/controller_settings")
			managers.controller:clear_user_mod("normal", MenuCustomizeControllerCreator.CONTROLS_INFO)
			node_component:refresh_keybinds()
		end
	}

	managers.menu:show_default_option_dialog(params)
end

-- Lines 989-1001
function MenuCallbackHandler:set_default_video_options_raid(node_component, callback_function)
	local params = {
		text = managers.localization:text("dialog_default_video_options_message"),
		callback = function ()
			managers.user:reset_video_setting_map()
			node_component:_load_video_values()
			node_component:_load_advanced_video_values()
			callback_function()
		end
	}

	managers.menu:show_default_option_dialog(params)
end

-- Lines 1003-1014
function MenuCallbackHandler:set_default_sound_options_raid(node_component)
	local params = {
		text = managers.localization:text("dialog_default_sound_options_message"),
		callback = function ()
			managers.user:reset_sound_setting_map()
			self:_reset_mainmusic()
			node_component:_load_sound_values()
		end
	}

	managers.menu:show_default_option_dialog(params)
end

-- Lines 1016-1023
function MenuCallbackHandler:set_default_network_options_raid(node_component)
	local params = {
		text = managers.localization:text("dialog_default_network_options_message"),
		callback = function ()
			managers.user:reset_network_setting_map()
			node_component:_load_network_values()
		end
	}

	managers.menu:show_default_option_dialog(params)
end
