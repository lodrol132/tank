--[[
    TerritoryInfoPanel.lua
    Shows info about selected territory
]]

local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))

local TerritoryInfoPanel = {}
TerritoryInfoPanel.gui = nil
TerritoryInfoPanel.isVisible = false

function TerritoryInfoPanel:Initialize()
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "TerritoryInfoPanel"
    self.gui.ResetOnSpawn = false
    self.gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    self:CreatePanel()
    print("[TerritoryInfoPanel] Initialized")
end

function TerritoryInfoPanel:CreatePanel()
    local frame = Instance.new("Frame")
    frame.Name = "Panel"
    frame.Size = UDim2.new(0, 350, 0, 400)
    frame.Position = UDim2.new(0.5, -175, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = self.gui
    
    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 149, 237)
    stroke.Thickness = 2
    stroke.Parent = frame
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.Text = "Territory Info"
    titleLabel.Parent = frame
    
    -- Content frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, -20, 1, -60)
    contentFrame.Position = UDim2.new(0, 10, 0, 50)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = frame
    
    -- Info text
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "InfoLabel"
    infoLabel.Size = UDim2.new(1, 0, 1, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 16
    infoLabel.TextWrapped = true
    infoLabel.Text = "Select a territory\nto see details"
    infoLabel.Parent = contentFrame
    
    frame.TerritoryInfoPanel_Frame = frame
end

function TerritoryInfoPanel:ShowTerritory(territory)
    if not territory then return end
    
    local frame = self.gui:FindFirstChild("Panel")
    if not frame then return end
    
    local titleLabel = frame:FindFirstChild("Title")
    local infoLabel = frame:FindFirstChild("Content"):FindFirstChild("InfoLabel")
    
    if titleLabel then
        titleLabel.Text = territory.name or "Region"
    end
    
    if infoLabel then
        local info = string.format(
            "Type: %s\nOwner: %s\nTroops: %d\nResources:\n  💰 Money: %d\n  🧱 Concrete: %d\n  ⚙️ Steel: %d\n  ⛽ Fuel: %d\n  ☢️ Uranium: %d",
            territory.type or "Unknown",
            territory.owner or "Neutral",
            territory.resources and territory.resources.Troops or 0,
            territory.resources and territory.resources.Money or 0,
            territory.resources and territory.resources.Concrete or 0,
            territory.resources and territory.resources.Steel or 0,
            territory.resources and territory.resources.Fuel or 0,
            territory.resources and territory.resources.Uranium or 0
        )
        infoLabel.Text = info
    end
    
    frame.Visible = true
    self.isVisible = true
end

function TerritoryInfoPanel:Hide()
    local frame = self.gui:FindFirstChild("Panel")
    if frame then
        frame.Visible = false
        self.isVisible = false
    end
end

return TerritoryInfoPanel
