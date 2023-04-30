local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.knit)
local Trove = require(ReplicatedStorage.Packages.Trove)

local Collectable = {}
Collectable.__index = Collectable

Collectable.Tag = "Collectable"

function Collectable.new(instance)
	local self = setmetatable({}, Collectable)

	self._trove = Trove.new()
	self._collected = false

	return self
end

function Collectable:Init()
	self._trove:Add(self.Instance.Touched:Connect(function (hit: BasePart)
		if hit:IsDescendantOf(Knit.Player.Character) then
			Knit.GetService("CollectableService").Collected:Fire(self.Instance.Name)
		end
	end))
end

function Collectable:Destroy()
	self._trove:Destroy()
end

return Collectable