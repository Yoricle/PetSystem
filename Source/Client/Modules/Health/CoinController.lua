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

local viewModel = HealthViewModel.new() -- passing in the coinpile
-- Components

function CoinController:KnitStart()

    print("CoinController Started")

    --local HealthService = Knit.GetService("HealthService")

    -- we need to mount the health bar to the instance of a coin


    -- we want to observe the amount of health on a pile of coins
    -- if that heatlh is lower than 0 then unmount roact
    print("Roact HealthFrame Mounted")
end

function CoinController:Attack(Part : BasePart | MeshPart)

    viewModel:setAdornee(Part) -- send part to viewmodel to update

    Roact.mount(Roact.createElement(HealthGui, {
        viewModel = viewModel,
        coinPile = Part,
    }), Players.LocalPlayer.PlayerGui, "Health")

end


return CoinController
