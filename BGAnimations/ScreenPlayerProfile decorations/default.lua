local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite {
	InitCommand = function(self)
		self:Load(getCardPath(PLAYER_1)):halign(0):valign(0)
		self:zoom(SCREEN_WIDTH/536)
	end
}

	t[#t + 1] = Def.Sprite{
		Name = "BG",
		Texture = THEME:GetPathG("","profbggg"),
		InitCommand = function(self)
			self:FullScreen()
		end
	}

	t[#t + 1] = Def.Sprite{
		Name = "Lines",
		Texture = THEME:GetPathG("","LineGradient"),
		InitCommand = function(self)
			self:FullScreen()
		end
	}

t[#t+1] = LoadActor("profilecard") .. {
	InitCommand = function(self)
		self:xy(10,80)
		self:delayedFadeIn(0)
	end
}

t[#t+1] = LoadActor("ssrbreakdown") .. {
	InitCommand = function(self)
		self:xy(160,295)
		self:delayedFadeIn(1)
	end
}

t[#t+1] = LoadActor("infobox") .. {
	InitCommand = function(self)
		self:xy(320,30)
		self:delayedFadeIn(2)
	end
}

return t