local allowedCustomization = playerConfig:get_data(pn_to_profile_slot(PLAYER_1)).CustomizeGameplay
local fullPlayerInfo = themeConfig:get_data().global.PlayerInfoType -- true for full, false for minimal (lifebar only)
--Avatar frames which also includes current additive %score, mods, and the song stepsttype/difficulty.
local profileP1

local buddyPosition = {
	--[[
	X = MovableValues.PlayerInfoP1X,
	Y = MovableValues.PlayerInfoP1Y ]]
	X = 400,
	Y = 200
}

local function PLife(pn)
	local life = STATSMAN:GetCurStageStats():GetPlayerStageStats():GetCurrentLife() or 0
	if life < 0 then
		return 0
	else
		return life
	end
end

local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats()
local profile = GetPlayerOrMachineProfile(PLAYER_1)

-- whole frame actorframe
local t = Def.ActorFrame {
	OnCommand = function(self)
		self:xy(buddyPosition.X,buddyPosition.Y)
		self:zoomto(MovableValues.PlayerInfoP1Width, MovableValues.PlayerInfoP1Height)
		if (allowedCustomization) then
			Movable.DeviceButton_j.element = self
			Movable.DeviceButton_j.condition = true
			Movable.DeviceButton_k.element = self
			Movable.DeviceButton_k.condition = true
		end
	end,
}

if fullPlayerInfo then
	-- whole frame bg quad

	t[#t+1] = Def.Sprite {
		InitCommand = function(self)
			self:halign(0):valign(0)
		end,
		BeginCommand = function(self) self:queuecommand('ModifyAvatar') end,
		ModifyAvatarCommand=function(self)
			self:finishtweening()
			self:Load(getBuddyPath(PLAYER_1)):addx(50)
			self:zoom(100/815)
		end,
		MissCommand = function ()
			self:diffusealpha(0.3):easeOut(0.3):diffusealpha(1)
		end
	}
end

return t