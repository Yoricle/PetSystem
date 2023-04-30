-- Utility
-- AmazingRocker
-- November 1, 2021

local BoatTween = require(script.Parent.BoatTween)

local Utility = {}


function Utility:Tween(instance: Instance, data: {}, callback)
	local tween: Tween = BoatTween:Create(instance, data)

	tween.Completed:Connect(function()
		if tween.PlaybackState == Enum.PlaybackState.Completed then
			tween:Destroy()
			if callback then
				callback()
			end
		end
	end)

	tween:Play()

	return tween
end


function Utility:Create(className: string, parent: Instance, properties: {})
	properties = properties or {}
	parent = parent or nil

	local instance = Instance.new(className)

	for property, value in pairs(properties) do
		xpcall(function()
			instance[property] = value
		end, warn)
	end

	if (parent) then
		instance.Parent = parent
	end

	return instance
end


return Utility