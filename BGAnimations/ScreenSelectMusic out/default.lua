local haveaniceplay = {
	"Your choice is made.",
	"This is true love we're making!",
	"This is tuna with bacon! (yum!)",
	"hi oomf",
	"Believe in the me that believes in you.",
	"hi bestie!",
	"Please act like this text is scary.",
	"Bye worstie.",
	"I eat rocks for a living.",
	"Keep rocking baby!",
	"Waiting for shaders.",
	"˘˘˘ CHI CHI CHI LE LE LE VIVA CHILE ˘˘˘",
    "You are one in a krillion Ą"
}

local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
        self:draworder(2)
		self:FullScreen()
		self:diffuse(color("#F3F3F3"))
		self:diffusealpha(0)
	end,
	OnCommand=function(self)
		self:easeOut(0.8)
		self:diffuse(color("#000000")):diffusealpha(1)
	end
}

t[#t+1] = Def.Sprite{
    Texture="bgbgbgb.png",
    InitCommand=function (self)
        self:FullScreen():draworder(3):diffusealpha(0)
    end,
    OnCommand=function (self)
        self:easeOut(2.5):diffusealpha(1):sleep(0):easeIn(0.5):diffusealpha(0)
    end
}

t[#t+1] = Def.Sprite{
    Texture="awww.png",
    InitCommand=function (self)
        self:FullScreen():draworder(4):diffusealpha(0)
    end,
    OnCommand=function (self)
        self:easeOut(2.5):diffusealpha(1):zoom(2):sleep(0):easeIn(0.5):diffusealpha(0)
    end
}

t[#t+1] = Def.Sprite{
	Texture="boxframe.png",
	InitCommand=function(self)
		self:draworder(4)
            :xy(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)
            :diffusealpha(0)
            :zoom(3)
            :rotationz(-360*2)
		    :SetTextureFiltering(true)
	end,
    OnCommand=function(self)
        self:easeOut(2.5)
		    :zoom(0.3)
            :rotationz(56)
            :diffusealpha(0.3)
            :sleep(1)
            :easeIn(2)
            :rotationz(-360*2)
            :zoom(3)
            :diffusealpha(0)
    end
}

t[#t+1] = Def.Sprite{
	Texture="boxframeoutter.png",
	InitCommand=function(self)
		self:draworder(4)
            :xy(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)
            :diffusealpha(0)
            :zoom(3)
            :rotationz(-360*2)
		    :SetTextureFiltering(true)
	end,
    OnCommand=function(self)
		self:sleep(0.3)
        self:easeOut(2.5)
		    :zoom(0.3)
            :rotationz(50)
            :diffusealpha(0.2)
            :sleep(0)
            :easeIn(2)
            :rotationz(360*2)
            :zoom(3)
            :diffusealpha(0)
    end
}

t[#t+1] = Def.Sprite{
	Texture="boxframeoutout.png",
	InitCommand=function(self)
		self:draworder(4)
            :xy(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)
            :diffusealpha(0)
            :zoom(3)
            :rotationz(-360*2)
		    :SetTextureFiltering(true)
	end,
    OnCommand=function(self)
		self:sleep(0.5)
        self:easeOut(2.5)
		    :zoom(0.3)
            :rotationz(45)
            :diffusealpha(0.15)
            :sleep(0)
            :easeIn(2)
            :rotationz(-360*2)
            :zoom(3)
            :diffusealpha(0)
    end
}

t[#t+1] = Def.Sprite{
	Texture="ett.png",
	InitCommand=function(self)
		self:draworder(5)
            :xy(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)
            :diffusealpha(0)
            :zoom(3)
            :rotationz(0)
		    :SetTextureFiltering(true)
	end,
    OnCommand=function(self)
        self:easeOut(3)
		    :zoom(0.3)
            :diffusealpha(0.8)
            :easeIn(0.5)
            :zoom(110)
            :diffusealpha(1)
            :stopTweening(0.1)
            :diffusealpha(0)
    end
}


t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand = function(self)
		self:xy( SCREEN_WIDTH/2,SCREEN_HEIGHT/2):draworder(6):diffusealpha(0):zoom(5)
		self:settext(haveaniceplay[math.random(#haveaniceplay)])
		--self:settext("ĄĄĄ˘˘˘")
	end,
	OnCommand=function(self)
        self:sleep(0.3)
		:easeOut(2):zoom(0.5):diffusealpha(1):sleep(1)
        :easeIn(0.5):zoom(5):diffusealpha(0)
	end
}

t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand = function(self)
		self:xy( SCREEN_WIDTH/2,SCREEN_HEIGHT/2):draworder(6):diffusealpha(0):zoom(0.2)
		self:settext("Press start to change your preferences.")
	end,
	OnCommand=function(self)
        self:sleep(1)
		:easeOut(1):zoom(0.2):addy(50):diffusealpha(0.9):sleep(1)
        :easeIn(0.1):zoom(0.2):diffusealpha(0)
	end
}

t[#t+1] = Def.Quad{
    InitCommand = function (self)
        self:FullScreen():diffuse(color("#000000")):diffusealpha(0):draworder(99)
    end,
    OnCommand = function (self)
        self:sleep(3):easeOut(0.5):diffusealpha(1)
    end
}

return t