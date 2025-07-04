-- Server Scanner Executable Script
-- Paste this entire script into your executor

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ServerScannerGUI"
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")

-- Persistent data storage
local serverData = {
    jobId = game.JobId,
    scanResults = nil,
    firstScanTime = os.time()
}

-- Main scanner container
local scannerContainer = Instance.new("Frame", gui)
scannerContainer.Name = "ScannerContainer"
scannerContainer.AnchorPoint = Vector2.new(0.5, 0.5)
scannerContainer.Position = UDim2.new(1.5, 0, 0.5, 0) -- Start off-screen
scannerContainer.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
scannerContainer.BackgroundTransparency = 0.1
scannerContainer.BorderSizePixel = 0
scannerContainer.Visible = false

-- Responsive sizing
local function updateSize()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local width = math.clamp(viewportSize.X * 0.35, 280, 400)
    local height = math.clamp(viewportSize.Y * 0.5, 350, 500)
    scannerContainer.Size = UDim2.new(0, width, 0, height)
end

updateSize()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(updateSize)
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateSize)

-- UI Corner
local corner = Instance.new("UICorner", scannerContainer)
corner.CornerRadius = UDim.new(0, 8)

-- Glowing border
local stroke = Instance.new("UIStroke", scannerContainer)
stroke.Color = Color3.fromRGB(0, 200, 100)
stroke.Thickness = 1.5
stroke.Transparency = 0.3

-- Header with gradient
local header = Instance.new("Frame", scannerContainer)
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0.14, 0)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(10, 15, 20)
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 8)

-- Scanner title
local title = Instance.new("TextLabel", header)
title.Name = "Title"
title.Text = "SERVER SCANNER v5.0"
title.Font = Enum.Font.Code
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.BackgroundTransparency = 1
title.Size = UDim2.new(0.7, 0, 0.8, 0)
title.Position = UDim2.new(0.05, 0, 0.1, 0)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Server ID
local serverId = Instance.new("TextLabel", header)
serverId.Name = "ServerID"
serverId.Text = "SERVER: "..string.sub(serverData.jobId, 1, 6).."..."
serverId.Font = Enum.Font.Code
serverId.TextSize = 12
serverId.TextColor3 = Color3.fromRGB(100, 255, 200)
serverId.BackgroundTransparency = 1
serverId.Size = UDim2.new(0.3, 0, 0.8, 0)
serverId.Position = UDim2.new(0.65, 0, 0.1, 0)
serverId.TextXAlignment = Enum.TextXAlignment.Right

-- Status indicator
local statusContainer = Instance.new("Frame", scannerContainer)
statusContainer.Name = "StatusContainer"
statusContainer.Size = UDim2.new(0.9, 0, 0.08, 0)
statusContainer.Position = UDim2.new(0.05, 0, 0.15, 0)
statusContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
statusContainer.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner", statusContainer)
statusCorner.CornerRadius = UDim.new(0, 4)

local statusLabel = Instance.new("TextLabel", statusContainer)
statusLabel.Name = "Status"
statusLabel.Text = "STATUS: [OFFLINE]"
statusLabel.Font = Enum.Font.Code
statusLabel.TextSize = 14
statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.Position = UDim2.new(0.02, 0, 0, 0)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Scan results grid
local resultsGrid = Instance.new("Frame", scannerContainer)
resultsGrid.Name = "ResultsGrid"
resultsGrid.Size = UDim2.new(0.9, 0, 0.5, 0)
resultsGrid.Position = UDim2.new(0.05, 0, 0.24, 0)
resultsGrid.BackgroundTransparency = 1

-- Create a grid layout
local gridLayout = Instance.new("UIGridLayout", resultsGrid)
gridLayout.CellPadding = UDim2.new(0, 4, 0, 6)
gridLayout.CellSize = UDim2.new(0.48, 0, 0.2, 0)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Metric templates
local metrics = {
    {name = "Srv Version", value = "Roblox/"..game.PlaceVersion},
    {name = "Credentials", value = player.Name.." ("..player.UserId..")"},
    {name = "Server Age", value = "00:00:00"},
    {name = "Server Time", value = os.date("%H:%M:%S")},
    {name = "Srv Luck", value = "0.00%"},
    {name = "Seed Luck", value = "0.00%"},
    {name = "Egg Luck", value = "0.00%"},
    {name = "Plant Luck", value = "0.00%"},
    {name = "Data Intgty", value = "0.00%"},
    {name = "Firewall", value = "Secure"}
}

-- Create metric cards
local metricCards = {}
for i, metric in ipairs(metrics) do
    local card = Instance.new("Frame", resultsGrid)
    card.Name = metric.name.."Card"
    card.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
    card.BorderSizePixel = 0
    card.LayoutOrder = i

    local cardCorner = Instance.new("UICorner", card)
    cardCorner.CornerRadius = UDim.new(0, 4)

    local nameLabel = Instance.new("TextLabel", card)
    nameLabel.Name = "Name"
    nameLabel.Text = metric.name..":"
    nameLabel.Font = Enum.Font.Code
    nameLabel.TextSize = 11
    nameLabel.TextColor3 = Color3.fromRGB(100, 255, 200)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(0.95, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0.025, 0, 0.05, 0)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local valueLabel = Instance.new("TextLabel", card)
    valueLabel.Name = "Value"
    valueLabel.Text = "[PENDING]"
    valueLabel.Font = Enum.Font.Code
    valueLabel.TextSize = 12
    valueLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(0.95, 0, 0.5, 0)
    valueLabel.Position = UDim2.new(0.025, 0, 0.45, 0)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left

    metricCards[metric.name] = valueLabel
end

-- Terminal output
local terminalContainer = Instance.new("Frame", scannerContainer)
terminalContainer.Name = "TerminalContainer"
terminalContainer.Size = UDim2.new(0.9, 0, 0.15, 0)
terminalContainer.Position = UDim2.new(0.05, 0, 0.75, 0)
terminalContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
terminalContainer.BackgroundTransparency = 0.3
terminalContainer.BorderSizePixel = 0

local terminalCorner = Instance.new("UICorner", terminalContainer)
terminalCorner.CornerRadius = UDim.new(0, 4)

local terminalOutput = Instance.new("TextLabel", terminalContainer)
terminalOutput.Name = "TerminalOutput"
terminalOutput.Text = "> SYSTEM READY\n> AWAITING COMMANDS"
terminalOutput.Font = Enum.Font.Code
terminalOutput.TextSize = 8
terminalOutput.TextColor3 = Color3.fromRGB(0, 255, 150)
terminalOutput.BackgroundTransparency = 1
terminalOutput.Size = UDim2.new(0.95, 0, 0.95, 0)
terminalOutput.Position = UDim2.new(0.025, 0, 0.025, 0)
terminalOutput.TextXAlignment = Enum.TextXAlignment.Left
terminalOutput.TextYAlignment = Enum.TextYAlignment.Top
terminalOutput.TextWrapped = true

-- Control buttons
local buttonContainer = Instance.new("Frame", scannerContainer)
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(0.9, 0, 0.08, 0)
buttonContainer.Position = UDim2.new(0.05, 0, 0.87, 0)
buttonContainer.BackgroundTransparency = 1

-- Scan button
local scanButton = Instance.new("TextButton", buttonContainer)
scanButton.Name = "ScanButton"
scanButton.Text = "INITIATE SCAN"
scanButton.Font = Enum.Font.Code
scanButton.TextSize = 13
scanButton.TextColor3 = Color3.fromRGB(0, 0, 0)
scanButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
scanButton.Size = UDim2.new(0.48, 0, 1, 0)
scanButton.Position = UDim2.new(0, 0, 0, 0)

local scanButtonCorner = Instance.new("UICorner", scanButton)
scanButtonCorner.CornerRadius = UDim.new(0, 4)

-- Close button
local closeButton = Instance.new("TextButton", buttonContainer)
closeButton.Name = "CloseButton"
closeButton.Text = "CLOSE"
closeButton.Font = Enum.Font.Code
closeButton.TextSize = 13
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 20, 30)
closeButton.Size = UDim2.new(0.48, 0, 1, 0)
closeButton.Position = UDim2.new(0.52, 0, 0, 0)

local closeButtonCorner = Instance.new("UICorner", closeButton)
closeButtonCorner.CornerRadius = UDim.new(0, 4)

-- Blinking cursor effect
local showCursor = true
runService.Heartbeat:Connect(function(dt)
    if scannerContainer.Visible then
        showCursor = not showCursor
        local cursorText = showCursor and "█" or ""
        terminalOutput.Text = terminalOutput.Text:gsub("█", "")..cursorText
    end
end)

-- Animation functions
local function openScanner()
    scannerContainer.Visible = true
    local tween = tweenService:Create(scannerContainer, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.85, 0, 0.5, 0)
    })
    tween:Play()
end

local function closeScanner()
    local tween = tweenService:Create(scannerContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(1.5, 0, 0.5, 0)
    })
    tween:Play()
    tween.Completed:Wait()
    scannerContainer.Visible = false
end

-- Generate consistent luck values
local function generateLuckValues()
    if serverData.scanResults then return serverData.scanResults end

    local hash = 0
    for i = 1, #serverData.jobId do
        hash = (hash * 31 + string.byte(serverData.jobId, i)) % 2^32
    end
    local rng = Random.new(hash)

    serverData.scanResults = {
        serverLuck = math.floor(rng:NextNumber() * 10000)/100,
        seedPackLuck = math.floor(rng:NextNumber() * 10000)/100,
        eggLuck = math.floor(rng:NextNumber() * 10000)/100,
        plantLuck = math.floor(rng:NextNumber() * 10000)/100,
        dataIntegrity = math.floor(80 + rng:NextNumber() * 20 * 100)/100,
        firewallStatus = ({"Secure", "Compromised", "Vulnerable"})[math.floor(rng:NextNumber() * 3) + 1]
    }

    return serverData.scanResults
end

-- Format time display
local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local seconds = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- Terminal lines with hacker jargon
local terminalLines = {
    "> INIT QUANTUM DECRYPT",
    "> BYPASS FIREWALL",
    "> ACCESS SEED MATRIX",
    "> DECODE LUCK ALGO",
    "> ANALYZE PROBABILITY",
    "> ESTABLISH CONNECTION",
    "> VERIFY INTEGRITY",
    "> COMPILE REPORT"
}

local function animateScan()
    -- Reset UI for new scan
    terminalOutput.Text = "> INIT SCAN"
    statusLabel.Text = "STATUS: [SCANNING...]"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

    -- Reset all metrics to pending
    for _, card in pairs(metricCards) do
        card.Text = "[PENDING]"
        card.TextColor3 = Color3.fromRGB(150, 150, 150)
    end

    -- Add terminal output with delays
    for i, line in ipairs(terminalLines) do
        task.wait(math.random(3, 7)/10)
        terminalOutput.Text = terminalOutput.Text.."\n"..line
        statusLabel.Text = "STATUS: [SCAN "..math.floor((i/#terminalLines)*100).."%]"
    end

    -- Get luck values
    local luckValues = generateLuckValues()

    -- Update metrics
    task.wait(0.4)
    metricCards["Srv Version"].Text = "Roblox/"..game.PlaceVersion
    metricCards["Credentials"].Text = player.Name.." ("..player.UserId..")"
    metricCards["Server Age"].Text = formatTime(os.time() - serverData.firstScanTime)
    
    task.wait(0.2)
    metricCards["Srv Luck"].Text = string.format("%.2f%%", luckValues.serverLuck)
    metricCards["Seed Luck"].Text = string.format("%.2f%%", luckValues.seedPackLuck)
    metricCards["Egg Luck"].Text = string.format("%.2f%%", luckValues.eggLuck)
    metricCards["Plant Luck"].Text = string.format("%.2f%%", luckValues.plantLuck)
    
    task.wait(0.2)
    metricCards["Data Intgty"].Text = string.format("%.2f%%", luckValues.dataIntegrity)
    metricCards["Firewall"].Text = luckValues.firewallStatus
    metricCards["Server Time"].Text = os.date("%H:%M:%S")

    -- Complete scan
    task.wait(0.4)
    statusLabel.Text = "STATUS: [COMPLETE]"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    terminalOutput.Text = terminalOutput.Text.."\n> SCAN COMPLETE"

    -- Flash effect
    local originalColor = lighting.Ambient
    for i = 1, 2 do
        lighting.Ambient = Color3.fromRGB(0, 20, 8)
        task.wait(0.08)
        lighting.Ambient = originalColor
        task.wait(0.08)
    end

    -- Update colors for metrics
    for _, card in pairs(metricCards) do
        card.TextColor3 = Color3.fromRGB(0, 255, 150)
    end
end

-- Button functionality
scanButton.MouseButton1Click:Connect(function()
    scanButton.Text = "SCANNING..."
    scanButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    animateScan()
    task.wait(2.5)
    scanButton.Text = "RESCAN"
    scanButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
end)

closeButton.MouseButton1Click:Connect(function()
    closeScanner()
end)

-- Automatically open the scanner when executed
openScanner()
