local defaultGameplayCoordinates = {
	NotefieldX= 0, NotefieldY= 0, LeaderboardX= 619.15, 
      LeaderboardY= 20, PracticeCDGraphX= 0, PracticeCDGraphY= 445, 
      BPMTextX= 427, BPMTextY= 450, MusicRateX= 427, MusicRateY= 460, 
      DisplayMeanX= 80, DisplayMeanY= 135, JudgeCounterX= 105, 
      JudgeCounterY= 229, JudgeX= -30, JudgeY= 25, ComboX= 25, ComboY= 25, 
      ErrorBarX= 322, ErrorBarY= 303, TargetTrackerX= 453, TargetTrackerY= 270, 
      PlayerInfoP1X= 2, PlayerInfoP1Y= 413, DisplayPercentX= 185, 
      DisplayPercentY= 208, NPSDisplayX= 5, NPSDisplayY= 310, NPSGraphX= 0, 
      NPSGraphY= 320
}

local default7KCoords = {
	JudgeY= 45, ComboX= -25, ComboY= 45, ErrorBarX= 427, ErrorBarY= 293, 
      TargetTrackerX= 453, TargetTrackerY= 270, JudgeCounterX= 0, 
      JudgeCounterY= 160, DisplayPercentX= 80, DisplayPercentY= 148, 
      NPSDisplayX= 5, NPSDisplayY= 310, NPSGraphX= 0, NPSGraphY= 320, 
      NotefieldX= -63, NotefieldY= -15, LeaderboardX= 619.15, LeaderboardY= 20, 
      PlayerInfoP1X= 119, PlayerInfoP1Y= 413, PracticeCDGraphX= 0, 
      PracticeCDGraphY= 445, BPMTextX= 427, BPMTextY= 450, MusicRateX= 427
	}

local defaultGameplaySizes = {
	PracticeCDGraphWidth= 0.8, PracticeCDGraphHeight= 1, 
      MusicRateZoom= 1, BPMTextZoom= 1, DisplayMeanZoom= 1, JudgeZoom= 1, 
      ComboZoom= 0.66, ErrorBarWidth= 130, ErrorBarHeight= 20, 
      TargetTrackerZoom= 0.4, DisplayPercentZoom= 1.47, NPSDisplayZoom= 0.4, 
      NPSGraphWidth= 1, NPSGraphHeight= 1, NotefieldWidth= 1, NotefieldHeight= 1, 
      NotefieldSpacing= 0, PlayerInfoP1Width= 0.76, PlayerInfoP1Height= 0.76, 
      LeaderboardSpacing= 0, LeaderboardHeight= 1, LeaderboardWidth= 1
}

local default7KZoom = {
	JudgeZoom= 1.22, ComboZoom= 1.17, ErrorBarWidth= 240, 
      ErrorBarHeight= 10, TargetTrackerZoom= 0.4, DisplayPercentZoom= 1, 
      NPSDisplayZoom= 0.4, NPSGraphWidth= 1, NPSGraphHeight= 1, 
      NotefieldWidth= 0.82, NotefieldHeight= 0.94, NotefieldSpacing= 0, 
      LeaderboardWidth= 1, LeaderboardHeight= 1, LeaderboardSpacing= 0, 
      PlayerInfoP1Width= 1, PlayerInfoP1Height= 1, PracticeCDGraphWidth= 0.8, 
      PracticeCDGraphHeight= 1, MusicRateZoom= 1, BPMTextZoom= 1, 
      DisplayMeanZoom= 1
}


local defaultConfig = {
	ScreenFilter = 0,
	JudgeType = 2, -- type for the judge counter
	AvgScoreType = 0,
	GhostScoreType = 0,
	GhostTarget = 0,
	TargetTracker = true,
	TargetTrackerMode = 0,
	TargetGoal = 93,
	ErrorBar = 0,
	--ErrorBarDuration = 1,
	--ErrorBarMaxCount = 100,
	leaderboardEnabled = false,
	PaceMaker = false,
	LaneCover = 0, -- soon to be changed to: 0=off, 1=sudden, 2=hidden
	LaneCoverHeight = 0,
	--LaneCoverLayer = 350, -- notefield_draw_order.under_explosions
	DisplayPercent = true,
	DisplayMean = false,
	NPSDisplay = false,
	NPSGraph = false,
	--NPSUpdateRate = 0.1,
	--NPSMaxVerts = 300,
	ReceptorSize = 100,
	CBHighlight = false,
	FCEffect = true,
	Username = "",
	Password = "",
	CBHighlightMinJudge = "TapNoteScore_W4",
	CustomizeGameplay = false,
	GameplayXYCoordinates = {
		["3K"] = DeepCopy(defaultGameplayCoordinates),
		["4K"] = DeepCopy(defaultGameplayCoordinates),
		["5K"] = DeepCopy(defaultGameplayCoordinates),
		["6K"] = DeepCopy(defaultGameplayCoordinates),
		["7K"] = DeepCopy(default7KCoords),
		["8K"] = DeepCopy(defaultGameplayCoordinates),
		["10K"] = DeepCopy(defaultGameplayCoordinates),
		["12K"] = DeepCopy(defaultGameplayCoordinates),
		["16K"] = DeepCopy(defaultGameplayCoordinates)
	},
	GameplaySizes = {
		["3K"] = DeepCopy(defaultGameplaySizes),
		["4K"] = DeepCopy(defaultGameplaySizes),
		["5K"] = DeepCopy(defaultGameplaySizes),
		["6K"] = DeepCopy(defaultGameplaySizes),
		["7K"] = DeepCopy(default7KZoom),
		["8K"] = DeepCopy(defaultGameplaySizes),
		["10K"] = DeepCopy(defaultGameplaySizes),
		["12K"] = DeepCopy(defaultGameplaySizes),
		["16K"] = DeepCopy(defaultGameplaySizes)
	}
}

function getDefaultGameplaySize(obj)
	return defaultGameplaySizes[obj]
end

function getDefaultGameplayCoordinate(obj)
	return defaultGameplayCoordinates[obj]
end


playerConfig = create_setting("playerConfig", "playerConfig.lua", defaultConfig, -1)
local tmp2 = playerConfig.load
playerConfig.load = function(self, slot)
	local tmp = force_table_elements_to_match_type
	force_table_elements_to_match_type = function()
	end
	local x = create_setting("playerConfig", "playerConfig.lua", {}, -1)
	x = x:load(slot)
	local coords = x.GameplayXYCoordinates
	local sizes = x.GameplaySizes
	if sizes and not sizes["4K"] then
		defaultConfig.GameplaySizes["3K"] = sizes
		defaultConfig.GameplaySizes["4K"] = sizes
		defaultConfig.GameplaySizes["5K"] = sizes
		defaultConfig.GameplaySizes["6K"] = sizes
		defaultConfig.GameplaySizes["7K"] = sizes
		defaultConfig.GameplaySizes["8K"] = sizes
		defaultConfig.GameplaySizes["10K"] = sizes
		defaultConfig.GameplaySizes["12K"] = sizes
		defaultConfig.GameplaySizes["16K"] = sizes
	end
	if coords and not coords["4K"] then
		defaultConfig.GameplayXYCoordinates["3K"] = coords
		defaultConfig.GameplayXYCoordinates["4K"] = coords
		defaultConfig.GameplayXYCoordinates["5K"] = coords
		defaultConfig.GameplayXYCoordinates["6K"] = coords
		defaultConfig.GameplayXYCoordinates["7K"] = coords
		defaultConfig.GameplayXYCoordinates["8K"] = coords
		defaultConfig.GameplayXYCoordinates["10K"] = coords
		defaultConfig.GameplayXYCoordinates["12K"] = coords
		defaultConfig.GameplayXYCoordinates["16K"] = coords
	end
	force_table_elements_to_match_type = tmp
	return tmp2(self, slot)
end
playerConfig:load()

function LoadProfileCustom(profile, dir)
	local players = GAMESTATE:GetEnabledPlayers()
	local playerProfile
	local pn
	for k,v in pairs(players) do
		playerProfile = PROFILEMAN:GetProfile(v)
		if playerProfile:GetGUID() == profile:GetGUID() then
			pn = v
		end
	end

	if pn then
		playerConfig:load(pn_to_profile_slot(pn))
	end
end

function SaveProfileCustom(profile, dir)
	local players = GAMESTATE:GetEnabledPlayers()
	local playerProfile
	local pn
	for k,v in pairs(players) do
		playerProfile = PROFILEMAN:GetProfile(v)
		if playerProfile:GetGUID() == profile:GetGUID() then
			pn = v
		end
	end

	if pn then
		playerConfig:set_dirty(pn_to_profile_slot(pn))
		playerConfig:save(pn_to_profile_slot(pn))
	end
end