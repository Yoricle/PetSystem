local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ViewModel = require(ReplicatedStorage.RoactComponents.ViewModel)

local InventoryViewModel = {}
InventoryViewModel.__index = InventoryViewModel
InventoryViewModel.className = "InventoryViewModel"
setmetatable(InventoryViewModel, ViewModel)

function InventoryViewModel.new(): table
    local self = ViewModel.new()

    self.value = 0

    return setmetatable(self, InventoryViewModel)
end

function InventoryViewModel:setValue(newValue: any)
    self.value = newValue
    self:update()
end

function InventoryViewModel:Destroy()
    getmetatable(InventoryViewModel).Destroy(self)
end

return InventoryViewModel
