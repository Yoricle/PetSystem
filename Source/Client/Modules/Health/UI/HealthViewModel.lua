local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ViewModel = require(ReplicatedStorage.RoactComponents.ViewModel)

local HealthViewModel = {}
HealthViewModel.__index = HealthViewModel
HealthViewModel.className = "HealthViewModel"
setmetatable(HealthViewModel, ViewModel)

function HealthViewModel.new(): table
    local self = ViewModel.new()

    self.health = 50 -- health should be set to whatever difficulty/level the coins are
    self.maxHealth = 100
    self.difference = self.health / self.maxHealth
    self.adornee = nil -- set to nil before the object adornee is assigned

    self.damage = 0 -- created this value so you can set a new viewmodel and call :setDamage() when controlling the pets to decrease the value
    
    return setmetatable(self, HealthViewModel)
end

function HealthViewModel:setHealth(newValue: number)
    self.health = newValue
    self:update()
end

function HealthViewModel:setMaxHealth(newValue : number)
    self.maxHealth = newValue
    self:update()
end

function HealthViewModel:setAdornee(newValue : BasePart | MeshPart) -- this will be a coin pile
    self.adornee = newValue
    self:update()
end

function HealthViewModel:setDamage(newValue : number) -- this will be a coin pile
    self.damage = newValue
    self:update()
end

function HealthViewModel:Destroy()
    getmetatable(HealthViewModel).Destroy(self)
end

return HealthViewModel
