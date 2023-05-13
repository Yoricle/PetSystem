local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Component = require(ReplicatedStorage.Packages.Component)
local Comm = require(ReplicatedStorage.Packages.Comm)

local ServerComm = Comm.ServerComm

local Pet = Component.new({ Tag = "Pet", Extensions = {} })

local function AddRarityTag()
    
end

local function AddNameTag()
    
end

function Pet:Construct()
    print(tostring(self.Instance).. " constructed")

    self._comm = ServerComm.new(self.Instance)

    self._petAquired = self._comm:CreateSignal("InventoryPetAquired") -- this could be fired from the egg?
end

function Pet:AddRarityTag()
    -- add the rarity type of the pet
end

function Pet:AddNameTag()
    -- add the name of the pet
end

function Pet:Start()
    print("Pet Component Started")
end

function Pet:Equip() -- This will equip the physical pet to follow the player
    
end

function Pet:Unequip()
    
end

function Pet:AddTag() -- nametag for the pet
    
end

function Pet:Stop()

end

type PetInstance = BasePart & {
	Mesh: SpecialMesh,
	bottom: Attachment,
    center : Attachment,
}


return Pet