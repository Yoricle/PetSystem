local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.roact)
local InventoryViewModel = require(script.Parent.InventoryViewModel)

return function(target)
    local viewModel = InventoryViewModel.new()

    local element = Roact.createElement(require(script.Parent.InventoryFrame), {
        viewModel = viewModel
    })
    local handler = Roact.mount(element, target)

    return function()
        Roact.unmount(handler)
        viewModel:Destroy()
    end
end