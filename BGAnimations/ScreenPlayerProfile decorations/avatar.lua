local avatarHeight = 75
local avatarWidth = 75
local CardWidth = 335
local avatarBorder = 3
local pn = GAMESTATE:GetEnabledPlayers()[1]
local profile = PROFILEMAN:GetProfile(pn)
local x = 0
local y = 0

local t = Def.ActorFrame{
	InitCommand = function (self)
		self:xy(x,y)
	end
}

t[#t+1] = Def.Quad{
		InitCommand = function(self)
			self:zoomto(avatarHeight+avatarBorder*2,avatarWidth+avatarBorder*2)
			self:diffuse(getBorderColor())
		end
	}

	t[#t+1] = Def.Quad{
		InitCommand = function(self)
			self:zoomto(avatarHeight+avatarBorder*2,avatarWidth+avatarBorder*2)
			self:diffusealpha(0.8)
		end,
		BeginCommand = function(self)
			self:diffuseramp()
			self:effectcolor2(color("1,1,1,0.6"))
			self:effectcolor1(color("1,1,1,0"))
			self:effecttiming(2,1,0,0)
		end
	}

	t[#t+1] = quadButton(3) .. {
		InitCommand = function(self)
			self:zoomto(avatarHeight+avatarBorder*2,avatarWidth+avatarBorder*2)
			self:visible(false)
		end,
		MouseDownCommand = function(self, params)
			if params.button == "DeviceButton_left mouse button" then
				SCREENMAN:AddNewScreenToTop("ScreenAssetSettings")
			end
		end
	}

	-- Avatar

	t[#t + 1] = Def.Sprite {
		Name = "Mask image 1",
		Texture = THEME:GetPathG("","mask_profav"),
		InitCommand = function(self)
			--this part just sets position and size, nothing special
			self:zoomto(avatarHeight,avatarWidth)
		end,
		OnCommand = function(self)
			--this is where the magic happens.
			--use MaskSource() on the mask and
			--then use MaskDest() on the image
			--that's going to be masked. MaskDest()
			--will refer back to the same MaskSource()
			--until another MaskSource() is used again
			--so you can use MaskDest() multiple times
			--for the same MaskSource() if you want
			self:MaskSource()
		end
	}

	t[#t+1] = Def.Sprite {
		InitCommand = function (self) self:playcommand("ModifyAvatar") end,
		PlayerJoinedMessageCommand = function(self) self:queuecommand('ModifyAvatar') end,
		PlayerUnjoinedMessageCommand = function(self) self:queuecommand('ModifyAvatar') end,
		AvatarChangedMessageCommand = function(self) self:queuecommand('ModifyAvatar') end,
		ModifyAvatarCommand = function(self)
			self:visible(true)
			self:Load(getAvatarPath(PLAYER_1))
			self:zoomto(avatarHeight,avatarWidth)
		end,
		OnCommand = function(self)
			self:MaskDest()
		end
	}

return t