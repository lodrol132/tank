--[[
    TopBar.lua
    Displays game resources and main UI elements
]]

local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))
local Constants = require(game:GetService("ReplicatedStorage"):WaitForChild("Constants"))

local TopBar = {}
TopBar.gui = nil
TopBar.resourceLabels = {}

function TopBar:Initialize()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TopBar"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    self.gui = screenGui
    self:CreateTopBarFrame()
    print("[TopBar] Initialized")
end

function TopBar:CreateTopBarFrame()
    local frame = Instance.new("Frame")
    frame.Name = "TopBarFrame"
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
    frame.BorderSizePixel = 0
    frame.Parent = self.gui
    
    -- Add border bottom
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(100, 149, 237)
    border.Thickness = 2
    border.LineJoinMode = Enum.LineJoinMode.Bevel
    border.Parent = frame
    
    self:CreateResourceDisplay(frame)
    self:CreateRightButtons(frame)
end

function TopBar:CreateResourceDisplay(parent)
    local resources = Config.Resources
    local resourcesFrame = Instance.new("Frame")
    resourcesFrame.Name = "ResourcesFrame"
    resourcesFrame.Size = UDim2.new(0, 500, 1, 0)
    resourcesFrame.Position = UDim2.new(0, 100, 0, 0)
    resourcesFrame.BackgroundTransparency = 1
    resourcesFrame.Parent = parent
    
    local uiLayout = Instance.new("UIListLayout")
    uiLayout.Orientation = Enum.Orientation.Horizontal
    uiLayout.Padding = UDim.new(0, 15)
    uiLayout.FillDirection = Enum.FillDirection.Horizontal
    uiLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiLayout.Parent = resourcesFrame
    
    -- Resource icons and amounts
    local resourceConfigs = {
        {name = "Troops", icon = "⚔️", color = Color3.fromRGB(220, 20, 60)},
        {name = "Money", icon = "💰", color = Color3.fromRGB(255, 215, 0)},
        {name = "Concrete", icon = "🧱", color = Color3.fromRGB(169, 169, 169)},
        {name = "Steel", icon = "⚙️", color = Color3.fromRGB(192, 192, 192)},
        {name = "Fuel", icon = "⛽", color = Color3.fromRGB(255, 140, 0)},
        {name = "Uranium", icon = "☢️", color = Color3.fromRGB(0, 255, 0)}
    }
    
    for _, res in ipairs(resourceConfigs) do
        self:CreateResourceItem(resourcesFrame, res)
    end
end

function TopBar:CreateResourceItem(parent, resource)
    local container = Instance.new("Frame")
    container.Name = resource.name
    container.Size = UDim2.new(0, 70, 1, -10)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.Text = resource.icon .. " 0"
    label.Parent = container
    
    self.resourceLabels[resource.name] = label
end

function TopBar:CreateRightButtons(parent)
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Name = "ButtonsFrame"
    buttonsFrame.Size = UDim2.new(0, 200, 1, 0)
    buttonsFrame.Position = UDim2.new(1, -200, 0, 0)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = parent
    
    local uiLayout = Instance.new("UIListLayout")
    uiLayout.Orientation = Enum.Orientation.Horizontal
    uiLayout.Padding = UDim.new(0, 10)
    uiLayout.FillDirection = Enum.FillDirection.Horizontal
    uiLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    uiLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uiLayout.Parent = buttonsFrame
    
    -- Timer
    local timerLabel = Instance.new("TextLabel")
    timerLabel.Name = "Timer"
    timerLabel.Size = UDim2.new(0, 60, 1, -10)
    timerLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timerLabel.Font = Enum.Font.GothamBold
    timerLabel.TextScaled = true
    timerLabel.Text = "00:00"
    timerLabel.Parent = buttonsFrame
    
    -- Settings button
    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Name = "SettingsBtn"
    settingsBtn.Size = UDim2.new(0, 40, 0, 40)
    settingsBtn.BackgroundColor3 = Color3.fromRGB(100, 149, 237)
    settingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.Text = "⚙️"
    settingsBtn.Parent = buttonsFrame
end

function TopBar:UpdateResources(resources)
    for resourceName, amount in pairs(resources) do
        if self.resourceLabels[resourceName] then
            local icons = {
                Troops = "⚔️",
                Money = "💰",
                Concrete = "🧱",
                Steel = "⚙️",
                Fuel = "⛽",
                Uranium = "☢️"
            }
            self.resourceLabels[resourceName].Text = (icons[resourceName] or "📦") .. " " .. tostring(amount)
        end
    end
end

return TopBar
