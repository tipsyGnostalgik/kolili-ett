t = Def.ActorFrame{}

local song = GAMESTATE:GetCurrentSong()

t[#t+1] = Def.Quad{
    InitCommand = function (self)
        self:FullScreen():diffuse(color("#000000")):diffusealpha(1):draworder(99)
    end,
    OnCommand = function (self)
        self:sleep(0):easeOut(0.2):diffusealpha(0)
    end
}

t[#t+1] = Def.Sprite{
	InitCommand=function(self)
		self:Load(getAvatarPath(PLAYER_1))
		self:x(SCREEN_WIDTH/2):y(SCREEN_HEIGHT/2):zoomto(128,128):rotationy(-40):easeOut(0.7):rotationy(0):addx(-250)
	end
}

t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand  = function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+75)
		self:zoom(0.4)
		self:halign(0)
		self:diffuse(color("#000000"))
		self:settext(getCurrentUsername(p1))
		self:easeOut(0.75):addx(-300)
	end
}

t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand  = function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-95)
		self:zoom(0.4)
		self:diffuse(color("#000000"))
		self:settext("Player:")
		self:easeOut(0.75):addx(-250)
	end
}

t[#t+1] = Def.Sprite {
	Name = "Banner",
	InitCommand = function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
		local bnpath = song:GetBannerPath()
		if not bnpath then
			bnpath = THEME:GetPathG("Common", "fallback banner")
		end
		self:LoadBackground(bnpath)
		self:scaletoclipped(96, 30)
		self:zoom(3)
		self:diffusealpha(0.3)
		self:skewy(0.1)
	end,
	OnCommand = function (self)
		self:easeOut(0.5):zoom(2):easeIn(0.5):zoom(0)
	end
}

t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand = function (self)
		self:diffuse(color("#000000")):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-10)
		self:zoom(0.4)
		self:maxwidth(1000)
		self:settext(song:GetMainTitle())
	end
}

t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand = function (self)
		self:diffuse(color("#000000")):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+20)
		self:zoom(0.3)
		self:maxwidth(450)
		self:settext(song:GetDisplayArtist())
	end
}

return t