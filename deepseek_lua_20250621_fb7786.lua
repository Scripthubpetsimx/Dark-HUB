local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local random = Random.new()

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SystemDiagnostic"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Create hacker background effect
local function CreateHackerBackground()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundColor3 = Color3.new(0, 0, 0)
    container.Parent = ScreenGui
    
    -- Create hex grid
    for i = 1, 100 do
        local hex = Instance.new("TextLabel")
        hex.Text = "0x"..string.format("%04X", math.random(0, 65535))
        hex.TextColor3 = Color3.new(0, math.random() * 0.3, 0)
        hex.TextTransparency = math.random() * 0.5 + 0.5
        hex.BackgroundTransparency = 1
        hex.Font = Enum.Font.Code
        hex.TextSize = math.random(8, 12)
        hex.Position = UDim2.new(math.random(), 0, math.random(), 0)
        hex.Parent = container
        
        spawn(function()
            while hex.Parent do
                hex.TextTransparency = math.random() * 0.5 + 0.5
                hex.TextColor3 = Color3.new(0, math.random() * 0.5, 0)
                task.wait(math.random() * 2)
            end
        end)
    end
    
    return container
end

local hackerBG = CreateHackerBackground()

-- Main terminal container
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.55, 0, 0.25, 0) -- Right center
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Add cyberpunk scan line effect
local ScanLine = Instance.new("Frame")
ScanLine.Size = UDim2.new(1, 0, 0.005, 0)
ScanLine.BackgroundColor3 = Color3.new(0, 1, 0.2)
ScanLine.BackgroundTransparency = 0.7
ScanLine.BorderSizePixel = 0
ScanLine.ZIndex = 10
ScanLine.Parent = MainFrame

spawn(function()
    while ScanLine.Parent do
        ScanLine.Position = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ScanLine, TweenInfo.new(0.8), {Position = UDim2.new(0, 0, 1, 0)}):Play()
        task.wait(1.2)
    end
end)

-- Terminal text display
local Terminal = Instance.new("ScrollingFrame")
Terminal.Size = UDim2.new(1, -10, 1, -10)
Terminal.Position = UDim2.new(0, 5, 0, 5)
Terminal.BackgroundTransparency = 1
Terminal.ScrollBarThickness = 5
Terminal.ScrollBarImageColor3 = Color3.new(0, 0.5, 0)
Terminal.CanvasSize = UDim2.new(0, 0, 0, 0)
Terminal.AutomaticCanvasSize = Enum.AutomaticSize.Y
Terminal.ScrollingDirection = Enum.ScrollingDirection.Y
Terminal.VerticalScrollBarInset = Enum.ScrollBarInset.Always
Terminal.Parent = MainFrame

local TerminalList = Instance.new("UIListLayout")
TerminalList.Padding = UDim.new(0, 5)
TerminalList.Parent = Terminal

-- Auto-scroll to bottom
TerminalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Terminal.CanvasPosition = Vector2.new(0, TerminalList.AbsoluteContentSize.Y)
end)

-- Typewriter effect with glitches
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    local glitchChars = {"#", "@", "%", "&", "*", "!", "~"}
    
    for i = 1, #text do
        -- Rapid typing effect
        local displayText = string.sub(text, 1, i)
        
        -- Random glitch effect
        if math.random() < 0.2 then
            local glitchLength = math.random(1, 3)
            for j = 1, glitchLength do
                if i + j <= #text then
                    displayText = displayText .. glitchChars[math.random(1, #glitchChars)]
                end
            end
        end
        
        label.Text = displayText
        task.wait(speed)
        
        -- Random full glitch
        if math.random() < 0.08 then
            local original = label.Text
            local glitched = ""
            for k = 1, #original do
                if math.random() < 0.3 then
                    glitched = glitched .. glitchChars[math.random(1, #glitchChars)]
                else
                    glitched = glitched .. string.sub(original, k, k)
                end
            end
            label.Text = glitched
            task.wait(0.1)
            label.Text = original
        end
    end
end

-- Create terminal line with random color variation
local function CreateTerminalLine()
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, -10, 0, 20)
    line.Text = ""
    line.TextColor3 = Color3.new(
        math.random() * 0.2,
        math.random() * 0.5 + 0.5,
        math.random() * 0.2
    )
    line.Font = Enum.Font.Code
    line.TextSize = 14
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.BackgroundTransparency = 1
    line.TextStrokeTransparency = 0.8
    line.TextStrokeColor3 = Color3.new(0, 0.1, 0)
    line.Parent = Terminal
    
    return line
end

-- Create receipt popup
local function CreateReceiptPopup(username, luck, version)
    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0.5, 0, 0.6, 0)
    Popup.Position = UDim2.new(0.25, 0, 0.2, 0)
    Popup.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    Popup.BackgroundTransparency = 0.1
    Popup.BorderSizePixel = 0
    Popup.Parent = ScreenGui
    
    -- Neon border
    local Border = Instance.new("Frame")
    Border.Size = UDim2.new(1, 6, 1, 6)
    Border.Position = UDim2.new(0, -3, 0, -3)
    Border.BackgroundColor3 = Color3.new(0, 0.8, 0.3)
    Border.ZIndex = -1
    Border.Parent = Popup
    
    -- Grid pattern
    local Grid = Instance.new("Frame")
    Grid.Size = UDim2.new(1, 0, 1, 0)
    Grid.BackgroundTransparency = 0.9
    Grid.BackgroundColor3 = Color3.new(0, 0.1, 0.05)
    Grid.Parent = Popup
    
    for i = 1, 20 do
        for j = 1, 15 do
            if math.random() < 0.2 then
                local dot = Instance.new("Frame")
                dot.Size = UDim2.new(0, 2, 0, 2)
                dot.Position = UDim2.new((j-1)/15, 0, (i-1)/20, 0)
                dot.BackgroundColor3 = Color3.new(0, math.random() * 0.5 + 0.3, 0)
                dot.BorderSizePixel = 0
                dot.Parent = Grid
            end
        end
    end
    
    -- Title with glow
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0.15, 0)
    Title.Text = "SYSTEM DIAGNOSTIC REPORT"
    Title.TextColor3 = Color3.new(0, 1, 0.5)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 22
    Title.BackgroundTransparency = 1
    Title.TextStrokeTransparency = 0.5
    Title.TextStrokeColor3 = Color3.new(0, 0.5, 0.2)
    Title.Parent = Popup
    
    -- Decorative lines
    local line1 = Instance.new("Frame")
    line1.Size = UDim2.new(0.8, 0, 0.002, 0)
    line1.Position = UDim2.new(0.1, 0, 0.15, 0)
    line1.BackgroundColor3 = Color3.new(0, 1, 0.3)
    line1.BorderSizePixel = 0
    line1.Parent = Popup
    
    local line2 = line1:Clone()
    line2.Position = UDim2.new(0.1, 0, 0.85, 0)
    line2.Parent = Popup
    
    -- Receipt content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(0.9, 0, 0.6, 0)
    Content.Position = UDim2.new(0.05, 0, 0.2, 0)
    Content.BackgroundTransparency = 1
    Content.Parent = Popup
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 15)
    ContentList.Parent = Content
    
    -- Receipt data with cyberpunk style
    local data = {
        {label = "USER IDENT:", value = username, color = Color3.new(0, 0.8, 1)},
        {label = "SERVER LUCK INDEX:", value = string.format("%.1f%%", luck), color = Color3.new(1, 0.8, 0.2)},
        {label = "VERSION DETECTED:", value = "v"..version, color = Color3.new(0.5, 1, 0.5)},
        {label = "REQUIRED VERSION:", value = "v1346 below", color = Color3.new(1, 0.3, 0.3)},
        {label = "COMPATIBILITY STATUS:", value = version < 1346 and "COMPATIBLE" or "INCOMPATIBLE", 
            color = version < 1346 and Color3.new(0, 1, 0.3) or Color3.new(1, 0.2, 0.2)},
        {label = "EGG INTEGRITY:", value = "VERIFIED", color = Color3.new(0.3, 1, 0.8)},
        {label = "SECURITY BREACH:", value = "SUCCESSFUL", color = Color3.new(0, 1, 0.5)},
        {label = "DIAGNOSTIC STATUS:", value = "COMPLETE", color = Color3.new(0, 1, 0.2)}
    }
    
    for _, item in ipairs(data) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 25)
        row.BackgroundTransparency = 1
        row.Parent = Content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.55, 0, 1, 0)
        label.Text = item.label
        label.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        label.Font = Enum.Font.Code
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = row
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0.45, 0, 1, 0)
        value.Position = UDim2.new(0.55, 0, 0, 0)
        value.Text = item.value
        value.TextColor3 = item.color
        value.Font = Enum.Font.GothamBold
        value.TextSize = 16
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.BackgroundTransparency = 1
        value.Parent = row
    end
    
    -- Holographic OK button
    local OkButton = Instance.new("TextButton")
    OkButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    OkButton.Position = UDim2.new(0.3, 0, 0.85, 0)
    OkButton.Text = "ACKNOWLEDGE"
    OkButton.Font = Enum.Font.GothamBlack
    OkButton.TextSize = 18
    OkButton.TextColor3 = Color3.new(0, 0, 0)
    OkButton.BackgroundColor3 = Color3.new(0, 1, 0.4)
    OkButton.BorderSizePixel = 0
    OkButton.Parent = Popup
    
    -- Button glow
    local buttonGlow = Instance.new("ImageLabel")
    buttonGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
    buttonGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    buttonGlow.Image = "rbxassetid://5028857084"
    buttonGlow.ImageColor3 = Color3.new(0, 1, 0.3)
    buttonGlow.ScaleType = Enum.ScaleType.Slice
    buttonGlow.SliceCenter = Rect.new(100, 100, 100, 100)
    buttonGlow.BackgroundTransparency = 1
    buttonGlow.ZIndex = -1
    buttonGlow.Parent = OkButton
    
    -- Button animation
    OkButton.MouseEnter:Connect(function()
        TweenService:Create(OkButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.2, 1, 0.6)}):Play()
    end)
    
    OkButton.MouseLeave:Connect(function()
        TweenService:Create(OkButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0, 1, 0.4)}):Play()
    end)
    
    OkButton.MouseButton1Click:Connect(function()
        TweenService:Create(Popup, TweenInfo.new(0.5), {Size = UDim2.new(0,0,0,0)}):Play()
        TweenService:Create(ScreenGui, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()
        task.wait(0.5)
        ScreenGui:Destroy()
    end)
    
    -- Animate in with cyberpunk effect
    Popup.Size = UDim2.new(0,0,0,0)
    Popup.BackgroundTransparency = 1
    Border.BackgroundTransparency = 1
    
    TweenService:Create(Popup, TweenInfo.new(0.7), {
        Size = UDim2.new(0.5,0,0.6,0),
        BackgroundTransparency = 0.1
    }):Play()
    
    TweenService:Create(Border, TweenInfo.new(0.7), {
        BackgroundTransparency = 0
    }):Play()
end

-- Main diagnostic sequence (faster pace)
local function RunDiagnostic()
    -- Create initial line
    local line1 = CreateTerminalLine()
    TypewriterEffect(line1, "> INITIALIZING SYSTEM DIAGNOSTICS...", 0.02)
    task.wait(1.5)
    
    -- Collect data
    local username = player.Name
    local luck = random:NextNumber(0.1, 100.0)
    local version = game.PlaceVersion
    local eggCount = math.random(5, 25)
    
    -- Sequence of diagnostics (faster with more steps)
    local steps = {
        {text = "> BYPASSING SECURITY PROTOCOLS...", delay = 1.2},
        {text = "> ESTABLISHING ENCRYPTED CONNECTION...", delay = 1.2},
        {text = "> ACCESSING USER CREDENTIALS...", delay = 1.2},
        {text = "> USER IDENT: " .. username, delay = 1},
        {text = "> SCANNING SERVER INFRASTRUCTURE...", delay = 1.2},
        {text = "> CALCULATING SERVER LUCK COEFFICIENT...", delay = 1.5},
        {text = "> SERVER LUCK INDEX: " .. string.format("%.1f", luck) .. "%", delay = 1},
        {text = "> ANALYZING GAME VERSION DATA...", delay = 1.2},
        {text = "> REQUIRED VERSION: v1346 BELOW", delay = 1},
        {text = "> DETECTED VERSION: v" .. version, delay = 1},
        {text = "> VERSION COMPATIBILITY: " .. (version < 1346 and "COMPATIBLE" or "INCOMPATIBLE"), delay = 1},
        {text = "> DECRYPTING EGG DATABASE...", delay = 1.5},
        {text = "> EGG SIGNATURES VERIFIED: " .. eggCount .. " EGGS", delay = 1},
        {text = "> ESTABLISHING BACKDOOR ACCESS...", delay = 1.5},
        {text = "> BACKDOOR SECURED", delay = 1},
        {text = "> PURGING TRACES...", delay = 1.2},
        {text = "> DIAGNOSTIC COMPLETE", delay = 1},
        {text = "> GENERATING ENCRYPTED REPORT...", delay = 1.5}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine()
        TypewriterEffect(line, step.text, 0.01)
        task.wait(step.delay)
    end
    
    -- Flash effect before showing receipt
    for i = 1, 3 do
        MainFrame.BackgroundTransparency = 0.7
        task.wait(0.05)
        MainFrame.BackgroundTransparency = 0.3
        task.wait(0.05)
    end
    
    -- Hide terminal and show receipt
    TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.5)
    MainFrame:Destroy()
    
    -- Show receipt
    CreateReceiptPopup(username, luck, version)
end

-- Start the diagnostic sequence with dramatic intro
spawn(function()
    -- Initial flash effect
    for i = 1, 2 do
        ScreenGui.BackgroundTransparency = 0
        task.wait(0.1)
        ScreenGui.BackgroundTransparency = 1
        task.wait(0.1)
    end
    
    -- Start diagnostic
    RunDiagnostic()
end)
