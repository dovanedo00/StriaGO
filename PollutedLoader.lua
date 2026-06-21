local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local IsMobile = UserInputService.TouchEnabled

local function getContainerSize()
    local cam = workspace.CurrentCamera
    if not cam then return UDim2.new(0, 240, 0, 180) end
    local isPortrait = cam.ViewportSize.Y > cam.ViewportSize.X
    if IsMobile then
        return isPortrait and UDim2.new(0, 280, 0, 220) or UDim2.new(0, 260, 0, 200)
    end
    return UDim2.new(0, 240, 0, 180)
end

local function buildLoaderUI(theme)
    local C = theme.colors
    local ContainerSize = getContainerSize()
    local LogoSize = IsMobile and UDim2.new(0, 140, 0, 140) or UDim2.new(0, 120, 0, 120)
    local BarHeight = IsMobile and 3 or 2

    local Loader = Instance.new("ScreenGui")
    Loader.Name = theme.name .. "Loader"
    Loader.Parent = CoreGui
    Loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(0, ContainerSize.X.Offset + 40, 0, ContainerSize.Y.Offset + 40)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.ImageTransparency = 1
    Shadow.Image = "rbxassetid://7912134082"
    Shadow.ImageColor3 = C.shadow
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(80, 80, 80, 80)
    Shadow.Parent = Loader

    local Container = Instance.new("Frame")
    Container.Size = ContainerSize
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = C.bg
    Container.BorderSizePixel = 0
    Container.Parent = Loader

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Container

    local UIGradient
    if C.gradient then
        UIGradient = Instance.new("UIGradient")
        UIGradient.Color = C.gradient
        UIGradient.Rotation = 45
        UIGradient.Parent = Container
    end

    if theme.bubble then
        local Bubbles = Instance.new("Frame")
        Bubbles.Size = UDim2.new(1, 0, 1, 0)
        Bubbles.BackgroundTransparency = 0.8
        Bubbles.BackgroundColor3 = C.bubble
        Bubbles.ClipsDescendants = true
        Bubbles.Parent = Container

        local BCorner = Instance.new("UICorner")
        BCorner.CornerRadius = UDim.new(0, 12)
        BCorner.Parent = Bubbles

        local BGrad = Instance.new("UIGradient")
        BGrad.Transparency = NumberSequence.new({
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
        BGrad.Rotation = 90
        BGrad.Parent = Bubbles

        task.spawn(function()
            while Loader.Parent do
                TweenService:Create(BGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                    Rotation = BGrad.Rotation - 360
                }):Play()
                task.wait(2)
            end
        end)
    end

    if theme.shine then
        local Shine = Instance.new("Frame")
        Shine.Size = UDim2.new(1, 0, 1, 0)
        Shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Shine.BackgroundTransparency = 0.9
        Shine.Parent = Container

        local SCorner = Instance.new("UICorner")
        SCorner.CornerRadius = UDim.new(0, 12)
        SCorner.Parent = Shine

        local Grad = Instance.new("UIGradient")
        Grad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.4, 0.97),
            NumberSequenceKeypoint.new(0.5, 0.95),
            NumberSequenceKeypoint.new(0.6, 0.97),
            NumberSequenceKeypoint.new(1, 1)
        })
        Grad.Parent = Shine

        task.spawn(function()
            while Loader.Parent do
                TweenService:Create(Grad, TweenInfo.new(2), {
                    Offset = Vector2.new(1, 0)
                }):Play()
                task.wait(2)
                Grad.Offset = Vector2.new(-1, 0)
                task.wait(0.1)
            end
        end)
    end

    local Logo = Instance.new("ImageLabel")
    Logo.Size = LogoSize
    Logo.Position = UDim2.new(0.5, 0, 0.45, 0)
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.BackgroundTransparency = 1
    Logo.Image = theme.logoAsset
    Logo.ImageColor3 = C.logo
    Logo.ImageTransparency = 1
    Logo.Parent = Container

    local Glow = Instance.new("ImageLabel")
    Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow.BackgroundTransparency = 1
    Glow.Image = theme.glowAsset or "rbxassetid://7912134082"
    Glow.ImageColor3 = C.glow
    Glow.ImageTransparency = 1
    Glow.Parent = Logo

    local LoadingText
    if theme.label then
        LoadingText = Instance.new("TextLabel")
        LoadingText.Size = UDim2.new(1, 0, 0, 20)
        LoadingText.Position = UDim2.new(0, 0, IsMobile and 0.82 or 0.8, 0)
        LoadingText.Font = Enum.Font.GothamBold
        LoadingText.Text = theme.label
        LoadingText.TextColor3 = C.text
        LoadingText.TextSize = IsMobile and 18 or 16
        LoadingText.BackgroundTransparency = 1
        LoadingText.TextTransparency = 1
        LoadingText.Parent = Container
    end

    local BarContainer = Instance.new("Frame")
    BarContainer.Size = UDim2.new(IsMobile and 0.7 or 0.8, 0, 0, BarHeight)
    BarContainer.Position = UDim2.new(0.5, 0, 0.9, 0)
    BarContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    BarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BarContainer.BackgroundTransparency = 1
    BarContainer.Parent = Container

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0, 0, 1, 0)
    Bar.BackgroundColor3 = C.bar
    Bar.BackgroundTransparency = 1
    Bar.Parent = BarContainer

    if theme.introSound then
        local Snd = Instance.new("Sound")
        Snd.SoundId = theme.introSound
        Snd.Volume = 0.5
        Snd.Parent = Loader
        theme._introSound = Snd
    end

    if theme.outroSound then
        local Snd = Instance.new("Sound")
        Snd.SoundId = theme.outroSound
        Snd.Volume = 0.5
        Snd.Parent = Loader
        theme._outroSound = Snd
    end

    local rotationSpeed = theme.rotationSpeed or 360
    if UIGradient then
        task.spawn(function()
            while Loader.Parent do
                TweenService:Create(UIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                    Rotation = UIGradient.Rotation + rotationSpeed
                }):Play()
                task.wait(2)
            end
        end)
    end

    local api = {}

    function api.playIntro()
        Container.Size = UDim2.new(0, ContainerSize.X.Offset - 20, 0, ContainerSize.Y.Offset - 20)
        Container.BackgroundTransparency = 1
        Shadow.ImageTransparency = 1

        if theme._introSound then
            theme._introSound:Play()
        end

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

        if LoadingText then
            TweenService:Create(LoadingText, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
                TextTransparency = 0
            }):Play()
        end

        TweenService:Create(Bar, TweenInfo.new(0.7), {
            BackgroundTransparency = 0,
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
    end

    function api.setBarProgress(fraction)
        Bar.Size = UDim2.new(fraction, 0, 1, 0)
    end

    function api.playOutro()
        if theme._outroSound then
            theme._outroSound:Play()
        end

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

        if LoadingText then
            TweenService:Create(LoadingText, TweenInfo.new(0.5), {
                TextTransparency = 1
            }):Play()
        end

        TweenService:Create(Bar, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play()

        task.wait(0.7)
        Loader:Destroy()
    end

    return api
end

local pollutedTheme = {
    name = "Polluted",
    logoAsset = "rbxassetid://130082951267456",
    colors = {
        shadow = Color3.fromRGB(0, 255, 0),
        bg = Color3.fromRGB(20, 20, 20),
        logo = Color3.fromRGB(144, 255, 96),
        glow = Color3.fromRGB(144, 255, 96),
        bar = Color3.fromRGB(144, 255, 96),
        text = Color3.fromRGB(255, 255, 255),
        bubble = Color3.fromRGB(144, 255, 96),
        gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 183, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(33, 125, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 83, 0))
        }),
    },
    bubble = true,
    rotationSpeed = 360,
}

local zephyrTheme = {
    name = "Zephyr",
    logoAsset = "rbxassetid://77613174656421",
    glowAsset = "rbxassetid://89033969723631",
    label = "ZEPHYR",
    colors = {
        shadow = Color3.fromRGB(0, 0, 0),
        bg = Color3.fromRGB(20, 20, 20),
        logo = Color3.fromRGB(255, 255, 255),
        glow = Color3.fromRGB(255, 255, 255),
        bar = Color3.fromRGB(255, 255, 255),
        text = Color3.fromRGB(255, 255, 255),
        gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
        }),
    },
    shine = true,
    introSound = "rbxassetid://111599986078727",
    outroSound = "rbxassetid://8968249849",
    rotationSpeed = -360,
}

local scriptInfo = {
    -- Zephyr games
    [4348829796] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/ZephyrV2', isLuarmor = false},
    [7709344486] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/StealABrainrot', isLuarmor = false},
    [7344582593] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/DieOfDealth', isLuarmor = false},
    [5995470825] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Hypershot.lua', isLuarmor = false},
    [6035872082] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/Rivals.lua', isLuarmor = false},
    [5544551093] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/Secret%20Killer.lua', isLuarmor = false},
    [9251333102] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/Invade%20the%20World', isLuarmor = false},
    [1176784616] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/TDSLoadup.lua', isLuarmor = false},
    -- Build A Ring Farm
    [107646426076756] = {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/StriaGO.lua', isLuarmor = false},
    -- Polluted games
    [8353962342] = {url = "https://api.luarmor.net/files/v3/loaders/0f8751b134191b33890f77ac3be49dbc.lua", isLuarmor = true},
    [126884695634066] = {url = "https://api.luarmor.net/files/v3/loaders/22c850869e9e8c3cdc71aedbb632dac6.lua", isLuarmor = true},
    [79546208627805] = {url = "https://api.luarmor.net/files/v3/loaders/7b49a212373561851fa3bc6b9e4a45c0.lua", isLuarmor = true},
    [8316902627] = {url = "https://api.luarmor.net/files/v3/loaders/3e0e5bada3453caa36246a325f2345f3.lua", isLuarmor = true},
    [6701277882] = {url = "https://api.luarmor.net/files/v3/loaders/b9162d4ef4823b2af2f93664cf9ec393.lua", isLuarmor = true},
    [7750955984] = {url = "https://api.luarmor.net/files/v3/loaders/7b5caf0fbbd276ba9747f231e47c0b1a.lua", isLuarmor = true},
    [8066283370] = {url = "https://api.luarmor.net/files/v3/loaders/59181ae583fe3b51a97d7d7e769d857e.lua", isLuarmor = true},
    [7882829745] = {url = "https://api.luarmor.net/files/v3/loaders/c29a3e11688e5806e228f2c67a36149d.lua", isLuarmor = true},
    [7264587281] = {url = "https://api.luarmor.net/files/v3/loaders/7203478c42c592bee50a25c8056cfb74.lua", isLuarmor = true},
    [7671049560] = {url = "https://api.luarmor.net/files/v3/loaders/ecfcccea43f60fa4c46009f854c06a52.lua", isLuarmor = true},
    [8144728961] = {url = "https://api.luarmor.net/files/v4/loaders/cf7d7d4cd57d21138be3f35d4442557a.lua", isLuarmor = true},
    [7394964165] = {url = "https://api.luarmor.net/files/v4/loaders/83dfede315f32da25e5d660d5d9629cb.lua", isLuarmor = true},
    [9509842868] = {url = "https://api.luarmor.net/files/v4/loaders/7e95f50fa8d660cad182e6278cf70afe.lua", isLuarmor = true},
    [9186719164] = {url = "https://api.luarmor.net/files/v4/loaders/b1f30331e1af9ab6e96fc80cd00b20a9.lua", isLuarmor = true},
    [9792947201] = {url = "https://api.luarmor.net/files/v4/loaders/31e477a833e8d30b78b51f032625aa44.lua", isLuarmor = true},
    [10039338037] = {url = "https://api.luarmor.net/files/v4/loaders/544f64759db6021216af8ca483bb53c4.lua", isLuarmor = true},
    [10004244222] = {url = "https://api.luarmor.net/files/v4/loaders/d130dee84ed1d9ccecfd6a91fc49665b.lua", isLuarmor = true},
    [10200395747] = {url = "https://api.luarmor.net/files/v4/loaders/e8580ba6e94aeaa7aa2486f060167f85.lua", isLuarmor = true},
}

local success, result = pcall(function()
    local universeId = game.GameId
    local info = scriptInfo[universeId] or {url = 'https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/Games/Universal.lua', isLuarmor = false}

    local theme = info.isLuarmor and pollutedTheme or zephyrTheme
    local loader = buildLoaderUI(theme)

    loader.playIntro()

    local scriptContent
    local fetchOk, fetchResult = pcall(function()
        return game:HttpGet(info.url)
    end)
    fetchOk = fetchOk and type(fetchResult) == "string" and #fetchResult > 0

    if fetchOk then
        scriptContent = fetchResult
        for i = 0, 10 do
            loader.setBarProgress(i / 10)
            task.wait(0.05)
        end
    else
        warn("[Loader] Failed to fetch script: " .. info.url)
        loader.setBarProgress(1)
    end

    task.wait(0.5)
    loader.playOutro()
    task.wait(0.7)

    if fetchOk and scriptContent then
        local loadOk, loadErr = pcall(loadstring, scriptContent)
        if loadOk then
            pcall(loadErr)
        else
            warn("[Loader] Script compilation failed: " .. tostring(loadErr))
        end
    end
end)

if not success then
    warn("[Loader] Fatal error: " .. tostring(result))
end
