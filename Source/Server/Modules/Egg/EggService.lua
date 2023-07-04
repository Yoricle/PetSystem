local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Knit = require(ReplicatedStorage.Packages.Knit)

local EggService = Knit.CreateService {
    Name = "EggService",
    Client = {
        StartHatch = Knit.CreateSignal("StartHatch")
    },
}

function EggService:KnitStart()
    print("EggService Started")
end

function EggService:StartHatching()
    
end

function EggService:KnitInit()
    
end


return EggService
