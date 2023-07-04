--[[
    This is the actual inventory that holds the pets
]]


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local PetPanel = Roact.Component:extend("PetPanel")

function PetPanel:init()
    self:setState({
        inventoryVisible = self.props.viewModel.inventoryVisible,
    })
end

function PetPanel:didMount()
    self.props.viewModel.updated:Connect(function(viewModel)
        self:setState({
            inventoryVisible = viewModel.inventoryVisible,
        })
    end)
end

function PetPanel:render()
    return Roact.createElement("ImageLabel", { -- this will be just the design of the ui
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 170, 255),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.55, 0, 0.55, 0),
        Visible = self.state.inventoryVisible,
    },{
        Inventory = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.419, 0),
            Size = UDim2.new(1.02, 0, 1.009, 0),
            ZIndex = 6,
        },{
            InventoryFrame = Roact.createElement("ScrollingFrame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0.515, 0),
                Size = UDim2.new(0.97, 0, 0.97, 0),
                ZIndex = 7,
                CanvasSize = UDim2.new(0, 0, 3, 0),
                BottomImage = "rbxassetid://6433369893",
                MidImage = "rbxassetid://158362264",
                TopImage = "rbxassetid://6433369534",
                BorderSizePixel = 0,
            }),

            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 25),
            }),

            UIAspectRatioConstraint= Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1.8,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width,
            }),
        }),

        SearchBar = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 0.45,
            BackgroundColor3 = Color3.fromRGB(0, 95, 143),
            Position = UDim2.new(1, 0, 1, 0),
            Size = UDim2.new(0.478, 0, 0.123, 0),
            Visible = true,
            ZIndex = 7,
        },{

            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(1, 0),
            }),

            UIStroke = Roact.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = Color3.fromRGB(0, 90, 132),
                Thickness = 2,
                Transparency = 0,
            }),

            Input = Roact.createElement("TextBox", {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.175, 0, 0.5, 0),
                Size = UDim2.new(0.75, 0, 0.8, 0),
                TextEditable = true,
                Visible = true,
                ZIndex = 1,
                PlaceholderText = self.state.placeholderText,
                Font = Enum.Font.FredokaOne,
                PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
            },{
                UIStroke = Roact.createElement("UIStroke", {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                    Color = Color3.fromRGB(0, 90, 132),
                    Thickness = 2,
                    Transparency = 0,
                }), 
            }),

            ImageLabel = Roact.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.03, 0, 0.48, 0),
                Size = UDim2.new(0.13, 0, 0.9, 0),
                Visible = true,
                ZIndex = 1,
                Image = "rbxassetid://5352277644",
            }),
        }),

        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 1.5,
        }),
        
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 25),
        }),

        UIPadding = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0.1, 0),
            PaddingLeft = UDim.new(0.025, 0),
            PaddingRight = UDim.new(0.025, 0),
            PaddingTop = UDim.new(0.1, 0),
        }),

        UIStroke = Roact.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
            Color = Color3.fromRGB(28, 69, 82),
            Thickness = 3,
            Transparency = 0,
        }),

        Close = Roact.createElement("ImageButton", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.901, 0, -0.254, 0),
            Size = UDim2.new(0.249, 0, 0.177, 0),
            Visible = true,
            ZIndex = 6,
            Image = "http://www.roblox.com/asset/?id=10639558446",
            HoverImage = "http://www.roblox.com/asset/?id=10639560635",
            PressedImage = "http://www.roblox.com/asset/?id=10639562516",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(90, 90, 90, 90),
        },{
            TextLabel = Roact.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0.85, 0, 0.85, 0),
                ZIndex = 8,
                Font = Enum.Font.FredokaOne,
                TextScaled = true,
                Text = "Close",
                TextColor3 = Color3.fromRGB(255,255,255),
            },{ 
                UIStroke = Roact.createElement("UIStroke", {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                    Color = Color3.fromRGB(0,0,0),
                    Thickness = 2.5,
                    Transparency = 0.75,
                }),
            }),

            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 2.5,
            }),

            UIPadding = Roact.createElement("UIPadding", {
                PaddingBottom = UDim.new(0.1, 0),
                PaddingLeft = UDim.new(0.025, 0),
                PaddingRight = UDim.new(0.025, 0),
                PaddingTop = UDim.new(0.1, 0),
            }),
        }),

        ToggleGrid = Roact.createElement("ImageButton", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.47, 0, 1, 0),
            Size = UDim2.new(0.066, 0, 0.117, 0),
            ZIndex = 15,
            Image = "rbxassetid://11574640769",
            ImageColor3 = Color3.fromRGB(199, 199, 199),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1,
            }),
        }),

        ShowAll = Roact.createElement("ImageButton", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(1.169, 0, -0.059, 0),
            Size = UDim2.new(0.227, 0, 0.135, 0),
            ZIndex = 15,
            Image = "rbxassetid://10581856859",
            HoverImage = "http://www.roblox.com/asset/?id=10639560635",
            PressedImage = "http://www.roblox.com/asset/?id=10639562516",
            ImageColor3 = Color3.fromRGB(85, 255, 0),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(90, 90, 90, 90),
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 3,
            }),

            UIPadding = Roact.createElement("UIPadding", {
                PaddingBottom = UDim.new(0.1, 0),
                PaddingLeft = UDim.new(0.025, 0),
                PaddingRight = UDim.new(0.025, 0),
                PaddingTop = UDim.new(0.1, 0),
            }),

            TextLabel = Roact.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0.95, 0, 0.95, 0),
                ZIndex = 27,
                Font = Enum.Font.FredokaOne,
                TextScaled = true,
                Text = "Show All",
                TextColor3 = Color3.fromRGB(255,255,255),
            },{ 
                UIStroke = Roact.createElement("UIStroke", {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                    Color = Color3.fromRGB(0,0,0),
                    Thickness = 2.5,
                    Transparency = 0.75,
                }),
            }),
        }),

        Title = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.285, 0, -0.251, 0),
            Size = UDim2.new(0.596, 0, 0.154, 0),
            ZIndex = 8,
            Text = "Pets 😺",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.FredokaOne,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        },{
            UIStroke = Roact.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = Color3.fromRGB(28, 69, 82),
                Thickness = 3,
                Transparency = 0,
            }),
        }),

        Storage = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.13, 0, 1.05, 0),
            Size = UDim2.new(0.237, 0, 0.084, 0),
            ZIndex = 25,
            Text = "PETS N/A",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.FredokaOne,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        },{
            UIStroke = Roact.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = Color3.fromRGB(28, 69, 82),
                Thickness = 3,
                Transparency = 0,
            }),
        }),

        Equipped = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.1, 0, 0.95, 0),
            Size = UDim2.new(0.187, 0, 0.095, 0),
            ZIndex = 25,
            Text = "N/A",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.FredokaOne,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        },{
            UIStroke = Roact.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = Color3.fromRGB(28, 69, 82),
                Thickness = 3,
                Transparency = 0,
            }),
        })

    })
end

return PetPanel