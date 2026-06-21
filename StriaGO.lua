local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local IsMobile = UserInputService.TouchEnabled

local Lib = {}
local customTheme = {
    Main = Color3.fromRGB(18, 18, 25),
    Second = Color3.fromRGB(28, 28, 40),
    Accent = Color3.fromRGB(255, 140, 50),
    Text = Color3.fromRGB(230, 230, 245),
    Red = Color3.fromRGB(255, 70, 70),
    Blue = Color3.fromRGB(70, 130, 255),
    Stroke = Color3.fromRGB(45, 45, 60),
    Font = Enum.Font.GothamBold,
    TextSize = IsMobile and 16 or 14,
}

do
    local gui = Instance.new("ScreenGui")
    gui.Name = "StriaGO"
    gui.Parent = CoreGui
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Enabled = false

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 380, 0, 500)
    main.Position = UDim2.new(0.5, -190, 0.5, -250)
    main.BackgroundColor3 = customTheme.Main
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = main

    local stroke = Instance.new("UIStroke")
    stroke.Color = customTheme.Stroke
    stroke.Thickness = 1
    stroke.Parent = main

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = customTheme.Second
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = customTheme.Stroke
    titleStroke.Thickness = 1
    titleStroke.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = customTheme.Font
    titleLabel.Text = "StriaGO | Build A Ring Farm"
    titleLabel.TextColor3 = customTheme.Accent
    titleLabel.TextSize = customTheme.TextSize
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundColor3 = customTheme.Red
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14
    closeBtn.Font = customTheme.Font
    closeBtn.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -45)
    scroll.Position = UDim2.new(0, 5, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = customTheme.Accent
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 4)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scroll

    Lib.GUI = gui
    Lib.Main = main
    Lib.Scroll = scroll
    Lib.Layout = layout
    Lib.CloseBtn = closeBtn
    Lib.TitleLabel = titleLabel
    Lib.customTheme = customTheme

    closeBtn.MouseButton1Click:Connect(function()
        gui.Enabled = false
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            gui.Enabled = not gui.Enabled
        end
    end)

    local openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(0, 140, 0, 30)
    openBtn.Position = UDim2.new(0, 10, 1, -40)
    openBtn.BackgroundColor3 = customTheme.Accent
    openBtn.BackgroundTransparency = 0.2
    openBtn.Text = "StriaGO [RShift]"
    openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    openBtn.TextSize = 12
    openBtn.Font = customTheme.Font
    openBtn.Parent = gui

    local openCorner = Instance.new("UICorner")
    openCorner.CornerRadius = UDim.new(0, 6)
    openCorner.Parent = openBtn

    openBtn.MouseButton1Click:Connect(function()
        gui.Enabled = true
    end)
end

function Lib:CreateToggle(text, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 32)
    container.BackgroundColor3 = customTheme.Second
    container.BorderSizePixel = 0
    container.Parent = self.Scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = customTheme.Font
    label.Text = text
    label.TextColor3 = customTheme.Text
    label.TextSize = customTheme.TextSize - 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 36, 0, 20)
    toggle.Position = UDim2.new(1, -44, 0.5, -10)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.BorderSizePixel = 0
    toggle.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = knob

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container

    local state = default or false

    local function updateVisual()
        if state then
            toggle.BackgroundColor3 = customTheme.Accent
            knob:TweenPosition(UDim2.new(0, 18, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            knob:TweenPosition(UDim2.new(0, 2, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
    updateVisual()

    btn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        if self.OnToggle then
            self.OnToggle(text, state)
        end
    end)

    return container, function() return state end
end

function Lib:CreateLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 22)
    label.BackgroundTransparency = 1
    label.Font = customTheme.Font
    label.Text = text
    label.TextColor3 = customTheme.Accent
    label.TextSize = customTheme.TextSize + 1
    label.Parent = self.Scroll
    return label
end

function Lib:CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = customTheme.Second
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = customTheme.Text
    btn.TextSize = customTheme.TextSize - 1
    btn.Font = customTheme.Font
    btn.Parent = self.Scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn
end

Lib.GUI.Enabled = true

local Settings = {}
Lib.OnToggle = function(name, state)
    Settings[name] = state
end

local function getToggle(name)
    return Settings[name] or false
end

Lib:CreateLabel("STRIA AUTO")
Lib:CreateToggle("Auto Harvest", true)
Lib:CreateToggle("Auto Collect", true)
Lib:CreateToggle("Auto Sell", true)
Lib:CreateToggle("Auto Plant", true)
Lib:CreateToggle("Auto Replant", true)
Lib:CreateToggle("Auto Upgrade", false)
Lib:CreateToggle("Auto Pet Collect", false)
Lib:CreateLabel("EVENTS")
Lib:CreateToggle("Event Detection", true)
Lib:CreateToggle("Auto Event Claim", true)
Lib:CreateLabel("CODES REDEEM")
Lib:CreateButton("Redeem All Codes", function()
    pcall(redeemCodes)
end)
Lib:CreateLabel("INFO")
local statusLabel = Lib:CreateLabel("Status: Idle")
local eventLabel = Lib:CreateLabel("Event: None")

-- ============== CACHED REMOTES ==============
local RemoteCache = nil
local RemoteCacheTime = 0
local REMOTE_CACHE_TTL = 5

local function refreshRemoteCache()
    local now = tick()
    if RemoteCache and now - RemoteCacheTime < REMOTE_CACHE_TTL then
        return RemoteCache
    end
    RemoteCache = {}
    for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            table.insert(RemoteCache, {type = "event", obj = obj, name = obj.Name:lower()})
        elseif obj:IsA("RemoteFunction") then
            table.insert(RemoteCache, {type = "function", obj = obj, name = obj.Name:lower()})
        end
    end
    RemoteCacheTime = now
    return RemoteCache
end

local function fireRemote(namePattern, ...)
    local args = { ... }
    local pattern = type(namePattern) == "string" and namePattern:lower() or nil
    local remotes = refreshRemoteCache()
    for _, entry in ipairs(remotes) do
        if not pattern or entry.name:find(pattern, 1, true) then
            local ok, err = pcall(function()
                if entry.type == "event" then
                    entry.obj:FireServer(unpack(args))
                else
                    entry.obj:InvokeServer(unpack(args))
                end
            end)
            if not ok and err then
                warn("[StriaGO] Remote error: " .. tostring(err))
            end
        end
    end
end

-- ============== HELPERS ==============
local function updateStatus(text)
    statusLabel.Text = "Status: " .. text
end

local function updateEvent(text)
    eventLabel.Text = "Event: " .. text
end

-- Workspace scanning (throttled)
local wsScanCache = {}
local wsScanTime = 0
local WS_SCAN_TTL = 1.5

local function scanWorkspace()
    local now = tick()
    if now - wsScanTime < WS_SCAN_TTL then
        return wsScanCache
    end
    wsScanTime = now
    local harvestBoxes = {}
    local collectionAreas = {}
    local plots = {}
    local highTier = {}
    local petItems = {}
    local eventFlags = {}

    for _, v in ipairs(workspace:GetDescendants()) do
        local name = v.Name:lower()
        local isPart = v:IsA("BasePart")
        local isModel = v:IsA("Model")

        if (isPart or isModel) then
            -- collection areas
            if name:find("sell", 1, true) or name:find("dropoff", 1, true) or name:find("collection", 1, true) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then table.insert(collectionAreas, part) end
            end
            -- plots
            if name:find("plot", 1, true) or name:find("ring", 1, true) or name:find("soil", 1, true) or name:find("pot", 1, true) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then table.insert(plots, part) end
            end
            -- high tier plants
            if name:find("celestial", 1, true) or name:find("eternal", 1, true) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then table.insert(highTier, part) end
            end
            -- pet items
            if name:find("pet", 1, true) or name:find("egg", 1, true) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then table.insert(petItems, part) end
            end
            -- harvest boxes (BasePart with BillboardGui OR model with harvest keywords)
            if isPart and v:FindFirstChildOfClass("BillboardGui") then
                if name:find("harvest", 1, true) or name:find("collect", 1, true) or name:find("produce", 1, true) then
                    table.insert(harvestBoxes, v)
                end
            end
            if isModel and (name:find("harvest", 1, true) or name:find("produce", 1, true)) then
                local part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                if part then table.insert(harvestBoxes, part) end
            end
        end

        -- event detection via values
        if v:IsA("BoolValue") or v:IsA("StringValue") or v:IsA("NumberValue") then
            local evtMatch = nil
            for _, evt in ipairs({"rain", "galaxy", "ufo", "beeswarm", "plantrush", "adminabuse", "carnival", "summerfuse", "jackpot"}) do
                if name:find(evt, 1, true) then
                    evtMatch = evt
                    break
                end
            end
            if evtMatch then
                local active = false
                if v:IsA("BoolValue") then active = v.Value
                elseif v:IsA("NumberValue") then active = v.Value > 0
                elseif v:IsA("StringValue") then active = v.Value ~= "" and v.Value ~= "None"
                end
                if active then
                    eventFlags[evtMatch] = true
                end
            end
        end
    end

    -- event detection via GUI text
    if not next(eventFlags) then
        for _, v in ipairs(playerGui:GetDescendants()) do
            if (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Visible and v.AbsoluteSize.X > 0 then
                local text = v.Text:lower()
                for _, evt in ipairs({"rain", "galaxy", "ufo", "beeswarm", "plantrush", "adminabuse", "carnival", "summerfuse", "celestial"}) do
                    if text:find(evt, 1, true) and not text:find("none", 1, true) and not text:find("no event", 1, true) then
                        eventFlags[evt] = true
                        break
                    end
                end
                if next(eventFlags) then break end
            end
        end
    end

    wsScanCache = {
        harvestBoxes = harvestBoxes,
        collectionAreas = collectionAreas,
        plots = plots,
        highTier = highTier,
        petItems = petItems,
        eventFlags = eventFlags,
    }
    return wsScanCache
end

-- ============== INTERACTION ==============
local function tryInteract(part)
    if not part then return end
    local char = player.Character
    if not char then
        local ok = pcall(function()
            return player.CharacterAdded:Wait(3)
        end)
        if not ok then return end
        char = player.Character
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - part.Position).Magnitude
    if dist > 30 then
        hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 5))
        task.wait(0.3)
    end
    pcall(function()
        fireRemote("interact", part)
        fireRemote("collect", part)
        fireRemote("harvest", part)
    end)
end

-- ============== FEATURES ==============
local function redeemCodes()
    local codes = {
        "BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS",
        "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3",
        "2KLIKES", "UPDATE1", "100KVISITS"
    }
    for _, code in ipairs(codes) do
        local ok = pcall(function()
            fireRemote("code", code)
            fireRemote("redeem", code)
        end)
        if ok then task.wait(0.3) end
    end
end

task.spawn(function()
    task.wait(5)
    pcall(redeemCodes)
    while true do
        task.wait(600)
        pcall(redeemCodes)
    end
end)

local function collectPetRewards()
    local data = scanWorkspace()
    for _, part in ipairs(data.petItems) do
        tryInteract(part)
        task.wait(0.15)
    end
end

local function doUpgrade()
    local upgradeList = {
        "SeedLuck", "SawYield", "SprinklerPower", "SawRange", "SprinklerRange",
        "CelestialRoll", "EternalRoll", "JackpotRoll", "LuckyCloverRoll"
    }
    for _, name in ipairs(upgradeList) do
        fireRemote("upgrade", name)
        fireRemote("buy", name)
        task.wait(0.05)
    end
end

local function autoHarvest()
    local data = scanWorkspace()
    local targets = {}
    for _, box in ipairs(data.harvestBoxes) do
        table.insert(targets, box)
    end
    for _, plant in ipairs(data.highTier) do
        table.insert(targets, plant)
    end
    if #targets > 0 then
        updateStatus("Harvesting " .. #targets .. " items...")
        for _, target in ipairs(targets) do
            tryInteract(target)
            task.wait(0.1)
        end
        return true
    end
    return false
end

local function autoCollect()
    local data = scanWorkspace()
    if #data.collectionAreas > 0 then
        updateStatus("Collecting...")
        for _, area in ipairs(data.collectionAreas) do
            tryInteract(area)
            task.wait(0.15)
        end
    end
end

local function autoSell()
    local data = scanWorkspace()
    for _, area in ipairs(data.collectionAreas) do
        local name = area.Name:lower()
        if name:find("sell", 1, true) then
            tryInteract(area)
            task.wait(0.3)
            fireRemote("sell", "all")
            fireRemote("sellall")
            return
        end
    end
end

local function autoPlant()
    fireRemote("plant")
    fireRemote("plantseed")
    fireRemote("celestialplant")
    fireRemote("eternalplant")

    local data = scanWorkspace()
    if getToggle("Auto Replant") then
        for _, part in ipairs(data.highTier) do
            tryInteract(part)
            task.wait(0.15)
        end
    end
    for _, plot in ipairs(data.plots) do
        tryInteract(plot)
        task.wait(0.15)
    end
end

local function scanForWeather()
    local data = scanWorkspace()
    local names = ""
    for evt, _ in pairs(data.eventFlags) do
        names = names ~= "" and (names .. ", " .. evt) or evt
        if getToggle("Auto Event Claim") then
            fireRemote("claim", evt)
            fireRemote("eventclaim", evt)
        end
    end
    updateEvent(names ~= "" and "Active: " .. names or "None")
end

-- ============== MAIN LOOPS ==============
-- Run harvest/collect every 1.5s (not every frame!)
task.spawn(function()
    while true do
        if Lib.GUI.Enabled then
            if getToggle("Auto Harvest") then autoHarvest() end
            if getToggle("Auto Collect") then autoCollect() end
        end
        task.wait(1.5)
    end
end)

task.spawn(function()
    while true do
        if Lib.GUI.Enabled then
            if getToggle("Event Detection") then scanForWeather() end
            if getToggle("Auto Sell") then autoSell() end
            if getToggle("Auto Plant") then autoPlant() end
            if getToggle("Auto Upgrade") then doUpgrade() end
            if getToggle("Auto Pet Collect") then collectPetRewards() end
            updateStatus("Running")
        end
        task.wait(2)
    end
end)

Lib:CreateLabel("Tiers: Common · Uncommon · Rare · Epic · Legendary")
Lib:CreateLabel("Secret · Prismatic · Divine · Exotic · Transcended")
Lib:CreateLabel("Celestial · Eternal")
Lib:CreateLabel("StriaGO v1.0 - by ciroyal")
updateStatus("Ready")
