local t = Def.ActorFrame{}
local gc = Var("GameCommand")

t[#t+1] = LoadFont("Common Normal") .. {
	Text=THEME:GetString("ScreenTitleMenu",gc:GetText()),
	OnCommand=function(self)
		self:halign(0):zoom(0.5):addx(20):draworder(2)
	end,
	GainFocusCommand=function(self)
		self:stoptweening():easeOut(0.5):diffuse(color("#000000")):diffusealpha(1):addx(4)
	end,
	LoseFocusCommand=function(self)
		self:stoptweening():easeOut(0.5):diffuse(color("#FFFFFF")):diffusealpha(0.5):addx(-4)
	end
}

return t