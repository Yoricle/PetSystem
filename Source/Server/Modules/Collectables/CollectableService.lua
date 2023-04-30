local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.knit)
local Component = require(ReplicatedStorage.Packages.Component)

local RESPAWN_TIME = 30

local random = Random.new()

local playerCollectables = {}
local globalCollectables = {}

local CollectableService = Knit.CreateService({
	Name = "CollectableService",
	Client = {},
})
CollectableService.Client.NewCollectable = Knit.CreateSignal()
CollectableService.Client.CreateFromCollectableList = Knit.CreateSignal()
CollectableService.Client.Collected = Knit.CreateSignal()
CollectableService.Client.Remove = Knit.CreateSignal()

function CollectableService:KnitStart()
	Players.PlayerRemoving:Connect(function(player)
		self:PlayerRemoving(player)
	end)

	self.Client.Collected:Connect(function(...)
		self:Collected(...)
	end)
end

function CollectableService:Collected(player: Player, guid: string)
	local infoTable

	if globalCollectables[guid] then
		infoTable = globalCollectables
	elseif playerCollectables[player][guid] then
		infoTable = playerCollectables[player]
	end

	if not infoTable then
		return
	end

	local info = infoTable[guid]

	infoTable[guid] = nil
	self.Client.Remove:FireAll(guid)

	local CargoHoldComponent = Component.FromTag("CargoHold")
	local cargoHold = CargoHoldComponent:GetFromInstance(player.Character)
	cargoHold:AddItem(info.type, info.variant)

	task.delay(RESPAWN_TIME, function()
		if info.isGlobal then
			self:CreateGlobalCollectable(nil, info.type, info.onGround, info.cframe)
		else
			self:CreateLocalCollectable(player, nil, info.type, info.onGround, info.cframe)
		end
	end)
end

function CollectableService:CreateCollectableAtCFrame(
	cframe: CFrame,
	collectableName: string,
	onGround: boolean,
	isGlobal: boolean
)
	local guid = HttpService:GenerateGUID(false)

	local collectableVariants = ReplicatedStorage.Assets.Collectables:FindFirstChild(collectableName)
	local children = collectableVariants:GetChildren()
	local randomCollectable = children[random:NextInteger(1, #children)]

	if onGround then
		local rotation = cframe - cframe.Position

		local params = RaycastParams.new()
		local raycastResult = workspace:Raycast(cframe.Position, Vector3.new(0, -1000, 0), params)

		if raycastResult.Position then
			cframe = rotation + raycastResult.Position + Vector3.new(0, 2, 0)
		end
	end

	return {
		guid = guid,
		type = collectableName,
		cframe = cframe,
		variant = randomCollectable.Name,
		isGlobal = isGlobal,
		onGround = onGround,
	}
end

function CollectableService:CreateCollectable(
	referenceBlock: BasePart,
	collectableName: string,
	onGround: boolean,
	isGlobal: boolean
)
	-- we need to place the collectable randomly on the spawn block
	local halfX = referenceBlock.Size.X / 2
	local halfZ = referenceBlock.Size.Z / 2

	local randomCFrame = referenceBlock.CFrame
		* CFrame.new(random:NextNumber(-halfX, halfX), 0, random:NextNumber(-halfZ, halfZ))

	local rotation = randomCFrame - randomCFrame.Position

	if onGround then
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = { referenceBlock }
		local raycastResult = workspace:Raycast(randomCFrame.Position, Vector3.new(0, -1000, 0), params)

		if raycastResult.Position then
			randomCFrame = rotation + raycastResult.Position
		end
	end

	return self:CreateCollectableAtCFrame(randomCFrame, collectableName, isGlobal)
end

function CollectableService:CreateGlobalCollectable(
	referenceBlock: BasePart,
	collectableName: string,
	onGround: boolean,
	cframe: CFrame?
)
	local info = if cframe then 
		self:CreateCollectableAtCFrame(cframe, collectableName, onGround, true) 
	else 
		self:CreateCollectable(referenceBlock, collectableName, onGround, true)

	globalCollectables[info.guid] = info

	self.Client.NewCollectable:FireAll(info)
end

function CollectableService:CreateLocalCollectable(
	player: Player,
	referenceBlock: BasePart,
	collectableName: string,
	onGround: boolean,
	cframe: CFrame?
)
	local info = if cframe then 
		self:CreateCollectableAtCFrame(cframe, collectableName, onGround, false)
	else 
		self:CreateCollectable(referenceBlock, collectableName, onGround, false)

	playerCollectables[player][info.guid] = info

	self.Client.NewCollectable:Fire(player, info)
end

function CollectableService.Client:GetGlobals()
	return globalCollectables
end

function CollectableService.Client:CreateLocals(player)
	if playerCollectables[player] then
		return
	end

	playerCollectables[player] = {}

	for _, v in pairs(CollectionService:GetTagged("CollectableSpawner")) do
		local spawner = Component.FromTag("CollectableSpawner"):GetFromInstance(v)

		spawner:CreateLocalItems(player)
	end

	for _, v in pairs(CollectionService:GetTagged("BeamSpawner")) do
		local spawner = Component.FromTag("BeamSpawner"):GetFromInstance(v)

		spawner:CreateLocalItems(player)
	end
end

function CollectableService:PlayerRemoving(player: Player)
	playerCollectables[player] = nil
end

return CollectableService
