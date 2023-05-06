local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Knit = require(ReplicatedStorage.Packages.knit)

local PetService = Knit.CreateService {
    Name = "PetService",
    Client = {},
}


function PetService:KnitStart()
    print("PetService Started")
end


function PetService:KnitInit()
    
end


return PetService
