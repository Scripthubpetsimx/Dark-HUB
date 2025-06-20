-- Party GUI with ANTIban (Garden Spawner) button
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Main GUI (Visible, no transparency)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PartyGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

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

-- Main Container (Solid background)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "PARTY HUB 🎉"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- ANTIban Button (Now loads Garden Spawner)
local Button = Instance.new("TextButton")
Button.Name = "GardenSpawnerButton"
Button.Size = UDim2.new(0.8, 0, 0.5, 0)
Button.Position = UDim2.new(0.1, 0, 0.3, 0)
Button.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
Button.Text = "LOAD GARDEN SPAWNER"
Button.Font = Enum.Font.GothamBold
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 18
Button.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.1, 0)
ButtonCorner.Parent = Button

-- Button Animation
Button.MouseButton1Down:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0.75, 0, 0.45, 0)}):Play()
end)

Button.MouseButton1Up:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.3, {EasingStyle = Enum.EasingStyle.Elastic}), {Size = UDim2.new(0.8, 0, 0.5, 0)}):Play()
end)

-- Load Garden Spawner Script
Button.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/main/Spawner.lua", true))()
        Spawner.Load()
    end)
    
    if success then
        Button.Text = "LOADED! 🌱"
        task.wait(2)
        Button.Text = "GARDEN SPAWNER"
    else
        warn("Garden Spawner failed:", err)
        Button.Text = "ERROR! TRY AGAIN"
        task.wait(1)
        Button.Text = "GARDEN SPAWNER"
    end
end)

-- Play Correct Music (ID: 142376088)
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://142376088"
sound.Looped = true
sound.Volume = 0.7
sound.Parent = ScreenGui
sound:Play()

-- Initial GUI Animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Visible = true
TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), {Size = UDim2.new(0.4, 0, 0.3, 0)}):Play()
