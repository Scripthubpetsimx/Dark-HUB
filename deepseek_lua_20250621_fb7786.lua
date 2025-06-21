local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create hacker-style GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberHack"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Create CRT-style terminal
local TerminalFrame = Instance.new("Frame")
TerminalFrame.Size = UDim2.new(0.35, 0, 0.4, 0)
TerminalFrame.Position = UDim2.new(0.6, 0, 0.3, 0)
TerminalFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
TerminalFrame.BorderSizePixel = 0
TerminalFrame.ClipsDescendants = true
TerminalFrame.Parent = ScreenGui

-- Add CRT screen curvature effect
local Curvature = Instance.new("ImageLabel")
Curvature.Size = UDim2.new(1, 0, 1, 0)
Curvature.Image = "rbxassetid://9995398932" -- CRT curvature texture
Curvature.ImageTransparency = 0.95
Curvature.BackgroundTransparency = 1
Curvature.Parent = TerminalFrame

-- Add scan lines effect
local ScanLines = Instance.new("Frame")
ScanLines.Size = UDim2.new(1, 0, 1, 0)
ScanLines.BackgroundTransparency = 0.95
ScanLines.BackgroundColor3 = Color3.new(0, 0, 0)
ScanLines.ZIndex = 10
ScanLines.Parent = TerminalFrame

local scanPattern = Instance.new("UIGradient")
scanPattern.Rotation = 90
scanPattern.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.05, 0.8),
    NumberSequenceKeypoint.new(0.1, 1),
    NumberSequenceKeypoint.new(1, 1)
})
scanPattern.Parent = ScanLines

-- Terminal text display
local Terminal = Instance.new("ScrollingFrame")
Terminal.Size = UDim2.new(1, -15, 1, -15)
Terminal.Position = UDim2.new(0, 7, 0, 7)
Terminal.BackgroundTransparency = 1
Terminal.ScrollBarThickness = 0
Terminal.CanvasSize = UDim2.new(0, 0, 0, 0)
Terminal.AutomaticCanvasSize = Enum.AutomaticSize.Y
Terminal.ScrollingDirection = Enum.ScrollingDirection.Y
Terminal.Parent = TerminalFrame

local TerminalList = Instance.new("UIListLayout")
TerminalList.Padding = UDim.new(0, 8)
TerminalList.Parent = Terminal

TerminalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Terminal.CanvasPosition = Vector2.new(0, TerminalList.AbsoluteContentSize.Y)
end)

-- Create flickering effect
spawn(function()
    while TerminalFrame.Parent do
        local intensity = math.random() * 0.05
        TweenService:Create(TerminalFrame, TweenInfo.new(0.1), {
            BackgroundTransparency = intensity
        }):Play()
        task.wait(math.random(0.1, 0.3))
    end
end)

-- Matrix rain effect
local MatrixRain = Instance.new("Frame")
MatrixRain.Size = UDim2.new(1, 0, 1, 0)
MatrixRain.BackgroundTransparency = 1
MatrixRain.ZIndex = -1
MatrixRain.Parent = TerminalFrame

local function CreateMatrixCode()
    local code = Instance.new("TextLabel")
    code.Size = UDim2.new(0, 20, 0, 20)
    code.Position = UDim2.new(math.random(), 0, 0, -20)
    code.Text = string.char(math.random(33, 126))
    code.TextColor3 = Color3.new(0, math.random() * 0.3 + 0.7, 0)
    code.BackgroundTransparency = 1
    code.Font = Enum.Font.Code
    code.TextSize = 14
    code.ZIndex = -1
    code.Parent = MatrixRain
    
    spawn(function()
        local speed = math.random(5, 15)
        while code.Parent do
            code.Position += UDim2.new(0, 0, 0, speed)
            if code.Position.Y.Offset > TerminalFrame.AbsoluteSize.Y then
                code:Destroy()
                break
            end
            task.wait(0.03)
        end
    end)
end

spawn(function()
    while MatrixRain.Parent do
        CreateMatrixCode()
        task.wait(0.05)
    end
end)

-- Enhanced typewriter effect with glitches
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    local charDelay = speed
    
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        
        -- Random glitch effect
        if math.random() < 0.1 then
            local glitchChars = {"#", "@", "%", "&", "*", "~"}
            local original = label.Text
            label.Text = string.sub(text, 1, i-1) .. glitchChars[math.random(1, #glitchChars)]
            task.wait(0.03)
            label.Text = original
        end
        
        task.wait(charDelay)
    end
    
    -- Final glitch for dramatic effect
    if math.random() < 0.3 then
        local original = label.Text
        for _ = 1, 3 do
            label.Text = original .. "�"
            task.wait(0.05)
            label.Text = original
            task.wait(0.05)
        end
    end
end

-- Create terminal line
local function CreateTerminalLine(text, color)
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, -10, 0, 20)
    line.Text = ""
    line.TextColor3 = color or Color3.new(0, 1, 0.3)
    line.Font = Enum.Font.Code
    line.TextSize = 14
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.BackgroundTransparency = 1
    line.TextStrokeTransparency = 0.8
    line.TextStrokeColor3 = Color3.new(0, 0.2, 0)
    line.Parent = Terminal
    
    return line
end

-- Enhanced dark-themed popup with luck metrics
local function CreateHackerReport(username, serverLuck, plantLuck, eggLuck, seedLuck, version)
    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0.4, 0, 0.6, 0)  -- Increased height for more content
    Popup.Position = UDim2.new(0.3, 0, 0.2, 0)
    Popup.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    Popup.BackgroundTransparency = 0.05
    Popup.BorderSizePixel = 0
    Popup.Parent = ScreenGui
    
    -- Dark background with subtle grid
    local Grid = Instance.new("ImageLabel")
    Grid.Size = UDim2.new(1, 0, 1, 0)
    Grid.Image = "rbxassetid://9091674221" -- Grid texture
    Grid.ImageTransparency = 0.97
    Grid.ImageColor3 = Color3.new(0, 0.1, 0.05)
    Grid.ScaleType = Enum.ScaleType.Tile
    Grid.TileSize = UDim2.new(0, 100, 0, 100)
    Grid.BackgroundTransparency = 1
    Grid.ZIndex = 0
    Grid.Parent = Popup
    
    -- Glowing border
    local Border = Instance.new("Frame")
    Border.Size = UDim2.new(1, 4, 1, 4)
    Border.Position = UDim2.new(0, -2, 0, -2)
    Border.BackgroundColor3 = Color3.new(0, 0.7, 0.2)
    Border.ZIndex = -1
    Border.Parent = Popup
    
    -- Animated glow effect
    local GlowEffect = Instance.new("ImageLabel")
    GlowEffect.Size = UDim2.new(1, 10, 1, 10)
    GlowEffect.Position = UDim2.new(0, -5, 0, -5)
    GlowEffect.Image = "rbxassetid://5028857084"
    GlowEffect.ImageColor3 = Color3.new(0, 0.5, 0.1)
    GlowEffect.ScaleType = Enum.ScaleType.Slice
    GlowEffect.SliceCenter = Rect.new(100, 100, 100, 100)
    GlowEffect.BackgroundTransparency = 1
    GlowEffect.ZIndex = -1
    GlowEffect.Parent = Border
    
    -- Pulsing glow animation
    spawn(function()
        while GlowEffect.Parent do
            TweenService:Create(GlowEffect, TweenInfo.new(1.5), {
                ImageTransparency = 0.3
            }):Play()
            task.wait(1.5)
            TweenService:Create(GlowEffect, TweenInfo.new(1.5), {
                ImageTransparency = 0.7
            }):Play()
            task.wait(1.5)
        end
    end)
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0.12, 0)
    Header.BackgroundColor3 = Color3.new(0.03, 0.05, 0.04)
    Header.BorderSizePixel = 0
    Header.Parent = Popup
    
    -- Title with glow
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = "SYSTEM DIAGNOSTICS"
    Title.TextColor3 = Color3.new(0.7, 1, 0.8)
    Title.Font = Enum.Font.Code
    Title.TextSize = 18
    Title.TextStrokeTransparency = 0.7
    Title.TextStrokeColor3 = Color3.new(0, 0.2, 0.1)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    -- Timestamp
    local Timestamp = Instance.new("TextLabel")
    Timestamp.Size = UDim2.new(1, -10, 0.08, 0)
    Timestamp.Position = UDim2.new(0, 5, 0.12, 0)
    Timestamp.Text = "GENERATED: " .. os.date("%Y-%m-%d %H:%M:%S")
    Timestamp.TextColor3 = Color3.new(0.6, 0.6, 0.6)
    Timestamp.Font = Enum.Font.Code
    Timestamp.TextSize = 12
    Timestamp.TextXAlignment = Enum.TextXAlignment.Right
    Timestamp.BackgroundTransparency = 1
    Timestamp.Parent = Popup
    
    -- Luck metrics container
    local LuckContainer = Instance.new("Frame")
    LuckContainer.Size = UDim2.new(0.9, 0, 0.4, 0)
    LuckContainer.Position = UDim2.new(0.05, 0, 0.22, 0)
    LuckContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    LuckContainer.BackgroundTransparency = 0.9
    LuckContainer.BorderSizePixel = 0
    LuckContainer.Parent = Popup
    
    local LuckTitle = Instance.new("TextLabel")
    LuckTitle.Size = UDim2.new(1, 0, 0.2, 0)
    LuckTitle.Text = "LUCK METRICS"
    LuckTitle.TextColor3 = Color3.new(0, 1, 0.5)
    LuckTitle.Font = Enum.Font.Code
    LuckTitle.TextSize = 16
    LuckTitle.TextXAlignment = Enum.TextXAlignment.Center
    LuckTitle.BackgroundTransparency = 1
    LuckTitle.Parent = LuckContainer
    
    -- Luck bars
    local luckTypes = {
        {name = "SERVER LUCK", value = serverLuck, color = Color3.new(0, 0.8, 1)},
        {name = "PLANT LUCK", value = plantLuck, color = Color3.new(0.5, 1, 0.2)},
        {name = "EGG LUCK", value = eggLuck, color = Color3.new(1, 0.8, 0)},
        {name = "SEED PACK LUCK", value = seedLuck, color = Color3.new(1, 0.4, 0.6)}
    }
    
    local barYPosition = 0.25
    for _, luck in ipairs(luckTypes) do
        local barContainer = Instance.new("Frame")
        barContainer.Size = UDim2.new(0.9, 0, 0.15, 0)
        barContainer.Position = UDim2.new(0.05, 0, barYPosition, 0)
        barContainer.BackgroundTransparency = 1
        barContainer.Parent = LuckContainer
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Text = luck.name
        label.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = barContainer
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0.3, 0, 1, 0)
        value.Position = UDim2.new(0.5, 0, 0, 0)
        value.Text = string.format("%.1f%%", luck.value)
        value.TextColor3 = luck.color
        value.Font = Enum.Font.Code
        value.TextSize = 14
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.BackgroundTransparency = 1
        value.Parent = barContainer
        
        -- Progress bar
        local barBackground = Instance.new("Frame")
        barBackground.Size = UDim2.new(1, 0, 0.4, 0)
        barBackground.Position = UDim2.new(0, 0, 0.6, 0)
        barBackground.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        barBackground.BorderSizePixel = 0
        barBackground.Parent = barContainer
        
        local barFill = Instance.new("Frame")
        barFill.Size = UDim2.new(luck.value/100, 0, 1, 0)
        barFill.BackgroundColor3 = luck.color
        barFill.BorderSizePixel = 0
        barFill.Parent = barBackground
        
        barYPosition = barYPosition + 0.2
    end
    
    -- System info container
    local SystemContainer = Instance.new("Frame")
    SystemContainer.Size = UDim2.new(0.9, 0, 0.25, 0)
    SystemContainer.Position = UDim2.new(0.05, 0, 0.65, 0)
    SystemContainer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    SystemContainer.BackgroundTransparency = 0.9
    SystemContainer.BorderSizePixel = 0
    SystemContainer.Parent = Popup
    
    local SystemTitle = Instance.new("TextLabel")
    SystemTitle.Size = UDim2.new(1, 0, 0.25, 0)
    SystemTitle.Text = "SYSTEM INFO"
    SystemTitle.TextColor3 = Color3.new(0, 1, 0.5)
    SystemTitle.Font = Enum.Font.Code
    SystemTitle.TextSize = 16
    SystemTitle.TextXAlignment = Enum.TextXAlignment.Center
    SystemTitle.BackgroundTransparency = 1
    SystemTitle.Parent = SystemContainer
    
    -- System data
    local systemData = {
        {label = "USER ID:", value = username},
        {label = "VERSION:", value = "v"..version},
        {label = "COMPATIBILITY:", value = version < 1346 and "COMPATIBLE" or "INCOMPATIBLE", color = version < 1346 and Color3.new(0, 1, 0.3) or Color3.new(1, 0.3, 0.3)}
    }
    
    local dataYPosition = 0.3
    for _, data in ipairs(systemData) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(0.9, 0, 0.2, 0)
        row.Position = UDim2.new(0.05, 0, dataYPosition, 0)
        row.BackgroundTransparency = 1
        row.Parent = SystemContainer
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Text = data.label
        label.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = row
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0.5, 0, 1, 0)
        value.Position = UDim2.new(0.5, 0, 0, 0)
        value.Text = data.value
        value.TextColor3 = data.color or Color3.new(1, 1, 1)
        value.Font = Enum.Font.Code
        value.TextSize = 14
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.BackgroundTransparency = 1
        value.Parent = row
        
        dataYPosition = dataYPosition + 0.25
    end
    
    -- Status indicator
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.9, 0, 0.1, 0)
    Status.Position = UDim2.new(0.05, 0, 0.92, 0)
    Status.Text = "STATUS: SECURE"
    Status.TextColor3 = Color3.new(0, 1, 0.3)
    Status.Font = Enum.Font.Code
    Status.TextSize = 14
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.BackgroundTransparency = 1
    Status.Parent = Popup
    
    -- OK button with hover effect
    local OkButton = Instance.new("TextButton")
    OkButton.Size = UDim2.new(0.3, 0, 0.08, 0)
    OkButton.Position = UDim2.new(0.7, 0, 0.92, 0)
    OkButton.Text = "ACKNOWLEDGE"
    OkButton.Font = Enum.Font.Code
    OkButton.TextSize = 14
    OkButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    OkButton.TextColor3 = Color3.new(0, 1, 0.3)
    OkButton.BorderColor3 = Color3.new(0, 0.7, 0.2)
    OkButton.Parent = Popup
    
    -- Button hover effect
    OkButton.MouseEnter:Connect(function()
        TweenService:Create(OkButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.new(0.15, 0.15, 0.15),
            TextColor3 = Color3.new(0, 1, 0.5)
        }):Play()
    end)
    
    OkButton.MouseLeave:Connect(function()
        TweenService:Create(OkButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
            TextColor3 = Color3.new(0, 1, 0.3)
        }):Play()
    end)
    
    OkButton.MouseButton1Click:Connect(function()
        TweenService:Create(Popup, TweenInfo.new(0.5), {
            Size = UDim2.new(0,0,0,0),
            Position = UDim2.new(0.5,0,0.5,0)
        }):Play()
        task.wait(0.5)
        Popup:Destroy()
    end)
    
    -- Animate in with scaling effect
    Popup.Size = UDim2.new(0,0,0,0)
    Popup.AnchorPoint = Vector2.new(0.5, 0.5)
    Popup.Position = UDim2.new(0.5,0,0.5,0)
    TweenService:Create(Popup, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0.4,0,0.6,0)
    }):Play()
end

-- Main hacking sequence
local function RunHackSequence()
    task.wait(0.5)
    
    -- Create initial line
    local line1 = CreateTerminalLine()
    TypewriterEffect(line1, "> Initializing CYBER SYSTEMS diagnostic protocol...", 0.03)
    task.wait(1.5)
    
    -- Generate luck values
    local serverLuck = math.random(1, 1000)/10
    local plantLuck = math.random(1, 1000)/10
    local eggLuck = math.random(1, 1000)/10
    local seedLuck = math.random(1, 1000)/10
    local version = game.PlaceVersion
    local username = player.Name
    
    -- Hacking sequence with luck metrics
    local steps = {
        {text = "> Analyzing server environment...", delay = 1.2},
        {text = "> Calculating SERVER LUCK...", color = Color3.new(0, 0.8, 1), delay = 1.5},
        {text = "> SERVER LUCK: " .. string.format("%.1f%%", serverLuck), color = Color3.new(0, 0.8, 1), delay = 2},
        {text = "> Scanning botanical systems...", delay = 1.2},
        {text = "> Calculating PLANT LUCK...", color = Color3.new(0.5, 1, 0.2), delay = 1.5},
        {text = "> PLANT LUCK: " .. string.format("%.1f%%", plantLuck), color = Color3.new(0.5, 1, 0.2), delay = 2},
        {text = "> Accessing egg repository...", delay = 1.2},
        {text = "> Calculating EGG LUCK...", color = Color3.new(1, 0.8, 0), delay = 1.5},
        {text = "> EGG LUCK: " .. string.format("%.1f%%", eggLuck), color = Color3.new(1, 0.8, 0), delay = 2},
        {text = "> Analyzing seed database...", delay = 1.2},
        {text = "> Calculating SEED PACK LUCK...", color = Color3.new(1, 0.4, 0.6), delay = 1.5},
        {text = "> SEED PACK LUCK: " .. string.format("%.1f%%", seedLuck), color = Color3.new(1, 0.4, 0.6), delay = 2},
        {text = "> Compiling final report...", delay = 1.5},
        {text = "> DIAGNOSTIC COMPLETE", color = Color3.new(0, 1, 0), delay = 2}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine(nil, step.color)
        TypewriterEffect(line, step.text, 0.03)
        task.wait(step.delay)
    end
    
    -- Fade out terminal
    local fadeTween = TweenService:Create(TerminalFrame, TweenInfo.new(1), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0,0,0,0),
        Position = UDim2.new(0.65,0,0.35,0)
    })
    fadeTween:Play()
    fadeTween.Completed:Wait()
    TerminalFrame:Destroy()
    
    -- Show hacker report with all luck metrics
    CreateHackerReport(username, serverLuck, plantLuck, eggLuck, seedLuck, version)
end

-- Start the hack sequence
spawn(RunHackSequence)
