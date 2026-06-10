# API Documentation - Territorial.io

## Server-Side API

### TerritoryManager
```lua
-- Initialize and generate map
TerritoryManager:Initialize()

-- Get territory by ID
local territory = TerritoryManager:GetTerritory(id)

-- Get territory by coordinates
local territory = TerritoryManager:GetTerritoryByCoords(x, y)

-- Get neighboring territories
local neighbors = TerritoryManager:GetNeighbors(territory)

-- Change territory owner
TerritoryManager:SetOwner(territoryId, newOwner)

-- Get territories owned by player
local territories = TerritoryManager:GetTerritoriesByOwner(owner)

-- Validate if attack is possible
local canAttack, error = TerritoryManager:CanAttack(sourceId, targetId)
```

### ResourceManager
```lua
-- Initialize player resources
ResourceManager:InitializePlayer(playerId)

-- Get player resources
local resources = ResourceManager:GetResources(playerId)

-- Add resource
ResourceManager:AddResource(playerId, resourceName, amount)

-- Remove resource
ResourceManager:RemoveResource(playerId, resourceName, amount)

-- Check if player has resources
local hasResources = ResourceManager:HasResources(playerId, costTable)

-- Spend resources (all or nothing)
local success = ResourceManager:SpendResources(playerId, costTable)
```

### CombatSystem
```lua
-- Attack territory
local success, msg = CombatSystem:AttackTerritory(
    attacker, sourceTerrId, targetTerrId, troops,
    territoryMgr, resourceMgr
)

-- Calculate attack power
local power = CombatSystem:CalculateAttackPower(territory, troops)

-- Calculate defense power
local power = CombatSystem:CalculateDefensePower(territory)
```

### BuildingSystem
```lua
-- Construct building
local success, buildingId = BuildingSystem:ConstructBuilding(
    owner, territoryId, buildingType, resourceMgr
)

-- Get buildings by territory
local buildings = BuildingSystem:GetBuildingsByTerritory(territoryId)

-- Upgrade building
local success, newLevel = BuildingSystem:UpgradeBuilding(buildingId, resourceMgr)
```

## Client-Side API

### TopBar
```lua
TopBar:Initialize()
TopBar:UpdateResources(resources)
```

### TerritoryInfoPanel
```lua
TerritoryInfoPanel:Initialize()
TerritoryInfoPanel:ShowTerritory(territory)
TerritoryInfoPanel:Hide()
```

### MapController
```lua
MapController:Initialize()
MapController:SelectTerritory(territoryId)
MapController:UpdateTerritoryColor(territoryId, color, owner)
MapController:GetSelectedTerritoryId()
```

## Remote Events

### AttackTerritory
```lua
NetworkHandler:GetRemoteEvent("AttackTerritory"):FireServer(sourceTerrId, targetTerrId, troops)
```

### BuildStructure
```lua
NetworkHandler:GetRemoteEvent("BuildStructure"):FireServer(territoryId, buildingType)
```

### SyncResources
```lua
NetworkHandler:GetRemoteEvent("SyncResources"):FireServer(playerId)
```

### GameEvent
```lua
NetworkHandler:GetRemoteEvent("GameEvent"):FireAllClients(eventData)
```
