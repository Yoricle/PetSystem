local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ViewModel = require(ReplicatedStorage.RoactComponents.ViewModel)

local InventoryViewModel = {}
InventoryViewModel.__index = InventoryViewModel
InventoryViewModel.className = "InventoryViewModel"
setmetatable(InventoryViewModel, ViewModel)

function InventoryViewModel.new(): table
    local self = ViewModel.new()

    self.value = 0
    self.popUpText = "" -- this will changed based on which button is hovered over
    self.sizeX = 0.5
    self.sizeY = 0.5

    self.placeholderText = "Search" -- This probably won't change, but it's placeholder for the searchbar
    self.inventoryVisible = false

    return setmetatable(self, InventoryViewModel)
end

function InventoryViewModel:setInventorySize(scaleX: number, scaleY: number)
    self.sizeX = scaleX
    self.sizeY = scaleY
    self:update()
end

function InventoryViewModel:setInventoryVisible(Visible : BoolValue)
    Visible = not Visible
    self.inventoryVisible = Visible
    self:update()
end

function InventoryViewModel:setPopupTitle(newValue: any)
    self.popUpText = newValue
    self:update()
end

function InventoryViewModel:Destroy()
    getmetatable(InventoryViewModel).Destroy(self)
end

return InventoryViewModel
