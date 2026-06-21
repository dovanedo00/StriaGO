local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

repeat task.wait() until game:GetService("Players").LocalPlayer
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then playerGui = CoreGui end

-- ============== WARNA HIJAU POLLUTED HUB ==============
local GREEN = Color3.fromRGB(144, 255, 96)
local GREEN_DARK = Color3.fromRGB(48, 183, 0)
local GREEN_MID = Color3.fromRGB(33, 125, 0)
local GREEN_DEEP = Color3.fromRGB(22, 83, 0)
local IsMobile = UserInputService.TouchEnabled

-- Container lebih tinggi dari loader asli supaya muat toggle
local W, H = 280, 320
local ContainerSize = UDim2.new(0, W, 0, H)

local gui = Instance.new("ScreenGui")
gui.Name = "StriaGO"
gui.Parent = playerGui
gui.Enabled = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- SHADOW (identik Polluted Hub - hijau)
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(0, W + 40, 0, H + 40)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://7912134082"
Shadow.ImageColor3 = GREEN
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(80, 80, 80, 80)
Shadow.Parent = gui

-- CONTAINER (identik)
local Container = Instance.new("Frame")
Container.Size = ContainerSize
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.AnchorPoint = Vector2.new(0.5, 0.5)
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Container.BorderSizePixel = 0
Container.ClipsDescendants = true
Container.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Container

-- GRADIENT BACKGROUND (identik - hijau)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, GREEN_DARK),
    ColorSequenceKeypoint.new(0.5, GREEN_MID),
    ColorSequenceKeypoint.new(1, GREEN_DEEP)
})
UIGradient.Rotation = 45
UIGradient.Parent = Container

-- TOXIC BUBBLES (identik)
local ToxicBubbles = Instance.new("Frame")
ToxicBubbles.Size = UDim2.new(1, 0, 1, 0)
ToxicBubbles.BackgroundTransparency = 0.8
ToxicBubbles.BackgroundColor3 = GREEN
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

-- LOGO (identik Polluted Hub - pakai teks karena rbxasset mungkin 404)
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 60, 0, 60)
Logo.Position = UDim2.new(0.5, 0, 0.2, 0)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Font = Enum.Font.GothamBold
Logo.Text = "S"
Logo.TextColor3 = GREEN
Logo.TextSize = 44
Logo.Parent = Container

-- GLOW LOGO
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(0, 90, 0, 90)
Glow.Position = UDim2.new(0.5, 0, 0.2, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.ImageColor3 = GREEN
Glow.ImageTransparency = 0.7
Glow.Parent = Container

-- TITLE
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 22)
TitleLabel.Position = UDim2.new(0, 0, 0, 82)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "StriaGO"
TitleLabel.TextColor3 = GREEN
TitleLabel.TextSize = 16
TitleLabel.Parent = Container

-- ============== SCROLL AREA UNTUK TOGGLE (di bawah logo) ==============
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -16, 0, 170)
Scroll.Position = UDim2.new(0, 8, 0, 110)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 0
Scroll.CanvasSize = UDim2.new(0, 0, 0, 340)
Scroll.Parent = Container

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 3)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

pcall(function()
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, math.max(Layout.AbsoluteContentSize.Y + 4, 170))
    end)
end)

-- ============== TOGGLE COMPONENT ==============
local Settings = {}

local function CreateToggle(text, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 26)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.Parent = Scroll

    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -44, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 34, 0, 18)
    toggle.Position = UDim2.new(1, -40, 0.5, -9)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggle.BorderSizePixel = 0
    toggle.Parent = container

    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 9)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 7)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container

    local state = default or false
    local function update()
        toggle.BackgroundColor3 = state and GREEN or Color3.fromRGB(40, 40, 40)
        knob.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
        knob.Position = state and UDim2.new(0, 18, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    end
    update()
    btn.MouseButton1Click:Connect(function() state = not state; update(); Settings[text] = state end)
    return function() return state end
end

-- ============== BUILD TOGGLES ==============
CreateToggle("Auto Harvest", true)
CreateToggle("Auto Collect", true)
CreateToggle("Auto Sell", true)
CreateToggle("Auto Plant", true)
CreateToggle("Auto Replant", true)
CreateToggle("Auto Upgrade", false)
CreateToggle("Auto Pet Collect", false)
CreateToggle("Event Detection", true)
CreateToggle("Auto Event Claim", true)

-- STATUS LABEL
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -16, 0, 18)
StatusLabel.Position = UDim2.new(0, 8, 0, 288)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
StatusLabel.TextSize = 10
StatusLabel.Parent = Container

-- CLOSE BUTTON (X kecil)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -26, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(120, 120, 120)
CloseBtn.TextSize = 11
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Container

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- OPEN BUTTON (bawah kiri)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 135, 0, 28)
OpenBtn.Position = UDim2.new(0, 8, 1, -36)
OpenBtn.BackgroundColor3 = GREEN
OpenBtn.Text = "StriaGO [RShift]"
OpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.TextSize = 11
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = gui

Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
OpenBtn.MouseButton1Click:Connect(function() gui.Enabled = true end)

-- RIGHT SHIFT TOGGLE
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then gui.Enabled = not gui.Enabled end
end)

-- ANIMASI (identik Polluted Hub)
task.spawn(function()
    while gui.Parent do
        TweenService:Create(BubbleGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = BubbleGradient.Rotation - 360}):Play()
        task.wait(2)
    end
end)

task.spawn(function()
    while gui.Parent do
        TweenService:Create(UIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = UIGradient.Rotation + 360}):Play()
        task.wait(2)
    end
end)

-- ============== REMOTE HELPERS ==============
local remotes = {}
local lastRefresh = 0
local function getRemotes()
    local now = tick()
    if now - lastRefresh < 5 and #remotes > 0 then return remotes end
    remotes = {}
    for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then table.insert(remotes, obj) end
    end
    lastRefresh = now
    return remotes
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
local scanCache = {}
local scanTime = 0
local function scan()
    local now = tick()
    if now - scanTime < 1.5 then return scanCache end
    scanTime = now
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
    scanCache = r; return r
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

local function doHarvest()
    local data = scan()
    if #data.harvest > 0 then StatusLabel.Text = "Harvesting..."
        for _, p in ipairs(data.harvest) do interact(p); task.wait(0.12) end end
end
local function doCollect()
    local data = scan()
    if #data.collect > 0 then for _, p in ipairs(data.collect) do interact(p); task.wait(0.15) end end
end
local function doSell()
    local data = scan()
    if #data.sell > 0 then StatusLabel.Text = "Selling..."
        for _, p in ipairs(data.sell) do interact(p); task.wait(0.15)
            fireAll({"sell", "sellall", "collectall"}, "all"); fireAll({"sell", "sellall", "collectall"}) end end
end
local function doPlant()
    fireAll({"plant", "plantseed", "buyseed", "purchase"}, "1"); fireAll({"plant", "plantseed", "buyseed", "purchase"})
    local data = scan()
    if Settings["Auto Replant"] then for _, p in ipairs(data.high) do interact(p); task.wait(0.15) end end
    for _, p in ipairs(data.plots) do interact(p); task.wait(0.15) end
end
local function doUpgrade()
    StatusLabel.Text = "Upgrading..."
    for _, n in ipairs({"SeedLuck","SawYield","SprinklerPower","SawRange","SprinklerRange","CelestialRoll","EternalRoll","JackpotRoll","LuckyCloverRoll"}) do
        fireAll({"upgrade", "buy", "purchase"}, n); task.wait(0.05) end
end
local function doPets()
    local data = scan()
    if #data.pets > 0 then StatusLabel.Text = "Pets"
        for _, p in ipairs(data.pets) do interact(p); task.wait(0.15) end end
end
local function doEvents()
    local data = scan(); local active = {}
    for evt, _ in pairs(data.events) do
        table.insert(active, evt)
        if Settings["Auto Event Claim"] then fireAll({"claim", "eventclaim", "collectevent"}, evt) end end
end

-- ============== AUTO CODES ==============
task.spawn(function()
    task.wait(3)
    pcall(function()
        for _, code in ipairs({"BZZBZZ","CARNIVAL","UPDATE5","250KUSERS","PLANTRUSH","UPDATE2","THANKYOU","BARF:3","2KLIKES","UPDATE1","100KVISITS","RELEASE","SORRY","1MVISITS"}) do
            pcall(function()
                local r = game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true)
                if r then r:InvokeServer(code) else fireAll({"redeem","code","claimcode"}, code) end
            end)
            task.wait(0.3)
        end
    end)
    StatusLabel.Text = "Codes redeemed"
end)

-- ============== MAIN LOOPS ==============
task.spawn(function()
    while gui.Parent do task.wait(1.5)
        if Settings["Auto Harvest"] then pcall(doHarvest) end
        if Settings["Auto Collect"] then pcall(doCollect) end
        StatusLabel.Text = "Active" end end)

task.spawn(function()
    while gui.Parent do task.wait(2)
        if Settings["Auto Sell"] then pcall(doSell) end
        if Settings["Auto Plant"] then pcall(doPlant) end
        if Settings["Auto Upgrade"] then pcall(doUpgrade) end
        if Settings["Auto Pet Collect"] then pcall(doPets) end
        if Settings["Event Detection"] then pcall(doEvents) end end end)

-- ============== ACTIVATE ==============
StatusLabel.Text = "Ready"
gui.Enabled = true