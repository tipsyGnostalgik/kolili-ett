local showVisualizer = true

local song = GAMESTATE:GetCurrentSong()

local function input(event)
	if event.DeviceInput.button == "DeviceButton_left mouse button" and event.type == "InputEventType_Release" then
	elseif event.DeviceInput.button == "DeviceButton_right mouse button" and event.type == "InputEventType_Release" then
	end
	return false
end

local function chartprevieww(event)

	if event.type == "InputEventType_FirstPress" and song ~= nil then
		if event.DeviceInput.button == "DeviceButton_space" then
			MESSAGEMAN:Broadcast("comehere")
            SOUND:PlayOnce(THEME:GetPathS("", "Common Value"))
			SCREENMAN:SetNewScreen("ScreenChartPreview")

		end
	end

	return false
end

local function highlight(self)
	self:GetChild("rando"):queuecommand("Highlight")
end

local function highlightIfOver(self)
	if isOver(self) then
		self:diffusealpha(0.6)
	else
		self:diffusealpha(0.2)
	end
end

local t =
	Def.ActorFrame {
	BeginCommand = function(self)
		self:SetUpdateFunction(highlight)
		self:SetUpdateFunctionInterval(0.025)
		local s = SCREENMAN:GetTopScreen()
		s:AddInputCallback(input)
	end
}

t[#t + 1] =
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(SCREEN_WIDTH,28):halign(0):valign(0):diffuse(color("#000000")):diffusealpha(0.8)
		end
}

t[#t+1] = Def.ActorFrame {
    Name = "some frame on the screen",
    BeginCommand = function(self)
        --i'm not sure if adding many of these is a good idea
        --so try to combine the binds into a few functions instead of having a billion of them
        SCREENMAN:GetTopScreen():AddInputCallback(chartprevieww)
    end
}

t[#t + 1] =
	LoadFont("_176mksd")..{
		InitCommand = function (self)
			song = GAMESTATE:GetCurrentSong()
			local group

			self:halign(1):valign(0):x(SCREEN_WIDTH-10)
			self:zoom(27/100)
			self:settext(group or " ")
		end,

		CurrentStepsChangedMessageCommand = function (self)
			song = GAMESTATE:GetCurrentSong()
			local group
			if song == nil then
				group = " "
			else
			group = song:GetGroupName()
			end
			
			self:settext(group or " ")
		end
	}

t[#t + 1] =
	Def.Actor {
	CodeMessageCommand = function(self, params)
		if params.Name == "AvatarShow" and getTabIndex() == 0 and not SCREENMAN:get_input_redirected(PLAYER_1) then
			SCREENMAN:SetNewScreen("ScreenAssetSettings")
		end
	end
}

t[#t + 1] = LoadActor("../_djframe")
t[#t + 1] = LoadActor("../_PlayerInfo")


t[#t + 1] = LoadActor("currentsort")
t[#t + 1] =
	LoadFont("Common Normal") ..
	{
		Name="rando",
		InitCommand = function(self)
			self:xy(75, 22):halign(0):valign(1):zoom(0.35):diffuse(getMainColor("positive")):diffusealpha(0.2)
			self:settext("SONG SELECT")
		end,
		HighlightCommand=function(self)
			highlightIfOver(self)
		end,
		MouseLeftClickMessageCommand = function(self)
			if isOver(self) then
				local t = SONGMAN:GetAllSongs()
				local random_song = t[math.random(#t)]
				SCREENMAN:GetTopScreen():GetMusicWheel():SelectSong(random_song)
			end
		end
	}

--[[t[#t + 1] = LoadFont("_176mksd")..{
	Text=getSongPreviewMode(),
	InitCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y):zoom(0.3)
	end
	}
]]
t[#t + 1] = LoadActor("../_mouse")
t[#t + 1] = LoadActor("../_cursor")
t[#t + 1] = LoadActor("../_halppls")
t[#t + 1] = LoadActor("currenttime")



GAMESTATE:UpdateDiscordMenu(
	GetPlayerOrMachineProfile(PLAYER_1):GetDisplayName() ..
		": " .. string.format("%5.2f", GetPlayerOrMachineProfile(PLAYER_1):GetPlayerRating())
)

File.Write("nowplaying.txt", " ")
return t