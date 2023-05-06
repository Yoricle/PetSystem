local RunService = game:GetService("RunService")
return {
	COINS_RESPAWN_TIME = 20,
	DIAMONDS_RESPAWN_TIME = 30,
	AMOUNT_OF_LAPS = RunService:IsStudio() and 2 or 4,
	RACE_JOIN_TIMER = RunService:IsStudio() and 10 or 15,
	AUTO_RACE_TIME = 60
}
