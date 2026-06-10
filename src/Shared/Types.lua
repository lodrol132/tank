--[[
    Type definitions for Territorial.io
    Used for documentation and validation
]]

local Types = {}

--[[
    Territory Type Definition
    @table Territory
    @field id number - Unique territory identifier
    @field name string - Territory name
    @field owner string|nil - Player ID of owner (nil if neutral)
    @field x number - Grid X coordinate
    @field y number - Grid Y coordinate
    @field type string - Region type (Farm, Quarry, etc.)
    @field resources table - Current resources
    @field buildings table - Constructed buildings
    @field troops number - Current troop count
    @field state string - Current state (neutral, contested, capturing, owned)
    @field defenseBonus number - Defense bonus from buildings
    @field lastAttackedBy string|nil - Player ID of last attacker
    @field captureProgress number - Capture progress (0-1)
]]
Types.Territory = {}

--[[
    Player Data Type Definition
    @table PlayerData
    @field userId number - Roblox user ID
    @field username string - Player username
    @field level number - Player level
    @field faction string - Faction color
    @field resources table - Resource inventory
    @field territories table - List of territory IDs owned
    @field buildings table - Building inventory
    @field allies table - List of allied player IDs
    @field stats table - Player statistics
    @field joinedAt number - Timestamp when player joined
]]
Types.PlayerData = {}

--[[
    Building Type Definition
    @table Building
    @field id number - Unique building identifier
    @field type string - Building type (Farm, Defense, etc.)
    @field owner string - Player ID of owner
    @field territoryId number - Territory where building is located
    @field level number - Building level
    @field health number - Current health (0-100)
    @field productionProgress number - Production progress (0-1)
    @field x number - Position X
    @field y number - Position Y
    @field z number - Position Z
]]
Types.Building = {}

--[[
    Combat Event Type Definition
    @table CombatEvent
    @field attacker string - Attacking player ID
    @field defender string - Defending player ID
    @field sourceTerritory number - Territory ID attacker is in
    @field targetTerritory number - Territory ID being attacked
    @field troopsAttacking number - Number of troops attacking
    @field troopsDefending number - Number of troops defending
    @field attackPower number - Calculated attack power
    @field defensePower number - Calculated defense power
    @field result string - "victory" or "defeat"
    @field timestamp number - When combat occurred
]]
Types.CombatEvent = {}

--[[
    Resource Type Definition
    @table Resource
    @field name string - Resource name
    @field amount number - Current amount
    @field limit number - Maximum capacity
    @field generationRate number - Amount generated per tick
]]
Types.Resource = {}

--[[
    Game State Type Definition
    @table GameState
    @field status string - Game status (waiting, playing, ended)
    @field timeRemaining number - Seconds remaining
    @field territories table - All territories
    @field players table - All players
    @field events table - Recent events
    @field leaderboard table - Ranked players
]]
Types.GameState = {}

return Types
