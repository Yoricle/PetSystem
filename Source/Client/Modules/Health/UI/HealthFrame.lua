local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Flipper = require(ReplicatedStorage.Packages.Flipper)
local RoactFlipper = require(ReplicatedStorage.Packages.RoactFlipper)

local UPDATE_HEALTH_SPEED: number = 5 -- adjusted by the amount of damage the pet has
local HEALTH_FADE_DELAY: number = 2

local HealthFrame = Roact.Component:extend("HealthFrame")

function HealthFrame:init(props) -- passed down the viewModel table
    self:setState({
        health = self.props.viewModel.health,
        maxHealth = self.props.viewModel.maxHealth,
    })  
    print(props)
    -- Animation motor
    self._healthMotor = Flipper.SingleMotor.new(props.viewModel.health)
    self._healthBinding = RoactFlipper.getBinding(self._healthMotor)

    self.motor = Flipper.SingleMotor.new(0)
    self.binding = RoactFlipper.getBinding(self.motor)
end

function HealthFrame:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        --self.state.health -= viewModel.health 
        self:setState({
            health = viewModel.health,
            maxHealth = viewModel.maxHealth,
            difference = viewModel.difference,
            adornee = viewModel.adornee,
        })
        self._healthMotor:setGoal(Flipper.Spring.new(viewModel.health, { -- this is the health number
            frequency = 1,
            dampingRatio = 1,
        }))
        self.motor:setGoal(Flipper.Spring.new(viewModel.difference, { -- this is the progress bar
            frequency = 1,
            dampingRatio = 1,
        }))
    end)
end

function HealthFrame:render()
    return Roact.createElement("Frame", {
        Name = "Background",
        BackgroundColor3 = Color3.fromRGB(17, 58, 72),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0.25, 2),
        AnchorPoint = Vector2.new(0, 1),
    },{
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
    UIPadding = Roact.createElement("UIPadding", {
        PaddingBottom = UDim.new(0.2, 0),
        PaddingLeft = UDim.new(0.023, 0),
        PaddingRight = UDim.new(0.023, 0),
        PaddingTop = UDim.new(0.2, 0),
    }),
    
    Bar = Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(252, 198, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = self.binding:map(function(value) -- map binding to size property
            return UDim2.new(1, 0, 1, 0):Lerp(UDim2.new(0.1, 0, 1, 0), value)
        end)
    },{
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(1, 0)
        }),
    }),
    HealthDisplay = Roact.createElement("TextLabel", {
        Text = self._healthBinding:map(function(health: number)
            return `{math.floor(health)}/`.. tostring(self.state.maxHealth)
        end),
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.FredokaOne,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        TextScaled = true,
        BackgroundTransparency = 1,
        ZIndex = 2,
    })
})

end

function HealthFrame:willUnmount()
    --viewModel:Destroy()
end

return HealthFrame