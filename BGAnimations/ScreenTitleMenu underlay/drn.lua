t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
	Texture="deltarune/fountain.png",
	InitCommand=function(self)
		self:SetTextureFiltering(false)
		self:draworder(-4)
		self:valign(1)
		self:x(SCREEN_CENTER_X)
		self:y(SCREEN_HEIGHT+20)
		self:zoom(4)
		self:sleep(1)
		self:easeOut(0.25)
		self:addy(-20)
		self:zoom(2.7)
	end	
}

local animspeed = 0.25

t[#t+1] = Def.Sprite{
	Texture="deltarune/deltaspr 1x5",
	Frames={
        -- The structure for the Frame is as follows:
        --{ Frame = int, Delay = float , {float,float}, {float,float} }
        -- The two tables are optional upper left and lower right corners of the fraction of the
        -- frame to use.

        -- This will make a 4 frame sprite toggle between its frames for 0.5 seconds,
        -- making a 2 second animation.
        { Frame = 0, Delay = animspeed },
        { Frame = 1, Delay = animspeed },
        { Frame = 2, Delay = animspeed },
        { Frame = 3, Delay = animspeed },
        { Frame = 4, Delay = animspeed },
    },
	InitCommand=function(self)
		self:SetTextureFiltering(false)
		self:draworder(-4)
		self:valign(1)
		self:x(SCREEN_CENTER_X)
		self:y(SCREEN_HEIGHT+20)
		self:zoom(4)
		self:sleep(1)
		self:easeOut(0.25)
		self:addy(-20)
		self:zoom(2.7)
	end	
}

t[#t+1] = Def.Sprite{
	Texture="deltarune/title.png",
	InitCommand=function(self)
		self:zoom(1)
		self:diffusealpha(0)
		self:y(SCREEN_HEIGHT/2.5)
		self:sleep(1)
		self:sleep(0.3)
		self:decelerate(0.3)
		self:diffusealpha(1)
		self:halign(0)
		self:x(20)
		self:zoom(0.5)
	end
}

t[#t+1] = LoadActor("deltarune/fountainparticles")
--t[#t+1] = LoadActor("deltarune/scroller")

return t