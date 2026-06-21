warn("[StriaGO] Loading...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

repeat task.wait() until game:GetService("Players").LocalPlayer
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then playerGui = CoreGui end

-- ============== THEME (Polluted Hub inspired) ==============
local C = {
    bg = Color3.fromRGB(20, 20, 20),
    main = Color3.fromRGB(25, 25, 30),
    accent = Color3.fromRGB(255, 140, 50),
    accentDark = Color3.fromRGB(200, 110, 40),
    text = Color3.fromRGB(230, 230, 245),
    muted = Color3.fromRGB(140, 140, 160),
    red = Color3.fromRGB(255, 70, 70),
    green = Color3.fromRGB(80, 220, 100),
    stroke = Color3.fromRGB(45, 45, 60),
    font = Enum.Font.GothamBold,
    bubble = Color3.fromRGB(255, 140, 50),
}

-- ============== GUI (1 ScreenGui, always enabled) ==============
local gui = Instance.new("ScreenGui")
gui.Name = "StriaGO"
gui.Parent = playerGui
gui.Enabled = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 380, 0, 520)
main.Position = UDim2.new(0.5, -190, 0.5, -260)
main.BackgroundColor3 = C.bg
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
main.Visible = true
main.ClipsDescendants = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

-- === GRADIENT BACKGROUND (Polluted Hub style) ===
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 25, 15)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 20, 18)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 25, 15)),
})
bgGradient.Rotation = 45
bgGradient.Parent = main

-- === TOXIC OVERLAY (animated bubbles effect) ===
local toxicOverlay = Instance.new("Frame")
toxicOverlay.Size = UDim2.new(1, 0, 1, 0)
toxicOverlay.BackgroundTransparency = 0.85
toxicOverlay.BackgroundColor3 = C.accent
toxicOverlay.ClipsDescendants = true
toxicOverlay.Parent = main

local toxicCorner = Instance.new("UICorner")
toxicCorner.CornerRadius = UDim.new(0, 12)
toxicCorner.Parent = toxicOverlay

local toxicGradient = Instance.new("UIGradient")
toxicGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(0.2, 0.9),
    NumberSequenceKeypoint.new(0.4, 0.95),
    NumberSequenceKeypoint.new(0.6, 0.9),
    NumberSequenceKeypoint.new(0.8, 0.88),
    NumberSequenceKeypoint.new(1, 0.92),
})
toxicGradient.Rotation = 90
toxicGradient.Parent = toxicOverlay

-- Animate toxic gradient rotation
task.spawn(function()
    while gui.Parent do
        TweenService:Create(toxicGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {Rotation = toxicGradient.Rotation + 360}):Play()
        task.wait(3)
    end
end)

-- === SHADOW / GLOW (like Polluted Hub) ===
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1.1, 0, 1.1, 0)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://7912134082"
shadow.ImageColor3 = C.accent
shadow.ImageTransparency = 0.85
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(80, 80, 80, 80)
shadow.ZIndex = -1
shadow.Parent = main

-- === TITLE BAR ===
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Accent line under title
local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 1, 0)
accentLine.BackgroundColor3 = C.accent
accentLine.BorderSizePixel = 0
accentLine.Parent = titleBar

-- Logo/brand
local brandIcon = Instance.new("TextLabel")
brandIcon.Size = UDim2.new(0, 22, 0, 22)
brandIcon.Position = UDim2.new(0, 10, 0.5, -11)
brandIcon.BackgroundTransparency = 1
brandIcon.Font = C.font
brandIcon.Text = "S"
brandIcon.TextColor3 = C.accent
brandIcon.TextSize = 18
brandIcon.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -90, 1, 0)
titleLabel.Position = UDim2.new(0, 36, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = C.font
titleLabel.Text = "StriaGO  |  Build A Ring Farm"
titleLabel.TextColor3 = C.text
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
closeBtn.Text = "X"
closeBtn.TextColor3 = C.muted
closeBtn.TextSize = 13
closeBtn.Font = C.font
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() main.Visible = false end)

-- === SCROLL AREA ===
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -48)
scroll.Position = UDim2.new(0, 5, 0, 43)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = C.accent
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = scroll

Instance.new("UIPadding", scroll).PaddingTop = UDim.new(0, 4)

pcall(function()
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
end)

-- === OPEN BUTTON (always visible bottom-left) ===
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 145, 0, 32)
openBtn.Position = UDim2.new(0, 10, 1, -42)
openBtn.BackgroundColor3 = C.accent
openBtn.Text = "StriaGO [RShift]"
openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
openBtn.TextSize = 12
openBtn.Font = C.font
openBtn.BorderSizePixel = 0
openBtn.Parent = gui

Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)
openBtn.MouseButton1Click:Connect(function() main.Visible = true end)

-- === RIGHT SHIFT TOGGLE ===
local uiInput = UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

-- ============== UI COMPONENTS ==============
local Settings = {}

local function CreateLabel(text, isHeader)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, isHeader and 26 or 20)
    label.BackgroundTransparency = 1
    label.Font = C.font
    label.Text = text
    label.TextColor3 = isHeader and C.accent or C.muted
    label.TextSize = isHeader and 16 or 12
    label.Parent = scroll
    return label
end

local function CreateToggle(text, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 34)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    container.BorderSizePixel = 0
    container.Parent = scroll

    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -55, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = C.font
    label.Text = text
    label.TextColor3 = C.text
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 40, 0, 22)
    toggleFrame.Position = UDim2.new(1, -48, 0.5, -11)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = container

    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 11)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    knob.BorderSizePixel = 0
    knob.Parent = toggleFrame

    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 9)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container

    local state = default or false

    local function updateVisual()
        toggleFrame.BackgroundColor3 = state and C.accent or Color3.fromRGB(40, 40, 45)
        knob.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        knob.Position = state and UDim2.new(0, 20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    end
    updateVisual()

    btn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        Settings[text] = state
    end)

    return function() return state end
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = C.accent
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 13
    btn.Font = C.font
    btn.BorderSizePixel = 0
    btn.Parent = scroll

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function() pcall(callback) end)

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
local codeBtn = CreateButton("Redeem All Codes", function()
    local codes = {"BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3", "2KLIKES", "UPDATE1", "100KVISITS", "RELEASE", "SORRY", "1MVISITS"}
    for _, code in ipairs(codes) do
        pcall(function()
            local r = game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true)
            if r then r:InvokeServer(code) end
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
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(remotes, obj)
        end
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
                    if r:IsA("RemoteEvent") then r:FireServer(unpack(args))
                    else r:InvokeServer(unpack(args)) end
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

-- ============== WORKSPACE SCANNER ==============
local scanCache = {}
local scanTime = 0

local function scan()
    local now = tick()
    if now - scanTime < 1.5 then return scanCache end
    scanTime = now

    local r = {harvest = {}, sell = {}, collect = {}, plots = {}, high = {}, pets = {}, events = {}}

    for _, v in ipairs(workspace:GetDescendants()) do
        local ok, name, isPart, isModel = pcall(function()
            return v.Name:lower(), v:IsA("BasePart"), v:IsA("Model")
        end)
        if not ok then break end

        if isPart or isModel then
            -- Harvest (has BillboardGui or keyword)
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
            -- Sell/Shop
            if name:find("sell",1,true) or name:find("shop",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.sell, p) end
            end
            -- Collection/Dropoff
            if name:find("dropoff",1,true) or name:find("collection",1,true) or (name:find("collect",1,true) and not name:find("collectible",1,true)) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.collect, p) end
            end
            -- Plots/Rings
            if name:find("plot",1,true) or name:find("ring",1,true) or name:find("soil",1,true) or name:find("pot",1,true) or name:find("planter",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.plots, p) end
            end
            -- High tier
            if name:find("celestial",1,true) or name:find("eternal",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.high, p) end
            end
        end

        -- Event values
        if v:IsA("BoolValue") or v:IsA("StringValue") then
            local active = false
            if v:IsA("BoolValue") then active = v.Value
            elseif v:IsA("StringValue") then active = v.Value ~= "" and v.Value:lower() ~= "none"
            end
            if active then
                for _, e in ipairs({"rain","galaxy","ufo","beeswarm","plantrush","adminabuse","carnival","summerfuse","jackpot","celestial"}) do
                    if name:find(e,1,true) then r.events[e] = true; break end
                end
            end
        end
    end

    -- Event via GUI text fallback
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

    scanCache = r
    return r
end

-- ============== ACTIONS ==============
local function interact(part)
    if not part then return end
    local hrp = getHRP()
    if not hrp then return end
    local pos = pcall(function() return part.Position end) and part.Position or (pcall(function() return part:GetPivot().Position end) and part:GetPivot().Position)
    if not pos then return end
    if (hrp.Position - pos).Magnitude > 25 then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 5))
        task.wait(0.2)
    end
    fireAll({"interact", "collect", "harvest", "claim", "click"}, part)
end

local function doHarvest()
    local data = scan()
    if #data.harvest > 0 then
        updateStatus("Harvest " .. #data.harvest)
        for _, p in ipairs(data.harvest) do interact(p); task.wait(0.12) end
    end
end

local function doCollect()
    local data = scan()
    if #data.collect > 0 then
        for _, p in ipairs(data.collect) do interact(p); task.wait(0.15) end
    end
end

local function doSell()
    local data = scan()
    if #data.sell > 0 then
        updateStatus("Selling")
        for _, p in ipairs(data.sell) do
            interact(p)
            task.wait(0.15)
            fireAll({"sell", "sellall", "collectall"}, "all")
            fireAll({"sell", "sellall", "collectall"})
        end
    end
end

local function doPlant()
    fireAll({"plant", "plantseed", "buyseed", "purchase"}, "1")
    fireAll({"plant", "plantseed", "buyseed", "purchase"})
    local data = scan()
    if Settings["Auto Replant"] then
        for _, p in ipairs(data.high) do interact(p); task.wait(0.15) end
    end
    for _, p in ipairs(data.plots) do interact(p); task.wait(0.15) end
end

local function doUpgrade()
    updateStatus("Upgrading")
    for _, n in ipairs({"SeedLuck", "SawYield", "SprinklerPower", "SawRange", "SprinklerRange", "CelestialRoll", "EternalRoll", "JackpotRoll", "LuckyCloverRoll"}) do
        fireAll({"upgrade", "buy", "purchase"}, n)
        task.wait(0.05)
    end
end

local function doPets()
    local data = scan()
    if #data.pets > 0 then
        updateStatus("Pets")
        for _, p in ipairs(data.pets) do interact(p); task.wait(0.15) end
    end
end

local function doEvents()
    local data = scan()
    local active = {}
    for evt, _ in pairs(data.events) do
        table.insert(active, evt)
        if Settings["Auto Event Claim"] then
            fireAll({"claim", "eventclaim", "collectevent"}, evt)
        end
    end
    updateEvent(#active > 0 and "Active: " .. table.concat(active, ", ") or "None")
end

-- ============== AUTO CODES ==============
task.spawn(function()
    task.wait(3)
    pcall(function()
        local codes = {"BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3", "2KLIKES", "UPDATE1", "100KVISITS", "RELEASE", "SORRY", "1MVISITS"}
        for _, code in ipairs(codes) do
            pcall(function()
                local r = game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true)
                if r then r:InvokeServer(code) else fireAll({"redeem", "code", "claimcode"}, code) end
            end)
            task.wait(0.3)
        end
    end)
    updateStatus("Codes done")
end)

-- ============== MAIN LOOPS ==============
task.spawn(function()
    while gui.Parent do
        task.wait(1.5)
        if Settings["Auto Harvest"] then pcall(doHarvest) end
        if Settings["Auto Collect"] then pcall(doCollect) end
        updateStatus("Active")
    end
end)

task.spawn(function()
    while gui.Parent do
        task.wait(2)
        if Settings["Auto Sell"] then pcall(doSell) end
        if Settings["Auto Plant"] then pcall(doPlant) end
        if Settings["Auto Upgrade"] then pcall(doUpgrade) end
        if Settings["Auto Pet Collect"] then pcall(doPets) end
        if Settings["Event Detection"] then pcall(doEvents) end
    end
end)

-- ============== ACTIVATE ==============
updateStatus("Ready")
updateEvent("None")
warn("[StriaGO] Loaded! Press RightShift to toggle")