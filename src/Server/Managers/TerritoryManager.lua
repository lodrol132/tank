--[[
    TerritoryManager.lua
    Manages all territories on the map
]]

local Config = require(game:GetService("ServerScriptService"):WaitForChild("Config"))
local Constants = require(game:GetService("ServerScriptService"):WaitForChild("Constants"))
local Utils = require(game:GetService("ServerScriptService"):WaitForChild("Utils"))

local TerritoryManager = {}
TerritoryManager.territories = {}
TerritoryManager.territoryCount = 0

-- INITIALIZATION
function TerritoryManager:Initialize()
    self:GenerateMap()
    self:UpdateBorders()
    print("[TerritoryManager] Initialized with " .. self.territoryCount .. " territories")
end

-- GENERATE MAP BASED ON GRID
function TerritoryManager:GenerateMap()
    local cols = Config.GridSize.Columns
    local rows = Config.GridSize.Rows
    local regionWidth = Config.MapSize.Width / cols
    local regionHeight = Config.MapSize.Height / rows
    local regionTypes = {"Farm", "Quarry", "SteelFactory", "OilRefinery", "UraniumPlant"}
    
    for y = 1, rows do
        for x = 1, cols do
            local id = (y - 1) * cols + x
            local regionType = regionTypes[((x + y) % #regionTypes) + 1]
            
            self.territories[id] = {
                id = id,
                name = "Region_" .. id,
                owner = nil,
                x = x,
                y = y,
                type = regionType,
                resources = {
                    Troops = Config.ResourceInitial.Troops,
                    Money = Config.ResourceInitial.Money,
                    Concrete = Config.ResourceInitial.Concrete,
                    Steel = Config.ResourceInitial.Steel,
                    Fuel = Config.ResourceInitial.Fuel,
                    Uranium = Config.ResourceInitial.Uranium
                },
                buildings = {},
                state = Constants.TerritoryState.NEUTRAL,
                defenseBonus = 0,
                captureProgress = 0,
                lastAttackedBy = nil
            }
            
            self.territoryCount = self.territoryCount + 1
        end
    end
end

-- GET TERRITORY BY ID
function TerritoryManager:GetTerritory(id)
    return self.territories[id]
end

-- GET TERRITORY BY COORDINATES
function TerritoryManager:GetTerritoryByCoords(x, y)
    for id, territory in pairs(self.territories) do
        if territory.x == x and territory.y == y then
            return territory
        end
    end
    return nil
end

-- GET NEIGHBORS OF TERRITORY
function TerritoryManager:GetNeighbors(territory)
    local neighbors = {}
    local dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    
    for _, dir in ipairs(dirs) do
        local nx = territory.x + dir[1]
        local ny = territory.y + dir[2]
        local neighbor = self:GetTerritoryByCoords(nx, ny)
        if neighbor then
            table.insert(neighbors, neighbor)
        end
    end
    
    return neighbors
end

-- CHANGE TERRITORY OWNER
function TerritoryManager:SetOwner(territoryId, newOwner)
    local territory = self:GetTerritory(territoryId)
    if not territory then return false end
    
    territory.owner = newOwner
    territory.state = Constants.TerritoryState.OWNED
    territory.captureProgress = 0
    
    return true
end

-- UPDATE TERRITORY BORDERS
function TerritoryManager:UpdateBorders()
    for id, territory in pairs(self.territories) do
        -- This will be called by client-side rendering
        -- Server just maintains data consistency
    end
end

-- GET TERRITORIES BY OWNER
function TerritoryManager:GetTerritoriesByOwner(owner)
    local owned = {}
    for id, territory in pairs(self.territories) do
        if territory.owner == owner then
            table.insert(owned, territory)
        end
    end
    return owned
end

-- COUNT OWNED TERRITORIES
function TerritoryManager:CountOwnedTerritories(owner)
    return #self:GetTerritoriesByOwner(owner)
end

-- GET ALL TERRITORIES
function TerritoryManager:GetAllTerritories()
    return self.territories
end

-- VALIDATE NEIGHBOR ATTACK
function TerritoryManager:CanAttack(sourceId, targetId)
    local source = self:GetTerritory(sourceId)
    local target = self:GetTerritory(targetId)
    
    if not source or not target then return false, "Invalid territory" end
    if source.owner == target.owner then return false, "Cannot attack own territory" end
    if not Utils.IsNeighbor(source.x, source.y, target.x, target.y) then
        return false, "Target is not a neighbor"
    end
    
    return true, nil
end

return TerritoryManager
