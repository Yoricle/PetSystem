-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
-- Packages
local Knit = require(ReplicatedStorage.Packages.Knit)
local Roact = require(ReplicatedStorage.Packages.Roact)
local Trove = require(ReplicatedStorage.Packages.Trove)

local CoinController = Knit.CreateController { Name = "CoinController" }
-- Roact
local HealthGui = require(script.Parent.UI.HealthGui)
local HealthViewModel = require(script.Parent.UI.HealthViewModel)

local Coin = require(script.Parent.Coin)

-- Components

local viewModel = HealthViewModel.new()



function CoinController:KnitInit()
    --[[
        When a coin pile is clicked, we want the health to be mounted onto
        the coin pile, this is just a temporary test
    ]]
end

function CoinController:KnitStart()

    print("CoinController Started")

    --local HealthService = Knit.GetService("HealthService")

    -- we need to mount the health bar to the instance of a coin


    -- we want to observe the amount of health on a pile of coins
    -- if that heatlh is lower than 0 then unmount roact
    print("Roact HealthFrame Mounted")
end

function CoinController:EnableHealthBar() -- if you want to pass in a value you can, but for now it's visible
    viewModel:setVisibility(true)
end

function CoinController:Attack(Part : BasePart | MeshPart)
    local health : number = Part:SetAttribute("Health", viewModel.health)-- this will get the attribute of the coins health and assign it to the viewmodel
    local maxHealth : number = Part:SetAttribute("MaxHealth", viewModel.maxHealth)

    task.spawn(function()
        viewModel:setHealth()
        viewModel:setMaxHealth()
    end)

    viewModel:setAdornee(Part) -- pass in the component instance

    Roact.mount(Roact.createElement(HealthGui, {
        viewModel = viewModel,
    }), Players.LocalPlayer.PlayerGui, "Health")

    -- these values are replaced inside of the viewmodel
end


return CoinController
