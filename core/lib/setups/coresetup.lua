core:import("CoreClass")
core:import("CoreEngineAccess")
core:import("CoreLocalizationManager")
core:import("CoreNewsReportManager")
core:import("CoreSubtitleManager")
core:import("CoreViewportManager")
core:import("CoreSequenceManager")
core:import("CoreMissionManager")
core:import("CoreControllerManager")
core:import("CoreListenerManager")
core:import("CoreSlotManager")
core:import("CoreCameraManager")
core:import("CoreExpressionManager")
core:import("CoreShapeManager")
core:import("CorePortalManager")
core:import("CoreDOFManager")
core:import("CoreRumbleManager")
core:import("CoreOverlayEffectManager")
core:import("CoreSessionManager")
core:import("CoreInputManager")
core:import("CoreGTextureManager")
core:import("CoreSmoketestManager")
core:import("CoreEnvironmentAreaManager")
core:import("CoreEnvironmentEffectsManager")
core:import("CoreSlaveManager")
core:import("CoreHelperUnitManager")
core:import("CoreSystemEventListenerHolder")
core:import("CoreSystemEventListenerManager")
require("core/lib/managers/cutscene/CoreCutsceneManager")
require("core/lib/managers/CoreWorldCameraManager")
require("core/lib/managers/CoreSoundEnvironmentManager")
require("core/lib/managers/CoreMusicManager")
require("core/lib/managers/CoreWorldInstanceManager")
require("core/lib/utils/dev/editor/WorldHolder")
require("core/lib/managers/CoreWorldCollection")
require("core/lib/managers/CoreEnvironmentControllerManager")
require("core/lib/units/CoreSpawnSystem")
require("core/lib/units/CoreUnitDamage")
require("core/lib/units/CoreEditableGui")
require("core/lib/units/data/CoreScriptUnitData")
require("core/lib/units/data/CoreWireData")
require("core/lib/units/data/CoreCutsceneData")

if Application:ews_enabled() then
	core:import("CoreLuaProfilerViewer")
	core:import("CoreDatabaseManager")
	core:import("CoreToolHub")
	core:import("CoreInteractionEditor")
	core:import("CoreInteractionEditorConfig")
	require("core/lib/utils/dev/tools/CoreUnitReloader")
	require("core/lib/utils/dev/tools/CoreUnitTestBrowser")
	require("core/lib/utils/dev/tools/CoreEnvEditor")
	require("core/lib/utils/dev/tools/CoreDatabaseBrowser")
	require("core/lib/utils/dev/tools/CoreLuaProfiler")
	require("core/lib/utils/dev/tools/CoreXMLEditor")
	require("core/lib/utils/dev/ews/CoreEWSDeprecated")
	require("core/lib/utils/dev/tools/CorePuppeteer")
	require("core/lib/utils/dev/tools/material_editor/CoreMaterialEditor")
	require("core/lib/utils/dev/tools/particle_editor/CoreParticleEditor")
	require("core/lib/utils/dev/tools/cutscene_editor/CoreCutsceneEditor")
end

CoreSetup = CoreSetup or class()
local _CoreSetup = CoreSetup

-- Lines 116-122
function CoreSetup:init()
	CoreClass.close_override()

	self.__quit = false
	self.__exec = false
	self.__context = nil
	self.__firstupdate = true
end

-- Lines 124-125
function CoreSetup:init_category_print()
end

-- Lines 127-128
function CoreSetup:load_packages()
end

-- Lines 130-131
function CoreSetup:unload_packages()
end

-- Lines 133-134
function CoreSetup:start_boot_loading_screen()
end

-- Lines 136-137
function CoreSetup:init_managers(managers)
end

-- Lines 139-140
function CoreSetup:init_toolhub(toolhub)
end

-- Lines 142-143
function CoreSetup:init_game()
end

-- Lines 145-147
function CoreSetup:init_finalize()
	managers.mission:post_init()
end

-- Lines 149-150
function CoreSetup:start_loading_screen()
end

-- Lines 152-153
function CoreSetup:stop_loading_screen()
end

-- Lines 155-156
function CoreSetup:update(t, dt)
end

-- Lines 158-159
function CoreSetup:paused_update(t, dt)
end

-- Lines 161-162
function CoreSetup:render()
end

-- Lines 164-165
function CoreSetup:end_frame(t, dt)
end

-- Lines 167-168
function CoreSetup:end_update(t, dt)
end

-- Lines 170-171
function CoreSetup:paused_end_update(t, dt)
end

-- Lines 173-174
function CoreSetup:save(data)
end

-- Lines 176-177
function CoreSetup:load(data)
end

-- Lines 179-180
function CoreSetup:destroy()
end

-- Lines 186-188
function CoreSetup:freeflight()
	return self.__freeflight
end

-- Lines 194-197
function CoreSetup:exec(context)
	self.__exec = true
	self.__context = context
end

-- Lines 199-203
function CoreSetup:quit()
	if not Application:editor() then
		self.__quit = true
	end
end

-- Lines 205-207
function CoreSetup:block_exec()
	return false
end

-- Lines 209-211
function CoreSetup:block_quit()
	return false
end

-- Lines 213-215
function CoreSetup:has_queued_exec()
	return self.__exec
end

-- Lines 221-273
function CoreSetup:__pre_init()
	if Application:editor() then
		managers.global_texture = CoreGTextureManager.GTextureManager:new()
		local frame_resolution = SystemInfo:desktop_resolution()
		local appwin_resolution = Vector3(frame_resolution.x * 0.75, frame_resolution.y * 0.75, 0)
		local frame = EWS:Frame("World Editor", Vector3(0, 0, 0), frame_resolution, "CAPTION,CLOSE_BOX,MINIMIZE_BOX,MAXIMIZE_BOX,MAXIMIZE,SYSTEM_MENU,RESIZE_BORDER")

		frame:set_icon(CoreEWS.image_path("world_editor_16x16.png"))

		local frame_panel = EWS:Panel(frame, "", "")
		local appwin = EWS:AppWindow(frame_panel, appwin_resolution, "SUNKEN_BORDER")

		appwin:set_max_size(Vector3(-1, -1, 0))

		Global.application_window = appwin
		Global.frame = frame

		appwin:connect("EVT_LEAVE_WINDOW", callback(nil, _G, "leaving_window"))
		appwin:connect("EVT_ENTER_WINDOW", callback(nil, _G, "entering_window"))
		appwin:connect("EVT_KILL_FOCUS", callback(nil, _G, "kill_focus"))
		appwin:connect("EVT_ACTIVATE", callback(nil, _G, "on_activate"))
		Application:set_ews_window(appwin)

		local top_sizer = EWS:BoxSizer("VERTICAL")
		local main_sizer = EWS:BoxSizer("HORIZONTAL")
		local left_toolbar_sizer = EWS:BoxSizer("VERTICAL")

		main_sizer:add(left_toolbar_sizer, 0, 0, "EXPAND")

		local app_sizer = EWS:BoxSizer("VERTICAL")

		main_sizer:add(app_sizer, 4, 0, "EXPAND")
		app_sizer:add(appwin, 5, 0, "EXPAND")
		top_sizer:add(main_sizer, 1, 0, "EXPAND")
		frame_panel:set_sizer(top_sizer)

		Global.main_sizer = main_sizer
		Global.v_sizer = app_sizer
		Global.frame_panel = frame_panel
		Global.left_toolbar_sizer = left_toolbar_sizer
	end
end

-- Lines 275-425
function CoreSetup:__init()
	self:init_category_print()

	if not PackageManager:loaded("core/packages/base") then
		PackageManager:load("core/packages/base")
	end

	managers.global_texture = managers.global_texture or CoreGTextureManager.GTextureManager:new()
	managers.slot = CoreSlotManager.SlotManager:new()
	managers.sequence = CoreSequenceManager.SequenceManager:new()
	managers.worldcollection = CoreWorldCollection:new({
		ordered = true,
		random = false
	})

	if not Global.__coresetup_bootdone then
		self:start_boot_loading_screen()

		Global.__coresetup_bootdone = true
	end

	self:load_packages()
	World:set_raycast_bounds(Vector3(-50000, -80000, -20000), Vector3(90000, 50000, 30000))
	World:load(Application:editor() and "core/levels/editor/editor" or "core/levels/zone", false)
	min_exe_version("1.0.0.7000", "Core Systems")
	rawset(_G, "UnitDamage", rawget(_G, "UnitDamage") or CoreUnitDamage)
	rawset(_G, "EditableGui", rawget(_G, "EditableGui") or CoreEditableGui)

	local aspect_ratio = nil

	if Application:editor() then
		local frame_resolution = SystemInfo:desktop_resolution()
		aspect_ratio = frame_resolution.x / frame_resolution.y
	elseif SystemInfo:platform() == Idstring("WIN32") then
		aspect_ratio = RenderSettings.aspect_ratio

		if aspect_ratio == 0 then
			aspect_ratio = RenderSettings.resolution.x / RenderSettings.resolution.y
		end
	elseif SystemInfo:platform() == Idstring("X360") or SystemInfo:platform() == Idstring("PS3") and SystemInfo:widescreen() then
		aspect_ratio = RenderSettings.resolution.x / RenderSettings.resolution.y
	else
		aspect_ratio = RenderSettings.resolution.x / RenderSettings.resolution.y
	end

	if Application:ews_enabled() then
		managers.database = CoreDatabaseManager.DatabaseManager:new()
	end

	managers.system_event_listener = CoreSystemEventListenerManager.SystemEventListenerManager:new()
	managers.localization = CoreLocalizationManager.LocalizationManager:new()
	managers.controller = CoreControllerManager.ControllerManager:new()
	managers.listener = CoreListenerManager.ListenerManager:new()
	managers.viewport = CoreViewportManager.ViewportManager:new(aspect_ratio)
	managers.mission = CoreMissionManager.MissionManager:new()
	managers.expression = CoreExpressionManager.ExpressionManager:new()
	managers.worldcamera = CoreWorldCameraManager:new()
	managers.environment_effects = CoreEnvironmentEffectsManager.EnvironmentEffectsManager:new()
	managers.shape = CoreShapeManager.ShapeManager:new()
	managers.portal = CorePortalManager.PortalManager:new()
	managers.sound_environment = CoreSoundEnvironmentManager:new()
	managers.environment_area = CoreEnvironmentAreaManager.EnvironmentAreaManager:new()
	managers.cutscene = CoreCutsceneManager:new()
	managers.rumble = CoreRumbleManager.RumbleManager:new()
	managers.DOF = CoreDOFManager.DOFManager:new()
	managers.subtitle = CoreSubtitleManager.SubtitleManager:new()
	managers.overlay_effect = CoreOverlayEffectManager.OverlayEffectManager:new()
	managers.camera = CoreCameraManager.CameraTemplateManager:new()
	managers.slave = CoreSlaveManager.SlaveManager:new()
	managers.world_instance = CoreWorldInstanceManager:new()
	managers.environment_controller = CoreEnvironmentControllerManager:new()
	managers.helper_unit = CoreHelperUnitManager.HelperUnitManager:new()
	self._input = CoreInputManager.InputManager:new()
	self._session = CoreSessionManager.SessionManager:new(self.session_factory, self._input)
	self._smoketest = CoreSmoketestManager.Manager:new(self._session:session())

	managers.sequence:internal_load()
	self:init_managers(managers)

	if Application:ews_enabled() then
		managers.news = CoreNewsReportManager.NewsReportManager:new()
		managers.toolhub = CoreToolHub.ToolHub:new()

		managers.toolhub:add("Environment Editor", CoreEnvEditor)
		managers.toolhub:add(CoreMaterialEditor.TOOLHUB_NAME, CoreMaterialEditor)
		managers.toolhub:add("LUA Profiler", CoreLuaProfiler)
		managers.toolhub:add("Particle Editor", CoreParticleEditor)
		managers.toolhub:add(CorePuppeteer.EDITOR_TITLE, CorePuppeteer)
		managers.toolhub:add(CoreCutsceneEditor.EDITOR_TITLE, CoreCutsceneEditor)

		if not Application:editor() then
			managers.toolhub:add("Unit Reloader", CoreUnitReloader)
		end

		self:init_toolhub(managers.toolhub)
		managers.toolhub:buildmenu()
	end

	self.__gsm = assert(self:init_game(), "self:init_game must return a GameStateMachine.")

	managers.cutscene:post_init()
	self._smoketest:post_init()

	if not Application:editor() then
		-- Nothing
	end

	self:init_finalize()
end

-- Lines 427-456
function CoreSetup:__destroy()
	self:destroy()
	self.__gsm:destroy()
	managers.global_texture:destroy()
	managers.cutscene:destroy()
	managers.subtitle:destroy()
	managers.worldcamera:destroy()
	managers.viewport:destroy()
	managers.overlay_effect:destroy()
	self._session:destroy()
	self._input:destroy()
	self._smoketest:destroy()
end

-- Lines 458-459
function CoreSetup:loading_update(t, dt)
end

-- Lines 461-540
function CoreSetup:__update(t, dt)
	if self.__firstupdate then
		self:stop_loading_screen()

		self.__firstupdate = false
	end

	managers.controller:update(t, dt)
	managers.cutscene:update()
	managers.sequence:update(t, dt)
	managers.worldcamera:update(t, dt)
	managers.environment_effects:update(t, dt)
	managers.sound_environment:update(t, dt)
	managers.environment_area:update(t, dt)
	managers.expression:update(t, dt)
	managers.subtitle:update(TimerManager:game_animation():time(), TimerManager:game_animation():delta_time())
	managers.overlay_effect:update(t, dt)
	managers.viewport:update(t, dt)
	managers.mission:update(t, dt)
	managers.slave:update(t, dt)
	self._session:update(t, dt)
	self._input:update(t, dt)
	self._smoketest:update(t, dt)
	managers.environment_controller:update(t, dt)
	self:update(t, dt)
end

-- Lines 542-571
function CoreSetup:__paused_update(t, dt)
	managers.viewport:paused_update(t, dt)
	managers.controller:paused_update(t, dt)
	managers.cutscene:paused_update(t, dt)
	managers.overlay_effect:paused_update(t, dt)
	managers.slave:paused_update(t, dt)
	self._session:update(t, dt)
	self._input:update(t, dt)
	self._smoketest:update(t, dt)
	self:paused_update(t, dt)
end

-- Lines 573-586
function CoreSetup:__end_update(t, dt)
	managers.camera:update(t, dt)
	self._session:end_update(t, dt)
	self:end_update(t, dt)
	self.__gsm:end_update(t, dt)
	managers.viewport:end_update(t, dt)
	managers.controller:end_update(t, dt)
	managers.DOF:update(t, dt)

	if Application:ews_enabled() then
		managers.toolhub:end_update(t, dt)
	end
end

-- Lines 588-593
function CoreSetup:__paused_end_update(t, dt)
	self:paused_end_update(t, dt)
	self.__gsm:end_update(t, dt)
	managers.DOF:paused_update(t, dt)
end

-- Lines 595-600
function CoreSetup:__render()
	managers.portal:render()
	managers.viewport:render()
	managers.overlay_effect:render()
	self:render()
end

-- Lines 602-665
function CoreSetup:__end_frame(t, dt)
	self:end_frame(t, dt)
	managers.viewport:end_frame(t, dt)

	if self.__quit then
		if not self:block_quit() then
			CoreEngineAccess._quit()
		end
	elseif self.__exec and not self:block_exec() then
		if managers.network and managers.network:session() then
			managers.network:save()
		end

		if managers.mission then
			managers.mission:destroy()
		end

		if managers.worldcollection then
			managers.worldcollection:destroy()
		end

		if managers.worldcollection then
			managers.worldcollection:destroy()
		end

		World:unload_all_units()

		if managers.blackmarket then
			managers.blackmarket:release_preloaded_blueprints()
		end

		if managers.dyn_resource and not managers.dyn_resource:is_ready_to_close() then
			Application:cleanup_thread_garbage()
			managers.dyn_resource:update()
		end

		if managers.sound_environment then
			managers.sound_environment:destroy()
		end

		TextureCache:abort_all_script_requests()
		self:start_loading_screen()

		if managers.worlddefinition then
			managers.worlddefinition:unload_packages()
		end

		if managers.worldcollection then
			managers.worldcollection:unload_packages()
		end

		self:unload_packages()
		managers.menu:destroy()
		Overlay:newgui():destroy_all_workspaces()
		Application:cleanup_thread_garbage()
		CoreEngineAccess._exec("core/lib/CoreEntry", self.__context)
	end
end

-- Lines 667-670
function CoreSetup:__loading_update(t, dt)
	self._session:update(t, dt)
	self:loading_update()
end

-- Lines 672-673
function CoreSetup:__animations_reloaded()
end

-- Lines 675-676
function CoreSetup:__script_reloaded()
end

-- Lines 678-683
function CoreSetup:__entering_window(user_data, event_object)
	if Global.frame:is_active() then
		Global.application_window:set_focus()
		Input:keyboard():acquire()
	end
end

-- Lines 685-689
function CoreSetup:__on_activate(user_data, event_object)
	Global.application_window:refresh()
end

-- Lines 691-695
function CoreSetup:__leaving_window(user_data, event_object)
	if not managers.editor or managers.editor._in_mixed_input_mode then
		Input:keyboard():unacquire()
	end
end

-- Lines 697-701
function CoreSetup:__kill_focus(user_data, event_object)
	if managers.editor and not managers.editor:in_mixed_input_mode() and not Global.running_simulation then
		managers.editor:set_in_mixed_input_mode(true)
	end
end

-- Lines 703-705
function CoreSetup:__save(data)
	self:save(data)
end

-- Lines 707-709
function CoreSetup:__load(data)
	self:load(data)
end

core:module("CoreSetup")

CoreSetup = _CoreSetup

-- Lines 719-759
function CoreSetup:make_entrypoint()
	if not _G.CoreSetup.__entrypoint_is_setup then
		assert(rawget(_G, "pre_init") == nil)
		assert(rawget(_G, "init") == nil)
		assert(rawget(_G, "destroy") == nil)
		assert(rawget(_G, "update") == nil)
		assert(rawget(_G, "end_update") == nil)
		assert(rawget(_G, "paused_update") == nil)
		assert(rawget(_G, "paused_end_update") == nil)
		assert(rawget(_G, "render") == nil)
		assert(rawget(_G, "end_frame") == nil)
		assert(rawget(_G, "animations_reloaded") == nil)
		assert(rawget(_G, "script_reloaded") == nil)
		assert(rawget(_G, "entering_window") == nil)
		assert(rawget(_G, "leaving_window") == nil)
		assert(rawget(_G, "kill_focus") == nil)
		assert(rawget(_G, "save") == nil)
		assert(rawget(_G, "load") == nil)
		assert(rawget(_G, "on_activate") == nil)

		_G.CoreSetup.__entrypoint_is_setup = true
	end

	rawset(_G, "pre_init", callback(self, self, "__pre_init"))
	rawset(_G, "init", callback(self, self, "__init"))
	rawset(_G, "destroy", callback(self, self, "__destroy"))
	rawset(_G, "update", callback(self, self, "__update"))
	rawset(_G, "end_update", callback(self, self, "__end_update"))
	rawset(_G, "loading_update", callback(self, self, "__loading_update"))
	rawset(_G, "paused_update", callback(self, self, "__paused_update"))
	rawset(_G, "paused_end_update", callback(self, self, "__paused_end_update"))
	rawset(_G, "render", callback(self, self, "__render"))
	rawset(_G, "end_frame", callback(self, self, "__end_frame"))
	rawset(_G, "animations_reloaded", callback(self, self, "__animations_reloaded"))
	rawset(_G, "script_reloaded", callback(self, self, "__script_reloaded"))
	rawset(_G, "entering_window", callback(self, self, "__entering_window"))
	rawset(_G, "on_activate", callback(self, self, "__on_activate"))
	rawset(_G, "leaving_window", callback(self, self, "__leaving_window"))
	rawset(_G, "kill_focus", callback(self, self, "__kill_focus"))
	rawset(_G, "save", callback(self, self, "__save"))
	rawset(_G, "load", callback(self, self, "__load"))
end
