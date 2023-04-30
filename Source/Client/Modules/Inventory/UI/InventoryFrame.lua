local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.roact)

local InventoryFrame = Roact.Component:extend("InventoryFrame")

function InventoryFrame:init()
    self:setState({
        value = self.props.viewModel.value,
        popUpText = self.props.viewModel.popUpText,
    })
end

function InventoryFrame:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        self:setState({
            value = viewModel.value,
        })
    end)
end

function InventoryFrame:render()
    return Roact.createElement("Frame", {
        Name = "Bottom",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 1, 0),
        Size = UDim2.new(0.75, 0, 0.1, 50),
    },{
        Inventory = Roact.createElement("TextButton", {
            Name = "Inventory",
            Text = "Inventory",
            LayoutOrder = 1,
            Size = UDim2.new(0.6, 0, 0.6,0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),
        }),


        Shop = Roact.createElement("TextButton", {
            Name = "Shop",
            Text = "Shop",
            LayoutOrder = 5,
            Size = UDim2.new(0.6, 0, 0.6,0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }), 
        }),

        Settings = Roact.createElement("TextButton", {
            Name = "Settings",
            Text = "Settings",
            LayoutOrder = 6,
            Size = UDim2.new(0.6, 0, 0.6,0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),  
        }),

        Trading = Roact.createElement("TextButton", {
            Name = "Trading",
            Text = "Trading",
            LayoutOrder = 3,
            Size = UDim2.new(0.6, 0, 0.6,0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),   
        }),

        Achievements = Roact.createElement("TextButton", {
            Name = "Achievements",
            Text = "Achievements",
            LayoutOrder = 4,
            Size = UDim2.new(0.6, 0, 0.6,0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),
        }),

        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0.01, 10),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
        })
    })
end

return InventoryFrame