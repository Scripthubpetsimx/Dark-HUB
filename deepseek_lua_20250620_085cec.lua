-- Ultimate Grow a Garden GUI with Stylish Popups
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

-- ===== MODERN POPUP DESIGN =====
local function CreateFancyPopup(title, message, accentColor)
    local PopupFrame = Instance.new("Frame")
    PopupFrame.Size = UDim2.new(0.65, 0, 0.35, 0)
    PopupFrame.Position = UDim2.new(0.175, 0, 0.325, 0)
    PopupFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 48)
    PopupFrame.BackgroundTransparency = 0.15
    PopupFrame.Parent = ScreenGui
    
    -- Glass effect
    local UIBlur = Instance.new("BlurEffect")
    UIBlur.Size = 12
    UIBlur.Parent = PopupFrame
    
    -- Stylish header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0.2, 0)
    Header.BackgroundColor3 = accentColor
    Header.BorderSizePixel = 0
    Header.Parent = PopupFrame
    
    -- Gradient accent
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, accentColor),
        ColorSequenceKeypoint.new(1, accentColor:Lerp(Color3.new(0,0,0), 0.3))
    })
    Gradient.Rotation = 90
    Gradient.Parent = Header
    
    -- Title text
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.9, 0, 0.9, 0)
    Title.Position = UDim2.new(0.05, 0, 0.05, 0)
    Title.Text = string.upper(title)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.new(1,1,1)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Header
    
    -- Message content
    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(0.9, 0, 0.6, 0)
    Message.Position = UDim2.new(0.05, 0, 0.25, 0)
    Message.Text = message
    Message.Font = Enum.Font.Gotham
    Message.TextColor3 = Color3.new(0.9,0.9,0.9)
    Message.TextSize = 14
    Message.TextWrapped = true
    Message.TextYAlignment = Enum.TextYAlignment.Top
    Message.BackgroundTransparency = 1
    Message.Parent = PopupFrame
    
    -- Modern OK button
    local OKButton = Instance.new("TextButton")
    OKButton.Size = UDim2.new(0.4, 0, 0.15, 0)
    OKButton.Position = UDim2.new(0.3, 0, 0.8, 0)
    OKButton.BackgroundColor3 = accentColor
    OKButton.Text = "GOT IT"
    OKButton.Font = Enum.Font.GothamBold
    OKButton.TextColor3 = Color3.new(1,1,1)
    OKButton.TextSize = 14
    OKButton.Parent = PopupFrame
    
    -- Button effects
    OKButton.MouseEnter:Connect(function()
        TweenService:Create(OKButton, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    OKButton.MouseLeave:Connect(function()
        TweenService:Create(OKButton, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    
    -- Close functionality
    OKButton.MouseButton1Click:Connect(function()
        TweenService:Create(PopupFrame, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.2)
        PopupFrame:Destroy()
    end)
    
    -- Animate in
    PopupFrame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(PopupFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0.65,0,0.35,0)
    }):Play()
    
    return PopupFrame
end

-- ===== SCRIPT BUTTONS =====
-- [Include all your previous buttons but replace CreatePopup with CreateFancyPopup]

-- Example button implementation:
local EggESPButton = Instance.new("TextButton")
-- [...] (your existing button setup)

EggESPButton.MouseButton1Click:Connect(function()
    CreateFancyPopup(
        "Egg ESP Warning", 
        "⚠️ YOUR EGG MUST BE READY TO HATCH ⚠️\n\n• Server hops will try to find lower versions (v1346 below)\n• Make sure your egg is in the final stage",
        Color3.fromRGB(255, 80, 80) -- Red accent
    )
    task.wait(2) -- Let them read the warning
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua", true))()
end)
