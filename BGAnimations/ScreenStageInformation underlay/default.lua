t = Def.ActorFrame{}

--t[#t+1] = LoadActor("bgbg")
t[#t+1] = Def.Quad{
    
}

t[#t+1] = Def.Quad{
	InitCommand=function (self)
		self:FullScreen():diffusealpha(1):diffuse(color("#FFFFFF"))
	end,
	OnCommand=function (self)
		self:easeOut(1):diffuse(color("#F3F3F3"))
	end
}

t[#t+1] = Def.Sprite{
	Texture="roseb.png",
	InitCommand=function (self)
		self:FullScreen():zoom(0.5)
	end,
	OnCommand=function (self)
		self:easeOut(0.8):zoom(1):easeIn(0.2):zoom(0)
	end
}



t[#t+1] = Def.Quad{
	InitCommand=function (self)
		self:zoomto(13,SCREEN_HEIGHT):x(SCREEN_WIDTH):valign(0):halign(0):diffuse(color("#a947ff")):diffusealpha(1):easeOut(0.5):addx(-SCREEN_WIDTH+60)
	end,
	OnCommand=function (self)
		self:easeIn(0.4):diffusealpha(0)
	end
}

t[#t+1] = Def.Quad{
	InitCommand=function (self)
		self:zoomto(5,SCREEN_HEIGHT):x(SCREEN_WIDTH):halign(0):valign(0):diffuse(color("#a947ff")):diffusealpha(0.5):easeOut(1):addx(-SCREEN_WIDTH+50)
	end,
	OnCommand=function (self)
		self:easeIn(0.4):diffusealpha(0)
	end
}



t[#t+1] = Def.Sprite{
	Texture="circ.png",
	InitCommand=function (self)
		self:xy( SCREEN_CENTER_X-200,SCREEN_CENTER_Y ):zoom(0.2):diffusealpha(1)
	end,
	OnCommand=function (self)
		self:easeOut(1):zoom(1):diffusealpha(0)
	end
}

return t