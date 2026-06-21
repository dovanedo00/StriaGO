warn("[StriaGO] Loading...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Wait for player to fully load
repeat task.wait() until game:GetService("Players").LocalPlayer
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then
    playerGui = Instance.new("ScreenGui")
    playerGui.Name = "StriaGO_Fallback"
    playerGui.Parent = game:GetService("CoreGui")
end

-- ============== THEME ==============
local theme = {
    Main = Color3.fromRGB(18, 18, 25),
    Second = Color3.fromRGB(28, 28, 40),
    Accent = Color3.fromRGB(255, 140, 50),
    Text = Color3.fromRGB(230, 230, 245),
    Muted = Color3.fromRGB(140, 140, 160),
    Red = Color3.fromRGB(255, 70, 70),
    Font = Enum.Font.GothamBold,
}

local Settings = {}

-- ============== GUI ==============
local function buildGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "StriaGO"
    gui.Parent = playerGui
    gui.Enabled = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 380, 0, 520)
    main.Position = UDim2.new(0.5, -190, 0.5, -260)
    main.BackgroundColor3 = theme.Main
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Parent = gui
    main.Visible = false

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = main

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(45, 45, 60)
    mainStroke.Thickness = 1
    mainStroke.Parent = main

    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 38)
    titleBar.BackgroundColor3 = theme.Second
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -45, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = theme.Font
    titleLabel.Text = "StriaGO"
    titleLabel.TextColor3 = theme.Accent
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = theme.Muted
    closeBtn.TextSize = 14
    closeBtn.Font = theme.Font
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar

    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    closeBtn.MouseButton1Click:Connect(function()
        main.Visible = false
    end)

    -- Scroll area
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -48)
    scroll.Position = UDim2.new(0, 5, 0, 43)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = theme.Accent
    scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
    scroll.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scroll

    Instance.new("UIPadding", scroll).PaddingTop = UDim.new(0, 4)

    -- Update canvas on layout change
    pcall(function()
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            local s = layout.AbsoluteContentSize
            scroll.CanvasSize = UDim2.new(0, 0, 0, s.Y + 10)
        end)
    end)

    -- Open button
    local openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(0, 145, 0, 32)
    openBtn.Position = UDim2.new(0, 10, 1, -42)
    openBtn.BackgroundColor3 = theme.Accent
    openBtn.Text = "StriaGO [RShift]"
    openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    openBtn.TextSize = 12
    openBtn.Font = theme.Font
    openBtn.BorderSizePixel = 0
    openBtn.Parent = gui

    Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)

    openBtn.MouseButton1Click:Connect(function()
        main.Visible = true
    end)

    -- Toggle
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            main.Visible = not main.Visible
        end
    end)

    return gui, main, scroll, layout
end

local gui, main, scroll, layout
local buildOk, buildErr = pcall(function()
    gui, main, scroll, layout = buildGUI()
end)
if not buildOk then
    warn("[StriaGO] GUI build error: " .. tostring(buildErr))
    -- Emergency fallback: simple text label
    local fb = Instance.new("ScreenGui")
    fb.Name = "StriaGO_Fallback"
    fb.Parent = playerGui
    fb.Enabled = true
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 200, 0, 30)
    lbl.Position = UDim2.new(0.5, -100, 0, 50)
    lbl.Text = "StriaGO loaded (error in GUI)"
    lbl.TextColor3 = Color3.fromRGB(255, 140, 50)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.Parent = fb
    return -- stop here if GUI failed
end

-- ============== UI HELPERS ==============
local function CreateLabel(text, isHeader)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, isHeader and 26 or 20)
    label.BackgroundTransparency = 1
    label.Font = theme.Font
    label.Text = text
    label.TextColor3 = isHeader and theme.Accent or theme.Muted
    label.TextSize = isHeader and 17 or 12
    label.Parent = scroll
    return label
end

local function CreateToggle(text, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 34)
    container.BackgroundColor3 = theme.Second
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.Parent = scroll

    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -55, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = theme.Font
    label.Text = text
    label.TextColor3 = theme.Text
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 22)
    toggle.Position = UDim2.new(1, -48, 0.5, -11)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggle.BorderSizePixel = 0
    toggle.Parent = container

    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 11)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 9)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container

    local state = default or false

    local function updateVisual()
        toggle.BackgroundColor3 = state and theme.Accent or Color3.fromRGB(50, 50, 60)
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
    btn.BackgroundColor3 = theme.Accent
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 13
    btn.Font = theme.Font
    btn.BorderSizePixel = 0
    btn.Parent = scroll

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        if callback then
            pcall(callback)
        end
    end)
    return btn
end

-- ============== BUILD UI ==============
CreateLabel("STRIA AUTO FARM", true)
local getToggle = {}
getToggle["Auto Harvest"] = CreateToggle("Auto Harvest", true)
getToggle["Auto Collect"] = CreateToggle("Auto Collect", true)
getToggle["Auto Sell"] = CreateToggle("Auto Sell", true)
getToggle["Auto Plant"] = CreateToggle("Auto Plant", true)
getToggle["Auto Replant"] = CreateToggle("Auto Replant", true)
getToggle["Auto Upgrade"] = CreateToggle("Auto Upgrade", false)
getToggle["Auto Pet Collect"] = CreateToggle("Auto Pet Collect", false)

CreateLabel("EVENT DETECTION", true)
getToggle["Event Detection"] = CreateToggle("Event Detection", true)
getToggle["Auto Event Claim"] = CreateToggle("Auto Event Claim", true)

CreateLabel("CODES", true)
CreateButton("Redeem All Codes", function()
    local codes = {"BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3", "2KLIKES", "UPDATE1", "100KVISITS", "RELEASE", "SORRY", "1MVISITS"}
    for _, code in ipairs(codes) do
        pcall(function()
            local r = game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true)
            if r then r:InvokeServer(code) end
        end)
        task.wait(0.3)
    end
end)

local statusLabel = CreateLabel("Status: Ready")
local eventLabel = CreateLabel("Event: None")

-- ============== HELPERS ==============
local function updateStatus(s)
    statusLabel.Text = "Status: " .. s
end

local function updateEvent(s)
    eventLabel.Text = "Event: " .. s
end

local remotes = {}
local lastRemoteRefresh = 0

local function getRemotes()
    local now = tick()
    if now - lastRemoteRefresh < 5 then
        return remotes
    end
    remotes = {}
    for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(remotes, obj)
        end
    end
    lastRemoteRefresh = now
    return remotes
end

local function fireAll(patterns, ...)
    local args = {...}
    local all = getRemotes()
    for _, r in ipairs(all) do
        local name = r.Name:lower()
        for _, p in ipairs(patterns) do
            if name:find(p:lower(), 1, true) then
                pcall(function()
                    if r:IsA("RemoteEvent") then
                        r:FireServer(unpack(args))
                    else
                        r:InvokeServer(unpack(args))
                    end
                end)
                break
            end
        end
    end
end

local function getHRP()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function tp(cf)
    local hrp = getHRP()
    if hrp then hrp.CFrame = cf end
end

-- ============== SCANNER ==============
local scanCache = {}
local scanTime = 0

local function scan()
    local now = tick()
    if now - scanTime < 1.5 then return scanCache end
    scanTime = now

    local r = {harvest = {}, sell = {}, collect = {}, plots = {}, highTier = {}, pets = {}, events = {}}

    for _, v in ipairs(workspace:GetDescendants()) do
        local ok, name, isPart, isModel = pcall(function()
            return v.Name:lower(), v:IsA("BasePart"), v:IsA("Model")
        end)
        if not ok then break end

        if isPart or isModel then
            if isPart and v:FindFirstChildOfClass("BillboardGui") then
                if name:find("harvest",1,true) or name:find("collect",1,true) or name:find("produce",1,true) or name:find("box",1,true) then
                    table.insert(r.harvest, v)
                end
            end
            if isModel then
                if name:find("harvest",1,true) or name:find("produce",1,true) or name:find("crate",1,true) then
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
            if name:find("dropoff",1,true) or name:find("collect",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p and not name:find("collectible",1,true) then table.insert(r.collect, p) end
            end
            if name:find("plot",1,true) or name:find("ring",1,true) or name:find("soil",1,true) or name:find("pot",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.plots, p) end
            end
            if name:find("celestial",1,true) or name:find("eternal",1,true) then
                local p = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if p then table.insert(r.highTier, p) end
            end
        end

        if v:IsA("BoolValue") or v:IsA("StringValue") then
            local active = false
            if v:IsA("BoolValue") then active = v.Value
            elseif v:IsA("StringValue") then active = v.Value ~= "" and v.Value:lower() ~= "none"
            end
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
                if (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Visible then
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
    local pos = part.Position or (pcall(function() return part:GetPivot().Position end) and part:GetPivot().Position or nil)
    if not pos then return end
    local dist = (hrp.Position - pos).Magnitude
    if dist > 25 then
        tp(CFrame.new(pos + Vector3.new(0, 3, 5)))
        task.wait(0.2)
    end
    fireAll({"interact", "collect", "harvest", "claim", "click"}, part)
end

local function doHarvest()
    local data = scan()
    if #data.harvest > 0 then
        updateStatus("Harvest " .. #data.harvest)
        for _, p in ipairs(data.harvest) do
            interact(p)
            task.wait(0.12)
        end
    end
end

local function doCollect()
    local data = scan()
    if #data.collect > 0 then
        for _, p in ipairs(data.collect) do
            interact(p)
            task.wait(0.15)
        end
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
        for _, p in ipairs(data.highTier) do
            interact(p)
            task.wait(0.15)
        end
    end
    for _, p in ipairs(data.plots) do
        interact(p)
        task.wait(0.15)
    end
end

local function doUpgrade()
    updateStatus("Upgrading")
    for _, name in ipairs({"SeedLuck", "SawYield", "SprinklerPower", "SawRange", "SprinklerRange", "CelestialRoll", "EternalRoll", "JackpotRoll", "LuckyCloverRoll"}) do
        fireAll({"upgrade", "buy", "purchase"}, name)
        task.wait(0.05)
    end
end

local function doPets()
    local data = scan()
    if #data.pets > 0 then
        updateStatus("Pets")
        for _, p in ipairs(data.pets) do
            interact(p)
            task.wait(0.15)
        end
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
        for _, code in ipairs({"BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3", "2KLIKES", "UPDATE1", "100KVISITS", "RELEASE", "SORRY", "1MVISITS"}) do
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
pcall(function()
    main.Visible = true
    updateStatus("Active")
    updateEvent("None")
end)
warn("[StriaGO] Loaded successfully! GUI at: " .. tostring(gui) .. " | Main: " .. tostring(main))
