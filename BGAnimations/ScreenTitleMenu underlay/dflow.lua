t = Def.ActorFrame{}

local animspeed = 0.1

local effects = {
	"sabinormal 2x2.png"
}

t[#t+1] = Def.Sprite{
	Texture="dotflow/sabi/"..effects[math.random(#effects)],
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
    },
	InitCommand=function(self)
		self:sleep(1)
		self:zoom(2)
		self:draworder(2)
		self:rotationy(360*5)
		self:SetTextureFiltering(false)
		self:x((SCREEN_WIDTH))
		self:y(SCREEN_HEIGHT/2)
		self:decelerate(0.6)
		self:addx(-(SCREEN_WIDTH/3))
		--self:decelerate(1)
		self:addrotationy(-360*5)
		--self:addy(SCREEN_HEIGHT/2)
	end
}

t[#t+1] = Def.Sprite{
	Texture="dotflow/titledflow.png",
	InitCommand=function(self)
		self:zoom(1)
		self:diffusealpha(0)
		self:y(SCREEN_HEIGHT/2.5)
		self:sleep(1)
		self:sleep(0.3)
		self:decelerate(0.3)
		self:diffusealpha(1)
		self:x(SCREEN_WIDTH/5)
		self:zoom(0.5)
	end
}

t[#t+1] = Def.Sprite{
	Texture="dotflow/titledflowblur.png",
	InitCommand=function(self)
		self:zoom(1)
		self:diffusealpha(0)
		self:y(SCREEN_HEIGHT/2.5)
		self:sleep(1)
		self:sleep(0.3)
		self:decelerate(0.3)
		self:diffusealpha(1)
		self:x(SCREEN_WIDTH/5)
		self:zoom(0.5)
	end
}

t[#t+1] = LoadActor("dotflow/walkway")

return t