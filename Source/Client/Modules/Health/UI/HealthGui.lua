local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local HealthFrame = require(script.Parent.HealthFrame)

local HealthGui = Roact.Component:extend("MobileControlsGui")

function HealthGui:init(props)
    self:setState({
        adornee = self.props.viewModel.adornee,
    })
end

function HealthGui:didMount()
    self.props.viewModel.updated:Connect(function(viewModel) -- uses signal to update state
		self:setState({
            adornee = viewModel.adornee,
		})
	end)
end

function HealthGui:render()
    return Roact.createElement("BillboardGui", {
        ResetOnSpawn = false,
        Adornee = self.state.adornee,
        Brightness = 1,
        MaxDistance = 60,
        Size = UDim2.fromScale(14,6),
        StudsOffset = Vector3.new(0,6,0)
    }, {
        HeatlhFrame = Roact.createElement(HealthFrame, {
            viewModel = self.props.viewModel,
        }),
    })
end

return HealthGui

