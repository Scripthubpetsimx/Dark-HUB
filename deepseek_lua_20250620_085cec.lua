-- Fixed Party GUI with ANTIban
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PartyGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- =============================================
-- 1ST SCRIPT (AUTO-EXECUTE) - DARK HUB (FIXED)
-- =============================================
local function ExecuteFirstScript()
    local success, err = pcall(function()
        local script = game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/DARK%20HUB%20VISUAL", true)
        loadstring(script)()
    end)
    if not success then
        warn("1st Script Error:", err)
    else
        print("Dark HUB loaded successfully!")
    end
end
ExecuteFirstScript() -- Auto-run on start

-- =============================================
-- RAINING TACOS ANIMATION
-- =============================================
local tacoImages = {
    "rbxassetid://1312944696",
    "rbxassetid://1312944877", 
    "rbxassetid://1312945012"
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

spawn(function()
    while true do
        createTaco()
        wait(0.2)
    end
end)

-- =============================================
-- MAIN UI FRAME (FIXED VISIBILITY)
-- =============================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "ANTIban PARTY 🎉"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- =============================================
-- 2ND SCRIPT BUTTON (ANTIban - FIXED)
-- =============================================
local Button = Instance.new("TextButton")
Button.Name = "ANTIbanButton"
Button.Size = UDim2.new(0.8, 0, 0.5, 0)
Button.Position = UDim2.new(0.1, 0, 0.3, 0)
Button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
Button.Text = "LOAD ANTIban"
Button.Font = Enum.Font.GothamBold
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 18
Button.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.1, 0)
ButtonCorner.Parent = Button

-- Button animation
Button.MouseButton1Down:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0.75, 0, 0.45, 0)}):Play()
end)

Button.MouseButton1Up:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.3, {EasingStyle = Enum.EasingStyle.Elastic}), {Size = UDim2.new(0.8, 0, 0.5, 0)}):Play()
end)

-- FIXED ANTIban load
Button.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        local script = game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/ANTIban.lua", true)
        loadstring(script)()
    end)
    
    if success then
        Button.Text = "ANTIban LOADED! 🔒"
        task.wait(2)
        Button.Text = "LOAD ANTIban"
    else
        warn("ANTIban Error:", err)
        Button.Text = "ERROR! TRY AGAIN"
        task.wait(1)
        Button.Text = "LOAD ANTIban"
    end
end)

-- =============================================
-- CLOSE BUTTON (FIXED)
-- =============================================
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 0.2, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0.05, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- =============================================
-- MUSIC (FIXED - ID: 142376088)
-- =============================================
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://142376088"
sound.Looped = true
sound.Volume = 0.7
sound.Parent = ScreenGui
sound:Play()

-- Initial animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), {Size = UDim2.new(0.4, 0, 0.3, 0)}):Play()
