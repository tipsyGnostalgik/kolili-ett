t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
    
}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:FullScreen():diffusealpha(1):diffuse(color(#F3F3F3))
	end,
	OnCommand=function(self)
		self:easeOut(0.3):diffusealpha(0)
	end
}

return t