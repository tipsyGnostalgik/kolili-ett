local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="transition.png",
	InitCommand=function(self)
		self:SetTextureFiltering(true)
		self:draworder(3)
		self:zoom(1)
	end,
	OnCommand=function(self)
		self:zoom(SCREEN_HEIGHT/1080)
		:halign(0):valign(0)
		:xy(0,0)
		:diffusealpha(1)
		:sleep(0.5)
		:easeOut(0.5)
		:diffusealpha(0)
		:zoom(3)
		:y(300)
		:x(10500)
	end
}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:FullScreen()
		self:diffuse(color("#a947ff"))
		self:draworder(2)
		self:diffusealpha(1)
	end,
	OnCommand=function(self)
		self:sleep(0.3)
		self:easeOut(0.4)
		self:diffusealpha(0)
	end
}


t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:zoomto( SCREEN_WIDTH,5 )
		:x(SCREEN_WIDTH/2)
		:y((SCREEN_HEIGHT/2) + 10)
		:diffuse(color("#a947ff"))
		:draworder(4)
	end,
	OnCommand=function(self)
	self:sleep(0)
	self:easeOut(1)
	:diffusealpha(0)
	:addy(10)
	:zoomto( SCREEN_WIDTH,0 )
	end
}

return t