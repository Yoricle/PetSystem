local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Component = require(ReplicatedStorage.Packages.Component)
local Knit = require(ReplicatedStorage.Packages.Knit)
local GlobalSettings = require(ReplicatedStorage.Source.Shared.Modules.Data.GlobalSettings)

local COINS_TO_AWARD_ATTRIBUTE = "CoinsToAward"
local RESPAWN_TIME_ATTRIBUTE = "RespawnTime"
local COINS_RESPAWN_TIME = GlobalSettings.COINS_RESPAWN_TIME

local Coin = Component.new({ Tag = "Coin", Extensions = {} })

function Coin:Construct()
	self._coinsToAward = self.Instance:GetAttribute(COINS_TO_AWARD_ATTRIBUTE) or 1
	self._respawnTime = self.Instance:GetAttribute(RESPAWN_TIME_ATTRIBUTE) or COINS_RESPAWN_TIME
	if self._respawnTime <= 0 then
		self._respawnTime = COINS_RESPAWN_TIME
	end

	self._debounces = {}
end

function Coin:Collect(player: Player)
	if self._debounces[player] then
		warn("Tried to collect a coin that was already collected:", player)
		return
	end

	self._debounces[player] = true

	task.delay(COINS_RESPAWN_TIME, function()
		self._debounces[player] = nil
	end)

	Knit.GetService("CoinService"):Increment(player, self._coinsToAward)
end

return Coin
