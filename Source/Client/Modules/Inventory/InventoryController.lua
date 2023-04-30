local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Knit = require(ReplicatedStorage.Packages.knit)
local Roact = require(ReplicatedStorage.Packages.roact)

local InventoryGui = require(script.Parent.UI.InventoryGui)
local InventoryViewModel = require(script.Parent.UI.InventoryViewModel)

local InventoryController = Knit.CreateController { Name = "InventoryController" }


function InventoryController:KnitStart()

    local InventoryForViewModel = InventoryViewModel.new() -- creating a new viewmodel


    print("InventoryController Started")
    Roact.mount(Roact.createElement(InventoryGui,{
        viewModel = InventoryForViewModel,
    }), Players.LocalPlayer.PlayerGui, "Inventory")
end

function InventoryController:KnitInit()
    print("InventoryController Inititialized")
end


return InventoryController
