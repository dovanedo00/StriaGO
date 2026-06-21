-- StriaGO - Build A Ring Farm Auto Farm
-- Loader appearance: identik Polluted Hub
-- Logic: dari script spesifik Build A Ring Farm (komtolmmek2)

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

repeat task.wait() until Players.LocalPlayer
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then playerGui = CoreGui end

local IsMobile = UserInputService.TouchEnabled
local ContainerSize = IsMobile and
    (workspace.CurrentCamera.ViewportSize.Y > workspace.CurrentCamera.ViewportSize.X
        and UDim2.new(0, 280, 0, 220)
        or UDim2.new(0, 260, 0, 200))
    or UDim2.new(0, 240, 0, 180)

-- ====================================================================
-- PHASE 1: EXACT POLLUTED HUB LOADER ANIMATION
-- ====================================================================
local Loader = Instance.new("ScreenGui")
Loader.Name = "PollutedLoader"
Loader.Parent = playerGui
Loader.Enabled = true
Loader.ResetOnSpawn = false
Loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(0, ContainerSize.X.Offset + 40, 0, ContainerSize.Y.Offset + 40)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.ImageTransparency = 1
Shadow.Image = "rbxassetid://7912134082"
Shadow.ImageColor3 = Color3.fromRGB(0, 255, 0)
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(80, 80, 80, 80)
Shadow.Parent = Loader

local Container = Instance.new("Frame")
Container.Size = ContainerSize
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.AnchorPoint = Vector2.new(0.5, 0.5)
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Container.BorderSizePixel = 0
Container.Parent = Loader

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Container

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 183, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(33, 125, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 83, 0))
})
UIGradient.Rotation = 45
UIGradient.Parent = Container

local ToxicBubbles = Instance.new("Frame")
ToxicBubbles.Size = UDim2.new(1, 0, 1, 0)
ToxicBubbles.BackgroundTransparency = 0.8
ToxicBubbles.BackgroundColor3 = Color3.fromRGB(144, 255, 96)
ToxicBubbles.ClipsDescendants = true
ToxicBubbles.Parent = Container

local BubbleCorner = Instance.new("UICorner")
BubbleCorner.CornerRadius = UDim.new(0, 12)
BubbleCorner.Parent = ToxicBubbles

local BubbleGradient = Instance.new("UIGradient")
BubbleGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.8),
    NumberSequenceKeypoint.new(0.1, 0.9),
    NumberSequenceKeypoint.new(0.2, 1),
    NumberSequenceKeypoint.new(0.3, 0.9),
    NumberSequenceKeypoint.new(0.4, 0.8),
    NumberSequenceKeypoint.new(0.5, 0.9),
    NumberSequenceKeypoint.new(0.6, 1),
    NumberSequenceKeypoint.new(0.7, 0.9),
    NumberSequenceKeypoint.new(0.8, 0.8),
    NumberSequenceKeypoint.new(0.9, 0.9),
    NumberSequenceKeypoint.new(1, 1)
})
BubbleGradient.Rotation = 90
BubbleGradient.Parent = ToxicBubbles

local LogoSize = IsMobile and UDim2.new(0, 140, 0, 140) or UDim2.new(0, 120, 0, 120)
local Logo = Instance.new("ImageLabel")
Logo.Size = LogoSize
Logo.Position = UDim2.new(0.48, 0, 0.47, 0)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://130082951267456"
Logo.ImageColor3 = Color3.fromRGB(144, 255, 96)
Logo.ImageTransparency = 1
Logo.Parent = Container

local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.ImageColor3 = Color3.fromRGB(144, 255, 96)
Glow.ImageTransparency = 1
Glow.Parent = Logo

local BarContainer = Instance.new("Frame")
local barSize = IsMobile and UDim2.new(0.7, 0, 0, 3) or UDim2.new(0.8, 0, 0, 2)
BarContainer.Size = barSize
BarContainer.Position = UDim2.new(0.5, 0, 0.9, 0)
BarContainer.AnchorPoint = Vector2.new(0.5, 0.5)
BarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarContainer.BackgroundTransparency = 1
BarContainer.Parent = Container

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0, 0, 1, 0)
Bar.BackgroundColor3 = Color3.fromRGB(144, 255, 96)
Bar.BackgroundTransparency = 1
Bar.Parent = BarContainer

local function playIntro()
    Container.Size = UDim2.new(0, ContainerSize.X.Offset - 20, 0, ContainerSize.Y.Offset - 20)
    Container.BackgroundTransparency = 1
    Shadow.ImageTransparency = 1

    TweenService:Create(Shadow, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
        ImageTransparency = 0.5
    }):Play()

    TweenService:Create(Container, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
        Size = ContainerSize,
        BackgroundTransparency = 0
    }):Play()

    local logoStartSize = UDim2.new(0, LogoSize.X.Offset - 20, 0, LogoSize.Y.Offset - 20)
    Logo.Size = logoStartSize

    TweenService:Create(Logo, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
        Size = LogoSize,
        ImageTransparency = 0
    }):Play()

    TweenService:Create(Glow, TweenInfo.new(1), {
        ImageTransparency = 0.8
    }):Play()

    TweenService:Create(Bar, TweenInfo.new(0.7), {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()

    spawn(function()
        while Loader.Parent do
            TweenService:Create(BubbleGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Rotation = BubbleGradient.Rotation - 360
            }):Play()
            wait(2)
        end
    end)

    spawn(function()
        while Loader.Parent do
            TweenService:Create(UIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Rotation = UIGradient.Rotation + 360
            }):Play()
            wait(2)
        end
    end)
end

local function playOutro()
    TweenService:Create(Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        ImageTransparency = 1
    }):Play()

    TweenService:Create(Container, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, ContainerSize.X.Offset - 20, 0, ContainerSize.Y.Offset - 20),
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Logo, TweenInfo.new(0.6), {
        Size = UDim2.new(0, LogoSize.X.Offset - 20, 0, LogoSize.Y.Offset - 20),
        ImageTransparency = 1
    }):Play()

    TweenService:Create(Glow, TweenInfo.new(0.6), {
        ImageTransparency = 1
    }):Play()

    TweenService:Create(Bar, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()

    task.wait(0.7)
    Loader:Destroy()
end

playIntro()
task.wait(2)
playOutro()
task.wait(0.7)

-- ====================================================================
-- PHASE 2: LOAD WORKING GAME SCRIPT (dari komtolmmek2)
-- ====================================================================
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LynX99-9/komtolmmek2/refs/heads/main/Build%20a%20Ring%20farm"))()
end)

if not success then
    warn("[StriaGO] Gagal load script: " .. tostring(err))
    -- Fallback: load Universal dari Zephyr
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/Universal.lua"))()
end
