core:import("CoreShapeManager")

CoreSoundEnvironmentManager = CoreSoundEnvironmentManager or class()

-- Lines 19-74
function CoreSoundEnvironmentManager:init()
	self._areas = {}
	self._areas_per_frame = 1
	self._check_objects = {}
	self._check_object_id = 0
	self._emitters = {}
	self._area_emitters = {}
	self._ambience_changed_callback = {}
	self._ambience_changed_callbacks = {}
	self._environment_changed_callback = {}
	self.GAME_DEFAULT_ENVIRONMENT = "padded_cell"
	self._default_environment = self.GAME_DEFAULT_ENVIRONMENT
	self._current_environment = self.GAME_DEFAULT_ENVIRONMENT

	self:_set_environment(self.GAME_DEFAULT_ENVIRONMENT)

	local in_editor = Application:editor()

	if in_editor then
		self._environments = self:_environment_effects()
		self.GAME_DEFAULT_ENVIRONMENT = self._environments[1] or nil
		self._default_environment = self.GAME_DEFAULT_ENVIRONMENT
		self._current_environment = self.GAME_DEFAULT_ENVIRONMENT

		self:_set_environment(self.GAME_DEFAULT_ENVIRONMENT)
	else
		self:_set_environment(self.GAME_DEFAULT_ENVIRONMENT)
	end

	if in_editor then
		self:_find_emitter_events()
		self:_find_ambience_events()
		self:_find_scene_events()
		self:_find_occasional_events()

		self.GAME_DEFAULT_EMITTER_PATH = self._emitter.paths[1]
		self.GAME_DEFAULT_AMBIENCE = self._ambience.events[1]
		self._default_ambience = self.GAME_DEFAULT_AMBIENCE
		self.GAME_DEFAULT_OCCASIONAL = self._occasional.events[1]
		self._default_occasional = self.GAME_DEFAULT_OCCASIONAL
		self.GAME_DEFAULT_SCENE_PATH = self._scene.paths[1]
	end

	self._ambience_enabled = false
	self._occasional_blocked_by_platform = SystemInfo:platform() == Idstring("X360")
	self._ambience_sources_count = 1
	self.POSITION_OFFSET = 50
	self._active_ambience_soundbanks = {}
	self._occasional_sound_source = SoundDevice:create_source("occasional")
end

-- Lines 76-91
function CoreSoundEnvironmentManager:_find_emitter_events()
	self._emitter = {
		events = {},
		paths = {},
		soundbanks = {}
	}

	for _, soundbank in ipairs(SoundDevice:sound_banks()) do
		for event, data in pairs(SoundDevice:events(soundbank)) do
			if string.match(event, "emitter") then
				if not table.contains(self._emitter.paths, data.path) then
					table.insert(self._emitter.paths, data.path)
				end

				self._emitter.events[data.path] = self._emitter.events[data.path] or {}

				table.insert(self._emitter.events[data.path], event)

				self._emitter.soundbanks[event] = soundbank
			end
		end
	end

	table.sort(self._emitter.paths)
end

-- Lines 93-104
function CoreSoundEnvironmentManager:_find_ambience_events()
	self._ambience = {
		events = {},
		soundbanks = {}
	}

	for _, soundbank in ipairs(SoundDevice:sound_banks()) do
		for event, data in pairs(SoundDevice:events(soundbank)) do
			if string.match(event, "ambience") then
				table.insert(self._ambience.events, event)

				self._ambience.soundbanks[event] = soundbank
			end
		end
	end

	table.sort(self._ambience.events)
end

-- Lines 106-121
function CoreSoundEnvironmentManager:_find_scene_events()
	self._scene = {
		events = {},
		paths = {},
		soundbanks = {}
	}

	for _, soundbank in ipairs(SoundDevice:sound_banks()) do
		for event, data in pairs(SoundDevice:events(soundbank)) do
			if not table.contains(self._scene.paths, data.path) then
				table.insert(self._scene.paths, data.path)
			end

			self._scene.events[data.path] = self._scene.events[data.path] or {}

			table.insert(self._scene.events[data.path], event)

			self._scene.soundbanks[event] = soundbank
		end
	end

	table.sort(self._scene.paths)
end

-- Lines 123-134
function CoreSoundEnvironmentManager:_find_occasional_events()
	self._occasional = {
		events = {},
		soundbanks = {}
	}

	for _, soundbank in ipairs(SoundDevice:sound_banks()) do
		for event, data in pairs(SoundDevice:events(soundbank)) do
			if string.match(event, "occasional") then
				table.insert(self._occasional.events, event)

				self._occasional.soundbanks[event] = soundbank
			end
		end
	end

	table.sort(self._occasional.events)
end

-- Lines 136-138
function CoreSoundEnvironmentManager:areas()
	return self._areas
end

-- Lines 140-142
function CoreSoundEnvironmentManager:game_default_ambience()
	return self.GAME_DEFAULT_AMBIENCE
end

-- Lines 144-146
function CoreSoundEnvironmentManager:game_default_occasional()
	return self.GAME_DEFAULT_OCCASIONAL
end

-- Lines 149-151
function CoreSoundEnvironmentManager:game_default_emitter_path()
	return self.GAME_DEFAULT_EMITTER_PATH
end

-- Lines 154-156
function CoreSoundEnvironmentManager:emitter_paths()
	return self._emitter.paths
end

-- Lines 159-161
function CoreSoundEnvironmentManager:emitter_events(path)
	return path and self._emitter.events[path] or self._emitter.events
end

-- Lines 164-169
function CoreSoundEnvironmentManager:emitter_soundbank(event)
	if not self._emitter then
		return
	end

	return self._emitter.soundbanks[event]
end

-- Lines 172-177
function CoreSoundEnvironmentManager:emitter_soundbanks()
	if not self._emitter then
		return
	end

	return self._emitter.soundbanks
end

-- Lines 180-182
function CoreSoundEnvironmentManager:ambience_events()
	return self._ambience.events
end

-- Lines 185-190
function CoreSoundEnvironmentManager:ambience_soundbank(event)
	if not self._ambience then
		return
	end

	return self._ambience.soundbanks[event]
end

-- Lines 193-198
function CoreSoundEnvironmentManager:ambience_soundbanks()
	if not self._ambience then
		return
	end

	return self._ambience.soundbanks
end

-- Lines 201-206
function CoreSoundEnvironmentManager:occasional_events()
	if not self._occasional then
		return
	end

	return self._occasional.events
end

-- Lines 209-214
function CoreSoundEnvironmentManager:occasional_soundbank(event)
	if not self._occasional then
		return
	end

	return self._occasional.soundbanks[event]
end

-- Lines 217-222
function CoreSoundEnvironmentManager:occasional_soundbanks()
	if not self._occasional then
		return
	end

	return self._occasional.soundbanks
end

-- Lines 225-227
function CoreSoundEnvironmentManager:game_default_scene_path()
	return self.GAME_DEFAULT_SCENE_PATH
end

-- Lines 230-232
function CoreSoundEnvironmentManager:scene_paths()
	return self._scene.paths
end

-- Lines 235-237
function CoreSoundEnvironmentManager:scene_events(path)
	return path and self._scene.events[path] or self._scene.events
end

-- Lines 240-242
function CoreSoundEnvironmentManager:scene_soundbank(event)
	return self._scene.soundbanks[event]
end

-- Lines 245-247
function CoreSoundEnvironmentManager:scene_soundbanks()
	return self._scene.soundbanks
end

-- Lines 250-256
function CoreSoundEnvironmentManager:scene_path(event)
	for path, events in pairs(self._scene.events) do
		if table.contains(events, event) then
			return path
		end
	end
end

-- Lines 259-261
function CoreSoundEnvironmentManager:emitters()
	return self._emitters
end

-- Lines 264-266
function CoreSoundEnvironmentManager:area_emitters()
	return self._area_emitters
end

-- Lines 269-276
function CoreSoundEnvironmentManager:_environment_effects()
	local effects = {}

	for name, _ in pairs(SoundDevice:effects()) do
		table.insert(effects, name)
	end

	table.sort(effects)

	return effects
end

-- Lines 279-281
function CoreSoundEnvironmentManager:environments()
	return self._environments
end

-- Lines 283-285
function CoreSoundEnvironmentManager:game_default_environment()
	return self.GAME_DEFAULT_ENVIRONMENT
end

-- Lines 287-289
function CoreSoundEnvironmentManager:default_environment()
	return self._default_environment
end

-- Lines 291-295
function CoreSoundEnvironmentManager:set_default_environment(environment)
	self._default_environment = environment

	self:_set_environment(self._default_environment)
	self:_change_acoustic(self._default_environment)
end

-- Lines 297-305
function CoreSoundEnvironmentManager:_set_environment(environment)
	for _, func in ipairs(self._environment_changed_callback) do
		func(environment)
	end

	self._current_environment = environment

	SoundDevice:set_default_environment({
		gain = 1,
		effect = environment
	})
end

-- Lines 307-309
function CoreSoundEnvironmentManager:current_environment()
	return self._current_environment
end

-- Lines 311-323
function CoreSoundEnvironmentManager:set_default_ambience(ambience_event)
	if not ambience_event then
		return
	end

	self._default_ambience = ambience_event

	if Application:editor() then
		self:add_soundbank(self:ambience_soundbank(self._default_ambience))
	end

	for id, data in pairs(self._check_objects) do
		self:_change_ambience(data)
	end
end

-- Lines 325-327
function CoreSoundEnvironmentManager:default_ambience()
	return self._default_ambience
end

-- Lines 329-345
function CoreSoundEnvironmentManager:set_default_occasional(occasional_event)
	if not occasional_event then
		return
	end

	if occasional_event and Application:editor() and not table.contains(managers.sound_environment:occasional_events(), occasional_event) then
		if managers.editor then
			managers.editor:output_error("Default occasional event " .. occasional_event .. " no longer exits. Falls back on default.")
		end

		occasional_event = managers.sound_environment:game_default_occasional()
	end

	self._default_occasional = occasional_event

	if Application:editor() then
		self:add_soundbank(self:occasional_soundbank(self._default_occasional))
	end
end

-- Lines 347-349
function CoreSoundEnvironmentManager:default_occasional()
	return self._default_occasional
end

-- Lines 351-360
function CoreSoundEnvironmentManager:add_soundbank(soundbank)
	if not soundbank then
		Application:error("Cant load nil soundbank")

		return
	end

	if Application:editor() then
		CoreEngineAccess._editor_load(("bnk"):id(), soundbank:id())
	end
end

-- Lines 363-368
function CoreSoundEnvironmentManager:set_to_default()
	self:set_default_environment(self.GAME_DEFAULT_ENVIRONMENT)
	self:set_default_ambience(self.GAME_DEFAULT_AMBIENCE)
	self:set_default_occasional(self.GAME_DEFAULT_OCCASIONAL)
	self:set_ambience_enabled(false)
end

-- Lines 370-375
function CoreSoundEnvironmentManager:add_area(area_params, world_id)
	local area = SoundEnvironmentArea:new(area_params)
	area._world_id = world_id

	table.insert(self._areas, area)

	return area
end

-- Lines 377-387
function CoreSoundEnvironmentManager:remove_area(area)
	area:remove()

	for _, data in pairs(self._check_objects) do
		if area == data.area then
			data.area = nil

			self:_change_ambience(data)
		end

		data.sound_area_counter = 1
	end

	table.delete(self._areas, area)
end

-- Lines 389-403
function CoreSoundEnvironmentManager:enable_area(name, enable)
	for _, area in pairs(self._areas) do
		if area:name() == name then
			if enable then
				area:_add_environment()
				area:enable(true)
			else
				area:_remove_environment()
				area:enable(false)
			end

			return
		end
	end
end

-- Lines 405-410
function CoreSoundEnvironmentManager:add_emitter(emitter_params, world_id)
	local emitter = SoundEnvironmentEmitter:new(emitter_params)
	emitter._world_id = world_id

	table.insert(self._emitters, emitter)

	return emitter
end

-- Lines 412-415
function CoreSoundEnvironmentManager:remove_emitter(emitter)
	emitter:destroy()
	table.delete(self._emitters, emitter)
end

-- Lines 417-422
function CoreSoundEnvironmentManager:add_area_emitter(emitter_params, world_id)
	local emitter = SoundEnvironmentAreaEmitter:new(emitter_params)
	emitter._world_id = world_id

	table.insert(self._area_emitters, emitter)

	return emitter
end

-- Lines 424-427
function CoreSoundEnvironmentManager:remove_area_emitter(emitter)
	emitter:destroy()
	table.delete(self._area_emitters, emitter)
end

-- Lines 432-437
function CoreSoundEnvironmentManager:add_listener(data)
	Application:throw_exception("add_listener function is no longer working because of new sound implementation. Use add_check_object instead.")

	local distance, orientation, occlusion = Sound:listener(data.listener)
	data.object = distance

	return self:add_check_object(data)
end

-- Lines 442-478
function CoreSoundEnvironmentManager:add_check_object(data)
	if not data.object then
		Application:error("Must use an Object3D when adding check objects to sound environment manager.")

		return nil
	end

	self:_disable_fallback()

	self._check_object_id = self._check_object_id + 1
	local soundsource = SoundDevice:create_source("ambience_source")

	soundsource:enable_env(true)

	local surround = {}

	for i = 1, self._ambience_sources_count do
		local source = SoundDevice:create_source("ambience_surround_" .. i)

		source:enable_env(true)

		local distance = 15000
		local x = (i == 1 or i == 4) and -distance or distance
		local y = (i == 1 or i == 2) and distance or -distance
		local offset = Vector3(x, y, 0)

		source:set_position(data.object:position() + offset)
		table.insert(surround, {
			source = source,
			offset = offset
		})
	end

	local t = {
		sound_area_counter = 1,
		object = data.object,
		soundsource = soundsource,
		surround = surround,
		surround_iterator = surround and 0 or nil,
		active = data.active,
		listener = data.listener,
		primary = data.primary,
		id = self._check_object_id,
		next_occasional = self:_next_occasional()
	}

	self:_change_ambience(t)

	self._check_objects[self._check_object_id] = t

	return self._check_object_id
end

-- Lines 481-491
function CoreSoundEnvironmentManager:remove_check_object(id)
	local remove_object = self._check_objects[id]

	remove_object.soundsource:stop()

	if remove_object.surround then
		for _, surround_data in ipairs(remove_object.surround) do
			surround_data.source:stop()
		end
	end

	self._check_objects[id] = nil

	self:_enable_fallback()
end

-- Lines 494-517
function CoreSoundEnvironmentManager:set_check_object_active(id, active)
	local object = self._check_objects[id]

	if object.active == active then
		return
	end

	object.active = active

	if not active then
		object.soundsource:stop()

		if object.surround then
			for _, surround_data in ipairs(object.surround) do
				surround_data.source:stop()
			end
		end
	else
		self:_check_inside(object)

		if not object.area then
			self:_change_ambience(object, 1)
		end
	end
end

-- Lines 519-522
function CoreSoundEnvironmentManager:obj_alive(id)
	local data = self._check_objects[id]

	return data and alive(data.object)
end

-- Lines 525-527
function CoreSoundEnvironmentManager:check_object(id)
	return self._check_objects[id]
end

-- Lines 530-535
function CoreSoundEnvironmentManager:_disable_fallback()
	local fallback = self._check_objects[self._fallback_id]

	if fallback then
		self:set_check_object_active(self._fallback_id, false)
	end
end

-- Lines 538-548
function CoreSoundEnvironmentManager:_enable_fallback()
	local fallback = self._check_objects[self._fallback_id]

	if fallback and not fallback.active then
		for id, object in pairs(self._check_objects) do
			if object ~= fallback then
				return
			end
		end

		self:set_check_object_active(self._fallback_id, true)
	end
end

-- Lines 550-552
function CoreSoundEnvironmentManager:_next_occasional()
	return Application:time() + 6 + math.rand(4)
end

local check_pos = Vector3()
local mvec_surround_pos = Vector3()

-- Lines 557-614
function CoreSoundEnvironmentManager:_update_object(t, dt, id, data)
	data.object:m_position(check_pos)

	local still_inside = nil

	if data.surround then
		local surround_data = data.surround[data.surround_iterator + 1]

		mvector3.set(mvec_surround_pos, check_pos)
		mvector3.add(mvec_surround_pos, surround_data.offset)
		surround_data.source:set_position(mvec_surround_pos)

		data.surround_iterator = math.mod(data.surround_iterator + 1, self._ambience_sources_count)
	end

	if data.next_occasional < t then
		data.next_occasional = self:_next_occasional()

		if self._ambience_enabled and not self._occasional_blocked_by_platform then
			local event = data.area and data.area:use_occasional() and data.area:occasional_event() or self._default_occasional

			if event then
				local x = math.rand(2) - 1
				local y = math.rand(2) - 1
				local pos = check_pos + Vector3(x, y, 0):normalized() * 7500

				self._occasional_sound_source:set_position(pos)
				self._occasional_sound_source:post_event(event)
			end
		end
	end

	if data.area then
		still_inside = data.area:still_inside(check_pos)

		if still_inside then
			return data.area
		end

		if self:_check_inside(data) then
			return data.area
		end

		self:_change_acoustic(self._default_environment)
		self:_change_ambience(data)
	end

	if self:_check_inside(data) then
		return data.area
	end

	return nil
end

-- Lines 617-642
function CoreSoundEnvironmentManager:_fallback_on_camera()
	if not self._use_fallback_on_camera then
		return
	end

	local vps = managers.viewport:active_viewports()

	if #vps == 0 then
		return
	end

	local camera = vps[1]:camera()

	if not camera then
		return
	end

	local fallback = self._check_objects[self._fallback_id]

	if fallback then
		if fallback.object ~= camera then
			fallback.object = camera
		end
	elseif not next(self._check_objects) then
		self._fallback_id = self:add_check_object({
			primary = true,
			active = true,
			object = camera
		})
		self:check_object(self._fallback_id).fallback = true
	end
end

-- Lines 644-653
function CoreSoundEnvironmentManager:update(t, dt)
	for id, data in pairs(self._check_objects) do
		if data.active then
			self:_update_object(t, dt, id, data)
		end
	end
end

-- Lines 655-679
function CoreSoundEnvironmentManager:_change_ambience(data, sound_gain)
	local area = data.area
	local ambience_event = area and area:ambience_event() or self._default_ambience

	if self._ambience_changed_callbacks[data.id] then
		for _, func in ipairs(self._ambience_changed_callbacks[data.id]) do
			func(ambience_event)
		end
	end

	for _, func in ipairs(self._ambience_changed_callback) do
		func(ambience_event)
	end

	if not self._ambience_enabled then
		return
	end

	if data.surround then
		for _, surround_data in ipairs(data.surround) do
			surround_data.source:post_event(ambience_event)
		end
	end
end

-- Lines 681-692
function CoreSoundEnvironmentManager:_change_acoustic(environment)
	self._acoustic = environment

	if tweak_data.sound.acoustics[environment] and tweak_data.sound.acoustics[environment].states then
		for state, value in pairs(tweak_data.sound.acoustics[environment].states) do
			Application:trace("set state", state, value)
			SoundDevice:set_state(state, value)
		end
	end
end

local check_pos2 = Vector3()

-- Lines 695-717
function CoreSoundEnvironmentManager:_check_inside(data)
	if #self._areas > 0 then
		local check_pos = check_pos2

		data.object:m_position(check_pos)

		for i = 1, self._areas_per_frame do
			local area = self._areas[data.sound_area_counter]
			data.sound_area_counter = math.mod(data.sound_area_counter, #self._areas) + 1

			if area:is_inside(check_pos) then
				data.area = area

				self:_change_acoustic(data.area:environment())
				self:_change_ambience(data)
				Application:trace("Acoustic flag ", data.area:environment())

				return area
			end
		end
	end

	data.area = nil

	return data.area
end

-- Lines 720-722
function CoreSoundEnvironmentManager:ambience_enabled()
	return self._ambience_enabled
end

-- Lines 725-743
function CoreSoundEnvironmentManager:set_ambience_enabled(enabled)
	self._ambience_enabled = enabled

	if not self._default_ambience then
		return
	end

	for _, data in pairs(self._check_objects) do
		if self._ambience_enabled and data.active then
			self:_change_ambience(data)
		else
			data.soundsource:stop()

			if data.surround then
				for _, surround_data in ipairs(data.surround) do
					surround_data.source:stop()
				end
			end
		end
	end
end

-- Lines 746-759
function CoreSoundEnvironmentManager:environment_at_position(pos)
	local environment = self._default_environment
	local ambience = self._default_ambience
	local occasional = self._default_occasional

	for _, area in ipairs(self._areas) do
		if area:is_inside(pos) then
			environment = area:environment()
			ambience = area:ambience_event()
			occasional = area:occasional_event()

			break
		end
	end

	return environment, ambience, occasional
end

-- Lines 762-774
function CoreSoundEnvironmentManager:apply_ambience_switch(switch_name, switch_value)
	self._current_switch_values = self._current_switch_values or {}

	for _, data in pairs(self._check_objects) do
		Application:trace("[CoreSoundEnvironmentManager:_apply_switch]  ", inspect(data), switch_name, switch_value)
		data.soundsource:set_switch(switch_name, switch_value)

		if data.surround then
			for _, surround_data in ipairs(data.surround) do
				surround_data.source:set_switch(switch_name, switch_value)
			end
		end
	end

	self._current_switch_values[switch_name] = switch_value
end

-- Lines 781-788
function CoreSoundEnvironmentManager:add_ambience_changed_callback(func, id)
	if id then
		self._ambience_changed_callbacks[id] = self._ambience_changed_callbacks[id] or {}

		table.insert(self._ambience_changed_callbacks[id], func)

		return
	end

	table.insert(self._ambience_changed_callback, func)
end

-- Lines 794-800
function CoreSoundEnvironmentManager:remove_ambience_changed_callback(func, id)
	if id and self._ambience_changed_callbacks[id] then
		table.delete(self._ambience_changed_callbacks[id], func)

		return
	end

	table.delete(self._ambience_changed_callback, func)
end

-- Lines 804-806
function CoreSoundEnvironmentManager:add_environment_changed_callback(func)
	table.insert(self._environment_changed_callback, func)
end

-- Lines 810-812
function CoreSoundEnvironmentManager:remove_environment_changed_callback(func)
	table.delete(self._environment_changed_callback, func)
end

-- Lines 814-833
function CoreSoundEnvironmentManager:destroy()
	for i, emitter in ipairs(self._emitters) do
		emitter:destroy()
	end

	self._emitters = {}

	for _, env_area in ipairs(self._areas) do
		env_area:remove()
	end

	self._areas = {}

	for i, area_emitter in ipairs(self._area_emitters) do
		area_emitter:destroy()
	end

	self._area_emitters = {}

	if self._occasional_sound_source then
		self._occasional_sound_source:stop()
	end
end

-- Lines 835-856
function CoreSoundEnvironmentManager:destroy_world_sounds(world_id)
	for i = #self._emitters, 1, -1 do
		local emitter = self._emitters[i]

		if emitter._world_id == world_id then
			self:remove_emitter(emitter)
		end
	end

	for i = #self._areas, 1, -1 do
		local env_area = self._areas[i]

		if env_area._world_id == world_id then
			self:remove_area(env_area)
		end
	end

	for i = #self._area_emitters, 1, -1 do
		local area = self._area_emitters[i]

		if area._world_id == world_id then
			self:remove_area_emitter(area)
		end
	end
end

SoundEnvironmentArea = SoundEnvironmentArea or class(CoreShapeManager.ShapeBox)

-- Lines 862-883
function SoundEnvironmentArea:init(params)
	params.type = "box"

	SoundEnvironmentArea.super.init(self, params)

	self._environment = params.environment or managers.sound_environment:game_default_environment()
	self._ambience_event = params.ambience_event or managers.sound_environment:game_default_ambience()
	self._occasional_event = params.occasional_event or managers.sound_environment:game_default_occasional()
	self._use_environment = params.use_environment or params.use_environment == nil and true
	self._use_ambience = params.use_ambience or params.use_ambience == nil and true
	self._use_occasional = params.use_occasional or params.use_occasional == nil and true
	self._gain = params.gain or 0
	self._name = params.name or ""
	self._enable = true

	self:_init_environment_effect()
	self:_init_event()

	self._environment_shape = EnvironmentShape(self:position(), self:size(), self:rotation())

	self:_add_environment()

	if Application:editor() then
		managers.sound_environment:add_soundbank(managers.sound_environment:ambience_soundbank(self._ambience_event))
		managers.sound_environment:add_soundbank(managers.sound_environment:occasional_soundbank(self._occasional_event))
	end
end

-- Lines 886-897
function SoundEnvironmentArea:_init_event()
	if Application:editor() then
		if not table.contains(managers.sound_environment:ambience_events(), self._ambience_event) then
			managers.editor:output_error("Ambience event " .. self._ambience_event .. " no longer exits. Falls back on default.")
			self:set_environment_ambience(managers.sound_environment:game_default_ambience())
		end

		if self._occasional_event and not table.contains(managers.sound_environment:occasional_events(), self._occasional_event) then
			managers.editor:output_error("Occasional event " .. self._occasional_event .. " no longer exits. Falls back on default.")
			self:set_environment_occasional(managers.sound_environment:game_default_occasional())
		end
	end
end

-- Lines 900-907
function SoundEnvironmentArea:_init_environment_effect()
	if Application:editor() and not table.contains(managers.sound_environment:environments(), self._environment) then
		managers.editor:output_error("Environment effect " .. self._environment .. " no longer exits. Falls back on default.")
		self:set_environment(managers.sound_environment:game_default_environment())
	end
end

-- Lines 909-913
function SoundEnvironmentArea:_add_environment()
	if self._use_environment and not self._environment_id then
		self._environment_id = SoundDevice:add_environment({
			effect = self._environment,
			gain = self._gain,
			shape = self._environment_shape
		})
	end
end

-- Lines 915-920
function SoundEnvironmentArea:_remove_environment()
	if self._environment_id then
		SoundDevice:remove_environment(self._environment_id)

		self._environment_id = nil
	end
end

-- Lines 922-924
function SoundEnvironmentArea:enable(enable)
	self._enable = enable
end

-- Lines 926-928
function SoundEnvironmentArea:name()
	return self._unit and self._unit:unit_data().name_id or self._name
end

-- Lines 930-932
function SoundEnvironmentArea:environment()
	return self._environment
end

-- Lines 934-937
function SoundEnvironmentArea:set_environment(environment)
	self._environment = environment

	self:_update_environment()
end

-- Lines 940-942
function SoundEnvironmentArea:ambience_event()
	return self._ambience_event
end

-- Lines 945-953
function SoundEnvironmentArea:set_environment_ambience(ambience_event)
	if not ambience_event then
		return
	end

	self._ambience_event = ambience_event

	if Application:editor() then
		managers.sound_environment:add_soundbank(managers.sound_environment:ambience_soundbank(self._ambience_event))
	end
end

-- Lines 955-957
function SoundEnvironmentArea:set_use_ambience(use_ambience)
	self._use_ambience = use_ambience
end

-- Lines 959-961
function SoundEnvironmentArea:use_ambience()
	return self._use_ambience
end

-- Lines 964-966
function SoundEnvironmentArea:occasional_event()
	return self._occasional_event
end

-- Lines 969-977
function SoundEnvironmentArea:set_environment_occasional(occasional_event)
	self._occasional_event = occasional_event

	if not occasional_event then
		return
	end

	if Application:editor() then
		managers.sound_environment:add_soundbank(managers.sound_environment:occasional_soundbank(self._occasional_event))
	end
end

-- Lines 979-981
function SoundEnvironmentArea:set_use_occasional(use_occasional)
	self._use_occasional = use_occasional
end

-- Lines 983-985
function SoundEnvironmentArea:use_occasional()
	return self._use_occasional
end

-- Lines 987-994
function SoundEnvironmentArea:set_use_environment(use_environment)
	self._use_environment = use_environment

	if self._use_environment then
		self:_add_environment()
	else
		self:_remove_environment()
	end
end

-- Lines 996-998
function SoundEnvironmentArea:use_environment()
	return self._use_environment
end

-- Lines 1000-1003
function SoundEnvironmentArea:set_unit(unit)
	SoundEnvironmentArea.super.set_unit(self, unit)
	self._environment_shape:link(unit:orientation_object())
end

-- Lines 1005-1009
function SoundEnvironmentArea:_update_environment()
	if self._environment_id then
		SoundDevice:update_environment(self._environment_id, {
			effect = self._environment,
			gain = self._gain,
			shape = self._environment_shape
		})
	end
end

-- Lines 1011-1014
function SoundEnvironmentArea:_update_environment_size()
	self._environment_shape:set_size(self:size())
	self:_update_environment()
end

-- Lines 1017-1020
function SoundEnvironmentArea:set_property(property, value)
	SoundEnvironmentArea.super.set_property(self, property, value)
	self:_update_environment_size()
end

-- Lines 1022-1025
function SoundEnvironmentArea:set_width(width)
	SoundEnvironmentArea.super.set_width(self, width)
	self:_update_environment_size()
end

-- Lines 1027-1031
function SoundEnvironmentArea:set_depth(depth)
	SoundEnvironmentArea.super.set_depth(self, depth)
	self:_update_environment_size()
end

-- Lines 1033-1037
function SoundEnvironmentArea:set_height(height)
	SoundEnvironmentArea.super.set_height(self, height)
	self:_update_environment_size()
end

-- Lines 1039-1042
function SoundEnvironmentArea:remove()
	self:_remove_environment()
end

-- Lines 1044-1049
function SoundEnvironmentArea:still_inside(pos)
	if not self._enable or not self._use_ambience then
		return false
	end

	return SoundEnvironmentArea.super.still_inside(self, pos)
end

-- Lines 1051-1056
function SoundEnvironmentArea:is_inside(pos)
	if not self._enable or not self._use_ambience then
		return false
	end

	return SoundEnvironmentArea.super.is_inside(self, pos)
end

SoundEnvironmentEmitter = SoundEnvironmentEmitter or class()

-- Lines 1062-1069
function SoundEnvironmentEmitter:init(params)
	self._position = params.position or Vector3()
	self._rotation = params.rotation or Rotation()
	self._name = params.name or ""
	self._soundsource = SoundDevice:create_source(self._name)
	local emitter_path = managers.sound_environment:game_default_emitter_path()

	self:set_emitter_event(params.emitter_event or managers.sound_environment:emitter_events(emitter_path)[1])
end

-- Lines 1072-1079
function SoundEnvironmentEmitter:save_xml(t)
	local properties = {
		name = self:name(),
		position = self:position(),
		rotation = self:rotation(),
		emitter_event = self._emitter_event
	}

	return simple_value_string("properties", properties, t)
end

-- Lines 1081-1083
function SoundEnvironmentEmitter:name()
	return self._unit and self._unit:unit_data().name_id or self._name
end

-- Lines 1086-1092
function SoundEnvironmentEmitter:emitter_path()
	for path, events in pairs(managers.sound_environment:emitter_events()) do
		if table.contains(events, self._emitter_event) then
			return path
		end
	end
end

-- Lines 1095-1097
function SoundEnvironmentEmitter:emitter_event()
	return self._emitter_event
end

-- Lines 1101-1112
function SoundEnvironmentEmitter:set_emitter_path(emitter_path)
	if not emitter_path then
		return
	end

	local current_path = self:emitter_path()

	if emitter_path == current_path then
		return
	end

	self:set_emitter_event(managers.sound_environment:emitter_events(emitter_path)[1])
end

-- Lines 1115-1121
function SoundEnvironmentEmitter:set_emitter_event(emitter_event)
	self._emitter_event = emitter_event

	if Application:editor() then
		managers.sound_environment:add_soundbank(managers.sound_environment:emitter_soundbank(self._emitter_event))
	end

	self:play_sound()
end

-- Lines 1123-1126
function SoundEnvironmentEmitter:set_unit(unit)
	self._unit = unit

	self._soundsource:link(self._unit:orientation_object())
end

-- Lines 1128-1130
function SoundEnvironmentEmitter:position()
	return self._unit and self._unit:position() or self._position
end

-- Lines 1132-1134
function SoundEnvironmentEmitter:set_position(position)
	self._position = position
end

-- Lines 1136-1138
function SoundEnvironmentEmitter:rotation()
	return self._unit and self._unit:rotation() or self._rotation
end

-- Lines 1140-1142
function SoundEnvironmentEmitter:set_rotation(rotation)
	self._rotation = rotation
end

-- Lines 1145-1156
function SoundEnvironmentEmitter:play_sound()
	if self._sound_event then
		self._sound_event:stop()
	end

	self._soundsource:stop()

	if self._unit then
		self._soundsource:link(self._unit:orientation_object())
	else
		self._soundsource:set_position(self:position())
	end

	self._sound_event = self._soundsource:post_event(self._emitter_event)
end

-- Lines 1158-1160
function SoundEnvironmentEmitter:restart()
	self:play_sound()
end

-- Lines 1162-1166
function SoundEnvironmentEmitter:draw(t, dt, r, g, b)
	Application:draw_sphere(self:position(), 75, r, g, b)
	Application:draw_cone(self:position(), self:position() + self:rotation():y() * 500, 500, r, g, b)
	Application:draw_cone(self:position(), self:position() - self:rotation():y() * 500, 500, r, g, b)
end

-- Lines 1168-1177
function SoundEnvironmentEmitter:destroy()
	if self._sound_event then
		self._sound_event:stop()

		self._sound_event = nil
	end

	if self._soundsource then
		self._soundsource:delete()

		self._soundsource = nil
	end
end

SoundEnvironmentAreaEmitter = SoundEnvironmentAreaEmitter or class(CoreShapeManager.ShapeBoxMiddle)

-- Lines 1183-1190
function SoundEnvironmentAreaEmitter:init(params)
	params.type = "box_middle"

	SoundEnvironmentAreaEmitter.super.init(self, params)

	self._properties.name = params.name or ""
	self._soundsource = SoundDevice:create_source(self._properties.name)
	local emitter_path = managers.sound_environment:game_default_emitter_path()

	self:set_emitter_event(params.emitter_event or managers.sound_environment:emitter_events(emitter_path)[1])
end

-- Lines 1192-1195
function SoundEnvironmentAreaEmitter:save(...)
	self._properties.name = self:name()

	return SoundEnvironmentAreaEmitter.super.save(self, ...)
end

-- Lines 1197-1199
function SoundEnvironmentAreaEmitter:name()
	return self._unit and self._unit:unit_data().name_id or self._name
end

-- Lines 1202-1208
function SoundEnvironmentAreaEmitter:emitter_path()
	for path, events in pairs(managers.sound_environment:emitter_events()) do
		if table.contains(events, self._properties.emitter_event) then
			return path
		end
	end
end

-- Lines 1211-1213
function SoundEnvironmentAreaEmitter:emitter_event()
	return self._properties.emitter_event
end

-- Lines 1216-1227
function SoundEnvironmentAreaEmitter:set_emitter_path(emitter_path)
	if not emitter_path then
		return
	end

	local current_path = self:emitter_path()

	if emitter_path == current_path then
		return
	end

	self:set_emitter_event(managers.sound_environment:emitter_events(emitter_path)[1])
end

-- Lines 1229-1235
function SoundEnvironmentAreaEmitter:set_emitter_event(emitter_event)
	self._properties.emitter_event = emitter_event

	if Application:editor() then
		managers.sound_environment:add_soundbank(managers.sound_environment:emitter_soundbank(self._properties.emitter_event))
	end

	self:play_sound()
end

-- Lines 1237-1248
function SoundEnvironmentAreaEmitter:play_sound()
	if self._sound_event then
		self._sound_event:stop()
	end

	if self._unit then
		self._soundsource:link(self._unit:orientation_object())
	else
		self._soundsource:set_position(self:position())
	end

	self._sound_event = self._soundsource:post_event(self._properties.emitter_event)
end

-- Lines 1250-1255
function SoundEnvironmentAreaEmitter:set_extent()
end

-- Lines 1257-1259
function SoundEnvironmentAreaEmitter:extent()
	return Vector3(self._properties.width / 2, self._properties.depth / 2, self._properties.height / 2)
end

-- Lines 1261-1264
function SoundEnvironmentAreaEmitter:set_property(...)
	SoundEnvironmentAreaEmitter.super.set_property(self, ...)
	self:set_extent()
end

-- Lines 1266-1269
function SoundEnvironmentAreaEmitter:set_unit(unit)
	SoundEnvironmentAreaEmitter.super.set_unit(self, unit)
	self._soundsource:link(self._unit:orientation_object())
end

-- Lines 1271-1273
function SoundEnvironmentAreaEmitter:restart()
	self:play_sound()
end

-- Lines 1275-1284
function SoundEnvironmentAreaEmitter:destroy()
	if self._sound_event then
		self._sound_event:stop()

		self._sound_event = nil
	end

	if self._soundsource then
		self._soundsource:delete()

		self._soundsource = nil
	end
end