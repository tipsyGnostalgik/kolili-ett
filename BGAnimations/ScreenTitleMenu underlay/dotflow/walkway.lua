local t = Def.ActorFrame{}

local enabled = themeConfig:get_data().global.Particles

local particleAmount = 5
local dx = {}
local dy = {}
local alpha = {}

local function isInScreen(particle)
	local half = particleSize/2
	local x = particle:GetX()
	local y = particle:GetY()
	return (x > -100-half and x < SCREEN_WIDTH+100+half) and (y > 0-half and y < SCREEN_HEIGHT+half)
end

local function resetPosition(particle)
	particle:x(math.random(0,SCREEN_WIDTH))
	particle:y(0)
	--particle:y(math.random(0,SCREEN_HEIGHT))
	particle:rotationz(math.random()*360)
	return
end

local scarystuff = {
	"watashi 2x1.png",
	"watashi 1x2.png",
	"death 3x2.png",
	"death 2x3.png"
}

local posX = {SCREEN_WIDTH,0}
local posY = {SCREEN_HEIGHT,0}
local function makeParticle(index)
	return Def.Sprite{
		Texture=scarystuff[math.random(#scarystuff)],
		--Texture="prunsel.png",
		Name="Particle"..index,
		BeginCommand=function (self)
			--self:load("dotflow/"..scarystuff[math.random(#scarystuff)])
			self:sleep(index*0.1)
			local size = math.random(20,50)
			self:zoomto(size,size)
			self:draworder(-3)
			self:x(math.random(SCREEN_CENTER_X,SCREEN_WIDTH/1.2))
			self:y(SCREEN_HEIGHT-30)
			self:rotationz(math.random(360))
			--self:diffuse(HSV(math.random(284,317),0,1))
			dx[index] = 0--math.random()*5+1
			dy[index] = math.random()*10+1
			alpha[index] = math.random()*4
			self:diffusealpha(alpha[index])
			self:queuecommand('Move')
		end,
		MoveCommand = function(self,params)
			self:finishtweening()
			self:addy(dy[index]*(((SCREEN_CENTER_Y-200)-self:GetY())/1500))
			--self:addrotationz(math.random(-3,3))
			if self:GetDiffuseAlpha() <= 0 then
				self:sleep(1)
				self:queuecommand('ResetPosition')
			end
			self:diffusealpha(clamp(alpha[index],0,0.8))
			self:sleep(1/200)
			self:queuecommand('Move')
			alpha[index] = alpha[index] - 0.005
		end,
		ResetPositionCommand = function(self)
			--self:Load(scarystuff[math.random(#scarystuff)])
			alpha[index] = math.random()*2+2
			dy[index] = math.random()*10+1
			self:diffuse(HSV(math.random(284,317),0,1))
			self:diffusealpha(alpha[index])
				self:x(math.random(SCREEN_CENTER_X,SCREEN_WIDTH/1.2))
				self:y(SCREEN_HEIGHT-30)
			self:queuecommand('Move')
		end
	}
end

if enabled then
	for i=1,particleAmount do
		t[#t+1] = makeParticle(i)
		dx[#dx+1] = 0
		dy[#dy+1] = 0
		alpha[#alpha+1] = 0
	end
end


return t