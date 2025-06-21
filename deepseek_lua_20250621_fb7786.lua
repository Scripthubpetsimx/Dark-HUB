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

-- Terminal-style text
local Terminal = Instance.new("ScrollingFrame")
Terminal.Size = UDim2.new(1, 0, 1, 0)
Terminal.BackgroundTransparency = 1
Terminal.ScrollBarThickness = 5
Terminal.ScrollBarImageColor3 = Color3.new(0, 0.5, 0)
Terminal.CanvasSize = UDim2.new(0, 0, 10, 0) -- Allow scrolling
Terminal.Parent = MainFrame

local TerminalList = Instance.new("UIListLayout")
TerminalList.Padding = UDim.new(0, 5)
TerminalList.Parent = Terminal

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
            wait(0.05)
        end
    end)
end

-- Create matrix rain effect
spawn(function()
    while MatrixRain.Parent do
        CreateMatrixCode()
        wait(0.05)
    end
end)

-- Typewriter effect function
local function TypewriterEffect(label, text, speed)
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        Terminal.CanvasPosition = Vector2.new(0, Terminal.CanvasSize.Y.Offset)
        wait(speed)
        
        -- Random glitch effect
        if math.random() < 0.1 then
            local original = label.Text
            label.Text = string.sub(text, 1, i-1) .. string.char(math.random(33, 126))
            wait(0.05)
            label.Text = original
        end
    end
end

-- Create new terminal line
local function CreateTerminalLine(text, color)
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, -10, 0, 20)
    line.Position = UDim2.new(0, 5, 0, 0)
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

-- Main diagnostic sequence
local function RunDiagnostic()
    -- Initial delay for dramatic effect
    wait(1)
    
    -- Create initial line
    local line1 = CreateTerminalLine()
    TypewriterEffect(line1, "> Initializing system diagnostics...", 0.05)
    wait(2)
    
    -- Sequence of diagnostics
    local steps = {
        {text = "> Running service diagnostics...", delay = 5},
        {text = "> Reading user credentials: " .. player.Name, color = Color3.new(0, 0.8, 1), delay = 5},
        {text = "> Calculating server luck coefficient...", delay = 5},
        {text = "> Server luck: " .. string.format("%.1f", random:NextNumber(0.1, 100.0)) .. "%", color = Color3.new(1, 0.5, 0), delay = 5},
        {text = "> Reading version data...", delay = 5},
        {text = "> Version required: v1346 below", color = Color3.new(1, 0.3, 0.3), delay = 5},
        {text = "> Detected version: v" .. game.PlaceVersion, color = Color3.new(0.5, 1, 0.5), delay = 5},
        {text = "> Analyzing egg database...", delay = 5},
        {text = "> Egg signatures verified", color = Color3.new(0, 1, 0.5), delay = 5},
        {text = "> Diagnostic complete", color = Color3.new(0, 1, 0), delay = 5},
        {text = "> Shutting down...", delay = 2}
    }
    
    for _, step in ipairs(steps) do
        local line = CreateTerminalLine(nil, step.color)
        TypewriterEffect(line, step.text, 0.03)
        wait(step.delay)
    end
    
    -- Fade out
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(1.5), {BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Wait()
    ScreenGui:Destroy()
end

-- Start the diagnostic sequence
spawn(RunDiagnostic)