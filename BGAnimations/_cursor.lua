--file containing stuff for cursors.
--this should only be loaded by screen overlays, 
--otherwise the inputcallback function won't be able to find the actors.

local maxChild = 20
local curIndex = 0

function cursorClick(index)
	return LoadActor(THEME:GetPathG("","_circle")) .. {
		Name="CursorClick",
		InitCommand=function(self)
			self:diffusealpha(0)
		end,
		MouseLeftClickMessageCommand=function(self)
			if index == curIndex then
				self:finishtweening()
				self:xy(INPUTFILTER:GetMouseX(),INPUTFILTER:GetMouseY())
				self:diffusealpha(1)
				self:zoom(0)
				self:decelerate(0.5)
				self:diffusealpha(0)
				self:zoom(1)
			end
		end
	}
end

local t = Def.ActorFrame{
	Name="Cursor"
}

for i=0,maxChild do
	t[#t+1] = cursorClick(i)
end

t[#t+1] = Def.Sprite{
	Texture=THEME:GetPathG("","_cursor"),
	Name="Cursor",
	InitCommand=function(self)
		self:halign(0):valign(0):xy(0,0)
		self:SetTextureFiltering(false)
	end,
	MouseLeftClickMessageCommand=function(self)
		curIndex = (curIndex+1)%20
	end
}

local function Update(self)
    
    if not GHETTOGAMESTATE:isWindowed() then
   		self:GetChild("Cursor"):xy(INPUTFILTER:GetMouseX(),INPUTFILTER:GetMouseY())
   		self:GetChild("Cursor"):visible(true)
   	else
   		self:GetChild("Cursor"):visible(false)
   	end

   	return false

end
t.InitCommand=function(self)
	self:SetUpdateFunction(Update)
end

return t