-- Number Animation
-- AmazingRocker
-- September 1, 2021

--[[
	
	obj = NumberAnimation.new()
	
--]]

local Janitor = require(script.Parent.Janitor)
local SuffixService = require(script.SuffixService)
local Spring = require(script.Spring)
local Utility = require(script.Utility)

local DEFAULT_STYLING = {
	Time = 2,
	EasingStyle = "Quad",
	EasingDirection = "InOut",
}

local DEFAULT_DATA = {
	DampingRatio = 1,
	Frequency = 3,
	DefaultStyle = "Tween",
	Abbreviate = false,
	InitialPrefix = ""
}


local NumberAnimation = {}
NumberAnimation.__index = NumberAnimation
NumberAnimation.State = require(script.State)


function NumberAnimation.new(label: GuiBase, value: any, stylingData: {})
	assert(label ~= nil, "GuiBase expected but got nil")
	assert(label:IsA("GuiBase"), string.format("GuiBase expected but got %s", label.ClassName))
	assert(value ~= nil, "BaseValue or State object expected but got nil")

	local self = setmetatable({}, NumberAnimation)
	self.Label = label
	self.Value = value
	self.Prefix = DEFAULT_DATA.InitialPrefix
	self.Abbreviate = stylingData and stylingData.Abbreviate or DEFAULT_DATA.Abbreviate
	self._stylingData = stylingData or DEFAULT_STYLING
	self._style = self._stylingData.Style or DEFAULT_DATA.DefaultStyle
	self._janitor = Janitor.new()

	return self
end


function NumberAnimation:_createSprings()
	self._springs = {}
	self._springs.Value = Spring.new(
		self._stylingData.InitialValue or self.Value.Value,
		self._stylingData.DampingRatio or DEFAULT_DATA.DampingRatio,
		self._stylingData.Frequency or DEFAULT_DATA.Frequency,

		function(value: number)
			self:_setText(value)
		end
	)

	for _, spring: Spring in pairs(self._springs) do
		spring:Start()
		self._janitor:Add(spring)
	end
end


function NumberAnimation:_initializeTween()
	setmetatable(self._stylingData, {
		__index = DEFAULT_STYLING
	})

	self._numberValue = Utility:Create("NumberValue", nil, {
		Value = self.Value and self.Value.Value or self.Value:Get()
	})

	self._janitor:Add(self._numberValue)
	self._janitor:Add(self._numberValue.Changed:Connect(function(newValue: number)
		self:_setText(newValue)
	end))
end


function NumberAnimation:_update()
	if self._style == "Spring" then
		self:_updateSprings()
	elseif self._style == "Tween" then
		self:_updateTween()
	end
end


function NumberAnimation:_updateSprings()
	self._springs.Value:SetTarget(self.Value and self.Value.Value or self.Value:Get())
end


function NumberAnimation:_updateTween()
	Utility:Tween(self._numberValue, {
		Time = self._stylingData.Time,
		EasingStyle = self._stylingData.EasingStyle,
		EasingDirection = self._stylingData.EasingDirection,

		Goal = {
			Value = self.Value and self.Value.Value or self.Value:Get()
		}
	})
end


function NumberAnimation:_setText(value: number)
	if self.Abbreviate then
		local text = string.format("%s%s", self.Prefix, SuffixService:FormatNumber(math.round(value)))
		self.Label.Text = text
	else
		local text = string.format("%s%s", self.Prefix, math.floor(math.round(value)))
		self.Label.Text = text
	end
end


function NumberAnimation:SetPrefix(prefix: string)
	self.Prefix = prefix
end


function NumberAnimation:Start()
	if (typeof(self.Value) == "Instance") then
		self:_setText(self.Value.Value)
		
		self._janitor:Add(self.Value.Changed:Connect(function()
			self:_update()
		end))
	elseif (type(self.Value) == "table") then
		self:_setText(self.Value:Get())
		
		self._janitor:Add(self.Value.Changed:Connect(function()
			self:_update()
		end))
	end
	
	if self._style == "Spring" then
		self:_createSprings()
	elseif self._style == "Tween" then
		self:_initializeTween()
	else
		warn("Invalid Styling style given")
	end
end

export type NumberAnimation = typeof(NumberAnimation.new())
return NumberAnimation