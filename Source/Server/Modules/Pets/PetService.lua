local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService("Players")

-- Packages
local ProfileService = require(ReplicatedStorage.Packages.ProfileService)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local Knit = require(ReplicatedStorage.Packages.Knit)


local PROFILE_TEMPLATE: { [string]: boolean } = {}

local profiles = {}

local PetService = Knit.CreateService {
    Name = "PetService",
    Client = {
        Inventory = Knit.CreateProperty({}), -- This needs to be able to store the "PetSlot" into it, so one of the templates and save
        PetEquipped = Knit.CreateProperty(false),
    },
}

local function CreateLeaderstats(player : Player)
    local Profile = profiles[player]

    if not Profile then 
        return 
    end

    local PetFolder = Instance.new("Folder", player)
    PetFolder.Name = "Pets"
end


local function initializePlayer(player: Player)
	local profile = PetService._profileStore:LoadProfileAsync("Player_" .. player.UserId)

	if not profile then
		return warn(`Failed to load PetInventory profile for ${player.Name}`)
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	profile:ListenToRelease(function()
		profiles[player] = nil
	end)

	if player:IsDescendantOf(Players) then
		profiles[player] = profile
        CreateLeaderstats(player)
	else
		profile:Release()
	end

	PetService.Client.Inventory:SetFor(player, profile.Data) -- This will set all the players pets in their inventory, we have to now apply this visually via the PetController
end

function PetService:AddPetToDatabase()
    
end

function PetService:KnitStart()
    print("PetService Started")
--[[
    self.Client.PetEquipped:Connect(function(player : Player)
        -- Pet equipped from client, make sure this is checked carefully just incase player can abuse
    end)
]]

end

local function deInitializePlayer(player: Player)
	local profile = profiles[player]
	if profile then
		profile:Release()
	end
end

function PetService:KnitInit()
	self._profileStore = ProfileService.GetProfileStore("Pets", PROFILE_TEMPLATE)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			initializePlayer(player)
		end)
	end

	Players.PlayerAdded:Connect(initializePlayer)
	Players.PlayerRemoving:Connect(deInitializePlayer)
end

function PetService:ResetData(player: Player)
	local profile = profiles[player]
	if not profile then
		return warn(`Failed to reset data for {player.Name} because they have no profile`)
	end

	profile.Data = TableUtil.Copy(PROFILE_TEMPLATE)
	self.Client.Inventory:SetFor(player, profile.Data) -- This will reset all the players pets in their inventory
end


function PetService:GetPet()
    
end


return PetService
