local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local PetViewModel = require(script.Parent.PetViewModel)

return function(target)
    local viewModel = PetViewModel.new()

    local element = Roact.createElement(require(script.Parent.PetFrame), {
        viewModel = viewModel
    })
    local handler = Roact.mount(element, target)

    return function()
        Roact.unmount(handler)
        viewModel:Destroy()
    end
end