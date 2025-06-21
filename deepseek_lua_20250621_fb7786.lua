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

-- Main container
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.35, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.6, 0, 0.3, 0) -- Right center
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Add cyberpunk-style glow
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.1, 0, 1.1, 0)
Glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.fromRGB(0, 0.7, 0.2)
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(100, 100, 100, 100)
Glow.BackgroundTransparency = 1
Glow.ZIndex = -1
Glow.Parent = MainFrame

-- Add scan lines effect
local ScanLines = Instance.new("Frame")
ScanLines.Size = UDim2.new(1, 0, 1, 0)
ScanLines.BackgroundTransparency = 0.95
ScanLines.BackgroundColor3 = Color3.new(0, 0, 0)
ScanLines.ZIndex = 10
ScanLines.Parent = MainFrame

local scanPattern = Instance.new("UIGradient")
scanPattern.Rotation = 90
scanPattern.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.05, 0.8),
    NumberSequenceKeypoint.new(0.1, 1),
    NumberSequenceKeypoint.new(1, 1)
})
scanPattern.Parent = ScanLines

-- Terminal-style text
local Terminal = Instance.new("ScrollingFrame")
Terminal.Size = UDim2.new(1, -10, 1, -10)
Terminal.Position = UDim2.new(0, 5, 0, 5)
Terminal.BackgroundTransparency = 1
Terminal.ScrollBarThickness = 5
Terminal.ScrollBarImageColor3 = Color3.new(0, 0.7, 0.2)
Terminal.CanvasSize = UDim2.new(0, 0, 0, 0)
Terminal.AutomaticCanvasSize = Enum.AutomaticSize.Y
Terminal.ScrollingDirection = Enum.ScrollingDirection.Y
Terminal.VerticalScrollBarInset = Enum.ScrollBarInset.Always
Terminal.Parent = MainFrame

local TerminalList = Instance.new("UIListLayout")
TerminalList.Padding = UDim.new(0, 8)
TerminalList.Parent = Terminal

-- Auto-scroll when new items added
TerminalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Terminal.CanvasPosition = Vector2.new(0, TerminalList.AbsoluteContentSize.Y)
end)

-- Create flickering effect
spawn(function()
    while MainFrame.Parent do
        local intensity = math.random() * 0.1
        TweenService:Create(Glow, TweenInfo.new(0.1), {
            ImageTransparency = intensity
        }):Play()
        task.wait(math.random(0.1, 0.5))
    end
end)

-- Matrix rain effect
local MatrixRain = Instance.new("Frame")
MatrixRain.Size = UDim2.new(1, 0, 1, 0)
MatrixRain.BackgroundTransparency = 1
MatrixRain.ZIndex = -1
MatrixRain.Parent = MainFrame

-- Add hacker effects
local function CreateMatrixCode()
    local code = Instance.new("TextLabel")
    code.Size = UDim2.new(0, 20, 0, 20)
    code.Position = UDim2.new(math.random(), 0, 0, -20)
    code.Text = string.char(math.random(65, 90))
    code.TextColor3 = Color3.new(0, math.random() * 0.5 + 0.5, 0)
    code.BackgroundTransparency = 1
    code.Font = Enum.Font.Code
    code.TextSize = 14
    code.ZIndex = -1
    code.Parent = MatrixRain
    
    spawn(function()
        local speed = math.random(5, 10)
        while code.Parent do
            code.Position += UDim2.new(0, 0, 0, speed)
            if code.Position.Y.Offset > MainFrame.AbsoluteSize.Y then
                code:Destroy()
                break
            end
            task.wait(0.03)
        end
    end)
end

-- Create matrix rain effect
spawn(function()
    while MatrixRain.Parent do
        CreateMatrixCode()
        task.wait(0.03)
    end
end)

-- Typewriter effect function
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    local charDelay = speed * 0.8  -- Faster typing
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(charDelay)
        
        -- Random glitch effect
        if math.random() < 0.15 then
            local glitchChars = {"#", "@", "%", "&", "*", "~"}
            local original = label.Text
            label.Text = string.sub(text, 1, i-1) .. glitchChars[math.random(1, #glitchChars)]
            task.wait(0.03)
            label.Text = original
        end
    end
    
    -- Final glitch for dramatic effect
    if math.random() < 0.7 then
        local original = label.Text
        for _ = 1, 3 do
            label.Text = original .. "�"
            task.wait(0.05)
            label.Text = original
            task.wait(0.05)
        end
    end
end

-- Create new terminal line
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

-- Create professional receipt popup
local function CreateReceiptPopup(username, luck, version)
    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0.4, 0, 0.5, 0)
    Popup.Position = UDim2.new(0.3, 0, 0.25, 0)
    Popup.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    Popup.BorderSizePixel = 0
    Popup.Parent = ScreenGui
    
    -- Hacker grid background
    local Grid = Instance.new("ImageLabel")
    Grid.Size = UDim2.new(1, 0, 1, 0)
    Grid.Image = "rbxassetid://9091674221" -- Grid texture
    Grid.ImageTransparency = 0.9
    Grid.ScaleType = Enum.ScaleType.Tile
    Grid.TileSize = UDim2.new(0, 50, 0, 50)
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
            TweenService:Create(GlowEffect, TweenInfo.new(1), {
                ImageTransparency = 0.3
            }):Play()
            task.wait(1)
            TweenService:Create(GlowEffect, TweenInfo.new(1), {
                ImageTransparency = 0.7
            }):Play()
            task.wait(1)
        end
    end)
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0.15, 0)
    Header.BackgroundColor3 = Color3.new(0, 0.15, 0.05)
    Header.BorderSizePixel = 0
    Header.Parent = Popup
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Text = "CYBER SYSTEMS REPORT"
    Title.TextColor3 = Color3.new(0, 1, 0.3)
    Title.Font = Enum.Font.Code
    Title.TextSize = 18
    Title.BackgroundTransparency = 1
    Title.Parent = Header
    
    -- Timestamp
    local Timestamp = Instance.new("TextLabel")
    Timestamp.Size = UDim2.new(1, 0, 0.1, 0)
    Timestamp.Position = UDim2.new(0, 0, 0.15, 0)
    Timestamp.Text = "GENERATED: " .. os.date("%Y-%m-%d %H:%M:%S")
    Timestamp.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    Timestamp.Font = Enum.Font.Code
    Timestamp.TextSize = 12
    Timestamp.TextXAlignment = Enum.TextXAlignment.Right
    Timestamp.BackgroundTransparency = 1
    Timestamp.Parent = Popup
    
    -- Receipt content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(0.9, 0, 0.6, 0)
    Content.Position = UDim2.new(0.05, 0, 0.25, 0)
    Content.BackgroundTransparency = 1
    Content.Parent = Popup
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 15)
    ContentList.Parent = Content
    
    -- Receipt data - enhanced with hacker details
    local data = {
        {label = "USER IDENT:", value = username, color = Color3.new(0, 0.8, 1)},
        {label = "SESSION ID:", value = "0x" .. string.format("%X", math.random(1000000, 9999999)), color = Color3.new(0.6, 0.6, 1)},
        {label = "SERVER LUCK:", value = string.format("%.1f%%", luck), color = Color3.new(1, 0.8, 0)},
        {label = "SECURITY LEVEL:", value = "LEVEL " .. math.random(3, 5), color = Color3.new(1, 0.3, 0.3)},
        {label = "VERSION:", value = "v"..version, color = Color3.new(0.5, 1, 0.5)},
        {label = "COMPATIBILITY:", value = "v1346 below "..(version < 1346 and "✅" or "❌"), color = version < 1346 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)},
        {label = "EGG STATUS:", value = "ENCRYPTED & VERIFIED", color = Color3.new(0, 1, 0.5)},
        {label = "SYSTEM STATUS:", value = "SECURE", color = Color3.new(0, 1, 0)},
        {label = "DIAGNOSTIC:", value = "COMPLETE", color = Color3.new(0, 1, 0)}
    }
    
    for _, item in ipairs(data) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 20)
        row.BackgroundTransparency = 1
        row.Parent = Content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.45, 0, 1, 0)
        label.Text = item.label
        label.TextColor3 = Color3.new(0.5, 1, 0.5)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = row
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0.55, 0, 1, 0)
        value.Position = UDim2.new(0.45, 0, 0, 0)
        value.Text = item.value
        value.TextColor3 = item.color
        value.Font = Enum.Font.Code
        value.TextSize = 14
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.BackgroundTransparency = 1
        value.Parent = row
    end
    
    -- Hacker signature
    local Signature = Instance.new("TextLabel")
    Signature.Size = UDim2.new(1, 0, 0.1, 0)
    Signature.Position = UDim2.new(0, 0, 0.85, 0)
    Signature.Text = ">_ SYSTEM SECURED BY CYBER DIAGNOSTICS"
    Signature.TextColor3 = Color3.new(0, 0.7, 0.2)
    Signature.Font = Enum.Font.Code
    Signature.TextSize = 12
    Signature.TextXAlignment = Enum.TextXAlignment.Center
    Signature.BackgroundTransparency = 1
    Signature.Parent = Popup
    
    -- OK button
    local OkButton = Instance.new("TextButton")
    OkButton.Size = UDim2.new(0.3, 0, 0.08, 0)
    OkButton.Position = UDim2.new(0.35, 0, 0.92, 0)
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
        TweenService:Create(Popup, TweenInfo.new(0.5), {Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.5)
        Popup:Destroy()
    end)
    
    -- Animate in
    Popup.Size = UDim2.new(0,0,0,0)
    TweenService:Create(Popup, TweenInfo.new(0.5), {
        Size = UDim2.new(0.4,0,0.5,0)
    }):Play()
end

-- Main diagnostic sequence - faster with more steps
local function RunDiagnostic()
    -- Initial delay for dramatic effect
    task.wait(0.5)
    
    -- Create initial line
    local line1 = CreateTerminalLine()
    TypewriterEffect(line1, "> Initializing CYBER SYSTEMS diagnostic protocol...", 0.02)
    task.wait(1)
    
    -- Sequence of diagnostics - more steps, faster execution
    local username = player.Name
    local luck = random:NextNumber(0.1, 100.0)
    local version = game.PlaceVersion
    
    local steps = {
        {text = "> Establishing secure connection...", delay = 1.5},
        {text = "> Bypassing security protocols...", color = Color3.new(1, 0.3, 0.3), delay = 1.5},
        {text = "> Accessing mainframe...", delay = 1.5},
        {text = "> Decrypting user credentials...", color = Color3.new(0.8, 0.8, 0.2), delay = 1.5},
        {text = "> USER IDENT: " .. username, color = Color3.new(0, 0.8, 1), delay = 1.5},
        {text = "> Analyzing server entropy matrix...", delay = 1.5},
        {text = "> Calculating probabilistic outcomes...", color = Color3.new(0.8, 0.5, 1), delay = 1.5},
        {text = "> SERVER LUCK COEFFICIENT: " .. string.format("%.1f", luck) .. "%", color = Color3.new(1, 0.8, 0), delay = 2},
        {text = "> Scanning version registry...", delay = 1.5},
        {text = "> TARGET VERSION: v1346 below", color = Color3.new(1, 0.3, 0.3), delay = 1.5},
        {text = "> DETECTED VERSION: v" .. version, color = Color3.new(0.5, 1, 0.5), delay = 2},
        {text = "> Running compatibility check...", delay = 1.5},
        {text = "> COMPATIBILITY: " .. (version < 1346 and "PASS" or "FAIL"), color = version < 1346 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0), delay = 2},
        {text = "> Accessing encrypted egg database...", delay = 1.5},
        {text = "> Decrypting egg signatures...", color = Color3.new(0.5, 0.8, 1), delay = 1.5},
        {text = "> Verifying cryptographic hashes...", delay = 1.5},
        {text = "> EGG SIGNATURES: VERIFIED", color = Color3.new(0, 1, 0.5), delay = 2},
        {text = "> Compiling diagnostic report...", delay = 1.5},
        {text = "> DIAGNOSTIC COMPLETE", color = Color3.new(0, 1, 0), delay = 2},
        {text = "> Generating final report...", delay = 1.5}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine(nil, step.color)
        TypewriterEffect(line, step.text, 0.02)
        task.wait(step.delay)
    end
    
    -- Fade out terminal
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Wait()
    MainFrame:Destroy()
    
    -- Show professional receipt
    CreateReceiptPopup(username, luck, version)
end

-- Start the diagnostic sequence
spawn(RunDiagnostic)
