local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local PetFrame = Roact.Component:extend("PetFrame")

function PetFrame:init()
    self:setState({
        inventoryVisible = self.props.viewModel.inventoryVisible,
    })
end

function PetFrame:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        self:setState({
            inventoryVisible = viewModel.inventoryVisible,
        })
    end)
end

function PetFrame:render()
    return Roact.createElement()
end

return PetFrame