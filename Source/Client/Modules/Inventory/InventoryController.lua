local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local PetUI = script.Parent.Parent:WaitForChild("Pet").UI
local PetFrame = require(PetUI:WaitForChild("PetFrame"))

local Knit = require(ReplicatedStorage.Packages.Knit)
local Roact = require(ReplicatedStorage.Packages.Roact)

local InventoryGui = require(script.Parent.UI.InventoryGui)
local InventoryViewModel = require(script.Parent.UI.InventoryViewModel)

local InventoryController = Knit.CreateController { Name = "InventoryController" }

local InventoryForViewModel = InventoryViewModel.new() -- creating a new viewmodel

function InventoryController:KnitStart()
    print("InventoryController Started")
    Roact.mount(Roact.createElement(InventoryGui,{
        viewModel = InventoryForViewModel,
    }), Players.LocalPlayer.PlayerGui, "Inventory")
end

function InventoryController:ToggleInventory(Value : BoolValue)
    InventoryForViewModel:setInventoryVisible(Value)
end

function InventoryController:AdjustInventory(scaleX: number, scaleY: number)
    InventoryForViewModel:setInventorySize(scaleX, scaleY) -- X, Y Scale
end

function InventoryController:KnitInit()
    print("InventoryController Inititialized")
end


return InventoryController
