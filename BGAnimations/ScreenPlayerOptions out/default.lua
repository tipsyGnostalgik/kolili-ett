t = Def.ActorFrame{}

local bullshitphrases = {
    "You took THAT long!?",
    "Good luck!",
    "You should rest.",
	"Your scroll speed ain't perfect yet?",
	"Did you remember to disable customize?",
	"Did you forget to change that one little thing?"
}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:FullScreen():diffusealpha(0):diffuse(color("#000000"))
	end,
	OnCommand=function(self)
		self:sleep(0.2)
        :easeOut(0.3):diffusealpha(1)
        :sleep(1):easeIn(1):diffuse(color("#F3F3F3"))
	end
}

t[#t+1] = LoadFont("_176mksd 100px")..{
	InitCommand = function(self)
		self:xy( 130,SCREEN_HEIGHT/2):draworder(4):diffusealpha(0):zoom(5):halign(0)
		self:settext(bullshitphrases[math.random(#bullshitphrases)])
	end,
	OnCommand=function(self)
		self:easeOut(0.25):zoom(0.3):diffusealpha(1):addx(-100):sleep(1)
        :easeOut(0.2):zoomy(1):zoomx(0.2):easeOut(0.1):zoomy(0):zoomx(5):diffusealpha(0)
	end
}

t[#t+1] = Def.Sprite {
	Texture="bar.png",
	InitCommand = function(self)
		self:FullScreen():diffusealpha(0)
	end,
	OnCommand = function(self)
		self:linear(1):diffusealpha(1):sleep(0.3):diffusealpha(0)
	end
}

t[#t+1] = Def.Sprite {
	Texture="rose.png",
	InitCommand = function(self)
		self:FullScreen():zoom(1)
	end,
	OnCommand = function (self)
		self:easeOut(1.3):zoom(0.8):easeIn(1.2):zoom(2):rotationz(12)
	end
}


return t