t = Def.ActorFrame{}

local rooms = {
	"room.png",
	"roomdream.png"
}

t[#t+1] = Def.Sprite{
	Texture="yumenikki/"..rooms[math.random(#rooms)],
	InitCommand=function(self)
		self:SetTextureFiltering(false)
		self:x(SCREEN_WIDTH-(SCREEN_WIDTH/4))
		self:y(SCREEN_HEIGHT/2)
		self:zoom(3)
		self:sleep(1)
		self:decelerate(0.4)
		self:zoom(2)
	end	
}

local effects = {
	"madotsukinormal 2x2.png",
	"madoblind 2x2.png",
	"madoknife 2x2.png"
}

t[#t+1] = Def.Sprite{
	Texture="yumenikki/mado/"..effects[math.random(#effects)],
	InitCommand=function(self)
		self:sleep(1)
		self:zoom(2)
		self:rotationy(360*5)
		self:SetTextureFiltering(false)
		self:x((SCREEN_WIDTH))
		self:y(SCREEN_HEIGHT/2)
		self:decelerate(0.6)
		self:addx(-(SCREEN_WIDTH/4))
		--self:decelerate(1)
		self:addrotationy(-360*5)
		--self:addy(SCREEN_HEIGHT/2)
	end
}

t[#t+1] = Def.Sprite{
	Texture="yumenikki/titleyn.png",
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