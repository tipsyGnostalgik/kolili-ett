local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="transition.png",
	InitCommand=function(self)
		self:SetTextureFiltering(true)
		self:zoom(3)
		:draworder(3)
	end,
	OnCommand=function(self)
		self:zoom(20)
		:y(300)
		:x(10500)
		:easeOut(0.4)
		:zoom(1)
		:FullScreen()
	end
}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:FullScreen()
		:diffuse(color("#a947ff"))
		:draworder(2)
		:diffusealpha(0)
	end,
	
	OnCommand=function(self)
		self:sleep(0.1)
		self:easeOut(0.4)
		:diffusealpha(1)
	end
}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:zoomto( 0,0 )
		:x(-SCREEN_WIDTH/2)
		:y(SCREEN_HEIGHT/2)
		:diffuse(color("#a947ff"))
		:draworder(4)
	end,
	OnCommand=function(self)
	self:sleep(0.4)
	self:easeOut(1)
	:addx(SCREEN_WIDTH)
	:addy(10)
	self:zoomto( SCREEN_WIDTH,5 )
	end
}

return t