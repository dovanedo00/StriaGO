-- StriaGO - Build A Ring Farm Auto Farm
-- Loader + GUI theme amber, search bar, toggle dinamis

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
-- WARNA AMBER
-- ====================================================================
local AMBER = Color3.fromRGB(255, 140, 50)
local AMBER_DARK = Color3.fromRGB(80, 40, 0)
local AMBER_MID = Color3.fromRGB(60, 30, 0)
local AMBER_DEEP = Color3.fromRGB(40, 20, 0)
local AMBER_SHADOW = Color3.fromRGB(200, 100, 30)

-- ====================================================================
-- PHASE 1: LOADER ANIMATION (StriaGO branded, amber theme)
-- ====================================================================
local Loader = Instance.new("ScreenGui")
Loader.Name = "StriaGO"
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
Shadow.ImageColor3 = AMBER
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
    ColorSequenceKeypoint.new(0, AMBER_DARK),
    ColorSequenceKeypoint.new(0.5, AMBER_MID),
    ColorSequenceKeypoint.new(1, AMBER_DEEP)
})
UIGradient.Rotation = 45
UIGradient.Parent = Container

local ToxicBubbles = Instance.new("Frame")
ToxicBubbles.Size = UDim2.new(1, 0, 1, 0)
ToxicBubbles.BackgroundTransparency = 0.8
ToxicBubbles.BackgroundColor3 = AMBER
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

local LogoSize = IsMobile and UDim2.new(0, 100, 0, 100) or UDim2.new(0, 80, 0, 80)
local Logo = Instance.new("TextLabel")
Logo.Size = LogoSize
Logo.Position = UDim2.new(0.5, 0, 0.44, 0)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Font = Enum.Font.GothamBold
Logo.Text = "S"
Logo.TextColor3 = AMBER
Logo.TextSize = IsMobile and 64 or 52
Logo.TextTransparency = 1
Logo.Parent = Container

local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.ImageColor3 = AMBER
Glow.ImageTransparency = 1
Glow.Parent = Logo

local BarContainer = Instance.new("Frame")
local barSize = IsMobile and UDim2.new(0.7, 0, 0, 3) or UDim2.new(0.8, 0, 0, 2)
BarContainer.Size = barSize
BarContainer.Position = UDim2.new(0.5, 0, 0.86, 0)
BarContainer.AnchorPoint = Vector2.new(0.5, 0.5)
BarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarContainer.BackgroundTransparency = 1
BarContainer.Parent = Container

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0, 0, 1, 0)
Bar.BackgroundColor3 = AMBER
Bar.BackgroundTransparency = 1
Bar.Parent = BarContainer

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 0, 20)
LoadingText.Position = UDim2.new(0, 0, IsMobile and 0.74 or 0.72, 0)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Text = "StriaGO"
LoadingText.TextColor3 = AMBER
LoadingText.TextSize = IsMobile and 18 or 16
LoadingText.BackgroundTransparency = 1
LoadingText.TextTransparency = 1
LoadingText.Parent = Container

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
        TextTransparency = 0
    }):Play()

    TweenService:Create(Glow, TweenInfo.new(1), {
        ImageTransparency = 0.8
    }):Play()

    TweenService:Create(LoadingText, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
        TextTransparency = 0
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
        TextTransparency = 1
    }):Play()

    TweenService:Create(Glow, TweenInfo.new(0.6), {
        ImageTransparency = 1
    }):Play()

    TweenService:Create(LoadingText, TweenInfo.new(0.5), {
        TextTransparency = 1
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
-- PHASE 2: AUTO-FARM GUI (amber theme, search bar, dynamic toggles)
-- ====================================================================
local gui = Instance.new("ScreenGui")
gui.Name = "StriaGO"
gui.Parent = playerGui
gui.Enabled = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local W, H = 340, 480

local Shadow2 = Instance.new("ImageLabel")
Shadow2.Size = UDim2.new(0, W + 40, 0, H + 40)
Shadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow2.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow2.BackgroundTransparency = 1
Shadow2.Image = "rbxassetid://7912134082"
Shadow2.ImageColor3 = AMBER
Shadow2.ImageTransparency = 0.5
Shadow2.ScaleType = Enum.ScaleType.Slice
Shadow2.SliceCenter = Rect.new(80, 80, 80, 80)
Shadow2.Parent = gui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local UIc2 = Instance.new("UICorner")
UIc2.CornerRadius = UDim.new(0, 12)
UIc2.Parent = main

local Grad2 = Instance.new("UIGradient")
Grad2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, AMBER_DARK),
    ColorSequenceKeypoint.new(0.5, AMBER_MID),
    ColorSequenceKeypoint.new(1, AMBER_DEEP)
})
Grad2.Rotation = 45
Grad2.Parent = main

local Bubbles2 = Instance.new("Frame")
Bubbles2.Size = UDim2.new(1, 0, 1, 0)
Bubbles2.BackgroundTransparency = 0.8
Bubbles2.BackgroundColor3 = AMBER
Bubbles2.ClipsDescendants = true
Bubbles2.Parent = main

local BCorner2 = Instance.new("UICorner")
BCorner2.CornerRadius = UDim.new(0, 12)
BCorner2.Parent = Bubbles2

local BGrad2 = Instance.new("UIGradient")
BGrad2.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(0.1, 0.9),
    NumberSequenceKeypoint.new(0.2, 1), NumberSequenceKeypoint.new(0.3, 0.9),
    NumberSequenceKeypoint.new(0.4, 0.8), NumberSequenceKeypoint.new(0.5, 0.9),
    NumberSequenceKeypoint.new(0.6, 1), NumberSequenceKeypoint.new(0.7, 0.9),
    NumberSequenceKeypoint.new(0.8, 0.8), NumberSequenceKeypoint.new(0.9, 0.9),
    NumberSequenceKeypoint.new(1, 1)
})
BGrad2.Rotation = 90
BGrad2.Parent = Bubbles2

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Parent = main
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "StriaGO | Build A Ring Farm"
titleLabel.TextColor3 = AMBER
titleLabel.TextSize = 13
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Minimize button
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 22, 0, 22)
minBtn.Position = UDim2.new(1, -28, 0, 7)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minBtn.Text = "-"
minBtn.TextColor3 = AMBER
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 4)
minBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- Search bar
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -16, 0, 28)
searchBox.Position = UDim2.new(0, 8, 0, 40)
searchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
searchBox.BackgroundTransparency = 0.3
searchBox.BorderSizePixel = 0
searchBox.Font = Enum.Font.GothamBold
searchBox.PlaceholderText = "Search items..."
searchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
searchBox.TextSize = 11
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.Parent = main
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 6)

-- Scroll area
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -16, 0, 340)
Scroll.Position = UDim2.new(0, 8, 0, 74)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 0
Scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
Scroll.Parent = main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 3)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

local function updateCanvas()
    pcall(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, math.max(Layout.AbsoluteContentSize.Y + 4, 340))
    end)
end
pcall(function()
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
end)

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -16, 0, 18)
Status.Position = UDim2.new(0, 8, 0, 425)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.Text = "Status: Ready"
Status.TextColor3 = Color3.fromRGB(140, 140, 140)
Status.TextSize = 10
Status.Parent = main

-- Open button
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 145, 0, 28)
OpenBtn.Position = UDim2.new(0, 8, 1, -36)
OpenBtn.BackgroundColor3 = AMBER
OpenBtn.Text = "StriaGO [RShift]"
OpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.TextSize = 11
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = gui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
OpenBtn.MouseButton1Click:Connect(function() gui.Enabled = true end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then gui.Enabled = not gui.Enabled end
end)

-- Animations
task.spawn(function()
    while gui.Parent do
        TweenService:Create(BGrad2, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = BGrad2.Rotation - 360}):Play()
        task.wait(2)
    end
end)
task.spawn(function()
    while gui.Parent do
        TweenService:Create(Grad2, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = Grad2.Rotation + 360}):Play()
        task.wait(2)
    end
end)

-- ============== TOGGLE SYSTEM ==============
local AllToggles = {}
local ToggleState = {}
local ToggleWidgets = {}

local function buildToggle(text, checked, isStatic)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 26)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Visible = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -44, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    if isStatic then
        local tag = Instance.new("TextLabel")
        tag.Size = UDim2.new(0, 16, 0, 16)
        tag.Position = UDim2.new(1, -20, 0.5, -8)
        tag.BackgroundTransparency = 1
        tag.Font = Enum.Font.GothamBold
        tag.Text = "*"
        tag.TextColor3 = AMBER
        tag.TextSize = 12
        tag.Parent = frame
    end

    local tog = Instance.new("Frame")
    tog.Size = UDim2.new(0, 34, 0, 18)
    tog.Position = UDim2.new(1, -40, 0.5, -9)
    tog.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tog.BorderSizePixel = 0
    tog.Parent = frame
    Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 9)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    knob.BorderSizePixel = 0
    knob.Parent = tog
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 7)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = frame

    local state = checked
    local function upd()
        tog.BackgroundColor3 = state and AMBER or Color3.fromRGB(40, 40, 40)
        knob.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
        knob.Position = state and UDim2.new(0, 18, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    end
    upd()

    btn.MouseButton1Click:Connect(function()
        state = not state; upd(); ToggleState[text] = state
    end)
    ToggleState[text] = state

    return frame
end

-- Static toggles (always shown)
local staticLabels = {"AUTO FEATURES", "AUTO HARVEST", "AUTO COLLECT", "AUTO SELL", "AUTO PLANT", "AUTO REPLANT", "AUTO ROLL SEED", "AUTO UPGRADE", "AUTO PET COLLECT", "EVENT DETECTION", "AUTO EVENT CLAIM"}
local staticUpper = {"Auto Harvest", "Auto Collect", "Auto Sell", "Auto Plant", "Auto Replant", "Auto Roll Seed", "Auto Upgrade", "Auto Pet Collect", "Event Detection", "Auto Event Claim"}

for _, lbl in ipairs({"STRIA AUTO"}) do
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 0, 22)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.Text = lbl
    l.TextColor3 = AMBER
    l.TextSize = 13
    l.Parent = Scroll
    table.insert(AllToggles, {obj = l, name = "STRIA AUTO|" .. lbl})
end

for _, name in ipairs(staticUpper) do
    local f = buildToggle(name, true)
    f.Parent = Scroll
    table.insert(AllToggles, {obj = f, name = name:lower()})
end

-- Dynamic toggles from ReplicatedStorage (seed items)
local labelAdded = false
local function refreshDynamicItems()
    local seen = {}
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        local name = obj.Name
        local lname = name:lower()
        if not seen[lname] and #name > 1 and #name < 30 then
            local skip = false
            for _, s in ipairs({"remote", "event", "function", "script", "module", "folder", "configuration", "value", "string", "number", "bool", "color", "ray", "vector", "cframe", "udim", "rect", "region", "physics", "camera", "sound", "animation", "pose", "keyframe", "material", "texture", "part", "mesh", "accessory", "body", "hat", "tool", "shop", "gui", "screen", "frame", "label", "button", "box", "scrolling", "list", "layout", "padding", "corner", "stroke", "constraint", "attachment", "weld", "joint"}) do
                if lname:find(s, 1, true) then skip = true; break end
            end
            if not skip then
                seen[lname] = true
            end
        end
    end
    local items = {}
    for name, _ in pairs(seen) do
        table.insert(items, name)
    end
    table.sort(items)
    if #items > 0 and not labelAdded then
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -10, 0, 22)
        l.BackgroundTransparency = 1
        l.Font = Enum.Font.GothamBold
        l.Text = "ITEMS"
        l.TextColor3 = AMBER
        l.TextSize = 13
        l.Parent = Scroll
        table.insert(AllToggles, {obj = l, name = "ITEMS|" .. l.Text})
        labelAdded = true
    end
    for _, name in ipairs(items) do
        local f = buildToggle(name, false)
        f.Parent = Scroll
        table.insert(AllToggles, {obj = f, name = name})
        task.wait()
    end
    updateCanvas()
end
task.spawn(refreshDynamicItems)

-- Search filter
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBox.Text:lower()
    for _, entry in ipairs(AllToggles) do
        if query == "" then
            entry.obj.Visible = true
        else
            entry.obj.Visible = entry.name:find(query, 1, true) ~= nil
        end
    end
end)

-- ============== REMOTE HELPERS ==============
local remoteCache = {}
local lastRef = 0
local function getRemotes()
    local now = tick()
    if now - lastRef < 5 and #remoteCache > 0 then return remoteCache end
    remoteCache = {}
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then table.insert(remoteCache, v) end
    end
    lastRef = now
    return remoteCache
end

local function fireAll(patterns, ...)
    local args = {...}
    for _, r in ipairs(getRemotes()) do
        for _, p in ipairs(patterns) do
            if r.Name:lower():find(p:lower(), 1, true) then
                pcall(function()
                    if r:IsA("RemoteEvent") then r:FireServer(unpack(args)) else r:InvokeServer(unpack(args)) end
                end)
                break
            end
        end
    end
end

local function getHRP()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ============== SCANNER ==============
local sCache = {}
local sTime = 0
local function scan()
    local now = tick()
    if now - sTime < 1.5 then return sCache end
    sTime = now
    local r = {harvest={}, sell={}, collect={}, plots={}, high={}, pets={}, events={}}
    for _, v in ipairs(workspace:GetDescendants()) do
        local ok, name, isPart, isModel = pcall(function()
            return v.Name:lower(), v:IsA("BasePart"), v:IsA("Model")
        end)
        if not ok then break end
        if isPart or isModel then
            if isPart and v:FindFirstChildOfClass("BillboardGui") then
                if name:find("harvest",1,true) or name:find("collect",1,true) or name:find("produce",1,true) or name:find("crop",1,true) or name:find("box",1,true) then
                    table.insert(r.harvest, v)
                end
            end
            if isModel then
                if name:find("harvest",1,true) or name:find("produce",1,true) or name:find("crop",1,true) or name:find("crate",1,true) then
                    local p = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                    if p then table.insert(r.harvest, p) end
                end
                if name:find("pet",1,true) or name:find("egg",1,true) then
                    local p = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                    if p then table.insert(r.pets, p) end
                end
            end
            if name:find("sell",1,true) or name:find("shop",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.sell, p) end
            end
            if name:find("dropoff",1,true) or name:find("collection",1,true) or (name:find("collect",1,true) and not name:find("collectible",1,true)) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.collect, p) end
            end
            if name:find("plot",1,true) or name:find("ring",1,true) or name:find("soil",1,true) or name:find("pot",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.plots, p) end
            end
            if name:find("celestial",1,true) or name:find("eternal",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.high, p) end
            end
        end
        if v:IsA("BoolValue") or v:IsA("StringValue") then
            local active = false
            if v:IsA("BoolValue") then active = v.Value
            elseif v:IsA("StringValue") then active = v.Value ~= "" and v.Value:lower() ~= "none" end
            if active then
                for _, e in ipairs({"rain","galaxy","ufo","beeswarm","plantrush","adminabuse","carnival","summerfuse","jackpot"}) do
                    if name:find(e,1,true) then r.events[e] = true; break end
                end
            end
        end
    end
    if not next(r.events) then
        pcall(function()
            for _, v in ipairs(playerGui:GetDescendants()) do
                if (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Visible and v.AbsoluteSize.X > 0 then
                    local txt = v.Text:lower()
                    for _, e in ipairs({"rain","galaxy","ufo","beeswarm","plantrush","adminabuse","carnival","summerfuse","celestial"}) do
                        if txt:find(e,1,true) and not txt:find("none",1,true) then r.events[e] = true; break end
                    end
                    if next(r.events) then break end
                end
            end
        end)
    end
    sCache = r; return r
end

-- ============== ACTIONS ==============
local function interact(part)
    if not part then return end
    local hrp = getHRP()
    if not hrp then return end
    local pos = pcall(function() return part.Position end) and part.Position or nil
    if not pos then pos = pcall(function() return part:GetPivot().Position end) and part:GetPivot().Position end
    if not pos then return end
    if (hrp.Position - pos).Magnitude > 25 then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 5))
        task.wait(0.2)
    end
    fireAll({"interact", "collect", "harvest", "claim", "click"}, part)
end

local function getToggle(name)
    return ToggleState[name] or false
end

local function doHarvest()
    local data = scan()
    if #data.harvest > 0 then Status.Text = "Harvesting..." end
    for _, p in ipairs(data.harvest) do interact(p); task.wait(0.12) end
end

local function doCollect()
    local data = scan()
    for _, p in ipairs(data.collect) do interact(p); task.wait(0.15) end
end

local function doSell()
    local data = scan()
    if #data.sell > 0 then Status.Text = "Selling..."
        for _, p in ipairs(data.sell) do interact(p); task.wait(0.15)
            fireAll({"sell", "sellall", "collectall"}, "all"); fireAll({"sell", "sellall", "collectall"}) end end
end

local function doPlant()
    fireAll({"plant", "plantseed", "buyseed", "purchase"}, "1")
    fireAll({"plant", "plantseed", "buyseed", "purchase"})
    -- Plant dynamic items that are toggled on
    for name, state in pairs(ToggleState) do
        if state and name ~= "Auto Harvest" and name ~= "Auto Collect" and name ~= "Auto Sell" and name ~= "Auto Plant" and name ~= "Auto Replant" and name ~= "Auto Roll Seed" and name ~= "Auto Upgrade" and name ~= "Auto Pet Collect" and name ~= "Event Detection" and name ~= "Auto Event Claim" then
            fireAll({"plant", "plantseed", "buyseed", "select", "choose"}, name)
            task.wait(0.05)
        end
    end
    local data = scan()
    if getToggle("Auto Replant") then
        for _, p in ipairs(data.high) do interact(p); task.wait(0.15) end end
    for _, p in ipairs(data.plots) do interact(p); task.wait(0.15) end
end

local function doRollSeed()
    Status.Text = "Rolling Seed..."
    fireAll({"roll", "reroll", "seedroll", "gacha", "spin", "luck", "upgradeseed", "seed", "rerollseed"})
    fireAll({"roll", "reroll", "seedroll", "gacha", "spin", "luck", "upgradeseed", "seed", "rerollseed"}, "all")
    fireAll({"roll", "reroll", "seedroll", "gacha", "spin", "luck", "upgradeseed", "seed", "rerollseed"}, 1)
    task.wait(0.5)
end

local function doUpgrade()
    Status.Text = "Upgrading..."
    for _, n in ipairs({"SeedLuck","SawYield","SprinklerPower","SawRange","SprinklerRange","CelestialRoll","EternalRoll","JackpotRoll","LuckyCloverRoll"}) do
        fireAll({"upgrade", "buy", "purchase"}, n); task.wait(0.05) end
end

local function doPets()
    local data = scan()
    if #data.pets > 0 then Status.Text = "Pets"
        for _, p in ipairs(data.pets) do interact(p); task.wait(0.15) end end
end

local function doEvents()
    local data = scan()
    for evt, _ in pairs(data.events) do
        if getToggle("Auto Event Claim") then fireAll({"claim", "eventclaim", "collectevent"}, evt) end end
end

-- Auto codes
task.spawn(function()
    task.wait(3)
    pcall(function()
        for _, code in ipairs({"BZZBZZ","CARNIVAL","UPDATE5","250KUSERS","PLANTRUSH","UPDATE2","THANKYOU","BARF:3","2KLIKES","UPDATE1","100KVISITS","RELEASE","SORRY","1MVISITS"}) do
            pcall(function()
                local r = ReplicatedStorage:FindFirstChild("RedeemCode", true)
                if r then r:InvokeServer(code) else fireAll({"redeem","code","claimcode"}, code) end
            end)
            task.wait(0.3)
        end
    end)
    Status.Text = "Codes redeemed"
end)

-- Main loops
task.spawn(function()
    while gui.Parent do task.wait(1.5)
        if getToggle("Auto Harvest") then pcall(doHarvest) end
        if getToggle("Auto Collect") then pcall(doCollect) end
        Status.Text = "Active" end end)

task.spawn(function()
    while gui.Parent do task.wait(2)
        if getToggle("Auto Sell") then pcall(doSell) end
        if getToggle("Auto Plant") then pcall(doPlant) end
        if getToggle("Auto Roll Seed") then pcall(doRollSeed) end
        if getToggle("Auto Upgrade") then pcall(doUpgrade) end
        if getToggle("Auto Pet Collect") then pcall(doPets) end
        if getToggle("Event Detection") then pcall(doEvents) end end end)

Status.Text = "Ready"
