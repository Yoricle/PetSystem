local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local PetTemplate = Roact.Component:extend("PetTemplate")

--[[
    This will also include the pop up which displays when hovering over an inventory slot

]]

function PetTemplate:init()
    self:setState({
        value = self.props.viewModel.value,
    })
end

function PetTemplate:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        self:setState({
            value = viewModel.value,
        })
    end)
end

function PetTemplate:render()
    return Roact.createElement("TextButton", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.2,
        Name = "PetTemplate", -- This may change later on
        Position = UDim2.new(0.5, 0, 0.17, 0),
        Size = UDim2.new(0.204, 0, 0.001, 0),
        ZIndex = 10,
        Font = Enum.Font.SourceSans,
        Text = "",
        [Roact.Event.Activated] = function(...)
            
        end
    },{
        UICorner = Roact.createElement("UICorner",{
            CornerRadius = UDim.new(0, 2500),
        }),

        Roact.createElement("ViewportFrame", {
			Size = UDim2.fromScale(0.7, 0.7),
			Position = UDim2.fromScale(0.65, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(37, 37, 37),
			BackgroundTransparency = 1,
			RichText = true,
		}),
    })
end

return PetTemplate