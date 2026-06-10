--[[
    Constants for Territorial.io
    Immutable game constants
]]

local Constants = {}

-- TERRITORY STATES
Constants.TerritoryState = {
    NEUTRAL = "neutral",
    CONTESTED = "contested",
    CAPTURING = "capturing",
    OWNED = "owned"
}

-- PLAYER STATUS
Constants.PlayerStatus = {
    ALIVE = "alive",
    SPECTATOR = "spectator",
    ELIMINATED = "eliminated"
}

-- EVENT TYPES
Constants.EventType = {
    TERRITORY_CAPTURED = "territory_captured",
    BUILDING_CONSTRUCTED = "building_constructed",
    RESOURCE_GENERATED = "resource_generated",
    COMBAT_INITIATED = "combat_initiated",
    PLAYER_JOINED = "player_joined",
    PLAYER_LEFT = "player_left",
    ALLIANCE_FORMED = "alliance_formed",
    NUCLEAR_LAUNCHED = "nuclear_launched"
}

-- REMOTE EVENT NAMES
Constants.RemoteEvents = {
    AttackTerritory = "AttackTerritory",
    BuildStructure = "BuildStructure",
    SyncResources = "SyncResources",
    SyncTerritories = "SyncTerritories",
    PlayerAction = "PlayerAction",
    GameEvent = "GameEvent"
}

-- REMOTE FUNCTION NAMES
Constants.RemoteFunctions = {
    GetGameState = "GetGameState",
    ValidateAction = "ValidateAction",
    GetPlayerData = "GetPlayerData"
}

-- ANIMATION DURATIONS (in seconds)
Constants.Animations = {
    BorderChange = 0.5,
    TroopMovement = 2,
    BuildingConstruction = 1.5,
    UIPopup = 0.3
}

-- SOUNDS
Constants.Sounds = {
    TerritoryCapture = "rbxassetid://12345678",
    Building = "rbxassetid://12345679",
    Attack = "rbxassetid://12345680",
    Victory = "rbxassetid://12345681",
    Defeat = "rbxassetid://12345682"
}

-- ERROR CODES
Constants.ErrorCode = {
    INSUFFICIENT_RESOURCES = 1001,
    INVALID_TERRITORY = 1002,
    NOT_NEIGHBOR = 1003,
    INSUFFICIENT_TROOPS = 1004,
    BUILDING_LIMIT_EXCEEDED = 1005,
    INVALID_ACTION = 1006,
    ANTI_CHEAT_VIOLATION = 9001
}

-- ANTI-CHEAT THRESHOLDS
Constants.AntiCheat = {
    MaxResourcePerTick = 1000,
    SuspiciousActionThreshold = 10,
    BanDuration = 3600 -- 1 hour
}

return Constants
