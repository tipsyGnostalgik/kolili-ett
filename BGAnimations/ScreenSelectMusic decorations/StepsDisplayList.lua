local song

local titleScroll = 0

local t = Def.ActorFrame
	{
	Name = "Song Info", -- dumb name
	
	CurrentStepsChangedMessageCommand = function(self)
		song = GAMESTATE:GetCurrentSong()
		self:queuecommand("StepsChanged")
	end,
	
	Def.Quad{
			Name = "Banner Background", -- lol
			InitCommand = function(self)
				self:xy(151.5, 196):halign(0.5):valign(0.5)
				self:setsize(232,200)
				self:diffuse(color("#000000"))
			end
		},
	-- used to be in wifetwirl
	Def.Sprite{
			Name = "Banner",
			
			InitCommand = function(self)
				self:xy(151.5, 196):halign(0.5):valign(0.5)
				self:scaletoclipped(232,200)
				self:fadetop(0.4)
			end,
			CurrentStepsChangedMessageCommand = function(self)
				if INPUTFILTER:IsBeingPressed("tab") then
					self:finishtweening():smooth(0.25):diffusealpha(0):sleep(0.2):queuecommand("ModifyBanner")
				else
					self:finishtweening():queuecommand("ModifyBanner")
				end
			end,
			ModifyBannerCommand = function(self)
				self:finishtweening()
				local bnpath = GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetBannerPath() or SONGMAN:GetSongGroupBannerPath(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
				if not bnpath or bnpath == "" then
					bnpath = THEME:GetPathG("Common", "fallback banner")
				end
				self:LoadBackground(bnpath)
				self:diffusealpha(1)
			end
		},

		Def.Sprite{
			Name = "CDTitle",
			
			InitCommand = function(self)
				self:xy(245-(32/2), 180):halign(0.5):valign(0.5)
				self:scaletoclipped(64,32)
				self:fadetop(0.4)
			end,
			CurrentStepsChangedMessageCommand = function(self)
				if INPUTFILTER:IsBeingPressed("tab") then
					self:finishtweening():smooth(0.25):diffusealpha(0):sleep(0.2):queuecommand("ModifyBanner")
				else
					self:finishtweening():queuecommand("ModifyBanner")
				end
			end,
			ModifyBannerCommand = function(self)
				self:finishtweening()
				local bnpath = GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetCDTitlePath()
				if not bnpath or bnpath == "" then
					bnpath = THEME:GetPathG("", "LineGradient")
				end
				self:LoadBackground(bnpath)
				self:diffusealpha(0.8)
			end
		},
		
	Def.Quad{
			Name = "Black thing",
			
			InitCommand = function(self)
				self:xy(151.5, 196+108/2):halign(0.5):valign(0.5)
				self:setsize(232, 92)
				self:diffuse(color("#000000")):diffusealpha(0.65)
			end
		},
	LoadFont("Common Normal") ..
		{
			Name = "Title Text",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 4, 196-200/2 + 16):halign(0):valign(0)
				self:zoom(0.9)
				self:zoomx(0.8)
				self:settext("Title")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				self:stoptweening():diffusealpha(0)
				titleScroll = 0
				self:settext(song and song:GetTranslitMainTitle() or "")
				self:queuecommand("Scroll")
				self:decelerate(0.5):diffusealpha(1)
			end,
			ScrollCommand = function(self) ------------------------------------------------------------- probably change this to addx and crop the sides
				if string.len(song:GetTranslitMainTitle()) >= titleScroll+20 then
					if titleScroll == 0 then
						self:sleep(2)
					end
					self:settext(string.sub(song:GetTranslitMainTitle(),1,20) .. "...")
					titleScroll = titleScroll + 1
					self:sleep(0.1)
					self:queuecommand("Scroll")
				else
					self:sleep(2)
					titleScroll = 0
					self:queuecommand("Scroll")
				end
			end,
		},
	LoadFont("Common Bold") ..
		{
			Name = "Artist Text",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 4, 196-200/2+16 + 24):halign(0):valign(0)
				self:zoom(0.45)
				self:diffuse(color("#dddddd")):diffusealpha(0.8)
				self:settext("Artist")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				self:settext(song and song:GetDisplayArtist() or "")
			end
		},
	LoadFont("Common Normal") ..
		{
			Name = "Bpm Text",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 4, 196-200/2+16+24 + 16):halign(0):valign(0)
				self:zoom(0.45)
				self:diffuse(color("#dddddd")):diffusealpha(0.8)
				self:settext("BPM")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				self:settext(song and "BPM" or "")
			end
		},
	Def.BPMDisplay{
		Name = "BPMDisplay",
			InitCommand = function(self)
				self:xy(151.5-232/2+4 + 26, 196-200/2+16+24 + 16):halign(0):valign(0)
				self:zoom(0.45)
			end,
			OnCommand=function (self)
				self:settext("000")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				local steps = GAMESTATE:GetCurrentSteps()
				--self:settext(song and bpms or " ") -- bpm ugh -- format to 3 or more digits
				if steps then self:SetFromSteps(steps) else self:settext(" ") end
			end
		},
		
		LoadFont("Common Normal") ..
		{
			Name = "Msd Text",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 4, 196-200/2+16+24 + 120):halign(0):valign(0)
				self:zoom(0.45)
				self:diffuse(color("#dddddd")):diffusealpha(0.8)
				self:settext("MSD")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				self:settext(song and "MSD" or "")
			end
		},
	LoadFont("Common Bold") ..
		{
			Name = "MSD Number",
			
			InitCommand = function(self)
				self:xy(151.5-232/2+4 + 26, 196-200/2+16+24 + 120):halign(0):valign(0)
				self:zoom(0.45)
			end,
			OnCommand = function (self)
				self:settext("0.00")
			end,
			CurrentStepsChangedMessageCommand = function(self)
			local steps = GAMESTATE:GetCurrentSteps()
			local meter = steps:GetMSD(getCurRateValue(), 1)

			self:settextf(song and "%0.2f",meter or " "):diffuse(getMSDColor(meter))
			end,
			
			CurrentRateChangedMessageCommand = function(self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
					self:settextf(song and "%0.2f",meter or " "):diffuse(getMSDColor(meter)) -- bpm ugh -- format to 3 or more digits
				end
		},

		LoadFont("Common Normal") ..
		{
			Name = "Rate Text",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 4, 196-200/2+16+24 + 133):halign(0):valign(0)
				self:zoom(0.45)
				self:diffuse(color("#dddddd")):diffusealpha(0.8)
				self:settext(" ")
			end,
			CurrentRateChangedMessageCommand = function(self)
				if getCurRate() == "1.0x" then
					self:settext(" ")
				else
					self:settext(song and "Rate" or " ")
				end
			end
		},
	LoadFont("Common Bold") ..
		{
			Name = "Rate Number",
			
			InitCommand = function(self)
				self:xy(151.5-232/2+4 + 26, 196-200/2+16+24 + 133):halign(0):valign(0)
				self:zoom(0.45)
			end,
			OnCommand = function (self)
				self:settext(" ")
			end,
			CurrentRateChangedMessageCommand = function(self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
				if getCurRate() == "1.0x" then
					self:settextf(" "):diffusealpha(0) 
				else				
					self:settextf(getCurRate " "):diffuse(getMSDColor(meter)) -- bpm ugh -- format to 3 or more digits
				end
			end,

			CurrentStepsChangedMessageCommand = function(self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
				if getCurRate() == "1.0x" then
					self:settextf(" "):diffusealpha(0) 
				else				
					self:settextf(getCurRate " "):diffuse(getMSDColor(meter)) -- bpm ugh -- format to 3 or more digits
				end
			end
		},

		LoadFont("_176menuksd") ..
		{
			Name = "Msd Stars Shade",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 0, 196-200/2+16+24 + 101):halign(0):valign(0.5)
				self:zoom(0.23)
				self:diffuse(color("#0c0c0c")):diffusealpha(0.8)
				self:settext("żżżżżżżżżż")
			end
		},

		LoadFont("_176menuksd") ..
		{
			Name = "Msd Stars",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 0, 196-200/2+16+24 + 101):halign(0):valign(0.5)
				self:zoom(0.23)
				self:diffuse(color("#dddddd")):diffusealpha(1)
				self:settext("żżżżżżżżż")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
				local floormeter = math.floor(steps:GetMSD(getCurRateValue(), 1))
				
				if floormeter > 10 then
					repeat floormeter = floormeter - 10 until floormeter <= 10
				end

				local neato = string.rep("ż", floormeter)

				--self:settext(song and "żżżżżżżżż" or ""):diffuse(getMSDColor(meter))
				self:settext(neato):diffuse(getMSDColor(meter))
			end,
			CurrentRateChangedMessageCommand = function (self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
				local floormeter = math.floor(steps:GetMSD(getCurRateValue(), 1))

				if floormeter > 10 then
					repeat floormeter = floormeter - 10 until floormeter <= 10
				end

				local neato = string.rep("ż", floormeter)

				self:stoptweening()
				self:settext(song and neato or ""):diffuse(getMSDColor(meter))
				self:zoom(0.25):easeOut(0.1):zoom(0.23)
			end
		},

		LoadFont("_176menuksd") ..
		{
			Name = "Msd Stars",
			
			InitCommand = function(self)
				self:xy(151.5-232/2 + 0, 196-200/2+16+24 + 101):halign(0):valign(0.5)
				self:zoom(0.23)
				self:diffuse(color("#dddddd")):diffusealpha(1)
				self:settext("żżżżżżżżż")
			end,
			CurrentStepsChangedMessageCommand = function(self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
				local floormeter = math.floor(steps:GetMSD(getCurRateValue(), 1))
				
				if floormeter > 10 then
					floormeter = math.floor(floormeter / 10)
				else
					floormeter = 0
				end

				local neato = string.rep("Ľ", floormeter)

				--self:settext(song and "żżżżżżżżż" or ""):diffuse(getMSDColor(meter))
				self:settext(neato):diffuse(color("#f3f3f3")):diffusealpha(0.8)
			end,
			CurrentRateChangedMessageCommand = function (self)
				local steps = GAMESTATE:GetCurrentSteps()
				local meter = steps:GetMSD(getCurRateValue(), 1)
				local floormeter = math.floor(steps:GetMSD(getCurRateValue(), 1))

				if floormeter > 10 then
					floormeter = math.floor(floormeter / 10)
				else
					floormeter = 0
				end

				local neato = string.rep("Ľ", floormeter)
				self:stoptweening()
				self:settext(song and neato or ""):diffuse(color("#F3F3F3")):diffusealpha(0.8)
				self:zoom(0.24):easeOut(0.1):zoom(0.23)
			end
		}
}

-- used to be in ScreenSelectMusic StepsDisplayList.lua
local sdl = Def.ActorFrame
{
	Name = "StepsDisplayList",
	InitCommand = function(self)
		self:xy(45, 216)
	end
}

local diffid = 0

for i = 1, 4 do
	local x = 54 * (i-1)
	local y = 0

	sdl[#sdl+1] = Def.ActorFrame
		{
			Name = "StepsDisplayList Difficulty " .. i,
			InitCommand = function(self)
				self:diffuse(color("#ffbb00"))
			end,
			
			Def.Quad{
					Name = "Difficulty Border Left",
					InitCommand = function(self)
						self:halign(0):valign(0)
						self:setsize(1, 14)
						self:xy(x, y)
					end
				},
			Def.Quad{
					Name = "Difficulty Border Top",
					InitCommand = function(self)
						self:halign(0):valign(0)
						self:setsize(52, 1)
						self:xy(x, y)
					end
				},
			Def.Quad{
					Name = "Difficulty Border Right",
					InitCommand = function(self)
						self:halign(1):valign(0)
						self:setsize(1, 14)
						self:xy(x + 52, y)
					end
				},
			Def.Quad{
					Name = "Difficulty Border Bottom",
					InitCommand = function(self)
						self:halign(0):valign(1)
						self:setsize(52, 1)
						self:xy(x, y + 14)
					end
				},
				
			LoadFont("Common Bold") ..{
					Name = "Difficulty Label",
					InitCommand = function(self)
						local steps = GAMESTATE:GetCurrentSteps()

						self:zoom(0.367)
						self:settext(steps:GetDifficulty())
						self:halign(0.5):valign(0.5)
						self:xy(x+52/2, y+14/2)
					end,
					CurrentStepsChangedMessageCommand = function(self)
						local steps = GAMESTATE:GetCurrentSteps()
						self:settext(steps:GetDifficulty())
					end
				}
		}
end

t[#t+1] = sdl

return t

--[[return Def.StepsDisplayList {
	Name = "StepsDisplayList",
	CursorP1 = Def.ActorFrame {
		InitCommand = function(self)
			self:x(-128 + 16):player(PLAYER_1)
		end,
		PlayerJoinedMessageCommand = function(self, params)
			if params.Player == PLAYER_1 then
				self:visible(true)
				self:bounceend(0.3):zoom(1)
			end
		end,
		PlayerUnjoinedMessageCommand = function(self, params)
			if params.Player == PLAYER_1 then
				self:visible(true)
				self:bounceend(0.3):zoom(0)
			end
		end,
		LoadFont("Common Normal") ..
			{
				Text = "P1",
				InitCommand = function(self)
					self:x(-4):diffuse(PlayerColor(PLAYER_1)):shadowlength(1)
				end,
				OnCommand = function(self)
					self:zoom(0.75)
				end
			}
	},
	CursorP2 = Def.ActorFrame {
		InitCommand = function(self)
			self:x(128 - 16):player(PLAYER_2)
		end,
		PlayerJoinedMessageCommand = function(self, params)
			if params.Player == PLAYER_2 then
				self:visible(true)
				self:bounceend(0.3):zoom(1)
			end
		end,
		PlayerUnjoinedMessageCommand = function(self, params)
			if params.Player == PLAYER_2 then
				self:visible(true)
				self:bounceend(0.3):zoom(0)
			end
		end,
		LoadFont("Common Normal") ..
			{
				Text = "P2",
				InitCommand = function(self)
					self:x(8):diffuse(PlayerColor(PLAYER_2)):shadowlength(1)
				end,
				OnCommand = function(self)
					self:zoom(0.75)
				end
			}
	},
	CursorP1Frame = Def.Actor {
		ChangeCommand = function(self)
			self:stoptweening():decelerate(0.125)
		end
	},
	CursorP2Frame = Def.Actor {
		ChangeCommand = function(self)
			self:stoptweening():decelerate(0.125)
		end
	}
}
]]