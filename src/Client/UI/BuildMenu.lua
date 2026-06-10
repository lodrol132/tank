--[[
    BuildMenu.lua
    Shows available buildings to construct
]]

local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))

local BuildMenu = {}
BuildMenu.gui = nil
BuildMenu.isVisible = false

function BuildMenu:Initialize()
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "BuildMenu"
    self.gui.ResetOnSpawn = false
    self.gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    self:CreateMenu()
    print("[BuildMenu] Initialized")
end

function BuildMenu:CreateMenu()
    local frame = Instance.new("Frame")
    frame.Name = "MenuFrame"
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(1, -420, 0.5, -250)
    frame.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = self.gui
    
    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 149, 237)
    stroke.Thickness = 2
    stroke.Parent = frame
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.Text = "Buildings"
    titleLabel.Parent = frame
    
    -- Scroll frame for buildings
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, -20, 1, -60)
    scrollFrame.Position = UDim2.new(0, 10, 0, 50)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.Parent = frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = scrollFrame
    
    -- Create building buttons
    for buildingName, buildingConfig in pairs(Config.Buildings) do
        self:CreateBuildingButton(scrollFrame, buildingName, buildingConfig)
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

function BuildMenu:CreateBuildingButton(parent, buildingName, buildingConfig)
    local button = Instance.new("TextButton")
    button.Name = buildingName
    button.Size = UDim2.new(1, 0, 0, 80)
    button.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.Text = ""
    button.Parent = parent
    
    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 149, 237)
    stroke.Thickness = 1
    stroke.Parent = button
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = button
    
    -- Building name label
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.Text = buildingName
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = button
    
    -- Type label
    local typeLabel = Instance.new("TextLabel")
    typeLabel.Name = "TypeLabel"
    typeLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    typeLabel.Position = UDim2.new(0, 10, 0.5, 0)
    typeLabel.BackgroundTransparency = 1
    typeLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    typeLabel.Font = Enum.Font.Gotham
    typeLabel.TextSize = 12
    typeLabel.Text = buildingConfig.Type
    typeLabel.TextXAlignment = Enum.TextXAlignment.Left
    typeLabel.Parent = button
    
    -- Cost label
    local costText = "Cost: "
    for resource, amount in pairs(buildingConfig.Cost) do
        costText = costText .. amount .. " " .. resource:sub(1, 1) .. " "
    end
    
    local costLabel = Instance.new("TextLabel")
    costLabel.Name = "CostLabel"
    costLabel.Size = UDim2.new(0.3, -10, 1, 0)
    costLabel.Position = UDim2.new(0.7, 0, 0, 0)
    costLabel.BackgroundTransparency = 1
    costLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    costLabel.Font = Enum.Font.Gotham
    costLabel.TextSize = 12
    costLabel.Text = costText
    costLabel.TextXAlignment = Enum.TextXAlignment.Right
    costLabel.Parent = button
end

function BuildMenu:Show()
    local frame = self.gui:FindFirstChild("MenuFrame")
    if frame then
        frame.Visible = true
        self.isVisible = true
    end
end

function BuildMenu:Hide()
    local frame = self.gui:FindFirstChild("MenuFrame")
    if frame then
        frame.Visible = false
        self.isVisible = false
    end
end

return BuildMenu
