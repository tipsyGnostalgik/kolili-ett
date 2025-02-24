if IsSMOnlineLoggedIn() then
	CloseConnection()
end

profilenum = 0
--[[ if event.type == "InputEventType_Release" and event.DeviceInput.button == "DeviceButton_escape" then
	p = p+1
end ]]--

local profileID = PROFILEMAN:GetLocalProfileIDFromIndex(profilenum)
local profile=PROFILEMAN:GetLocalProfileFromIndex(profilenum)
local yourname = profile:GetDisplayName()

local function BindChangeProfile(event)

	if event.type == "InputEventType_FirstPress" then
		if event.DeviceInput.button == "DeviceButton_w" and profilenum < PROFILEMAN:GetNumLocalProfiles()-1 then
			profilenum = profilenum + 1
			MESSAGEMAN:Broadcast("UpdateProfileNum")
            SOUND:PlayOnce(THEME:GetPathS("", "Common Value"))
		elseif event.DeviceInput.button == "DeviceButton_q" and profilenum > 0 then
			profilenum = profilenum - 1
			MESSAGEMAN:Broadcast("UpdateProfileNum")
            SOUND:PlayOnce(THEME:GetPathS("", "Common Value"))
		end
	end

	return profilenum
end

t = Def.ActorFrame{}

local scrollerX = 99 / 1920 * SCREEN_WIDTH
local scrollerY = 440 / 1920 * SCREEN_HEIGHT
local selectorHeight = 37 / 1080 * SCREEN_HEIGHT
local selectorWidth = 574 / 1920 * SCREEN_WIDTH

local menuscreenslol = {
	"yn",
	"drn",
	"dflow",
	"megaman2"
}

t[#t+1] = LoadActor(menuscreenslol[math.random(#menuscreenslol)])
--t[#t+1] = LoadActor("dflow")

t[#t+1] = LoadFont("Common Normal") .. {
	InitCommand=function(self)
		self:xy(5,5):zoom(0.4):valign(0):halign(0)
	end,
	OnCommand=function(self)
		self:settext(string.format("%s %s",ProductFamily(),ProductVersion()))
	end
}

t[#t+1] = Def.ActorFrame {
    Name = "some frame on the screen",
    BeginCommand = function(self)
        --i'm not sure if adding many of these is a good idea
        --so try to combine the binds into a few functions instead of having a billion of them
        SCREENMAN:GetTopScreen():AddInputCallback(BindChangeProfile)
    end
}

t[#t+1] = LoadFont("_176mksd") .. {
	InitCommand=function(self)
		self:xy(5,16):zoom(0.2):valign(0):halign(0)
	end,
	OnCommand=function(self)
		self:settext(string.format("%s Songs in %s Groups",SONGMAN:GetNumSongs(),SONGMAN:GetNumSongGroups()))
	end
}

t[#t+1] = LoadFont("_176mksd") .. {
	InitCommand=function(self)
		self:xy(5,SCREEN_HEIGHT-15):zoom(0.2):valign(1):halign(0)
	end,
	OnCommand=function(self)
		if IsNetSMOnline() then
			self:settext("Online")
			self:diffuse(getMainColor('enabled'))
		else
			self:settext("Offline")
			self:diffuse(getMainColor('disabled'))
		end
	end
}

t[#t+1] = LoadFont("_nikkyou sans") .. {
	InitCommand=function(self)
		self:xy(5,SCREEN_HEIGHT-5):zoom(0.12):valign(1):halign(0):diffuse(color("#666666"))
	end,
	OnCommand=function(self)
		if IsNetSMOnline() then
			self:settext(GetServerName())
			self:diffuse(color("#FFFFFF"))
		else
			self:settext("Not Available")
		end
	end
}

--[[
local profileID = PROFILEMAN:GetLocalProfileIDFromIndex(profilenum)
local profile=PROFILEMAN:GetLocalProfileFromIndex(profilenum)
local yourname = profile:GetDisplayName()
]]

t[#t+1] = Def.Sprite {
	InitCommand = function (self) 
		self:Load(getAssetPathFromProfileID("avatar", profileID))
		self:xy(SCREEN_WIDTH-100, SCREEN_HEIGHT-45)
		self:rotationz(0)
		:draworder(10)
		self:visible(true)
		self:zoomto(100,100)
		self:sleep(1)
		self:easeOut(0.5)
		self:addx(65)
		self:rotationz(0)
		self:zoomto(50,50)
	end,
	UpdateProfileNumMessageCommand = function(self)
		self:stoptweening():Load(getAssetPathFromProfileID("avatar", PROFILEMAN:GetLocalProfileIDFromIndex(profilenum)))
		self:rotationz(0)
		:zoomto(50,50)
		:draworder(10)
		self:visible(true)
		self:easeOut(0.5)
	end
}


t[#t+1] = Def.Quad {
	InitCommand = function(self)
		self:zoomto(50,50):xy(SCREEN_WIDTH-35, SCREEN_HEIGHT-45):draworder(-2):diffusealpha(0)
	end,
	OnCommand = function(self)
		self:sleep(2)
		:draworder(9)
		:halign(1)
		:easeOut(1)
		:diffuse(color("#FCBBFC"))
		:diffusealpha(0.3)
		:zoomx(22 + (string.len(yourname)*21))
		:addx(-10)
		:skewx(-0.07)
	end,
	UpdateProfileNumMessageCommand = function(self)
		self:stoptweening():easeOut(0.35):zoomx((22 + (string.len(PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetDisplayName())*21)))
	end
}

t[#t+1] = Def.Quad {
	InitCommand = function(self)
		self:zoomto(50,50):xy(SCREEN_WIDTH-35, SCREEN_HEIGHT-45):draworder(-2):diffusealpha(0)
	end,
	OnCommand = function(self)
		self:sleep(2)
		:draworder(9)
		:halign(1)
		:easeOut(1)
		:diffuse(color("#DA88DA"))
		--:diffuse(getMSDColor(lolocalrating))
		:diffusealpha(0.6)
		:skewx(-0.07)
		:zoomx((22 + (string.len(yourname)*21)) + 70)
		:addx(-10)
	end,
	UpdateProfileNumMessageCommand = function(self)
		local lolocalrating = PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetPlayerRating()
		--self:diffuse(getMSDColor(lolocalrating)):diffusealpha(0.6)
		self:stoptweening():easeOut(0.35):zoomx((22 + (string.len(PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetDisplayName())*21)) + 70)
	end
}

t[#t+1] = LoadFont("_176menuksd") .. {
	InitCommand=function(self)
		self:settext(profile:GetDisplayName()):zoom(0.4):xy(SCREEN_WIDTH,SCREEN_HEIGHT-50):draworder(-2):halign(1)
	end,
	OnCommand=function(self)
		self:sleep(0.7):easeOut(0.5):addx(-65)
	end,
	UpdateProfileNumMessageCommand = function(self)
		self:settext(PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetDisplayName())
	end
}

t[#t+1] = LoadFont("_176mksd") .. {
	InitCommand=function(self)
		self:settext("Use Q and W to Change Profile."):xy(SCREEN_WIDTH-15,SCREEN_HEIGHT-40):draworder(-2):zoom(0.12):diffusealpha(0)
	end,
	OnCommand=function(self)
		self:sleep(1.8):easeOut(0.5):addy(30):addx(-120):diffusealpha(1):rotationz(0)
	end
}



t[#t+1] = LoadFont("_176mksd") .. {
	InitCommand=function(self)
		localrating = PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetPlayerRating()
		if localrating < 8 then
			self:settextf("N/A")
		else
		self:settextf("%0.2f",localrating)
		end
		self:AddAttribute(#"Skill Rating:", {Length = -1, Zoom =0.4 ,Diffuse = getMSDColor(localrating)})
		:xy(SCREEN_WIDTH-45,SCREEN_HEIGHT-45):draworder(-2):zoom(0.3):diffuse(getMSDColor(localrating)):diffusealpha(0):halign(1)
	end,
	OnCommand=function(self)
		self:sleep(1.8):easeOut(0.5):addx(-30 - (string.len(yourname)*21)):diffusealpha(1):rotationz(0)
	end,
	UpdateProfileNumMessageCommand = function(self)
		local lolocalrating = PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetPlayerRating()
		self:stoptweening()
		if lolocalrating < 8 then
			self:settext("N/A"):diffuse(color"#000000")
		else
		self:settextf("%0.2f",lolocalrating):diffuse(getMSDColor(lolocalrating))
		end

		--:xy(SCREEN_WIDTH-45,SCREEN_HEIGHT-45)
		self:easeOut(0.35)
		:x(((SCREEN_WIDTH-45) - 30) - (string.len(PROFILEMAN:GetLocalProfileFromIndex(profilenum):GetDisplayName())*21))
	end
}

return t