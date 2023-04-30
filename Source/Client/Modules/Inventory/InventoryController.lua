local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Knit = require(ReplicatedStorage.Packages.Knit)
local Roact = require(ReplicatedStorage.Packages.roact)

local InventoryGui = require(script.Parent.UI.InventoryGui)

local InventoryController = Knit.CreateController { Name = "InventoryController" }


function InventoryController:KnitStart()
    print("InventoryController Inititialized")
    
end


function InventoryController:KnitInit()
    print("InventoryController Inititialized")
    Roact.mount(InventoryGui, game.players.LocalPlayer, "Main")
end


return InventoryController
