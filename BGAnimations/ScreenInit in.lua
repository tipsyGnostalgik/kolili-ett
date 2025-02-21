local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	InitCommand=function(self)
        self:draworder(4)
		self:FullScreen()
		self:diffuse(color("#000000"))
		self:diffusealpha(1)
	end,
	OnCommand=function(self)
		self:easeOut(1)
		self:diffusealpha(0)
	end
}

return t