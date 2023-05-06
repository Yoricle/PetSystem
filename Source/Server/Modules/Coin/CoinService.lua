local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)
local ProfileService = require(ReplicatedStorage.Packages.ProfileService)


--local PROFILE_TEMPLATE: { [string]: boolean } = {}

local PlayerDataTemplate = require(ReplicatedStorage.Source.Shared.Modules.Data.PlayerDataTemplate) -- This requires a module with different gem types

--[[
    This service is based on individual pet worth, for example in the trading plaza if a pet
    sells for a certain amount of gems we then record that data and give an average (recent average price)
    for that item/pet
]]

local profiles = {} -- might want to define this table elsewhere

local DEFAULT_COINS = 0

local CoinService = Knit.CreateService {
    Name = "ValueService",
    Client = {
        Amount = Knit.CreateProperty(DEFAULT_COINS)
    },
}

local function CreateLeaderstats(player : Player)
    local Profile = profiles[player]

    if not Profile then 
        return 
    end

    local leaderstats = Instance.new("Folder", player)
    leaderstats.Name = "leaderstats"

    local Coins = Instance.new("IntValue", leaderstats)
    Coins.Name = "Coins"
    Coins.Value = CoinService.Client.Amount
end

local function initializePlayer(player: Player)
    local profile = CoinService._profileStore:LoadProfileAsync("Player_" .. player.UserId)

    if not profile then
        -- Possibly kick the player
        return warn("Failed to fetch players coin amount")
    end

    profile:AddUserId(player.UserId)
	profile:Reconcile()

	profile:ListenToRelease(function() -- profiles is the array of stored profiles
        -- Possibly kick the player
		profiles[player] = nil
	end)

	if player:IsDescendantOf(Players) then
		profiles[player] = profile
        CreateLeaderstats(player)
	else
		profile:Release()
	end

	CoinService.Client.Amount:SetFor(player, profile.Data)
end

local function deInitializePlayer(player: Player)
	local profile = profiles[player]
	if profile then
		profile:Release()
	end
end

function CoinService:KnitInit()
    self._profileStore = ProfileService.GetProfileStore("Test", profiles)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			initializePlayer(player) -- looping all players when this service initialises
		end)
	end

	Players.PlayerAdded:Connect(initializePlayer)
	Players.PlayerRemoving:Connect(deInitializePlayer)
end

function CoinService:KnitStart()
    print("CoinService Started")
end





return CoinService
