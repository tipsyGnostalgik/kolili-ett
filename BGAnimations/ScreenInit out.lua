local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
        self:draworder(4)
		self:FullScreen()
		self:diffuse(color("#F3F3F3"))
		self:diffusealpha(0)
	end,
	OnCommand=function(self)
		self:easeOut(0.3)
		self:diffusealpha(1)
	end
}

return t