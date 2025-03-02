local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="transition.png",
	InitCommand=function(self)
		self:SetTextureFiltering(true)
		self:zoom(3)
		:draworder(3)
	end,
	OnCommand=function(self)
		self:halign(0):valign(0)
		:zoom(20)
		:y(-SCREEN_CENTER_Y)
		:easeOut(0.4)
		:xy(0,0)
		:zoom(SCREEN_HEIGHT/1080)
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