local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
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

-- Add subtle glow effect
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.1, 0, 1.1, 0)
Glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.new(0, 0.2, 0)
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(100, 100, 100, 100)
Glow.BackgroundTransparency = 1
Glow.ZIndex = -1
Glow.Parent = MainFrame

-- Terminal-style text
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
    code.Text = string.char(math.random(65, 90))
    code.TextColor3 = Color3.new(0, math.random() * 0.5 + 0.5, 0)
    code.BackgroundTransparency = 1
    code.Font = Enum.Font.Code
    code.TextSize = 14
    code.Parent = MatrixRain
    
    spawn(function()
        local speed = math.random(5, 10)
        while code.Parent do
            code.Position += UDim2.new(0, 0, 0, speed)
            if code.Position.Y.Offset > MainFrame.AbsoluteSize.Y then
                code:Destroy()
                break
            end
            task.wait(0.05)
        end
    end)
end

-- Create matrix rain effect
spawn(function()
    while MatrixRain.Parent do
        CreateMatrixCode()
        task.wait(0.05)
    end
end)

-- Typewriter effect function
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(speed)
        
        -- Random glitch effect
        if math.random() < 0.1 then
            local original = label.Text
            label.Text = string.sub(text, 1, i-1) .. string.char(math.random(33, 126))
            task.wait(0.05)
            label.Text = original
        end
    end
end

-- Create new terminal line
local function CreateTerminalLine(text, color)
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, -10, 0, 20)
    line.Text = ""
    line.TextColor3 = color or Color3.new(0, 1, 0)
    line.Font = Enum.Font.Code
    line.TextSize = 14
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.BackgroundTransparency = 1
    line.TextStrokeTransparency = 0.7
    line.TextStrokeColor3 = Color3.new(0, 0.2, 0)
    line.Parent = Terminal
    
    return line
end

-- Create receipt popup
local function CreateReceiptPopup(username, luck, version)
    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0.4, 0, 0.5, 0)
    Popup.Position = UDim2.new(0.3, 0, 0.25, 0)
    Popup.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    Popup.BorderSizePixel = 0
    Popup.Parent = ScreenGui
    
    -- Glowing border
    local Border = Instance.new("Frame")
    Border.Size = UDim2.new(1, 4, 1, 4)
    Border.Position = UDim2.new(0, -2, 0, -2)
    Border.BackgroundColor3 = Color3.new(0, 0.5, 0)
    Border.ZIndex = -1
    Border.Parent = Popup
    
    local GlowEffect = Instance.new("ImageLabel")
    GlowEffect.Size = UDim2.new(1, 10, 1, 10)
    GlowEffect.Position = UDim2.new(0, -5, 0, -5)
    GlowEffect.Image = "rbxassetid://5028857084"
    GlowEffect.ImageColor3 = Color3.new(0, 0.3, 0)
    GlowEffect.ScaleType = Enum.ScaleType.Slice
    GlowEffect.SliceCenter = Rect.new(100, 100, 100, 100)
    GlowEffect.BackgroundTransparency = 1
    GlowEffect.ZIndex = -1
    GlowEffect.Parent = Border
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0.15, 0)
    Title.Text = "SYSTEM DIAGNOSTIC REPORT"
    Title.TextColor3 = Color3.new(0, 1, 0)
    Title.Font = Enum.Font.Code
    Title.TextSize = 18
    Title.BackgroundTransparency = 1
    Title.Parent = Popup
    
    -- Receipt content
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(0.9, 0, 0.7, 0)
    Content.Position = UDim2.new(0.05, 0, 0.2, 0)
    Content.BackgroundTransparency = 1
    Content.Parent = Popup
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 10)
    ContentList.Parent = Content
    
    -- Receipt data
    local data = {
        {label = "USER:", value = username},
        {label = "SERVER LUCK:", value = string.format("%.1f%%", luck)},
        {label = "VERSION:", value = "v"..version},
        {label = "COMPATIBILITY:", value = "v1346 below "..(version < 1346 and "✅" or "❌")},
        {label = "EGG STATUS:", value = "VERIFIED"},
        {label = "DIAGNOSTIC:", value = "COMPLETE"}
    }
    
    for _, item in ipairs(data) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 20)
        row.BackgroundTransparency = 1
        row.Parent = Content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.4, 0, 1, 0)
        label.Text = item.label
        label.TextColor3 = Color3.new(0.5, 1, 0.5)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = row
        
        local value = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0.4, 0, 0, 0)
        label.Text = item.value
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Right
        label.BackgroundTransparency = 1
        label.Parent = row
    end
    
    -- OK button
    local OkButton = Instance.new("TextButton")
    OkButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    OkButton.Position = UDim2.new(0.35, 0, 0.85, 0)
    OkButton.Text = "ACKNOWLEDGE"
    OkButton.Font = Enum.Font.Code
    OkButton.TextSize = 14
    OkButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    OkButton.BorderColor3 = Color3.new(0, 0.5, 0)
    OkButton.Parent = Popup
    
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

-- Main diagnostic sequence
local function RunDiagnostic()
    -- Initial delay for dramatic effect
    task.wait(1)
    
    -- Create initial line
    local line1 = CreateTerminalLine()
    TypewriterEffect(line1, "> Initializing system diagnostics...", 0.05)
    task.wait(2)
    
    -- Sequence of diagnostics
    local username = player.Name
    local luck = random:NextNumber(0.1, 100.0)
    local version = game.PlaceVersion
    
    local steps = {
        {text = "> Running service diagnostics...", delay = 5},
        {text = "> Reading user credentials: " .. username, color = Color3.new(0, 0.8, 1), delay = 5},
        {text = "> Calculating server luck coefficient...", delay = 5},
        {text = "> Server luck: " .. string.format("%.1f", luck) .. "%", color = Color3.new(1, 0.5, 0), delay = 5},
        {text = "> Reading version data...", delay = 5},
        {text = "> Version required: v1346 below", color = Color3.new(1, 0.3, 0.3), delay = 5},
        {text = "> Detected version: v" .. version, color = Color3.new(0.5, 1, 0.5), delay = 5},
        {text = "> Analyzing egg database...", delay = 5},
        {text = "> Egg signatures verified", color = Color3.new(0, 1, 0.5), delay = 5},
        {text = "> Diagnostic complete", color = Color3.new(0, 1, 0), delay = 5},
        {text = "> Generating report...", delay = 2}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine(nil, step.color)
        TypewriterEffect(line, step.text, 0.03)
        task.wait(step.delay)
    end
    
    -- Fade out terminal
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(1.5), {BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Wait()
    MainFrame:Destroy()
    
    -- Show receipt
    CreateReceiptPopup(username, luck, version)
end

-- Start the diagnostic sequence
spawn(RunDiagnostic)
