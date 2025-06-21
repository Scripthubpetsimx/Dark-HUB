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

-- Main container with cyberpunk design
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.58, 0, 0.25, 0) -- Right center
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Cyberpunk neon border
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 6, 1, 6)
Border.Position = UDim2.new(0, -3, 0, -3)
Border.BackgroundColor3 = Color3.new(0, 0.8, 0.2)
Border.ZIndex = -1
Border.Parent = MainFrame

-- Glowing effect
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.1, 0, 1.1, 0)
Glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.new(0, 0.8, 0.2)
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(100, 100, 100, 100)
Glow.BackgroundTransparency = 1
Glow.ZIndex = -2
Glow.Parent = Border

-- CRT monitor effect (scanlines)
local Scanlines = Instance.new("Frame")
Scanlines.Size = UDim2.new(1, 0, 1, 0)
Scanlines.BackgroundTransparency = 0.95
Scanlines.BackgroundColor3 = Color3.new(0, 0, 0)
Scanlines.ZIndex = 2
Scanlines.Parent = MainFrame

local scanlinePattern = Instance.new("UIGradient")
scanlinePattern.Rotation = 90
scanlinePattern.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.05, 0.9),
    NumberSequenceKeypoint.new(0.1, 1)
})
scanlinePattern.Parent = Scanlines

-- Terminal-style text
local Terminal = Instance.new("ScrollingFrame")
Terminal.Size = UDim2.new(1, -20, 1, -20)
Terminal.Position = UDim2.new(0, 10, 0, 10)
Terminal.BackgroundTransparency = 1
Terminal.ScrollBarThickness = 0
Terminal.CanvasSize = UDim2.new(0, 0, 0, 0)
Terminal.AutomaticCanvasSize = Enum.AutomaticSize.Y
Terminal.ScrollingDirection = Enum.ScrollingDirection.Y
Terminal.Parent = MainFrame

local TerminalList = Instance.new("UIListLayout")
TerminalList.Padding = UDim.new(0, 8)
TerminalList.Parent = Terminal

-- Auto-scroll when new items added
TerminalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Terminal.CanvasPosition = Vector2.new(0, TerminalList.AbsoluteContentSize.Y)
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
    code.Text = string.char(math.random(33, 126))
    code.TextColor3 = Color3.new(0, math.random() * 0.8 + 0.2, 0)
    code.BackgroundTransparency = 1
    code.Font = Enum.Font.Code
    code.TextSize = 14
    code.TextTransparency = math.random() * 0.5
    code.Parent = MatrixRain
    
    spawn(function()
        local speed = math.random(8, 15)
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
        task.wait(0.02)
    end
end)

-- Typewriter effect function with enhanced glitches
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        
        -- Enhanced glitch effects
        if math.random() < 0.15 then
            local glitchText = ""
            for j = 1, i do
                glitchText = glitchText .. string.char(math.random(33, 126))
            end
            
            local original = label.Text
            label.Text = glitchText
            label.TextColor3 = Color3.new(math.random(), math.random(), math.random())
            task.wait(0.05)
            label.TextColor3 = Color3.new(0, 1, 0.5)
            label.Text = original
        end
        
        task.wait(speed)
    end
end

-- Create new terminal line
local function CreateTerminalLine(text, color)
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, -10, 0, 20)
    line.Text = ""
    line.TextColor3 = color or Color3.new(0, 1, 0.5)
    line.Font = Enum.Font.Code
    line.TextSize = 14
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.BackgroundTransparency = 1
    line.TextStrokeTransparency = 0.7
    line.TextStrokeColor3 = Color3.new(0, 0.2, 0)
    line.Parent = Terminal
    
    return line
end

-- Create cyberpunk receipt popup
local function CreateReceiptPopup(username, luck, version)
    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0.45, 0, 0.55, 0)
    Popup.Position = UDim2.new(0.275, 0, 0.225, 0)
    Popup.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    Popup.BorderSizePixel = 0
    Popup.ZIndex = 10
    Popup.Parent = ScreenGui
    
    -- Glowing border
    local PopupBorder = Instance.new("Frame")
    PopupBorder.Size = UDim2.new(1, 6, 1, 6)
    PopupBorder.Position = UDim2.new(0, -3, 0, -3)
    PopupBorder.BackgroundColor3 = Color3.new(0, 0.8, 0.2)
    PopupBorder.ZIndex = 9
    PopupBorder.Parent = Popup
    
    local PopupGlow = Instance.new("ImageLabel")
    PopupGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
    PopupGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    PopupGlow.Image = "rbxassetid://5028857084"
    PopupGlow.ImageColor3 = Color3.new(0, 0.8, 0.2)
    PopupGlow.ScaleType = Enum.ScaleType.Slice
    PopupGlow.SliceCenter = Rect.new(100, 100, 100, 100)
    PopupGlow.BackgroundTransparency = 1
    PopupGlow.ZIndex = 8
    PopupGlow.Parent = PopupBorder
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0.15, 0)
    Title.Text = "SYSTEM DIAGNOSTIC REPORT"
    Title.TextColor3 = Color3.new(0, 1, 0.5)
    Title.Font = Enum.Font.Code
    Title.TextSize = 20
    Title.TextStrokeTransparency = 0.5
    Title.TextStrokeColor3 = Color3.new(0, 0.2, 0)
    Title.BackgroundTransparency = 1
    Title.Parent = Popup
    
    -- Divider
    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(0.9, 0, 0, 2)
    Divider.Position = UDim2.new(0.05, 0, 0.15, 0)
    Divider.BackgroundColor3 = Color3.new(0, 0.8, 0.2)
    Divider.BorderSizePixel = 0
    Divider.Parent = Popup
    
    -- Receipt content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(0.9, 0, 0.7, 0)
    Content.Position = UDim2.new(0.05, 0, 0.2, 0)
    Content.BackgroundTransparency = 1
    Content.Parent = Popup
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 12)
    ContentList.Parent = Content
    
    -- Receipt data with cyberpunk style
    local data = {
        {label = "USER IDENT:", value = username, color = Color3.new(0, 1, 1)},
        {label = "SERVER LUCK INDEX:", value = string.format("%.1f%%", luck), color = luck > 50 and Color3.new(0, 1, 0.5) or Color3.new(1, 0.5, 0)},
        {label = "DETECTED VERSION:", value = "v"..version, color = Color3.new(0.8, 0.8, 1)},
        {label = "REQUIRED VERSION:", value = "v1346 below", color = Color3.new(1, 1, 0.5)},
        {label = "COMPATIBILITY STATUS:", value = version < 1346 and "COMPATIBLE ✅" or "INCOMPATIBLE ❌", color = version < 1346 and Color3.new(0, 1, 0) or Color3.new(1, 0.2, 0.2)},
        {label = "EGG DATABASE STATUS:", value = "DECRYPTED & VERIFIED", color = Color3.new(0, 1, 0.5)},
        {label = "SECURITY BREACHES:", value = "4 CRITICAL, 12 MODERATE", color = Color3.new(1, 0.3, 0.3)},
        {label = "SYSTEM INTEGRITY:", value = "87.4%", color = Color3.new(0.5, 1, 0.5)},
        {label = "DIAGNOSTIC RESULT:", value = "OPERATION SUCCESSFUL", color = Color3.new(0, 1, 0)}
    }
    
    for _, item in ipairs(data) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 22)
        row.BackgroundTransparency = 1
        row.Parent = Content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.55, 0, 1, 0)
        label.Text = item.label
        label.TextColor3 = Color3.new(0.7, 0.9, 0.7)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = row
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0.45, 0, 1, 0)
        value.Position = UDim2.new(0.55, 0, 0, 0)
        value.Text = item.value
        value.TextColor3 = item.color
        value.Font = Enum.Font.Code
        value.TextSize = 14
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.BackgroundTransparency = 1
        value.Parent = row
    end
    
    -- OK button
    local OkButton = Instance.new("TextButton")
    OkButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    OkButton.Position = UDim2.new(0.3, 0, 0.85, 0)
    OkButton.Text = "ACKNOWLEDGE"
    OkButton.Font = Enum.Font.Code
    OkButton.TextSize = 16
    OkButton.TextColor3 = Color3.new(0, 0, 0)
    OkButton.BackgroundColor3 = Color3.new(0, 0.8, 0.2)
    OkButton.Parent = Popup
    
    -- Button hover effect
    OkButton.MouseEnter:Connect(function()
        TweenService:Create(OkButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.2, 1, 0.4)}):Play()
    end)
    
    OkButton.MouseLeave:Connect(function()
        TweenService:Create(OkButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0, 0.8, 0.2)}):Play()
    end)
    
    OkButton.MouseButton1Click:Connect(function()
        TweenService:Create(Popup, TweenInfo.new(0.5), {Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.5)
        Popup:Destroy()
    end)
    
    -- Animate in
    Popup.Size = UDim2.new(0,0,0,0)
    TweenService:Create(Popup, TweenInfo.new(0.5), {
        Size = UDim2.new(0.45,0,0.55,0)
    }):Play()
end

-- Main diagnostic sequence (faster paced)
local function RunDiagnostic()
    -- Create initial line
    local line1 = CreateTerminalLine()
    TypewriterEffect(line1, "> INITIALIZING SYSTEM DIAGNOSTICS...", 0.02)
    task.wait(1.5)
    
    -- Create hacker effect lines
    local effectLines = {}
    for i = 1, 5 do
        local line = CreateTerminalLine()
        line.Text = "> " .. string.rep(string.char(math.random(33, 126)), math.random(20, 40))
        line.TextColor3 = Color3.new(0, math.random() * 0.5 + 0.3, 0)
        table.insert(effectLines, line)
        task.wait(0.1)
    end
    
    -- Remove effect lines
    for _, line in ipairs(effectLines) do
        line:Destroy()
        task.wait(0.05)
    end
    
    -- Sequence of diagnostics (faster)
    local username = player.Name
    local luck = random:NextNumber(0.1, 100.0)
    local version = game.PlaceVersion
    
    local steps = {
        {text = "> BYPASSING SECURITY PROTOCOLS...", delay = 1.5},
        {text = "> ESTABLISHING ENCRYPTED CONNECTION...", delay = 1.5},
        {text = "> ACCESSING MAINFRAME...", delay = 1.5},
        {text = "> RUNNING SERVICE DIAGNOSTICS...", delay = 1.5},
        {text = "> READING USER CREDENTIALS...", delay = 1.5},
        {text = "> USER IDENT: " .. username, color = Color3.new(0, 1, 1), delay = 1.5},
        {text = "> CALCULATING SERVER LUCK COEFFICIENT...", delay = 1.5},
        {text = "> LUCK INDEX: " .. string.format("%.1f", luck) .. "%", color = luck > 50 and Color3.new(0, 1, 0.5) or Color3.new(1, 0.5, 0), delay = 1.5},
        {text = "> SCANNING VERSION DATA...", delay = 1.5},
        {text = "> REQUIRED VERSION: v1346 BELOW", color = Color3.new(1, 1, 0.5), delay = 1.5},
        {text = "> DETECTED VERSION: v" .. version, color = Color3.new(0.8, 0.8, 1), delay = 1.5},
        {text = "> COMPATIBILITY: " .. (version < 1346 and "COMPATIBLE ✅" or "INCOMPATIBLE ❌"), color = version < 1346 and Color3.new(0, 1, 0) or Color3.new(1, 0.2, 0.2), delay = 1.5},
        {text = "> ACCESSING EGG DATABASE...", delay = 1.5},
        {text = "> DECRYPTING EGG SIGNATURES...", delay = 1.5},
        {text = "> EGG SIGNATURES VERIFIED", color = Color3.new(0, 1, 0.5), delay = 1.5},
        {text = "> COMPILING DIAGNOSTIC REPORT...", delay = 1.5},
        {text = "> DIAGNOSTIC COMPLETE", color = Color3.new(0, 1, 0), delay = 1},
        {text = "> PURGING TEMPORARY FILES...", delay = 1},
        {text = "> DISCONNECTING FROM MAINFRAME...", delay = 1}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine(nil, step.color)
        TypewriterEffect(line, step.text, 0.01)
        task.wait(step.delay)
    end
    
    -- Fade out terminal
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Wait()
    MainFrame:Destroy()
    
    -- Show receipt
    CreateReceiptPopup(username, luck, version)
end

-- Start the diagnostic sequence
spawn(RunDiagnostic)
