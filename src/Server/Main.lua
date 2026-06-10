--[[
    Server Main Script
    Initializes game server and manages game state
]]

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Wait for modules to be loaded
local Config = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("Config"))
local Constants = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("Constants"))
local Utils = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("Utils"))

local TerritoryManager = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("TerritoryManager"))
local ResourceManager = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("ResourceManager"))
local CombatSystem = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("CombatSystem"))
local BuildingSystem = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("BuildingSystem"))
local GameManager = require(ServerScriptService:WaitForChild("Managers"):WaitForChild("GameManager"))
local NetworkHandler = require(ServerScriptService:WaitForChild("Services"):WaitForChild("NetworkHandler"))

print("[Server] Starting Territorial.io...")

-- Initialize systems
TerritoryManager:Initialize()
NetworkHandler:InitializeRemotes()

print("[Server] TerritoryManager initialized")
print("[Server] Network handlers initialized")

-- Start game loop
local runService = game:GetService("RunService")
local lastResourceGeneration = tick()

runService.Heartbeat:Connect(function()
    local currentTime = tick()
    
    -- Generate resources every second
    if currentTime - lastResourceGeneration >= 1 then
        ResourceManager:GenerateResourcesFromTerritories(TerritoryManager)
        lastResourceGeneration = currentTime
    end
    
    -- Update game state
    GameManager:Update()
    CombatSystem:UpdateCombats()
    BuildingSystem:UpdateProduction()
end)

-- Handle player joins
Players.PlayerAdded:Connect(function(player)
    print("[Server] Player joined: " .. player.Name)
    GameManager:AddPlayer(player.UserId, player.Name)
    ResourceManager:InitializePlayer(player.UserId)
end)

-- Handle player leaves
Players.PlayerRemoving:Connect(function(player)
    print("[Server] Player left: " .. player.Name)
    GameManager:RemovePlayer(player.UserId)
    ResourceManager:RemovePlayer(player.UserId)
end)

-- Setup remote events
local attackEvent = NetworkHandler:GetRemoteEvent("AttackTerritory")
if attackEvent then
    attackEvent.OnServerEvent:Connect(function(player, sourceTerrId, targetTerrId, troops)
        print("[Server] Attack event from " .. player.Name)
        local success, msg = CombatSystem:AttackTerritory(
            player.UserId, sourceTerrId, targetTerrId, troops,
            TerritoryManager, ResourceManager
        )
        
        if success then
            NetworkHandler:BroadcastEvent("GameEvent", {
                type = "TERRITORY_CAPTURED",
                player = player.Name,
                territory = targetTerrId
            })
        end
    end)
end

print("[Server] Territorial.io initialized successfully")
