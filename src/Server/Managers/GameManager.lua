--[[
    GameManager.lua
    Main game loop and state management
]]

local Config = require(game:GetService("ServerScriptService"):WaitForChild("Config"))
local Constants = require(game:GetService("ServerScriptService"):WaitForChild("Constants"))

local GameManager = {}
GameManager.gameState = Constants.GameState.WAITING
GameManager.startTime = 0
GameManager.players = {}
GameManager.isRunning = false

-- START GAME
function GameManager:StartGame()
    if self.isRunning then return false end
    
    self.gameState = "playing"
    self.startTime = tick()
    self.isRunning = true
    
    print("[GameManager] Game started!")
    return true
end

-- STOP GAME
function GameManager:StopGame()
    self.isRunning = false
    self.gameState = "ended"
    print("[GameManager] Game ended!")
end

-- ADD PLAYER
function GameManager:AddPlayer(playerId, playerName)
    self.players[playerId] = {
        id = playerId,
        name = playerName,
        joinTime = tick(),
        status = Constants.PlayerStatus.ALIVE,
        faction = nil,
        score = 0
    }
end

-- REMOVE PLAYER
function GameManager:RemovePlayer(playerId)
    self.players[playerId] = nil
end

-- GET GAME TIME
function GameManager:GetGameTime()
    if not self.isRunning then return 0 end
    return tick() - self.startTime
end

-- GET TIME REMAINING
function GameManager:GetTimeRemaining()
    local elapsed = self:GetGameTime()
    local remaining = Config.GameDuration - elapsed
    return math.max(0, remaining)
end

-- UPDATE GAME LOOP
function GameManager:Update()
    if not self.isRunning then return end
    
    local timeRemaining = self:GetTimeRemaining()
    
    if timeRemaining <= 0 then
        self:StopGame()
    end
end

-- GET PLAYER COUNT
function GameManager:GetPlayerCount()
    local count = 0
    for _ in pairs(self.players) do count = count + 1 end
    return count
end

return GameManager
