--[[
    Client Main Script
    Initializes all client-side systems
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))
local TopBar = require(game:GetService("ReplicatedStorage"):WaitForChild("TopBar"))
local TerritoryInfoPanel = require(game:GetService("ReplicatedStorage"):WaitForChild("TerritoryInfoPanel"))
local BuildMenu = require(game:GetService("ReplicatedStorage"):WaitForChild("BuildMenu"))
local Leaderboard = require(game:GetService("ReplicatedStorage"):WaitForChild("Leaderboard"))
local MapController = require(game:GetService("ReplicatedStorage"):WaitForChild("MapController"))

print("[Client] Game initialized")

-- Initialize UI systems
TopBar:Initialize()
TerritoryInfoPanel:Initialize()
BuildMenu:Initialize()
Leaderboard:Initialize()
MapController:Initialize()

-- Keyboard shortcuts
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.L then
        if Leaderboard.isVisible then
            Leaderboard:Hide()
        else
            Leaderboard:Show()
        end
    elseif input.KeyCode == Enum.KeyCode.B then
        if BuildMenu.isVisible then
            BuildMenu:Hide()
        else
            BuildMenu:Show()
        end
    elseif input.KeyCode == Enum.KeyCode.Escape then
        TerritoryInfoPanel:Hide()
        BuildMenu:Hide()
        Leaderboard:Hide()
    end
end)

-- Simulate resource updates
spawn(function()
    local resources = {
        Troops = 100,
        Money = 500,
        Concrete = 50,
        Steel = 25,
        Fuel = 30,
        Uranium = 5
    }
    
    while true do
        TopBar:UpdateResources(resources)
        -- Simulate resource generation
        resources.Money = resources.Money + 2
        resources.Concrete = resources.Concrete + 1
        resources.Fuel = resources.Fuel + 0.5
        
        wait(1)
    end
end)

print("[Client] All systems initialized")
