local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Cleaner GUI setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberDiagnostics"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Modern frame design
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.6, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Subtle gradient background
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 25))
})
Gradient.Rotation = 90
Gradient.Parent = MainFrame

-- Minimalist border effect
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 0, 0.002, 0)
Border.Position = UDim2.new(0, 0, 0, 0)
Border.BackgroundColor3 = Color3.fromRGB(0, 230, 154)
Border.BorderSizePixel = 0
Border.ZIndex = 2
Border.Parent = MainFrame

-- Refined terminal styling
local Terminal = Instance.new("ScrollingFrame")
Terminal.Size = UDim2.new(1, -20, 1, -20)
Terminal.Position = UDim2.new(0, 10, 0, 10)
Terminal.BackgroundTransparency = 1
Terminal.ScrollBarThickness = 3
Terminal.ScrollBarImageColor3 = Color3.fromRGB(100, 255, 200)
Terminal.CanvasSize = UDim2.new(0, 0, 0, 0)
Terminal.AutomaticCanvasSize = Enum.AutomaticSize.Y
Terminal.Parent = MainFrame

local TerminalList = Instance.new("UIListLayout")
TerminalList.Padding = UDim.new(0, 6)
TerminalList.Parent = Terminal

TerminalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Terminal.CanvasPosition = Vector2.new(0, TerminalList.AbsoluteContentSize.Y)
end)

-- Enhanced typewriter effect function
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    local charDelay = speed
    
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        local variance = math.random() * 0.03
        task.wait(charDelay + variance)
    end
end

-- Create terminal line with improved styling
local function CreateTerminalLine(text, color, prefix)
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 20)
    line.Text = ""
    line.TextColor3 = color or Color3.fromRGB(180, 255, 230)
    line.Font = Enum.Font.Code
    line.TextSize = 14
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.BackgroundTransparency = 1
    line.TextTransparency = 0.1
    line.RichText = true
    line.Parent = Terminal
    
    if prefix then
        local prefixLabel = line:Clone()
        prefixLabel.Text = prefix
        prefixLabel.TextColor3 = Color3.fromRGB(0, 200, 150)
        prefixLabel.Size = UDim2.new(0, 40, 0, 20)
        prefixLabel.TextXAlignment = Enum.TextXAlignment.Right
        prefixLabel.Parent = line.Parent
        prefixLabel.LayoutOrder = line.LayoutOrder - 1
    end
    
    return line
end

-- Modern receipt popup
local function CreateReceiptPopup(username, luck, version)
    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0.4, 0, 0.5, 0)
    Popup.Position = UDim2.new(0.3, 0, 0.25, 0)
    Popup.BackgroundColor3 = Color3.new(0.1, 0.12, 0.15)
    Popup.BackgroundTransparency = 0.1
    Popup.BorderSizePixel = 0
    Popup.Parent = ScreenGui

    -- Header with accent
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0.12, 0)
    Header.BackgroundColor3 = Color3.new(0.08, 0.1, 0.12)
    Header.BorderSizePixel = 0
    Header.Parent = Popup
    
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(1, 0, 0, 3)
    AccentBar.Position = UDim2.new(0, 0, 1, 0)
    AccentBar.BackgroundColor3 = Color3.fromRGB(0, 230, 154)
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Header
    
    -- Minimalist title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Text = "SYSTEM DIAGNOSTICS"
    Title.TextColor3 = Color3.fromRGB(180, 255, 230)
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 18
    Title.BackgroundTransparency = 1
    Title.Parent = Header

    -- Content container
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(0.9, 0, 0.7, 0)
    Content.Position = UDim2.new(0.05, 0, 0.15, 0)
    Content.BackgroundTransparency = 1
    Content.Parent = Popup
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 12)
    ContentList.Parent = Content

    -- Data presentation - cleaner format
    local data = {
        {label = "User ID:", value = username},
        {label = "Session:", value = "0x" .. string.format("%X", math.random(1000000, 9999999))},
        {label = "Server Entropy:", value = string.format("%.1f%%", luck), color = luck > 75 and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(255, 200, 50)},
        {label = "Security Level:", value = "Tier " .. math.random(3, 5)},
        {label = "Version:", value = "v"..version},
        {label = "Compatibility:", value = version < 1346 and "Verified" or "Unsupported", color = version < 1346 and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(255, 80, 80)},
        {label = "System Status:", value = "Secure", color = Color3.fromRGB(0, 255, 170)}
    }
    
    for _, item in ipairs(data) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 24)
        row.BackgroundTransparency = 1
        row.Parent = Content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.45, 0, 1, 0)
        label.Text = item.label
        label.TextColor3 = Color3.fromRGB(180, 220, 240)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = row
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0.55, 0, 1, 0)
        value.Position = UDim2.new(0.45, 0, 0, 0)
        value.Text = item.value
        value.TextColor3 = item.color or Color3.fromRGB(200, 240, 255)
        value.Font = Enum.Font.GothamMedium
        value.TextSize = 14
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.BackgroundTransparency = 1
        value.Parent = row
    end
    
    -- Status indicator
    local Status = Instance.new("Frame")
    Status.Size = UDim2.new(0.9, 0, 0, 24)
    Status.Position = UDim2.new(0.05, 0, 0.88, 0)
    Status.BackgroundTransparency = 1
    Status.Parent = Popup
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 1, 0)
    StatusText.Text = "Diagnostic Complete • " .. os.date("%H:%M:%S")
    StatusText.TextColor3 = Color3.fromRGB(150, 220, 220)
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 12
    StatusText.TextXAlignment = Enum.TextXAlignment.Right
    StatusText.BackgroundTransparency = 1
    StatusText.Parent = Status
    
    -- Action button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0.3, 0, 0.08, 0)
    CloseButton.Position = UDim2.new(0.35, 0, 0.92, 0)
    CloseButton.Text = "CLOSE"
    CloseButton.Font = Enum.Font.GothamMedium
    CloseButton.TextSize = 14
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = Popup
    
    -- Button animation
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 40, 50)
        }):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(Popup, TweenInfo.new(0.3), {
            Size = UDim2.new(0,0,0,0),
            Position = UDim2.new(0.5,0,0.5,0)
        }):Play()
        task.wait(0.3)
        Popup:Destroy()
    end)
    
    -- Entrance animation
    Popup.Size = UDim2.new(0,0,0,0)
    TweenService:Create(Popup, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Size = UDim2.new(0.4,0,0.5,0)
    }):Play()
end

-- Streamlined diagnostic sequence
local function RunDiagnostic()
    task.wait(0.8)
    
    local username = player.Name
    local luck = math.random(0.1 * 100, 100.0 * 100) / 100
    local version = game.PlaceVersion
    
    local steps = {
        {text = "Initializing diagnostics protocol...", prefix = ">", delay = 1.2},
        {text = "Establishing secure connection...", delay = 1.0},
        {text = "Authenticating user credentials...", delay = 1.2},
        {text = username, prefix = "USER:", color = Color3.fromRGB(100, 220, 255), delay = 1.5},
        {text = "Analyzing server environment...", delay = 1.0},
        {text = string.format("%.1f%%", luck), prefix = "ENTROPY:", color = luck > 75 and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(255, 200, 50), delay = 2.0},
        {text = "Verifying system version...", delay = 1.0},
        {text = "v"..version, prefix = "VERSION:", color = version < 1346 and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(255, 100, 100), delay = 1.8},
        {text = "Validating security protocols...", delay = 1.5},
        {text = "Compiling final report...", color = Color3.fromRGB(180, 255, 230), delay = 1.8}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine(step.text, step.color, step.prefix)
        TypewriterEffect(line, step.text, 0.03)
        task.wait(step.delay)
    end
    
    -- Smooth transition
    TweenService:Create(MainFrame, TweenInfo.new(0.8), {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.6, 0, 0.2, 0)
    }):Play()
    task.wait(0.8)
    
    CreateReceiptPopup(username, luck, version)
end

spawn(RunDiagnostic)
