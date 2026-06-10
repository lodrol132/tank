--[[
    ResourceManager.lua
    Manages resource generation and consumption
]]

local Config = require(game:GetService("ServerScriptService"):WaitForChild("Config"))
local Utils = require(game:GetService("ServerScriptService"):WaitForChild("Utils"))

local ResourceManager = {}
ResourceManager.playerResources = {}
ResourceManager.lastTickTime = tick()

-- INITIALIZE PLAYER RESOURCES
function ResourceManager:InitializePlayer(playerId)
    self.playerResources[playerId] = Utils.DeepCopy(Config.ResourceInitial)
    return self.playerResources[playerId]
end

-- GET PLAYER RESOURCES
function ResourceManager:GetResources(playerId)
    if not self.playerResources[playerId] then
        self:InitializePlayer(playerId)
    end
    return self.playerResources[playerId]
end

-- ADD RESOURCE TO PLAYER
function ResourceManager:AddResource(playerId, resourceName, amount)
    local resources = self:GetResources(playerId)
    if not resources[resourceName] then return false end
    
    local newAmount = resources[resourceName] + amount
    resources[resourceName] = Utils.Clamp(newAmount, 0, Config.ResourceLimits[resourceName])
    
    return true
end

-- SUBTRACT RESOURCE FROM PLAYER
function ResourceManager:RemoveResource(playerId, resourceName, amount)
    local resources = self:GetResources(playerId)
    if not resources[resourceName] then return false end
    if resources[resourceName] < amount then return false end
    
    resources[resourceName] = resources[resourceName] - amount
    return true
end

-- CHECK IF PLAYER HAS ENOUGH RESOURCES
function ResourceManager:HasResources(playerId, costTable)
    local resources = self:GetResources(playerId)
    for resourceName, amount in pairs(costTable) do
        if (resources[resourceName] or 0) < amount then
            return false
        end
    end
    return true
end

-- SPEND RESOURCES (ALL OR NOTHING)
function ResourceManager:SpendResources(playerId, costTable)
    if not self:HasResources(playerId, costTable) then
        return false
    end
    
    for resourceName, amount in pairs(costTable) do
        self:RemoveResource(playerId, resourceName, amount)
    end
    
    return true
end

-- GENERATE RESOURCES FROM TERRITORIES
function ResourceManager:GenerateResourcesFromTerritories(territoriesManager)
    local territories = territoriesManager:GetAllTerritories()
    
    for id, territory in pairs(territories) do
        if territory.owner then
            local genRate = Config.ResourceGeneration[territory.type] or Config.ResourceGeneration.Neutral
            
            for resourceName, amount in pairs(genRate) do
                self:AddResource(territory.owner, resourceName, amount)
            end
        end
    end
end

-- SYNC RESOURCES TO CLIENT
function ResourceManager:SyncResources(playerId, remoteEvent)
    local resources = self:GetResources(playerId)
    remoteEvent:FireClient(resources)
end

-- GET RESOURCE LIMITS
function ResourceManager:GetResourceLimits()
    return Utils.DeepCopy(Config.ResourceLimits)
end

-- RESET PLAYER RESOURCES
function ResourceManager:ResetPlayer(playerId)
    self.playerResources[playerId] = Utils.DeepCopy(Config.ResourceInitial)
end

-- REMOVE PLAYER DATA
function ResourceManager:RemovePlayer(playerId)
    self.playerResources[playerId] = nil
end

return ResourceManager
