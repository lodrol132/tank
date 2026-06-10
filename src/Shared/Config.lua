--[[
    Configuration file for Territorial.io
    All game settings and balancing parameters
]]

local Config = {}

-- GAME SETTINGS
Config.GameVersion = "1.0.0"
Config.MaxPlayers = 32
Config.GameDuration = 3600 -- 1 hour in seconds
Config.TickRate = 1 -- Resource generation per second

-- MAP SETTINGS
Config.MapSize = {
    Width = 1024,
    Height = 768
}

Config.RegionType = {
    GRID = "grid",
    HEXAGON = "hexagon"
}
Config.CurrentRegionType = Config.RegionType.GRID

Config.GridSize = {
    Columns = 16,
    Rows = 12
}

-- RESOURCES
Config.Resources = {
    "Troops",
    "Money",
    "Concrete",
    "Steel",
    "Fuel",
    "Uranium"
}

Config.ResourceInitial = {
    Troops = 100,
    Money = 500,
    Concrete = 50,
    Steel = 25,
    Fuel = 30,
    Uranium = 5
}

Config.ResourceLimits = {
    Troops = 10000,
    Money = 50000,
    Concrete = 5000,
    Steel = 2500,
    Fuel = 3000,
    Uranium = 500
}

-- RESOURCE GENERATION PER SECOND BY REGION TYPE
Config.ResourceGeneration = {
    Farm = {
        Money = 2,
        Troops = 0,
        Concrete = 0,
        Steel = 0,
        Fuel = 0,
        Uranium = 0
    },
    Quarry = {
        Money = 0,
        Troops = 0,
        Concrete = 3,
        Steel = 0,
        Fuel = 0,
        Uranium = 0
    },
    SteelFactory = {
        Money = 0,
        Troops = 0,
        Concrete = 0,
        Steel = 2,
        Fuel = 0,
        Uranium = 0
    },
    OilRefinery = {
        Money = 0,
        Troops = 0,
        Concrete = 0,
        Steel = 0,
        Fuel = 2.5,
        Uranium = 0
    },
    UraniumPlant = {
        Money = 0,
        Troops = 0,
        Concrete = 0,
        Steel = 0,
        Fuel = 0,
        Uranium = 0.5
    },
    Neutral = {
        Money = 1,
        Troops = 0,
        Concrete = 0.5,
        Steel = 0,
        Fuel = 0,
        Uranium = 0
    }
}

-- BUILDINGS
Config.Buildings = {
    -- Economic
    Farm = {
        Type = "Economic",
        Cost = { Money = 300, Concrete = 100 },
        Effect = "Produces Money and Food",
        ProductionTime = 10,
        MaxPerTerritory = 3
    },
    Quarry = {
        Type = "Economic",
        Cost = { Money = 400, Concrete = 150 },
        Effect = "Produces Concrete",
        ProductionTime = 12,
        MaxPerTerritory = 2
    },
    SteelFactory = {
        Type = "Economic",
        Cost = { Money = 600, Steel = 50 },
        Effect = "Produces Steel",
        ProductionTime = 15,
        MaxPerTerritory = 2
    },
    OilRefinery = {
        Type = "Economic",
        Cost = { Money = 500, Steel = 100 },
        Effect = "Produces Fuel",
        ProductionTime = 14,
        MaxPerTerritory = 2
    },
    UraniumMine = {
        Type = "Economic",
        Cost = { Money = 1000, Steel = 200 },
        Effect = "Produces Uranium",
        ProductionTime = 20,
        MaxPerTerritory = 1
    },
    Bank = {
        Type = "Infrastructure",
        Cost = { Money = 800, Concrete = 200 },
        Effect = "+8 Money per tick",
        ProductionTime = 16,
        MaxPerTerritory = 2
    },
    Factory = {
        Type = "Infrastructure",
        Cost = { Money = 900, Steel = 150 },
        Effect = "1.5x extractor speed",
        ProductionTime = 18,
        MaxPerTerritory = 2
    },
    DefensePost = {
        Type = "Military",
        Cost = { Money = 400, Concrete = 200 },
        Effect = "+5% damage in radius",
        ProductionTime = 12,
        MaxPerTerritory = 4
    },
    Port = {
        Type = "Military",
        Cost = { Money = 700, Steel = 250 },
        Effect = "Naval units + deployment",
        ProductionTime = 18,
        MaxPerTerritory = 1
    },
    NuclearLauncher = {
        Type = "Military",
        Cost = { Money = 2000, Uranium = 50, Steel = 300 },
        Effect = "Ultimate weapon",
        ProductionTime = 30,
        MaxPerTerritory = 1
    }
}

-- COMBAT SYSTEM
Config.Combat = {
    BaseAttackPower = 1.0,
    BaseDefensePower = 1.5,
    CaptureDuration = 30, -- seconds to fully capture territory
    TroopLossPercentage = 0.15, -- 15% loss per attack
    MinimumTroopsToAttack = 10,
    DefenseBonusPerBuilding = 0.05 -- +5% per defense building
}

-- UI SETTINGS
Config.UI = {
    TopBarHeight = 50,
    PanelWidth = 300,
    Colors = {
        Primary = Color3.fromRGB(100, 149, 237),
        Secondary = Color3.fromRGB(255, 165, 0),
        Success = Color3.fromRGB(34, 139, 34),
        Danger = Color3.fromRGB(220, 20, 60),
        Neutral = Color3.fromRGB(128, 128, 128)
    }
}

-- FACTION COLORS
Config.FactionColors = {
    Purple = Color3.fromRGB(128, 0, 128),
    Pink = Color3.fromRGB(255, 192, 203),
    Brown = Color3.fromRGB(165, 42, 42),
    Green = Color3.fromRGB(34, 139, 34),
    Blue = Color3.fromRGB(0, 0, 255),
    Red = Color3.fromRGB(255, 0, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Orange = Color3.fromRGB(255, 165, 0)
}

-- DEBUGGING
Config.Debug = true
Config.ShowBorders = true
Config.ShowFPS = true

return Config
