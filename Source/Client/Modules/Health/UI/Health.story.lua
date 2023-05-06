local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local HealthViewModel = require(script.Parent.HealthViewModel)

return function(target)
    local viewModel = HealthViewModel.new()

    viewModel:setHealth(100)
    viewModel:setMaxHealth(100)

    local element = Roact.createElement(require(script.Parent.HealthFrame), {
        viewModel = viewModel,
        target = target,
    })
    local handler = Roact.mount(element, target) 

    local t = task.delay(1, function()
        viewModel:setHealth(0)
    end)

    return function()
        Roact.unmount(handler)
        task.cancel(t)
        viewModel:Destroy()
    end
end