-- Mobile GUI with persistent script execution
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local guiEnabled = true

-- Create main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimatedMobileGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main container
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.8, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 46)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Add stylish corner rounding
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.05, 0)
UICorner.Parent = MainFrame

-- Add glossy effect
local gradient = Instance.new("UIGradient")
gradient.Rotation = 90
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 90)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})
gradient.Transparency = NumberSequence.new(0.7)
gradient.Parent = MainFrame

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.15, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SCRIPT HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.TextSize = 22
Title.Parent = TitleBar

-- Button container
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
ButtonContainer.Position = UDim2.new(0.05, 0, 0.2, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05, 0)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ButtonContainer

-- Function to create animated buttons
local function createButton(name, color)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0.95, 0, 0.4, 0)
    Button.BackgroundColor3 = color
    Button.AutoButtonColor = false
    Button.Font = Enum.Font.GothamBold
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 18
    Button.Text = name
    Button.BorderSizePixel = 0
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0.2, 0)
    ButtonCorner.Parent = Button
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ButtonStroke.Color = Color3.fromRGB(180, 180, 220)
    ButtonStroke.Thickness = 2
    ButtonStroke.Parent = Button
    
    -- Hover effect
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color:lerp(Color3.new(1,1,1), 0.3)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    -- Press effect
    Button.MouseButton1Down:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0.92, 0, 0.38, 0)}):Play()
    end)
    
    Button.MouseButton1Up:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, {EasingStyle = Enum.EasingStyle.Elastic}), 
            {Size = UDim2.new(0.95, 0, 0.4, 0)}):Play()
    end)
    
    return Button
end

-- Create buttons
local Script1Button = createButton("DARK HUB", Color3.fromRGB(120, 80, 200))
Script1Button.LayoutOrder = 1
Script1Button.Parent = ButtonContainer

local Script2Button = createButton("GARDEN SPAWNER", Color3.fromRGB(80, 160, 120))
Script2Button.LayoutOrder = 2
Script2Button.Parent = ButtonContainer

-- Close button (minimize)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Position = UDim2.new(0.88, 0, 0.1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 75)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 18
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0.2, 0)
CloseCorner.Parent = CloseButton

-- Minimize button functionality
CloseButton.MouseButton1Click:Connect(function()
    guiEnabled = not guiEnabled
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
        {Size = UDim2.new(0, 0, 0, 0)}):Play()
end)

-- Reopen button (floating button)
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0.15, 0, 0.1, 0)
OpenButton.Position = UDim2.new(0.01, 0, 0.01, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(80, 100, 180)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Text = "≡"
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.TextSize = 24
OpenButton.Visible = false
OpenButton.BorderSizePixel = 0
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0.2, 0)
OpenCorner.Parent = OpenButton

OpenButton.MouseButton1Click:Connect(function()
    guiEnabled = true
    OpenButton.Visible = false
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), 
        {Size = UDim2.new(0.8, 0, 0.5, 0)}):Play()
end)

-- Handle GUI visibility
MainFrame.Changed:Connect(function()
    if MainFrame.Size.Y.Scale <= 0.01 then
        MainFrame.Visible = false
        OpenButton.Visible = true
    end
end)

-- Dragging functionality
local dragging
local dragInput
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService = game:GetService("UserInputService")

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Persistent execution function
local function executeScript(scriptUrl, retryCount)
    retryCount = retryCount or 0
    
    local success, result = pcall(function()
        local scriptSrc = game:HttpGet(scriptUrl, true)
        loadstring(scriptSrc)()
    end)
    
    if not success and retryCount < 3 then
        warn("Script execution failed. Retrying... ("..tostring(retryCount+1).."/3)")
        task.wait(2)
        executeScript(scriptUrl, retryCount + 1)
    end
end

-- Server hop persistence
local function handleServerHop()
    local teleportData = TeleportService:GetLocalPlayerTeleportData()
    if teleportData and teleportData.ScriptRunning then
        executeScript("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/5631075000133c7fa307da94f3bc5b7c.txt")
    end
end

-- Button functionality
Script1Button.MouseButton1Click:Connect(function()
    -- Set teleport data for persistence
    TeleportService:SetTeleportData({ScriptRunning = true})
    
    executeScript("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/5631075000133c7fa307da94f3bc5b7c.txt")
    
    -- Button animation
    local pulse = TweenService:Create(Script1Button, TweenInfo.new(0.5, Enum.EasingStyle.Quint), 
        {BackgroundTransparency = 0.5, TextTransparency = 0.5})
    pulse:Play()
    pulse.Completed:Wait()
    TweenService:Create(Script1Button, TweenInfo.new(0.3), 
        {BackgroundTransparency = 0, TextTransparency = 0}):Play()
end)

Script2Button.MouseButton1Click:Connect(function()
    local success, result = pcall(function()
        local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/main/Spawner.lua"))()
        Spawner.Load()
    end)
    
    if not success then
        warn("Garden Spawner failed: "..tostring(result))
    end
    
    -- Button animation
    local rotate = TweenService:Create(Script2Button, TweenInfo.new(0.3, Enum.EasingStyle.Back), 
        {Rotation = 10})
    rotate:Play()
    rotate:Destroy()
    task.wait(0.1)
    TweenService:Create(Script2Button, TweenInfo.new(0.5, Enum.EasingStyle.Elastic), 
        {Rotation = 0}):Play()
end)

-- Initial animations
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Visible = true
TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), 
    {Size = UDim2.new(0.8, 0, 0.5, 0)}):Play()

-- Handle server hops on join
handleServerHop()