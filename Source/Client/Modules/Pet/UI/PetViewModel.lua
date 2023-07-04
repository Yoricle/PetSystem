local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ViewModel = require(ReplicatedStorage.RoactComponents.ViewModel)

local PetViewModel = {}
PetViewModel.__index = PetViewModel
PetViewModel.className = "PetViewModel"
setmetatable(PetViewModel, ViewModel)

function PetViewModel.new(MaxStorage : number): table -- will either pass through the default storage or the data that's loaded with their custom max storage
    local self = ViewModel.new()

    -- inventory stuff
    self.Equipped = false
    self.petId = 0
    self.MaxEquipped = 1
    self.MaxPlayerStorage = MaxStorage
    self.Multiplier = 0

    return setmetatable(self, PetViewModel)
end

function PetViewModel:setMaxEquipped(newValue : number)
    self.MaxEquipped = newValue
    self:update()
end

function PetViewModel:setPetInventory(Value : BoolValue)
    self.inventoryVisible = Value
    self:update()
end

function PetViewModel:setPetEquipped(newValue : BoolValue)
    self.Equipped = newValue
    self:update()
end

function PetViewModel:setPetId(newValue : number)
    self.petId = newValue
    self:update()
end

function PetViewModel:setMaxStorage(newValue : number)
    self.MaxPlayerStorage = newValue
    self:update()
end

function PetViewModel:Destroy()
    getmetatable(PetViewModel).Destroy(self)
end

return PetViewModel
