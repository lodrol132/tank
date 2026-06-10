--[[
    MapController.lua
    Handles map rendering and territory visualization
]]

local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))
local Constants = require(game:GetService("ReplicatedStorage"):WaitForChild("Constants"))

local MapController = {}
MapController.territories = {}
MapController.selectedTerritory = nil
MapController.mapGui = nil

function MapController:Initialize()
    self.mapGui = Instance.new("ScreenGui")
    self.mapGui.Name = "MapGui"
    self.mapGui.ResetOnSpawn = false
    self.mapGui.ZIndex = 1
    self.mapGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    self:CreateMapFrame()
    print("[MapController] Initialized")
end

function MapController:CreateMapFrame()
    local mapFrame = Instance.new("Frame")
    mapFrame.Name = "MapFrame"
    mapFrame.Size = UDim2.new(1, 0, 1, 0)
    mapFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    mapFrame.BorderSizePixel = 0
    mapFrame.Parent = self.mapGui
    
    self:RenderGrid(mapFrame)
end

function MapController:RenderGrid(parent)
    local cols = Config.GridSize.Columns
    local rows = Config.GridSize.Rows
    
    local screenSize = parent.AbsoluteSize
    local regionWidth = screenSize.X / cols
    local regionHeight = screenSize.Y / rows
    
    for y = 1, rows do
        for x = 1, cols do
            local regionId = (y - 1) * cols + x
            self:CreateTerritoryFrame(parent, regionId, x, y, regionWidth, regionHeight)
        end
    end
end

function MapController:CreateTerritoryFrame(parent, regionId, gridX, gridY, width, height)
    local frame = Instance.new("Frame")
    frame.Name = "Territory_" .. regionId
    frame.Size = UDim2.new(0, width - 2, 0, height - 2)
    frame.Position = UDim2.new(0, (gridX - 1) * width + 1, 0, (gridY - 1) * height + 1)
    frame.BackgroundColor3 = Color3.fromRGB(100, 120, 80)
    frame.BorderColor3 = Color3.fromRGB(150, 150, 150)
    frame.BorderSizePixel = 1
    frame.Parent = parent
    
    -- Store territory info
    frame.TerritoryData = {
        id = regionId,
        gridX = gridX,
        gridY = gridY,
        owner = nil
    }
    
    self.territories[regionId] = frame
    
    -- Click handler
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = frame
    
    button.MouseButton1Click:Connect(function()
        self:SelectTerritory(regionId)
    end)
    
    -- Territory label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 10
    label.Text = "R" .. regionId
    label.Parent = frame
end

function MapController:SelectTerritory(territoryId)
    if self.selectedTerritory then
        self.selectedTerritory.BorderColor3 = Color3.fromRGB(150, 150, 150)
        self.selectedTerritory.BorderSizePixel = 1
    end
    
    local territory = self.territories[territoryId]
    if territory then
        territory.BorderColor3 = Color3.fromRGB(255, 215, 0)
        territory.BorderSizePixel = 3
        self.selectedTerritory = territory
        
        print("[MapController] Territory selected: " .. territoryId)
    end
end

function MapController:UpdateTerritoryColor(territoryId, color, owner)
    local territory = self.territories[territoryId]
    if territory then
        territory.BackgroundColor3 = color
        territory.TerritoryData.owner = owner
    end
end

function MapController:GetSelectedTerritoryId()
    if self.selectedTerritory and self.selectedTerritory.TerritoryData then
        return self.selectedTerritory.TerritoryData.id
    end
    return nil
end

return MapController
