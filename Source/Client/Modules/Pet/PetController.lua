local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Knit = require(ReplicatedStorage.Packages.knit)
local Roact = require(ReplicatedStorage.Packages.Roact)
local Flipper = require(ReplicatedStorage.Packages.Flipper) -- possibly used for egg movement
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local Player = game.Players.LocalPlayer

local PetInventoryGui = require(script.Parent.UI.PetInventoryGui)
local PetViewModel = require(script.Parent.UI.PetViewModel)

local DEFAULT_STORAGE_CAPACITY = 50

local PetController = Knit.CreateController { Name = "PetController" }

function PetController:KnitStart()
    -- safe to mount a new pet in the inventory..

    local PetService = Knit.GetService("PetService")

    local playerStorage = Player:GetAttribute("MaxStorage") or DEFAULT_STORAGE_CAPACITY -- find a way to set this on the player when they join and save that storage value
    local viewModel = PetViewModel.new(playerStorage) -- we can pass values here if needed, like the players max storage

    
    local InventoryGui = Roact.mount(Roact.createElement(PetInventoryGui, {
        viewModel = viewModel,
    }),
        Player:WaitForChild("PlayerGui"),
        "PetInventory"
    )

    PetService.inventory:Observe(function(pets)
        local AmountStored = #TableUtil.Keys(pets) -- pass through the pet table, this variable should return a number of the pet storage
        if AmountStored >= playerStorage then -- "playerStorage" should return number
            Roact.unmount(InventoryGui)
            viewModel:destroy()
            return
        end
        viewModel:setPet() -- here we want the set the pet template visually
    end)
end


function PetController:RequirePet(Pet : Instance, Id : number)
    
end


function PetController:SingleHatch()
    
end

function PetController:TrippleHatch()
    
end

function PetController:OctupleHatch()
    -- Optional, but players could possibly be able to hatch up to x8 eggs
end

function PetController:EquipPet() -- when adding to the pet inventory

end

return PetController
