local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "MobileFriendlyGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Main container with responsive sizing
local Frame = Instance.new("ImageLabel")
Frame.Name = "MainFrame"
Frame.Parent = gui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0.85, 0, 0.9, 0) -- Relative to screen size
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(131, 89, 46)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.120
Frame.Visible = false -- Start hidden

-- Header with relative sizing
local Frame_2 = Instance.new("ImageLabel")
Frame_2.Name = "Header"
Frame_2.Parent = Frame
Frame_2.AnchorPoint = Vector2.new(0.5, 0)
Frame_2.Position = UDim2.new(0.5, 0, 0.02, 0)
Frame_2.Size = UDim2.new(0.95, 0, 0.06, 0) -- 95% width, 6% height
Frame_2.Image = "rbxassetid://3570695787"
Frame_2.ImageColor3 = Color3.fromRGB(30, 181, 55)
Frame_2.ScaleType = Enum.ScaleType.Slice
Frame_2.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_2.SliceScale = 0.050

-- Timer with adaptive text size
local Timer = Instance.new("TextLabel")
Timer.Name = "Timer"
Timer.Parent = Frame
Timer.AnchorPoint = Vector2.new(0.5, 0.5)
Timer.Position = UDim2.new(0.5, 0, 0.055, 0)
Timer.Size = UDim2.new(0.9, 0, 0.9, 0)
Timer.Font = Enum.Font.SourceSansBold
Timer.Text = "00:00:00"
Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
Timer.TextScaled = true -- Auto-scales text
Timer.TextSize = 26.000
Timer.TextStrokeTransparency = 0.700
Timer.BackgroundTransparency = 1

-- Main content area
local Frame_3 = Instance.new("Frame")
Frame_3.Parent = Frame
Frame_3.AnchorPoint = Vector2.new(0.5, 0)
Frame_3.Position = UDim2.new(0.5, 0, 0.12, 0)
Frame_3.Size = UDim2.new(0.95, 0, 0.82, 0) -- 95% width, 82% height
Frame_3.BackgroundColor3 = Color3.fromRGB(35, 110, 118)
Frame_3.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame_3

-- Combination Section 1
local Frame_4 = Instance.new("ImageLabel")
Frame_4.Name = "Section1Border"
Frame_4.Parent = Frame_3
Frame_4.AnchorPoint = Vector2.new(0.5, 0)
Frame_4.Position = UDim2.new(0.5, 0, 0.05, 0)
Frame_4.Size = UDim2.new(0.95, 0, 0.22, 0)
Frame_4.Image = "rbxassetid://3570695787"
Frame_4.ImageColor3 = Color3.fromRGB(95, 7, 1)
Frame_4.ScaleType = Enum.ScaleType.Slice
Frame_4.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_4.SliceScale = 0.120

local Frame_5 = Instance.new("ImageLabel")
Frame_5.Name = "Section1"
Frame_5.Parent = Frame_3
Frame_5.AnchorPoint = Vector2.new(0.5, 0)
Frame_5.Position = UDim2.new(0.5, 0, 0.08, 0)
Frame_5.Size = UDim2.new(0.85, 0, 0.18, 0)
Frame_5.Image = "rbxassetid://3570695787"
Frame_5.ImageColor3 = Color3.fromRGB(154, 184, 84)
Frame_5.ScaleType = Enum.ScaleType.Slice
Frame_5.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_5.SliceScale = 0.120

-- Plus symbol with relative positioning
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = Frame_5
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0.2, 0, 0.8, 0)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "+"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.BackgroundTransparency = 1

-- Left item
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Parent = Frame_5
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.new(0.25, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0.35, 0, 0.9, 0)
ImageLabel.Image = "rbxassetid://79519384825184"
ImageLabel.BackgroundTransparency = 1
ImageLabel.ScaleType = Enum.ScaleType.Fit

-- Right item
local ImageLabel_2 = Instance.new("ImageLabel")
ImageLabel_2.Parent = Frame_5
ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_2.Position = UDim2.new(0.75, 0, 0.5, 0)
ImageLabel_2.Size = UDim2.new(0.35, 0, 0.9, 0)
ImageLabel_2.Image = "rbxassetid://72741260782585"
ImageLabel_2.BackgroundTransparency = 1
ImageLabel_2.ScaleType = Enum.ScaleType.Fit

-- Combine button with larger touch area
local TextButton = Instance.new("TextButton")
TextButton.Parent = Frame_5
TextButton.AnchorPoint = Vector2.new(0.5, 0)
TextButton.Position = UDim2.new(0.5, 0, 1.1, 0)
TextButton.Size = UDim2.new(0.7, 0, 0.4, 0)
TextButton.Font = Enum.Font.LuckiestGuy
TextButton.Text = "COMBINE"
TextButton.TextColor3 = Color3.fromRGB(255, 0, 0)
TextButton.TextScaled = true
TextButton.BackgroundColor3 = Color3.fromRGB(73, 225, 255)

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(0, 12)
UICorner_2.Parent = TextButton

-- Combination Section 2 (repeats pattern with different images)
-- [Similar structure to Section 1 with responsive sizing]
-- ... (omitted for brevity, use same pattern as above)

-- Information panel with scrollable text
local TextLabel_3 = Instance.new("TextLabel")
TextLabel_3.Parent = Frame_3
TextLabel_3.AnchorPoint = Vector2.new(0.5, 1)
TextLabel_3.Position = UDim2.new(0.5, 0, 0.98, 0)
TextLabel_3.Size = UDim2.new(0.95, 0, 0.25, 0)
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 170, 127)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "To obtain combination points, find the EAGLE that appears around the map every 5 minutes"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextScaled = true
TextLabel_3.TextWrapped = true

local UICorner_4 = Instance.new("UICorner")
UICorner_4.CornerRadius = UDim.new(0, 12)
UICorner_4.Parent = TextLabel_3

-- Title label
local TextLabel_4 = Instance.new("TextLabel")
TextLabel_4.Parent = Frame
TextLabel_4.AnchorPoint = Vector2.new(0.5, 0)
TextLabel_4.Position = UDim2.new(0.5, 0, 0.01, 0)
TextLabel_4.Size = UDim2.new(0.8, 0, 0.05, 0)
TextLabel_4.Font = Enum.Font.SourceSansBold
TextLabel_4.Text = "SECRET!"
TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.TextScaled = true
TextLabel_4.BackgroundTransparency = 1

-- Timer label
local TextLabel_5 = Instance.new("TextLabel")
TextLabel_5.Parent = Frame
TextLabel_5.AnchorPoint = Vector2.new(0, 0.5)
TextLabel_5.Position = UDim2.new(0.05, 0, 0.055, 0)
TextLabel_5.Size = UDim2.new(0.4, 0, 0.9, 0)
TextLabel_5.Font = Enum.Font.SourceSans
TextLabel_5.Text = "Leaving In: "
TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.TextScaled = true
TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_5.BackgroundTransparency = 1

-- Mobile-friendly toggle button
local OPEN = Instance.new("TextButton")
OPEN.Name = "OPEN"
OPEN.Parent = gui
OPEN.AnchorPoint = Vector2.new(1, 0.5)
OPEN.Position = UDim2.new(0.98, 0, 0.5, 0) -- Right side of screen
OPEN.Size = UDim2.new(0.1, 0, 0.15, 0) -- Larger touch target
OPEN.Font = Enum.Font.SourceSansBold
OPEN.Text = "≡" -- Hamburger icon
OPEN.TextColor3 = Color3.fromRGB(0, 0, 0)
OPEN.TextScaled = true
OPEN.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
OPEN.BackgroundTransparency = 0.2

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 12)
openCorner.Parent = OPEN

-- Timer script
local function timerScript()
	local timerLabel = Timer
	local totalTime = 3600 -- 1 hour in seconds
	
	while true do
		local hours = math.floor(totalTime / 3600)
		local minutes = math.floor((totalTime % 3600) / 60)
		local seconds = totalTime % 60
		
		timerLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
		
		task.wait(1)
		totalTime = totalTime - 1
		
		if totalTime < 0 then
			timerLabel.Text = "00:00:00"
			break
		end
	end
end

coroutine.wrap(timerScript)()

-- Toggle GUI with animation
OPEN.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
	
	-- Animate toggle button
	local tweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	if Frame.Visible then
		tweenService:Create(OPEN, tweenInfo, {
			Position = UDim2.new(0.92, 0, 0.5, 0),
			TextColor3 = Color3.fromRGB(255, 50, 50)
		}):Play()
	else
		tweenService:Create(OPEN, tweenInfo, {
			Position = UDim2.new(0.98, 0, 0.5, 0),
			TextColor3 = Color3.fromRGB(0, 0, 0)
		}):Play()
	end
end)