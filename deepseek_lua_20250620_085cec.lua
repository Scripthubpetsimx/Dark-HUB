-- Party GUI with ANTIban button & raining tacos
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Main GUI (Semi-transparent)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PartyGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Background (Subtle party effect)
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.8
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Raining Tacos Animation
local tacoImages = {
    "rbxassetid://1312944696", -- Taco image 1
    "rbxassetid://1312944877", -- Taco image 2
    "rbxassetid://1312945012"  -- Taco image 3
}

local function createTaco()
    local taco = Instance.new("ImageLabel")
    taco.Image = tacoImages[math.random(1, 3)]
    taco.Size = UDim2.new(0, 50, 0, 50)
    taco.Position = UDim2.new(math.random(), 0, 0, -50)
    taco.BackgroundTransparency = 1
    taco.Parent = ScreenGui
    
    local spin = math.random(-50, 50)
    local speed = math.random(3, 7)
    
    RunService.Heartbeat:Connect(function(dt)
        taco.Position += UDim2.new(0, spin * dt, 0, speed)
        taco.Rotation += spin * dt * 2
        
        if taco.Position.Y.Offset > workspace.CurrentCamera.ViewportSize.Y then
            taco:Destroy()
        end
    end)
end

-- Spawn tacos every 0.2 seconds
spawn(function()
    while true do
        createTaco()
        wait(0.2)
    end
end)

-- ANTIban Button (Glowing Party Style)
local Button = Instance.new("TextButton")
Button.Name = "ANTIbanButton"
Button.Size = UDim2.new(0.3, 0, 0.1, 0)
Button.Position = UDim2.new(0.35, 0, 0.8, 0)
Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Button.BackgroundTransparency = 0.5
Button.Text = "LOAD ANTIban"
Button.Font = Enum.Font.GothamBold
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 18
Button.BorderSizePixel = 0
Button.Parent = ScreenGui

-- Button Effects
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.3, 0)
UICorner.Parent = Button

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 0)
UIStroke.Thickness = 2
UIStroke.Parent = Button

-- Glow Animation
spawn(function()
    while true do
        TweenService:Create(Button, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {BackgroundTransparency = 0.3}):Play()
        wait(1)
        TweenService:Create(Button, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {BackgroundTransparency = 0.7}):Play()
        wait(1)
    end
end)

-- Click Effect
Button.MouseButton1Down:Connect(function()
    Button.Size = UDim2.new(0.28, 0, 0.09, 0)
    Button.Position = UDim2.new(0.36, 0, 0.805, 0)
end)

Button.MouseButton1Up:Connect(function()
    Button.Size = UDim2.new(0.3, 0, 0.1, 0)
    Button.Position = UDim2.new(0.35, 0, 0.8, 0)
end)

-- Load ANTIban Script
Button.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/ANTIban.lua", true))()
    end)
    
    if success then
        Button.Text = "LOADED!"
        task.wait(2)
        Button.Text = "LOAD ANTIban"
    else
        warn("ANTIban failed:", err)
        Button.Text = "ERROR!"
        task.wait(1)
        Button.Text = "TRY AGAIN"
    end
end)

-- Play "It's Raining Tacos" (Roblox Audio)
spawn(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://138081500" -- It's Raining Tacos
    sound.Looped = true
    sound.Volume = 0.5
    sound.Parent = player:WaitForChild("PlayerGui")
    sound:Play()
end)
