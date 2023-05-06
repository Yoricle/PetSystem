--[[
	This controller is responsible for handling the collectable spawning

	local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.knit)

local assets: Folder = ReplicatedStorage:FindFirstChild("Assets")
local collectables: Folder = assets:FindFirstChild("Collectables")

local CollectableController = Knit.CreateController { Name = "CollectableController" }

type CollectableInfo = {
	guid: string,
	cframe : CFrame,
	type : string,
	variant: string
}

local holdingFolder = Instance.new("Folder")
holdingFolder.Name = "Collectables"
holdingFolder.Parent = workspace

function CollectableController:KnitStart()
	local CollectableService = Knit.GetService("CollectableService")

	CollectableService.NewCollectable:Connect(function (info: CollectableInfo)
		self:CreateCollectable(info)
	end)

	CollectableService.Remove:Connect(function (guid: string)
		for _, collectable: BasePart in pairs (CollectionService:GetTagged("Collectable")) do
			if collectable.Name == guid then
				collectable:Destroy()
			end
		end
	end)

	CollectableService:GetGlobals():andThen(function (globals)
		for _, info: CollectableInfo in pairs(globals) do
			self:CreateCollectable(info)
		end
	end)


	CollectableService:CreateLocals()
end


function CollectableController:CreateCollectable(info: CollectableInfo)
	if holdingFolder:FindFirstChild(info.guid) then
		return
	end

	local collectableFolder: Folder = collectables:FindFirstChild(info.type)

	if not collectableFolder then
		warn("Could not find collectable of type " .. info.type)
		return
	end

	local reference = collectableFolder:FindFirstChild(info.variant)

	local newCollectable: BasePart = reference:Clone()

	newCollectable.CFrame = info.cframe
	newCollectable.Name = info.guid
	newCollectable:SetAttribute("Type", info.type)
	newCollectable.Parent = holdingFolder

	CollectionService:AddTag(newCollectable, "Pickupable")
	CollectionService:AddTag(newCollectable, "Collectable")
end


return CollectableController
]]


local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Knit = require(ReplicatedStorage.Packages.Knit)

local CollectableController = Knit.CreateController { Name = "CollectableController" }

function CollectableController:KnitInit()
	print("CollectableController Initialised")
end


return CollectableController

