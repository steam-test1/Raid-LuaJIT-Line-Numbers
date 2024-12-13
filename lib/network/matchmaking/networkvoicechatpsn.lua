NetworkVoiceChatPSN = NetworkVoiceChatPSN or class()

-- Lines 29-41
function NetworkVoiceChatPSN:init()
	self._started = false
	self._room_id = nil
	self._team = 1
	self._restart_session = nil
	self._peers = {}

	self:_load_globals()

	self._muted_players = {}
end

-- Lines 43-44
function NetworkVoiceChatPSN:check_status_information()
end

-- Lines 46-47
function NetworkVoiceChatPSN:open()
end

-- Lines 49-51
function NetworkVoiceChatPSN:voice_type()
	return "voice_psn"
end

-- Lines 53-54
function NetworkVoiceChatPSN:pause()
end

-- Lines 56-57
function NetworkVoiceChatPSN:resume()
end

-- Lines 59-61
function NetworkVoiceChatPSN:set_volume(volume)
	PSNVoice:set_volume(volume)
end

-- Lines 63-71
function NetworkVoiceChatPSN:init_voice()
	if self._started == false and not self._starting then
		self._starting = true

		PSNVoice:assign_callback(function (...)
			self:_callback(...)
		end)
		PSNVoice:init(4, 4, 50, 8000)
		self:set_volume(managers.user:get_setting("voice_volume"))

		self._started = true
	end
end

-- Lines 72-87
function NetworkVoiceChatPSN:destroy_voice(disconnected)
	if self._started == true then
		self._started = false

		if self._room_id and not disconnected then
			self:close_session()
		end

		PSNVoice:destroy()

		self._closing = nil
		self._room_id = nil
		self._restart_session = nil
		self._team = 1
	end
end

-- Lines 89-101
function NetworkVoiceChatPSN:num_peers()
	local l = PSNVoice:get_players_info()

	if l then
		local x = 0

		for k, v in pairs(l) do
			if v.joined == 1 then
				x = x + 1
			end
		end

		return x >= #l
	end

	return true
end

-- Lines 103-134
function NetworkVoiceChatPSN:open_session(roomid)
	if self._room_id and self._room_id == roomid then
		print("Voice: same_room")

		return
	end

	if self._restart_session and self._restart_session == roomid then
		print("Voice: restart")

		return
	end

	if self._closing or self._joining then
		print("Voice: closing|joining")

		self._restart_session = roomid

		return
	end

	if self._started == false then
		self._restart_session = roomid

		self:init_voice()
	end

	if self._room_id then
		print("Voice: restart room")

		self._restart_session = roomid

		self:close_session()

		return
	end

	self._room_id = roomid
	self._joining = true

	PSNVoice:start_session(roomid)
end

-- Lines 136-155
function NetworkVoiceChatPSN:close_session()
	if self._joining then
		self._close = true

		return
	end

	if self._room_id and not self._closing then
		self._closing = true

		if not PSNVoice:stop_session() then
			self._closing = nil
			self._room_id = nil
			self._delay_frame = TimerManager:wall():time() + 1
		end
	elseif not self._closing then
		self._restart_session = nil
		self._delay_frame = nil
	end
end

-- Lines 157-159
function NetworkVoiceChatPSN:open_channel_to(player_info, context)
	print("NetworkVoiceChatPSN:open_channel_to")
end

-- Lines 161-164
function NetworkVoiceChatPSN:close_channel_to(player_info)
	print("NetworkVoiceChatPSN:close_channel_to")
	PSNVoice:stop_sending_to(player_info._name)
end

-- Lines 166-167
function NetworkVoiceChatPSN:lost_peer(peer)
end

-- Lines 169-175
function NetworkVoiceChatPSN:close_all()
	if self._room_id then
		self:close_session()
	end

	self._room_id = nil
	self._closing = nil
end

-- Lines 177-183
function NetworkVoiceChatPSN:set_team(team)
	if self._room_id then
		PSN:change_team(self._room_id, PSN:get_local_userid(), team)
		PSNVoice:set_team_target(team)
	end

	self._team = team
end

-- Lines 186-192
function NetworkVoiceChatPSN:clear_team()
	if self._room_id and PSN:get_local_userid() then
		PSN:change_team(self._room_id, PSN:get_local_userid(), 1)
		PSNVoice:set_team_target(1)

		self._team = 1
	end
end

-- Lines 197-199
function NetworkVoiceChatPSN:set_drop_in(data)
	self._drop_in = data
end

-- Lines 201-228
function NetworkVoiceChatPSN:_load_globals()
	if Global.psn and Global.psn.voice then
		self._started = Global.psn.voice.started
	end

	if PSN:is_online() and Global.psn and Global.psn.voice then
		PSNVoice:assign_callback(function (...)
		end)

		self._room_id = Global.psn.voice.room
		self._team = Global.psn.voice.team

		if Global.psn.voice.drop_in then
			self:open_session(Global.psn.voice.drop_in.room_id)
		end

		if Global.psn.voice.restart then
			self._restart_session = restart
			self._delay_frame = TimerManager:wall():time() + 2
		else
			PSNVoice:assign_callback(function (...)
				self:_callback(...)
			end)

			if self._room_id then
				self:set_team(self._team)
			end
		end

		Global.psn.voice = nil
	end
end

-- Lines 229-258
function NetworkVoiceChatPSN:_save_globals(disable_voice)
	if disable_voice == nil then
		return
	end

	if not Global.psn then
		Global.psn = {}
	end

	-- Lines 238-238
	local function f(...)
	end

	PSNVoice:assign_callback(f)

	Global.psn.voice = {
		started = self._started,
		drop_in = self._drop_in
	}

	if type(disable_voice) == "boolean" then
		if disable_voice == true then
			Global.psn.voice.room = self._room_id
			Global.psn.voice.team = self._team
		else
			Global.psn.voice.team = 1
		end
	else
		self:close_all()

		Global.psn.voice.restart = disable_voice
		Global.psn.voice.team = 1
	end
end

-- Lines 260-301
function NetworkVoiceChatPSN:_callback(info)
	if info and PSN:get_local_userid() then
		if info.load_succeeded ~= nil then
			self._starting = nil

			if info.load_succeeded then
				self._started = true
				self._delay_frame = TimerManager:wall():time() + 1
			end

			return
		end

		if info.join_succeeded ~= nil then
			self._joining = nil

			if info.join_succeeded == false then
				self._room_id = nil
			else
				self:set_team(self._team)
			end

			if self._restart_session then
				self._delay_frame = TimerManager:wall():time() + 1
			end

			if self._close then
				self._close = nil

				self:close_session()
			end
		end

		if info.leave_succeeded ~= nil then
			self._closing = nil
			self._room_id = nil

			if self._restart_session then
				self._delay_frame = TimerManager:wall():time() + 1
			end
		end

		if info.unload_succeeded ~= nil then
			-- Lines 297-297
			local function f(...)
			end

			PSNVoice:assign_callback(f)
		end
	end
end

-- Lines 303-313
function NetworkVoiceChatPSN:update()
	if self._delay_frame and self._delay_frame < TimerManager:wall():time() then
		self._delay_frame = nil

		if self._restart_session then
			PSNVoice:assign_callback(function (...)
				self:_callback(...)
			end)

			local r = self._restart_session
			self._restart_session = nil

			self:open_session(r)
		end
	end
end

-- Lines 315-320
function NetworkVoiceChatPSN:psn_session_destroyed(roomid)
	if self._room_id and self._room_id == roomid then
		self._room_id = nil
		self._closing = nil
	end
end

-- Lines 323-336
function NetworkVoiceChatPSN:_get_peer_user_id(peer)
	if not self._room_id then
		return
	end

	local members = PSN:get_info_session(self._room_id).memberlist
	local name = peer:name()

	for i, member in ipairs(members) do
		if tostring(member.user_id) == name then
			return member.user_id
		end
	end
end

-- Lines 338-341
function NetworkVoiceChatPSN:mute_player(mute, peer)
	self._muted_players[peer:name()] = mute

	PSNVoice:mute_player(mute, peer:name())
end

-- Lines 344-346
function NetworkVoiceChatPSN:is_muted(peer)
	return self._muted_players[peer:name()] or false
end
