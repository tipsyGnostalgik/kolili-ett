local t = Def.ActorFrame{}
local gc = Var("GameCommand")

t[#t+1] = LoadFont("_176menuksd") .. {
	Text=THEME:GetString("ScreenTitleMenu",gc:GetText()),
	OnCommand=function(self)
		self:halign(0):zoom(0.15):draworder(2)
	end,
	GainFocusCommand=function(self)
		self:stoptweening():easeOut(0.5):diffuse(color("#ffffff")):diffusealpha(1):addx(4):zoom(0.2)
	end,
	LoseFocusCommand=function(self)
		self:stoptweening():easeOut(0.5):diffuse(color("#FFFFFF")):diffusealpha(0.5):addx(-4):zoom(0.15)
	end
}

return t