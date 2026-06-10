--[[
    BuildingSystem.lua
    Manages building construction and production
]]

local Config = require(game:GetService("ServerScriptService"):WaitForChild("Config"))
local Utils = require(game:GetService("ServerScriptService"):WaitForChild("Utils"))

local BuildingSystem = {}
BuildingSystem.buildings = {}
BuildingSystem.buildingIdCounter = 0

-- CONSTRUCT BUILDING
function BuildingSystem:ConstructBuilding(owner, territoryId, buildingType, resourceMgr)
    -- Validate building type
    if not Config.Buildings[buildingType] then
        return false, "Invalid building type"
    end
    
    local buildingConfig = Config.Buildings[buildingType]
    
    -- Check resources
    if not resourceMgr:HasResources(owner, buildingConfig.Cost) then
        return false, "Insufficient resources"
    end
    
    -- Spend resources
    resourceMgr:SpendResources(owner, buildingConfig.Cost)
    
    -- Create building
    self.buildingIdCounter = self.buildingIdCounter + 1
    local buildingId = self.buildingIdCounter
    
    self.buildings[buildingId] = {
        id = buildingId,
        type = buildingType,
        owner = owner,
        territoryId = territoryId,
        level = 1,
        health = 100,
        productionProgress = 0,
        constructionTime = buildingConfig.ProductionTime
    }
    
    return true, buildingId
end

-- GET BUILDINGS BY TERRITORY
function BuildingSystem:GetBuildingsByTerritory(territoryId)
    local result = {}
    for id, building in pairs(self.buildings) do
        if building.territoryId == territoryId then
            table.insert(result, building)
        end
    end
    return result
end

-- GET BUILDINGS BY OWNER
function BuildingSystem:GetBuildingsByOwner(owner)
    local result = {}
    for id, building in pairs(self.buildings) do
        if building.owner == owner then
            table.insert(result, building)
        end
    end
    return result
end

-- UPDATE BUILDING PRODUCTION
function BuildingSystem:UpdateProduction()
    for id, building in pairs(self.buildings) do
        building.productionProgress = building.productionProgress + 1
        
        if building.productionProgress >= building.constructionTime then
            building.productionProgress = 0
        end
    end
end

-- DAMAGE BUILDING
function BuildingSystem:DamageBuilding(buildingId, damage)
    local building = self.buildings[buildingId]
    if not building then return false end
    
    building.health = math.max(0, building.health - damage)
    return true
end

-- DESTROY BUILDING
function BuildingSystem:DestroyBuilding(buildingId)
    if self.buildings[buildingId] then
        self.buildings[buildingId] = nil
        return true
    end
    return false
end

-- UPGRADE BUILDING
function BuildingSystem:UpgradeBuilding(buildingId, resourceMgr)
    local building = self.buildings[buildingId]
    if not building then return false, "Building not found" end
    
    -- Upgrade cost increases with level
    local upgradeCost = {
        Money = 500 * building.level,
        Concrete = 200 * building.level
    }
    
    if not resourceMgr:HasResources(building.owner, upgradeCost) then
        return false, "Insufficient resources"
    end
    
    resourceMgr:SpendResources(building.owner, upgradeCost)
    building.level = building.level + 1
    building.health = 100
    
    return true, building.level
end

return BuildingSystem
