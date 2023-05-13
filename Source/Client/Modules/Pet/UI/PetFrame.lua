local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.roact)

local PetFrame = Roact.Component:extend("PetFrame")

function PetFrame:init()
    self:setState({
        value = self.props.viewModel.value,
    })
end

function PetFrame:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        self:setState({
            value = viewModel.value,
        })
    end)
end

function PetFrame:render()
    return Roact.createElement()
end

return PetFrame