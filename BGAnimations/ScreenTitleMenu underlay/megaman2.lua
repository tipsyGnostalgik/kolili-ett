t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="mm2/tower.png",
	InitCommand=function(self)
		self:sleep(1)
		self:draworder(-3)
		self:SetTextureFiltering(false)
		self:halign(1)
		:zoom(2)
		self:x(SCREEN_WIDTH)
		self:y(SCREEN_CENTER_Y)
		self:easeOut(0.5)
		self:addy(478.5)
	end	
}

t[#t+1] = Def.Sprite{
	Texture="mm2/city.png",
	InitCommand=function(self)
		self:sleep(1)
		self:draworder(-4)
		self:SetTextureFiltering(false)
		self:halign(1)
		:zoom(2)
		self:x(SCREEN_WIDTH)
		self:y(SCREEN_CENTER_Y)
		self:easeOut(0.5)
		self:addy(340)

	end	
}

t[#t+1] = Def.Sprite{
	Texture="mm2/rockman 2x1.png",
	InitCommand=function(self)
		self:sleep(1)
		self:zoom(2)
		--self:rotationy(360*5)
		self:SetTextureFiltering(false)
		self:x(SCREEN_WIDTH - 100)
		self:y(-230)
		self:easeOut(0.5)
		self:y(SCREEN_CENTER_Y)
		--self:addx(-(SCREEN_WIDTH/4))
		--self:decelerate(1)
		--self:addrotationy(-360*5)
		--self:addy(SCREEN_HEIGHT/2)
	end
}

t[#t+1] = Def.Sprite{
	Texture="mm2/title.png",
	InitCommand=function(self)
		self:zoom(1)
		self:diffusealpha(0)
		self:y(SCREEN_HEIGHT/2.5)
		self:sleep(1)
		self:sleep(0.3)
		self:decelerate(0.3)
		self:diffusealpha(1)
		self:x(SCREEN_WIDTH/6)
		self:zoom(0.3)
	end
}

return t