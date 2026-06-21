local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

repeat task.wait() until game:GetService("Players").LocalPlayer
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then playerGui = CoreGui end

-- ============== STYLE IDENTIK POLLUTED HUB ==============
local IsMobile = UserInputService.TouchEnabled
local ContainerSize = IsMobile and UDim2.new(0, 280, 0, 420) or UDim2.new(0, 340, 0, 450)

local gui = Instance.new("ScreenGui")
gui.Name = "StriaGO"
gui.Parent = playerGui
gui.Enabled = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- SHADOW (identik Polluted Hub)
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(0, ContainerSize.X.Offset + 40, 0, ContainerSize.Y.Offset + 40)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://7912134082"
Shadow.ImageColor3 = Color3.fromRGB(255, 140, 50)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(80, 80, 80, 80)
Shadow.Parent = gui

-- CONTAINER (identik Polluted Hub)
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

-- GRADIENT BACKGROUND (identik Polluted Hub - warna orange)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 110, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 80, 25))
})
UIGradient.Rotation = 45
UIGradient.Parent = Container

-- TOXIC BUBBLES (identik Polluted Hub)
local ToxicBubbles = Instance.new("Frame")
ToxicBubbles.Size = UDim2.new(1, 0, 1, 0)
ToxicBubbles.BackgroundTransparency = 0.8
ToxicBubbles.BackgroundColor3 = Color3.fromRGB(255, 140, 50)
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

-- TITLE AREA (StriaGO branding di atas)
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 35)
TitleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleFrame.BackgroundTransparency = 0.3
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = Container

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "StriaGO  |  Build A Ring Farm"
TitleLabel.TextColor3 = Color3.fromRGB(255, 140, 50)
TitleLabel.TextSize = IsMobile and 16 or 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleFrame

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleFrame

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- SCROLL AREA (untuk toggle)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -45)
Scroll.Position = UDim2.new(0, 5, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 50)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
Scroll.Parent = Container

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

Instance.new("UIPadding", Scroll).PaddingTop = UDim.new(0, 4)

pcall(function()
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
end)

-- OPEN BUTTON (selalu visible)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 145, 0, 32)
OpenBtn.Position = UDim2.new(0, 10, 1, -42)
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 50)
OpenBtn.Text = "StriaGO [RShift]"
OpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = gui

Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
OpenBtn.MouseButton1Click:Connect(function() gui.Enabled = true end)

-- RIGHT SHIFT TOGGLE
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        gui.Enabled = not gui.Enabled
    end
end)

-- ANIMASI BUBBLE GRADIENT (identik Polluted Hub)
task.spawn(function()
    while gui.Parent do
        TweenService:Create(BubbleGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Rotation = BubbleGradient.Rotation - 360
        }):Play()
        task.wait(2)
    end
end)

-- ANIMASI BACKGROUND GRADIENT (identik Polluted Hub)
task.spawn(function()
    while gui.Parent do
        TweenService:Create(UIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Rotation = UIGradient.Rotation + 360
        }):Play()
        task.wait(2)
    end
end)

-- ============== UI COMPONENTS ==============
local Settings = {}

local function CreateLabel(text, isHeader)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, isHeader and 24 or 18)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = isHeader and Color3.fromRGB(255, 140, 50) or Color3.fromRGB(140, 140, 160)
    label.TextSize = isHeader and 15 or 11
    label.Parent = Scroll
    return label
end

local function CreateToggle(text, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 32)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    container.BackgroundTransparency = 0.2
    container.BorderSizePixel = 0
    container.Parent = Scroll

    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 245)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 36, 0, 20)
    toggle.Position = UDim2.new(1, -44, 0.5, -10)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    toggle.BorderSizePixel = 0
    toggle.Parent = container

    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 8)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container

    local state = default or false
    local function update()
        toggle.BackgroundColor3 = state and Color3.fromRGB(255, 140, 50) or Color3.fromRGB(40, 40, 45)
        knob.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        knob.Position = state and UDim2.new(0, 18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    end
    update()
    btn.MouseButton1Click:Connect(function() state = not state; update(); Settings[text] = state end)
    return function() return state end
end

local function CreateButton(text, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(255, 140, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = Scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() pcall(cb) end)
    return btn
end

-- ============== BUILD UI ==============
CreateLabel("AUTO FARM", true)
local T = {}
T["Auto Harvest"] = CreateToggle("Auto Harvest", true)
T["Auto Collect"] = CreateToggle("Auto Collect", true)
T["Auto Sell"] = CreateToggle("Auto Sell", true)
T["Auto Plant"] = CreateToggle("Auto Plant", true)
T["Auto Replant"] = CreateToggle("Auto Replant", true)
T["Auto Upgrade"] = CreateToggle("Auto Upgrade", false)
T["Auto Pet Collect"] = CreateToggle("Auto Pet Collect", false)

CreateLabel("EVENTS", true)
T["Event Detection"] = CreateToggle("Event Detection", true)
T["Auto Event Claim"] = CreateToggle("Auto Event Claim", true)

CreateLabel("CODES", true)
CreateButton("Redeem All Codes", function()
    for _, code in ipairs({"BZZBZZ","CARNIVAL","UPDATE5","250KUSERS","PLANTRUSH","UPDATE2","THANKYOU","BARF:3","2KLIKES","UPDATE1","100KVISITS","RELEASE","SORRY","1MVISITS"}) do
        pcall(function()
            local r = game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true)
            if r then r:InvokeServer(code) else fireAll({"redeem","code","claimcode"}, code) end
        end)
        task.wait(0.3)
    end
end)

CreateLabel("", true)
local statusLabel = CreateLabel("Status: Ready")
local eventLabel = CreateLabel("Event: None")

-- ============== HELPERS ==============
local function updateStatus(s) statusLabel.Text = "Status: " .. s end
local function updateEvent(s) eventLabel.Text = "Event: " .. s end

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
    if #data.harvest > 0 then updateStatus("Harvest " .. #data.harvest)
        for _, p in ipairs(data.harvest) do interact(p); task.wait(0.12) end end
end
local function doCollect()
    local data = scan()
    if #data.collect > 0 then for _, p in ipairs(data.collect) do interact(p); task.wait(0.15) end end
end
local function doSell()
    local data = scan()
    if #data.sell > 0 then updateStatus("Selling")
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
    updateStatus("Upgrading")
    for _, n in ipairs({"SeedLuck","SawYield","SprinklerPower","SawRange","SprinklerRange","CelestialRoll","EternalRoll","JackpotRoll","LuckyCloverRoll"}) do
        fireAll({"upgrade", "buy", "purchase"}, n); task.wait(0.05) end
end
local function doPets()
    local data = scan()
    if #data.pets > 0 then updateStatus("Pets")
        for _, p in ipairs(data.pets) do interact(p); task.wait(0.15) end end
end
local function doEvents()
    local data = scan(); local active = {}
    for evt, _ in pairs(data.events) do
        table.insert(active, evt)
        if Settings["Auto Event Claim"] then fireAll({"claim", "eventclaim", "collectevent"}, evt) end end
    updateEvent(#active > 0 and "Active: " .. table.concat(active, ", ") or "None")
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
    updateStatus("Codes done")
end)

-- ============== MAIN LOOPS ==============
task.spawn(function()
    while gui.Parent do task.wait(1.5)
        if Settings["Auto Harvest"] then pcall(doHarvest) end
        if Settings["Auto Collect"] then pcall(doCollect) end
        updateStatus("Active") end end)

task.spawn(function()
    while gui.Parent do task.wait(2)
        if Settings["Auto Sell"] then pcall(doSell) end
        if Settings["Auto Plant"] then pcall(doPlant) end
        if Settings["Auto Upgrade"] then pcall(doUpgrade) end
        if Settings["Auto Pet Collect"] then pcall(doPets) end
        if Settings["Event Detection"] then pcall(doEvents) end end end)

-- ============== ACTIVATE ==============
updateStatus("Ready"); updateEvent("None")
warn("[StriaGO] Loaded - tampilan identik Polluted Hub")