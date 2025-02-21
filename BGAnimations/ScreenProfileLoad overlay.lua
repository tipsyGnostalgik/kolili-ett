local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="transition.png",
	InitCommand=function(self)
		self:zoom(1)
		:SetTextureFiltering(true)
		:draworder(3)
		:FullScreen()
	end
}


t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:FullScreen()
		self:diffuse(color("#a947ff"))
		self:draworder(2)
		self:diffusealpha(1)
	end
}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:zoomto( SCREEN_WIDTH,5 )
		:x(SCREEN_WIDTH/2)
		:y((SCREEN_HEIGHT/2) + 10)
		:diffuse(color("#a947ff"))
		:draworder(4)
	end
}

t[#t+1] = LoadFont("_176mksd")..{
	InitCommand = function(self)
		self:xy( 120,SCREEN_HEIGHT/2):draworder(4):diffuse(color("#a947ff")):diffusealpha(0):zoom(0.25)
		self:settext("Loading Profiles...")
	end,
	OnCommand=function(self)
		self:easeOut(0.25):addy(30):diffusealpha(1)
	end
}



t[#t+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1) end
		self:queuecommand("Load")
	end,
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
}

return t