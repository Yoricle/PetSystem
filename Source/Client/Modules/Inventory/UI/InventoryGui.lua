local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.roact)
local InventoryFrame = require(script.Parent.InventoryFrame)

return function(props)
    return Roact.createElement("ScreenGui", {
        ResetOnSpawn = false,
    }, {
        InventoryFrame = Roact.createElement(InventoryFrame, {
            viewModel = props.viewModel,
        }),
    })
end