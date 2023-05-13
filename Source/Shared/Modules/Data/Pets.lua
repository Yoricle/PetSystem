local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerData = require(script.Parent.PlayerDataTemplate)
local Rarity = require(ReplicatedStorage.Enums:WaitForChild("Rarity"))

--[[
    game starts by the player getting given an option of three basic pets
    from there the player should be able to farm coins, buy more pets, increase
    their village level
]]

export type PetInstance = {
	UUID: string,
	Name: string,
    Model: string,
    Rarity: string,
    Skill: string,

    Multiplier: number, --coin/gem multiplier
    Power: number,

    Equipped: boolean,
    Locked: boolean,
    RequiredVillage: number, --some pets may aquire you to be a certain level
}

type PetConfig = {

    Rarity: string,
}

local Config: { [string]: PetConfig } = {
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

local Pets = {}

Pets.Config = Config

function Pets.GetConfig(pet: PetInstance): PetConfig
    return Pets.Config[pet.Model]
end

function Pets.GetEquippedPower(data : PlayerData): PetConfig
    
end

--[[
    Calculates from the power, how much damage the pet does per second it's on the coins
    or attacking someones village
]]
function Pets.GetDamagePerHit(pet: PetInstance): PetConfig
    local config = Pets.GetConfig(pet)

    
end

return Pets