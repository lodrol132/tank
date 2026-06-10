--[[
    Leaderboard.lua
    Shows game leaderboard and player rankings
]]

local Leaderboard = {}
Leaderboard.gui = nil
Leaderboard.isVisible = false

function Leaderboard:Initialize()
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "Leaderboard"
    self.gui.ResetOnSpawn = false
    self.gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    self:CreateLeaderboard()
    print("[Leaderboard] Initialized")
end

function Leaderboard:CreateLeaderboard()
    local frame = Instance.new("Frame")
    frame.Name = "LeaderboardFrame"
    frame.Size = UDim2.new(0, 350, 0, 500)
    frame.Position = UDim2.new(0, 20, 0.5, -250)
    frame.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = self.gui
    
    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 149, 237)
    stroke.Thickness = 2
    stroke.Parent = frame
    
    -- Corner
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
    titleLabel.Text = "Leaderboard"
    titleLabel.Parent = frame
    
    -- Table header
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, 30)
    headerFrame.Position = UDim2.new(0, 0, 0, 40)
    headerFrame.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    headerFrame.BorderSizePixel = 0
    headerFrame.Parent = frame
    
    local headers = {"#", "Player", "Territories"}
    for i, header in ipairs(headers) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1/3, 0, 1, 0)
        label.Position = UDim2.new((i-1)/3, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 14
        label.Text = header
        label.Parent = headerFrame
    end
    
    -- Scroll frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, -10, 1, -80)
    scrollFrame.Position = UDim2.new(0, 5, 0, 75)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.Parent = frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = scrollFrame
    
    -- Sample data
    local sampleData = {
        {rank = 1, name = "Player1", territories = 12},
        {rank = 2, name = "Player2", territories = 10},
        {rank = 3, name = "Player3", territories = 8}
    }
    
    for _, playerData in ipairs(sampleData) do
        self:CreatePlayerRow(scrollFrame, playerData)
    end
end

function Leaderboard:CreatePlayerRow(parent, playerData)
    local row = Instance.new("Frame")
    row.Name = "Row" .. playerData.rank
    row.Size = UDim2.new(1, 0, 0, 35)
    row.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    row.BorderSizePixel = 0
    row.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = row
    
    -- Rank
    local rankLabel = Instance.new("TextLabel")
    rankLabel.Size = UDim2.new(1/3, 0, 1, 0)
    rankLabel.BackgroundTransparency = 1
    rankLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    rankLabel.Font = Enum.Font.GothamBold
    rankLabel.TextSize = 16
    rankLabel.Text = "#" .. playerData.rank
    rankLabel.Parent = row
    
    -- Player name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1/3, 0, 1, 0)
    nameLabel.Position = UDim2.new(1/3, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 14
    nameLabel.Text = playerData.name
    nameLabel.Parent = row
    
    -- Territories count
    local countLabel = Instance.new("TextLabel")
    countLabel.Size = UDim2.new(1/3, 0, 1, 0)
    countLabel.Position = UDim2.new(2/3, 0, 0, 0)
    countLabel.BackgroundTransparency = 1
    countLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
    countLabel.Font = Enum.Font.Gotham
    countLabel.TextSize = 14
    countLabel.Text = playerData.territories
    countLabel.Parent = row
end

function Leaderboard:Show()
    local frame = self.gui:FindFirstChild("LeaderboardFrame")
    if frame then
        frame.Visible = true
        self.isVisible = true
    end
end

function Leaderboard:Hide()
    local frame = self.gui:FindFirstChild("LeaderboardFrame")
    if frame then
        frame.Visible = false
        self.isVisible = false
    end
end

return Leaderboard
