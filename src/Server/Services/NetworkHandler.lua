--[[
    NetworkHandler.lua
    Manages server-client communication and synchronization
]]

local Constants = require(game:GetService("ServerScriptService"):WaitForChild("Constants"))
local Utils = require(game:GetService("ServerScriptService"):WaitForChild("Utils"))

local NetworkHandler = {}
NetworkHandler.remoteEvents = {}
NetworkHandler.remoteFunctions = {}

-- INITIALIZE REMOTE EVENTS
function NetworkHandler:InitializeRemotes()
    local remotes = Instance.new("Folder")
    remotes.Name = "Remotes"
    remotes.Parent = game:GetService("ReplicatedStorage")
    
    -- Create Remote Events
    for eventName, _ in pairs(Constants.RemoteEvents) do
        local event = Instance.new("RemoteEvent")
        event.Name = eventName
        event.Parent = remotes
        self.remoteEvents[eventName] = event
    end
    
    -- Create Remote Functions
    for funcName, _ in pairs(Constants.RemoteFunctions) do
        local func = Instance.new("RemoteFunction")
        func.Name = funcName
        func.Parent = remotes
        self.remoteFunctions[funcName] = func
    end
    
    print("[NetworkHandler] Remotes initialized")
end

-- GET REMOTE EVENT
function NetworkHandler:GetRemoteEvent(name)
    return self.remoteEvents[name]
end

-- GET REMOTE FUNCTION
function NetworkHandler:GetRemoteFunction(name)
    return self.remoteFunctions[name]
end

-- BROADCAST TO ALL CLIENTS
function NetworkHandler:BroadcastEvent(eventName, ...)
    local event = self:GetRemoteEvent(eventName)
    if event then
        event:FireAllClients(...)
    end
end

-- SEND TO SPECIFIC CLIENT
function NetworkHandler:SendToClient(player, eventName, ...)
    local event = self:GetRemoteEvent(eventName)
    if event then
        event:FireClient(player, ...)
    end
end

-- ANTI-CHEAT VALIDATION
function NetworkHandler:ValidateAction(player, actionType, ...)
    local args = {...}
    
    -- Log suspicious activity
    if actionType == "AttackTerritory" then
        -- Validate attack parameters
        if not args[1] or not args[2] then
            Utils.LogWarn("Invalid attack from player: " .. player.Name)
            return false
        end
    end
    
    return true
end

return NetworkHandler
