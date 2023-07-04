local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Knit = RunService:IsRunning() and require(ReplicatedStorage.Packages.Knit)

local Flipper = require(ReplicatedStorage.Packages.Flipper)
local RoactFlipper = require(ReplicatedStorage.Packages.RoactFlipper)

local InventoryFrame = Roact.Component:extend("InventoryFrame")

function InventoryFrame:init()
    self:setState({
        popUpText = self.props.viewModel.popUpText,
        sizeX = self.props.viewModel.sizeX,
        sizeY = self.props.viewModel.sizeY,
        inventoryVisible = self.props.viewModel.inventoryVisible
    })

    -- Animation motor
    self.shopMotor = Flipper.SingleMotor.new(1)
    self.shopBinding = RoactFlipper.getBinding(self.shopMotor)

    self.settingsMotor = Flipper.SingleMotor.new(1)
    self.settingsBinding = RoactFlipper.getBinding(self.settingsMotor)

    self.inventoryMotor = Flipper.SingleMotor.new(1)
    self.inventoryBinding = RoactFlipper.getBinding(self.inventoryMotor)

    self.tradingMotor = Flipper.SingleMotor.new(1)
    self.tradingBinding = RoactFlipper.getBinding(self.tradingMotor)

    self.achievementMotor = Flipper.SingleMotor.new(1)
    self.achievementBinding = RoactFlipper.getBinding(self.achievementMotor)
end

function InventoryFrame:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        self:setState({
            sizeX = viewModel.sizeX,
            sizeY = viewModel.sizeY,
            inventoryVisible = viewModel.inventoryVisible -- false
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
            Size = self.inventoryBinding:map(function(alpha) -- map binding to size property
                return UDim2.new(0.8, 0, 0.8,0):Lerp(UDim2.new(0.6, 0, 0.6,0), alpha)
            end),
            Position = UDim2.new(0.5, 0, 0.5, 0),

            [Roact.Event.MouseEnter] = function()
                self:setState({

                })
                self.inventoryMotor:setGoal(Flipper.Spring.new(0, {
                    frequency = 4,
                    dampingRatio = 0.75
                }))
            end,

            [Roact.Event.MouseLeave] = function()
                self.inventoryMotor:setGoal(Flipper.Spring.new(1, {
                    frequency = 5,
                    dampingRatio = 1
                }))
            end,

            [Roact.Event.Activated] = function()
                local InventoryController = Knit.GetController("InventoryController")
                InventoryController:ToggleInventory(self.state.inventoryVisible)
            end
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),
        }),

        Shop = Roact.createElement("TextButton", {
            Name = "Shop",
            Text = "Shop",
            LayoutOrder = 5,

            Size = self.shopBinding:map(function(alpha) -- map binding to size property
                return UDim2.new(0.8, 0, 0.8,0):Lerp(UDim2.new(0.6, 0, 0.6,0), alpha)
            end),

            Position = UDim2.new(0.5, 0, 0.5, 0),

            [Roact.Event.MouseEnter] = function()
                self.shopMotor:setGoal(Flipper.Spring.new(0, {
                    frequency = 4,
                    dampingRatio = 0.75
                }))
            end,

            [Roact.Event.MouseLeave] = function()
                self.shopMotor:setGoal(Flipper.Spring.new(1, {
                    frequency = 5,
                    dampingRatio = 1
                }))
            end,
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }), 
        }),

        Settings = Roact.createElement("TextButton", {
            Name = "Settings",
            Text = "Settings",
            LayoutOrder = 6,
            Size = self.settingsBinding:map(function(value) -- map binding to size property
                return UDim2.new(0.8, 0, 0.8,0):Lerp(UDim2.new(0.6, 0, 0.6,0), value)
            end),
            Position = UDim2.new(0.5, 0, 0.5, 0),

            [Roact.Event.MouseEnter] = function()
                self.settingsMotor:setGoal(Flipper.Spring.new(0, {
                    frequency = 4,
                    dampingRatio = 0.75
                }))
            end,

            [Roact.Event.MouseLeave] = function()
                self.settingsMotor:setGoal(Flipper.Spring.new(1, {
                    frequency = 5,
                    dampingRatio = 1
                }))
            end,
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),  
        }),

        Trading = Roact.createElement("TextButton", {
            Name = "Trading",
            Text = "Trading",
            LayoutOrder = 3,
            Size = self.tradingBinding:map(function(alpha) -- map binding to size property
                return UDim2.new(0.8, 0, 0.8,0):Lerp(UDim2.new(0.6, 0, 0.6,0), alpha)
            end),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            [Roact.Event.MouseEnter] = function()
                self.tradingMotor:setGoal(Flipper.Spring.new(0, {
                    frequency = 4,
                    dampingRatio = 0.75
                }))
            end,

            [Roact.Event.MouseLeave] = function()
                self.tradingMotor:setGoal(Flipper.Spring.new(1, {
                    frequency = 5,
                    dampingRatio = 1
                }))
            end,
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),   
        }),

        Achievements = Roact.createElement("TextButton", {
            Name = "Achievements",
            Text = "Achievements",
            LayoutOrder = 4,
            Size = self.achievementBinding:map(function(alpha) -- map binding to size property
                return UDim2.new(0.8, 0, 0.8,0):Lerp(UDim2.new(0.6, 0, 0.6,0), alpha)
            end),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            [Roact.Event.MouseEnter] = function()
                self.achievementMotor:setGoal(Flipper.Spring.new(0, {
                    frequency = 4,
                    dampingRatio = 0.75
                }))
            end,

            [Roact.Event.MouseLeave] = function()
                self.achievementMotor:setGoal(Flipper.Spring.new(1, {
                    frequency = 5,
                    dampingRatio = 1
                }))
            end,
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
        }),
    })
end

return InventoryFrame