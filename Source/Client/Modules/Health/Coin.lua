local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Component = require(ReplicatedStorage.Packages.Component)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Roact = require(ReplicatedStorage.Packages.Roact)
local Knit = require(ReplicatedStorage.Packages.Knit)

local mouse = Players.LocalPlayer:GetMouse()

-- MVVM modules
local Coin = Component.new({ Tag = "Coin", Extensions = {} })

type Coin = {
	Instance: BasePart,
	Sound: Sound,
	Collected: boolean,
	Value: number,
}
--[[
    Click detector is created for each self.instance that is tagged "Coin"
]]

--[[
    This function will activate when the player hovers over the coinpile
]]

local function ApplyHighlightProperties(Highlight : Highlight, newValue : any)
    Highlight.FillColor = Color3.fromRGB(255,255,255)
    Highlight.FillTransparency = newValue -- 0.2
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
end
function Coin:CreateHighlight(newValue : number)
    local Highlight = Instance.new("Highlight", self.Instance)
    Highlight.Adornee = self.Instance
    Highlight.Parent = self.Instance
    ApplyHighlightProperties(Highlight, 1)
    return Highlight
end

function Coin:CreateClickDetector(coinPile)
    print(coinPile)
    local ClickDetector = Instance.new("ClickDetector")
    ClickDetector.MaxActivationDistance = 32
    ClickDetector.CursorIcon = "rbxassetid://13317496006"
    ClickDetector.Parent = coinPile
    return ClickDetector
end

function Coin:Construct()
    self._trove = Trove.new()

    local Highlight = self:CreateHighlight(1) -- parents on the coin

    local ClickDetector = self:CreateClickDetector(self.Instance)

    self._trove:Add(ClickDetector.MouseHoverEnter:Connect(function(player : Player)
        ApplyHighlightProperties(Highlight, 0.2)
    end))

    self._trove:Add(ClickDetector.MouseHoverLeave:Connect(function(player : Player)
        ApplyHighlightProperties(Highlight, 1)
    end))

    self._trove:Add(ClickDetector.MouseClick:Connect(function(player : Player)
        -- do stuff to coin
        print("ClickDetector Activated!")
        Knit.GetController("CoinController"):Attack(self.Instance)
    end))
end

function Coin:Start()

end

function Coin:Stop()
    print("CoinPile Destroyed")
    self._trove:Destroy()
end

return Coin