local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rarity = require(ReplicatedStorage.Enums:WaitForChild("Rarity"))

export type PetData = {
	name: string,
	price: number,
}

return {
    Common = {
        [1] = {
            name = "Soft Dog",
            gamepass = 72149023,
            rarity = Rarity.Common
        },
        [2] = {
            name = "Soft Cat",
            gamepass = 72149023,
            rarity = Rarity.Common
        },
    }
}