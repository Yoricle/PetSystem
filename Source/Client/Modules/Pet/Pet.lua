--[[

This component ideally needs to link with the 'PetTemplate' to display onto the UI to regonise the type of pet, the pet template just sets the UI up with Roact

Bare in mind, this is JUST the object for the pet and nothing else we should be able to generate the object and destroy the object cleanly and use it elsewhere in a controller

]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Assets").Pets


local Knit = RunService:IsRunning and require(ReplicatedStorage.Packages.Knit)
local Component = require(ReplicatedStorage.Packages.Component)
local Comm = require(ReplicatedStorage.Packages.Comm)

local ClientComm = Comm.ClientComm

local Pet = Component.new({ Tag = "Pet", Extensions = {} })


--[[
The purpose of this component is to create the PetTemplate of the pet based on a stringvalue that is sent from the server to the client, 
this will then fill in the details to getting the pet into the players inventory

]]

function Pet:Construct()
    self._comm = ClientComm.new(self.Instance)

    self._petAquired = self._comm:GetSignal("InventoryPetAquired") -- This signal is about sending information to the client in order to add it to the inventory

    self._petAquired:Connect(function(Pet : StringValue, Id : number)
        self:AddPetToInventory(Pet, Id)
    end)
end

function Pet:AddPetToInventory(Pet : StringValue, Id : number)
    
end

function Pet:Add(Name : StringValue) -- maybe just pass in the string/name of the pet that is required
    local pickedPet = Library:FindFirstChild(Name) -- finding the child with the name
end

function Pet:Start()
    local Pet : PetInstance = self.Instance -- any instance that's tagged 'Pet' with the 'PetInstance' type

    self.id = Pet:GetAttribute("Id") -- gets the pets identifiable id

end

function Pet:Stop()

end

function Pet:PetAquired()
    
end

type PetInstance = BasePart & {
	Mesh: SpecialMesh,
	bottom: Attachment,
    center : Attachment,
}

return Pet