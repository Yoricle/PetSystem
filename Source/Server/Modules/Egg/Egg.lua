local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Component = require(ReplicatedStorage.Packages.Component)
local Roact = require(ReplicatedStorage.Packages.Roact)


-- library
local DataModules = ReplicatedStorage.Source.Shared.Modules.Data
local PetLibrary = require(DataModules.Pets)

local Egg = Component.new({ Tag = "Egg", Extensions = {} })

function Egg:Construct()
    -- Add gui stuff
    -- create functionality which starts hatching
    -- identify egg name and egg type (or whatever else need identifying)
    local eggName = self.Instance:GetAttribute("Egg") -- returns the name of the egg

end

function Egg:Start()
    -- allow hatching to be started
    -- 
end

function Egg:Stop()

end

return Egg