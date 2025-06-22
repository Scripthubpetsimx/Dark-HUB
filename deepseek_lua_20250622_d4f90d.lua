-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local Frame_2 = Instance.new("ImageLabel")
local Timer = Instance.new("TextLabel")
local Frame_3 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_4 = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local ScrollingFrame = Instance.new("ScrollingFrame")
local Frame_5 = Instance.new("ImageLabel")
local TextLabel_3 = Instance.new("TextLabel")
local ImageLabel = Instance.new("ImageLabel")
local ImageLabel_2 = Instance.new("ImageLabel")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Frame_6 = Instance.new("ImageLabel")
local TextLabel_4 = Instance.new("TextLabel")
local ImageLabel_3 = Instance.new("ImageLabel")
local ImageLabel_4 = Instance.new("ImageLabel")
local TextButton_2 = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TextLabel_5 = Instance.new("TextLabel")
local UICorner_4 = Instance.new("UICorner")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "Frame"
Frame.Parent = ScreenGui
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.Position = UDim2.new(0.0763827935, 0, 0.0472636819, 0)
Frame.Size = UDim2.new(0, 347, 0, 702)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(131, 89, 46)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.120

Frame_2.Name = "Frame"
Frame_2.Parent = Frame
Frame_2.Active = true
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.BackgroundTransparency = 1.000
Frame_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame_2.Position = UDim2.new(0.0230547544, 0, 0.0114613185, 0)
Frame_2.Size = UDim2.new(0, 330, 0, 42)
Frame_2.Image = "rbxassetid://3570695787"
Frame_2.ImageColor3 = Color3.fromRGB(30, 181, 55)
Frame_2.ScaleType = Enum.ScaleType.Slice
Frame_2.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_2.SliceScale = 0.050

Timer.Name = "Timer"
Timer.Parent = Frame
Timer.BackgroundColor3 = Color3.fromRGB(255, 255, 48)
Timer.BackgroundTransparency = 1.000
Timer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Timer.BorderSizePixel = 0
Timer.Position = UDim2.new(0.253602296, 0, 0.0128939832, 0)
Timer.Size = UDim2.new(0, 93, 0, 41)
Timer.Font = Enum.Font.SourceSans
Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
Timer.TextSize = 26.000
Timer.TextStrokeTransparency = 0.700

Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.fromRGB(35, 110, 118)
Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0.0403458215, 0, 0.0959885418, 0)
Frame_3.Size = UDim2.new(0, 317, 0, 425)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame_3

Frame_4.Name = "Frame"
Frame_4.Parent = Frame_3
Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_4.BackgroundTransparency = 1.000
Frame_4.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame_4.BorderSizePixel = 5
Frame_4.Position = UDim2.new(0.0220820196, 0, 0.0372771472, 0)
Frame_4.Size = UDim2.new(0, 304, 0, 148)
Frame_4.Image = "rbxassetid://3570695787"
Frame_4.ImageColor3 = Color3.fromRGB(95, 7, 1)
Frame_4.ScaleType = Enum.ScaleType.Slice
Frame_4.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_4.SliceScale = 0.120

TextLabel.Parent = Frame_3
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.447949439, 0, -0.158577561, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "SECRET!"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextSize = 47.000

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(-0.0172910672, 0, 0.00573065924, 0)
TextLabel_2.Size = UDim2.new(0, 124, 0, 50)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Leaving In: "
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextSize = 19.000

UIAspectRatioConstraint.Parent = Frame
UIAspectRatioConstraint.AspectRatio = 0.497

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(112, 42, 74)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.0230547544, 0, 0.0959885418, 0)
ScrollingFrame.Size = UDim2.new(0, 330, 0, 408)

Frame_5.Name = "Frame"
Frame_5.Parent = ScrollingFrame
Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_5.BackgroundTransparency = 1.000
Frame_5.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame_5.BorderSizePixel = 5
Frame_5.Position = UDim2.new(0.0694006309, 0, 0.0599675849, 0)
Frame_5.Size = UDim2.new(0, 275, 0, 120)
Frame_5.Image = "rbxassetid://3570695787"
Frame_5.ImageColor3 = Color3.fromRGB(154, 184, 84)
Frame_5.ScaleType = Enum.ScaleType.Slice
Frame_5.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_5.SliceScale = 0.120

TextLabel_3.Parent = Frame_5
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.167272732, 0, 0.283333331, 0)
TextLabel_3.Size = UDim2.new(0, 200, 0, 50)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "+"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextSize = 100.000

ImageLabel.Parent = Frame_5
ImageLabel.Active = true
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.552819073, 0, 0.0761750564, 0)
ImageLabel.Size = UDim2.new(0, 100, 0, 100)
ImageLabel.Image = "rbxassetid://79519384825184"

ImageLabel_2.Parent = Frame_5
ImageLabel_2.Active = true
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_2.BorderSizePixel = 0
ImageLabel_2.Position = UDim2.new(0.0946372226, 0, 0.0761750415, 0)
ImageLabel_2.Size = UDim2.new(0, 100, 0, 100)
ImageLabel_2.Image = "rbxassetid://72741260782585"

TextButton.Parent = Frame_5
TextButton.BackgroundColor3 = Color3.fromRGB(73, 225, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.13454546, 0, 1.26666665, 0)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Font = Enum.Font.LuckiestGuy
TextButton.Text = "COMBINE"
TextButton.TextColor3 = Color3.fromRGB(255, 0, 0)
TextButton.TextSize = 27.000

UICorner_2.Parent = TextButton

Frame_6.Name = "Frame"
Frame_6.Parent = ScrollingFrame
Frame_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_6.BackgroundTransparency = 1.000
Frame_6.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame_6.BorderSizePixel = 5
Frame_6.Position = UDim2.new(0.0694006681, 0, 0.243368059, 0)
Frame_6.Size = UDim2.new(0, 275, 0, 120)
Frame_6.Image = "rbxassetid://3570695787"
Frame_6.ImageColor3 = Color3.fromRGB(154, 184, 84)
Frame_6.ScaleType = Enum.ScaleType.Slice
Frame_6.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_6.SliceScale = 0.120

TextLabel_4.Parent = Frame_6
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.167272732, 0, 0.283333331, 0)
TextLabel_4.Size = UDim2.new(0, 200, 0, 50)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.Text = "+"
TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.TextSize = 100.000

ImageLabel_3.Parent = Frame_6
ImageLabel_3.Active = true
ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_3.BackgroundTransparency = 1.000
ImageLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_3.BorderSizePixel = 0
ImageLabel_3.Position = UDim2.new(0.563728154, 0, 0.0761749297, 0)
ImageLabel_3.Size = UDim2.new(0, 100, 0, 100)
ImageLabel_3.Image = "rbxassetid://122886404445185"

ImageLabel_4.Parent = Frame_6
ImageLabel_4.Active = true
ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_4.BackgroundTransparency = 1.000
ImageLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_4.BorderSizePixel = 0
ImageLabel_4.Position = UDim2.new(-0.0580900423, 0, -0.224999994, 0)
ImageLabel_4.Size = UDim2.new(0, 171, 0, 164)
ImageLabel_4.Image = "rbxassetid://75143674487546"

TextButton_2.Parent = Frame_6
TextButton_2.BackgroundColor3 = Color3.fromRGB(73, 225, 255)
TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.BorderSizePixel = 0
TextButton_2.Position = UDim2.new(0.13454546, 0, 1.26666665, 0)
TextButton_2.Size = UDim2.new(0, 200, 0, 50)
TextButton_2.Font = Enum.Font.LuckiestGuy
TextButton_2.Text = "COMBINE"
TextButton_2.TextColor3 = Color3.fromRGB(255, 0, 0)
TextButton_2.TextSize = 27.000

UICorner_3.Parent = TextButton_2

TextLabel_5.Parent = ScrollingFrame
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 170, 127)
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.0372334793, 0, 0.410608232, 0)
TextLabel_5.Size = UDim2.new(0, 304, 0, 76)
TextLabel_5.Font = Enum.Font.Unknown
TextLabel_5.Text = "To Obtain combination points you need to wait every 5 minutes for an EAGLE  to fly, find it around the MAP"
TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.TextSize = 11.000
TextLabel_5.TextWrapped = true

UICorner_4.Parent = TextLabel_5

-- Scripts:

local function NFTPIFV_fake_script() -- Timer.RealTimeCountdownTimer 
	local script = Instance.new('LocalScript', Timer)

	local timerLabel = script.Parent
	local totalTime = 3600 -- 1 hour in seconds
	
	while totalTime > 0 do
	    local hours = math.floor(totalTime / 3600)
	    local minutes = math.floor((totalTime % 3600) / 60)
	    local seconds = totalTime % 60
	
	    timerLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
	
	    task.wait(1)
	    totalTime = totalTime - 1
	end
	
	timerLabel.Text = "00:00:00" -- Timer ends
	
	
end
coroutine.wrap(NFTPIFV_fake_script)()
