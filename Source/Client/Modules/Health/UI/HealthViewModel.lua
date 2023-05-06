local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ViewModel = require(ReplicatedStorage.RoactComponents.ViewModel)

local HealthViewModel = {}
HealthViewModel.__index = HealthViewModel
HealthViewModel.className = "HealthViewModel"
setmetatable(HealthViewModel, ViewModel)

function HealthViewModel.new(): table
    local self = ViewModel.new()

    self.health = 0  -- health should be set to whatever difficulty/level the coins are
    self.maxHealth = 0
    self.difference = self.health / self.maxHealth
    self.adornee = nil -- set to nil before the object adornee is assigned
    
    return setmetatable(self, HealthViewModel)
end

function HealthViewModel:setHealth(newValue: number)
    if self.health > self.maxHealth then
        return warn("Error with coin health, please check roact for more information")
    end
    self.health = newValue
    self:update()
end

function HealthViewModel:setMaxHealth(newValue : number)
    if self.maxHealth > self.health then
        return
    end
    self.maxHealth = newValue
    self:update()
end

function HealthViewModel:setAdornee(newValue : BasePart | MeshPart) -- this will be a coin pile
    self.adornee = newValue
    self:update()
end

function HealthViewModel:Destroy()
    getmetatable(HealthViewModel).Destroy(self)
end

return HealthViewModel
