local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local IsMobile = UserInputService.TouchEnabled

-- Fallback parent: CoreGui preferred, PlayerGui if blocked
local screenParent = CoreGui
local ok = pcall(function()
    local test = Instance.new("ScreenGui")
    test.Parent = CoreGui
    test:Destroy()
end)
if not ok then
    screenParent = playerGui
    warn("[StriaGO] CoreGui blocked, using PlayerGui")
end

-- StriaGO Theme
local theme = {
    Main = Color3.fromRGB(18, 18, 25),
    Second = Color3.fromRGB(28, 28, 40),
    Accent = Color3.fromRGB(255, 140, 50),
    AccentDark = Color3.fromRGB(200, 110, 40),
    Text = Color3.fromRGB(230, 230, 245),
    Muted = Color3.fromRGB(140, 140, 160),
    Red = Color3.fromRGB(255, 70, 70),
    Green = Color3.fromRGB(80, 220, 100),
    Stroke = Color3.fromRGB(45, 45, 60),
    Font = Enum.Font.GothamBold,
    TextSize = IsMobile and 16 or 14,
}

local Settings = {}

-- ============== GUI BUILDER ==============
local gui = Instance.new("ScreenGui")
gui.Name = "StriaGO"
gui.Parent = screenParent
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = false

-- Separate ScreenGui for open button (always visible)
local openGui = Instance.new("ScreenGui")
openGui.Name = "StriaGO_Open"
openGui.Parent = screenParent
openGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
openGui.Enabled = true
openGui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 380, 0, 520)
main.Position = UDim2.new(0.5, -190, 0.5, -260)
main.BackgroundColor3 = theme.Main
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
main.ClipsDescendants = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = theme.Stroke
mainStroke.Thickness = 1
mainStroke.Parent = main

-- Accent glow strip at top
local glowBar = Instance.new("Frame")
glowBar.Size = UDim2.new(1, 0, 0, 3)
glowBar.BackgroundColor3 = theme.Accent
glowBar.BorderSizePixel = 0
glowBar.Parent = main

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 12)
glowCorner.Parent = glowBar

-- Animated gradient overlay
local bgOverlay = Instance.new("Frame")
bgOverlay.Size = UDim2.new(1, 0, 1, 0)
bgOverlay.BackgroundTransparency = 1
bgOverlay.Parent = main

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 110, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 50)),
})
bgGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.95),
    NumberSequenceKeypoint.new(0.3, 0.97),
    NumberSequenceKeypoint.new(0.7, 0.97),
    NumberSequenceKeypoint.new(1, 0.95),
})
bgGradient.Rotation = 45
bgGradient.Parent = bgOverlay

-- Animated gradient rotation
task.spawn(function()
    while gui.Parent do
        TweenService:Create(bgGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {Rotation = bgGradient.Rotation + 360}):Play()
        task.wait(3)
    end
end)

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = theme.Second
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleFiller = Instance.new("Frame")
titleFiller.Size = UDim2.new(0, 12, 1, 0)
titleFiller.Position = UDim2.new(1, -12, 0, 0)
titleFiller.BackgroundColor3 = theme.Second
titleFiller.BorderSizePixel = 0
titleFiller.Parent = titleBar

local titleIcon = Instance.new("TextLabel")
titleIcon.Size = UDim2.new(0, 24, 0, 24)
titleIcon.Position = UDim2.new(0, 10, 0.5, -12)
titleIcon.BackgroundTransparency = 1
titleIcon.Font = theme.Font
titleIcon.Text = "S"
titleIcon.TextColor3 = theme.Accent
titleIcon.TextSize = 18
titleIcon.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -90, 1, 0)
titleLabel.Position = UDim2.new(0, 38, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = theme.Font
titleLabel.Text = "StriaGO"
titleLabel.TextColor3 = theme.Text
titleLabel.TextSize = theme.TextSize + 2
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close button
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

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

-- Hover effects on close
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = theme.Red, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 65), TextColor3 = theme.Muted}):Play()
end)

-- Scrolling area
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -48)
scroll.Position = UDim2.new(0, 5, 0, 43)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = theme.Accent
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = scroll

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 4)
padding.Parent = scroll

-- RightShift toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        gui.Enabled = not gui.Enabled
    end
end)

-- Open button
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 145, 0, 32)
openBtn.Position = UDim2.new(0, 10, 1, -42)
openBtn.BackgroundColor3 = theme.Accent
openBtn.BackgroundTransparency = 0.15
openBtn.Text = "StriaGO [RShift]"
openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
openBtn.TextSize = 12
openBtn.Font = theme.Font
openBtn.BorderSizePixel = 0
    openBtn.Parent = openGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
openStroke.Color = theme.Accent
openStroke.Thickness = 1
openStroke.Transparency = 0.5
openStroke.Parent = openBtn

openBtn.MouseEnter:Connect(function()
    TweenService:Create(openBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
end)
openBtn.MouseLeave:Connect(function()
    TweenService:Create(openBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
end)
openBtn.MouseButton1Click:Connect(function()
    gui.Enabled = true
end)

-- ============== UI COMPONENTS ==============
local function CreateToggle(text, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 34)
    container.BackgroundColor3 = theme.Second
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.Parent = scroll

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -55, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = theme.Font
    label.Text = text
    label.TextColor3 = theme.Text
    label.TextSize = theme.TextSize - 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 40, 0, 22)
    toggle.Position = UDim2.new(1, -48, 0.5, -11)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggle.BorderSizePixel = 0
    toggle.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 11)
    toggleCorner.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 9)
    knobCorner.Parent = knob

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container

    local state = default or false

    local function updateVisual()
        TweenService:Create(toggle, TweenInfo.new(0.2), {
            BackgroundColor3 = state and theme.Accent or Color3.fromRGB(50, 50, 60)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180),
            Position = state and UDim2.new(0, 20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
    end
    updateVisual()

    btn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        Settings[text] = state
    end)

    return function() return state end
end

local function CreateLabel(text, isHeader)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, isHeader and 26 or 20)
    label.BackgroundTransparency = 1
    label.Font = theme.Font
    label.Text = text
    label.TextColor3 = isHeader and theme.Accent or theme.Muted
    label.TextSize = isHeader and (theme.TextSize + 3) or (theme.TextSize - 2)
    label.Parent = scroll
    return label
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = theme.Accent
    btn.BackgroundTransparency = 0.25
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = theme.TextSize - 1
    btn.Font = theme.Font
    btn.Parent = scroll

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.25}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

-- ============== BUILD UI ==============
CreateLabel("STRIA AUTO FARM", true)
local harvestToggle = CreateToggle("Auto Harvest", true)
local collectToggle = CreateToggle("Auto Collect", true)
local sellToggle = CreateToggle("Auto Sell", true)
local plantToggle = CreateToggle("Auto Plant", true)
local replantToggle = CreateToggle("Auto Replant", true)
local upgradeToggle = CreateToggle("Auto Upgrade", false)
local petToggle = CreateToggle("Auto Pet Collect", false)

CreateLabel("EVENT DETECTION", true)
local eventToggle = CreateToggle("Event Detection", true)
local claimToggle = CreateToggle("Auto Event Claim", true)

CreateLabel("CODES", true)
CreateButton("Redeem All Codes", function()
    pcall(function()
        local codes = {"BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3", "2KLIKES", "UPDATE1", "100KVISITS", "RELEASE", "SORRY", "1MVISITS"}
        for _, code in ipairs(codes) do
            pcall(function()
                game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true) and game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true):InvokeServer(code)
            end)
            task.wait(0.3)
        end
    end)
end)

CreateLabel("", true)
local statusLabel = CreateLabel("Status: Loading...")
local eventStatusLabel = CreateLabel("Event: None")

-- Wrap feature code in pcall so GUI always shows even if something fails
local ok, setupErr = pcall(function()

-- ============== HELPERS ==============
local function updateStatus(text)
    statusLabel.Text = "Status: " .. text
end

local function updateEventStatus(text)
    eventStatusLabel.Text = "Event: " .. text
end

local function getSetting(name)
    return Settings[name] or false
end

-- Remote cache
local remoteCache = nil
local remoteCacheTime = 0

local function getRemotes()
    local now = tick()
    if remoteCache and now - remoteCacheTime < 5 then
        return remoteCache
    end
    remoteCache = {}
    for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(remoteCache, obj)
        end
    end
    remoteCacheTime = now
    return remoteCache
end

local function fireRemotes(patterns, ...)
    local args = {...}
    local remotes = getRemotes()
    for _, remote in ipairs(remotes) do
        local name = remote.Name:lower()
        for _, pat in ipairs(patterns) do
            if name:find(pat:lower(), 1, true) then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                    else
                        remote:InvokeServer(unpack(args))
                    end
                end)
                break
            end
        end
    end
end

local function getCharacter()
    local char = player.Character
    if not char then
        local ok = pcall(function() return player.CharacterAdded:Wait(5) end)
        if not ok then return nil end
        char = player.Character
    end
    return char
end

local function getHRP()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function teleportCFrame(cf)
    local hrp = getHRP()
    if hrp then hrp.CFrame = cf end
end

local function teleportToPart(part, offset)
    if not part then return end
    local hrp = getHRP()
    if not hrp then return end
    local pos = part.Position or part:GetPivot().Position
    local dist = (hrp.Position - pos).Magnitude
    if dist > 25 then
        teleportCFrame(CFrame.new(pos + (offset or Vector3.new(0, 3, 5))))
        task.wait(0.2)
    end
end

-- ============== WORKSPACE SCANNER ==============
local scanCache = {}
local scanTime = 0

local function scanWorkspace()
    local now = tick()
    if now - scanTime < 1.5 then
        return scanCache
    end
    scanTime = now

    local result = {harvest = {}, collect = {}, sell = {}, plots = {}, highTier = {}, pets = {}, events = {}}

    -- Scan workspace
    for _, v in ipairs(workspace:GetDescendants()) do
        local name = v.Name:lower()
        local isPart = v:IsA("BasePart")
        local isModel = v:IsA("Model")

        if isPart or isModel then
            -- Harvest boxes (have BillboardGui OR name keywords)
            if isPart and v:FindFirstChildOfClass("BillboardGui") then
                if name:find("harvest", 1, true) or name:find("collect", 1, true) or name:find("produce", 1, true) or name:find("drop", 1, true) or name:find("box", 1, true) then
                    table.insert(result.harvest, v)
                end
            end
            -- Models with harvest/produce keywords
            if isModel then
                if name:find("harvest", 1, true) or name:find("produce", 1, true) or name:find("drop", 1, true) or name:find("crate", 1, true) then
                    local p = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                    if p then table.insert(result.harvest, p) end
                end
                -- Pet eggs
                if name:find("pet", 1, true) or name:find("egg", 1, true) then
                    local p = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                    if p then table.insert(result.pets, p) end
                end
            end
            -- Sell/collect areas
            if name:find("sell", 1, true) or name:find("shop", 1, true) or name:find("dropoff", 1, true) or (name:find("collect", 1, true) and not name:find("collectible", 1, true)) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then
                    if name:find("sell", 1, true) or name:find("shop", 1, true) then
                        table.insert(result.sell, part)
                    else
                        table.insert(result.collect, part)
                    end
                end
            end
            -- Plots
            if name:find("plot", 1, true) or name:find("ring", 1, true) or name:find("soil", 1, true) or name:find("pot", 1, true) or name:find("planter", 1, true) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then table.insert(result.plots, part) end
            end
            -- High tier plants
            if name:find("celestial", 1, true) or name:find("eternal", 1, true) then
                local part = isPart and v or (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart"))
                if part then table.insert(result.highTier, part) end
            end
        end

        -- Event detection via values
        if v:IsA("BoolValue") or v:IsA("StringValue") then
            local active = false
            if v:IsA("BoolValue") then active = v.Value
            elseif v:IsA("StringValue") then active = v.Value ~= "" and v.Value:lower() ~= "none"
            end
            if active then
                for _, evt in ipairs({"rain", "galaxy", "ufo", "beeswarm", "plantrush", "adminabuse", "carnival", "summerfuse", "jackpot", "celestial"}) do
                    if name:find(evt, 1, true) then
                        result.events[evt] = true
                        break
                    end
                end
            end
        end
    end

    -- Event detection via player GUI text
    if not next(result.events) then
        for _, v in ipairs(playerGui:GetDescendants()) do
            if (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Visible and v.AbsoluteSize.X > 0 then
                local text = v.Text:lower()
                for _, evt in ipairs({"rain", "galaxy", "ufo", "beeswarm", "plantrush", "adminabuse", "carnival", "summerfuse", "celestial"}) do
                    if text:find(evt, 1, true) and not text:find("none", 1, true) and not text:find("no event", 1, true) then
                        result.events[evt] = true
                        break
                    end
                end
                if next(result.events) then break end
            end
        end
    end

    scanCache = result
    return result
end

-- ============== FEATURES ==============
local function tryInteract(part)
    if not part then return end
    teleportToPart(part)
    task.wait(0.1)
    fireRemotes({"interact", "collect", "harvest", "claim", "click"}, part)
end

local function doHarvest()
    local data = scanWorkspace()
    if #data.harvest > 0 then
        updateStatus("Harvesting " .. #data.harvest .. " items...")
        for _, part in ipairs(data.harvest) do
            tryInteract(part)
            task.wait(0.12)
        end
        return true
    end
    return false
end

local function doCollect()
    local data = scanWorkspace()
    if #data.collect > 0 then
        updateStatus("Collecting...")
        for _, part in ipairs(data.collect) do
            tryInteract(part)
            task.wait(0.15)
        end
    end
end

local function doSell()
    local data = scanWorkspace()
    if #data.sell > 0 then
        updateStatus("Selling...")
        for _, part in ipairs(data.sell) do
            teleportToPart(part)
            task.wait(0.15)
            fireRemotes({"sell", "sellall", "collectall", "claim"}, "all")
            fireRemotes({"sell", "sellall", "collectall", "claim"})
        end
    end
end

local function doPlant()
    fireRemotes({"plant", "plantseed", "buyseed", "purchase"}, "1")
    fireRemotes({"plant", "plantseed", "buyseed", "purchase"})
    local data = scanWorkspace()
    if getSetting("Auto Replant") then
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

local function doUpgrade()
    updateStatus("Upgrading...")
    local upgrades = {"SeedLuck", "SawYield", "SprinklerPower", "SawRange", "SprinklerRange", "CelestialRoll", "EternalRoll", "JackpotRoll", "LuckyCloverRoll"}
    for _, name in ipairs(upgrades) do
        fireRemotes({"upgrade", "buy", "purchase"}, name)
        task.wait(0.05)
    end
end

local function collectPets()
    local data = scanWorkspace()
    if #data.pets > 0 then
        updateStatus("Collecting pets...")
        for _, part in ipairs(data.pets) do
            tryInteract(part)
            task.wait(0.15)
        end
    end
end

local function scanEvents()
    local data = scanWorkspace()
    local active = {}
    for evt, _ in pairs(data.events) do
        table.insert(active, evt)
        if getSetting("Auto Event Claim") then
            fireRemotes({"claim", "eventclaim", "collectevent", "reward"}, evt)
        end
    end
    if #active > 0 then
        updateEventStatus("Active: " .. table.concat(active, ", "))
    else
        updateEventStatus("None")
    end
end

-- Auto-code redemption on start
task.spawn(function()
    task.wait(3)
    pcall(function()
        local codes = {"BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2", "THANKYOU", "BARF:3", "2KLIKES", "UPDATE1", "100KVISITS", "RELEASE", "SORRY", "1MVISITS"}
        for _, code in ipairs(codes) do
            pcall(function()
                local redeemRemote = game:GetService("ReplicatedStorage"):FindFirstChild("RedeemCode", true)
                if redeemRemote then
                    redeemRemote:InvokeServer(code)
                else
                    fireRemotes({"redeem", "code", "claimcode"}, code)
                end
            end)
            task.wait(0.3)
        end
    end)
    updateStatus("Codes redeemed")
end)

-- ============== MAIN LOOPS ==============
task.spawn(function()
    while true do
        if gui.Enabled then
            if getSetting("Auto Harvest") then doHarvest() end
            if getSetting("Auto Collect") then doCollect() end
            updateStatus("Active")
        end
        task.wait(1.5)
    end
end)

task.spawn(function()
    while true do
        if gui.Enabled then
            if getSetting("Event Detection") then scanEvents() end
            if getSetting("Auto Sell") then doSell() end
            if getSetting("Auto Plant") then doPlant() end
            if getSetting("Auto Upgrade") then doUpgrade() end
            if getSetting("Auto Pet Collect") then collectPets() end
        end
        task.wait(2)
    end
end)

-- Ensure GUI shows even if something went wrong
updateStatus("Ready")
updateEventStatus("None")
gui.Enabled = true
openGui.Enabled = true
end)

if not ok then
    warn("[StriaGO] Setup error: " .. tostring(setupErr))
end