local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local PetFrame = require(script.Parent.PetFrame)

return function(props)
    return Roact.createElement("ScreenGui", {
        ResetOnSpawn = false,
    }, {
        PetFrame = Roact.createElement(PetFrame, {
            viewModel = props.viewModel,
        }),
    })
end