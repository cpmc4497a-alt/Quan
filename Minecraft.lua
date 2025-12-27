-- ================== FULL MINECRAFT MENU ==================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

-- ================== STYLE MINECRAFT ==================
local function MCText(obj, size)
    obj.Font = Enum.Font.GothamBlack
    obj.TextColor3 = Color3.fromRGB(120,200,80)
    obj.TextSize = size
    obj.TextStrokeTransparency = 0
    obj.TextStrokeColor3 = Color3.fromRGB(30,30,30)
end

-- ================== GUI GỐC ==================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false
gui.Name = "Minecraft_Menu"

-- ================== LOADING ==================
local Loading = Instance.new("Frame", gui)
Loading.Size = UDim2.new(1,0,1,0)
Loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
Loading.BorderSizePixel = 0

local Logo = Instance.new("TextLabel", Loading)
Logo.Size = UDim2.new(0,50,0,50)
Logo.Position = UDim2.new(0.5,-25,0.4,-25)
Logo.BackgroundTransparency = 1
Logo.Text = "MC"
MCText(Logo, 28)

local LoadText = Instance.new("TextLabel", Loading)
LoadText.Size = UDim2.new(0,200,0,40)
LoadText.Position = UDim2.new(0.5,-100,0.55,0)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Loading..."
LoadText.TextColor3 = Color3.fromRGB(200,200,200)
LoadText.Font = Enum.Font.Gotham
LoadText.TextSize = 16

task.spawn(function()
    while LoadText.Parent do
        LoadText.Text = "Loading."
        task.wait(0.4)
        LoadText.Text = "Loading.."
        task.wait(0.4)
        LoadText.Text = "Loading..."
        task.wait(0.4)
    end
end)

task.wait(2.5)
Loading:Destroy()

-- ================== ÂM THANH ==================
local ClickSound = Instance.new("Sound", SoundService)
ClickSound.SoundId = "rbxassetid://5419098676"
ClickSound.Volume = 1

local function Click()
    ClickSound:Play()
end

-- Nhạc Moog City
local BGM = Instance.new("Sound", SoundService)
BGM.Name = "MoogCity"
BGM.SoundId = "rbxassetid://1843529793"
BGM.Volume = 0.4
BGM.Looped = true

-- ================== MENU ==================
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0,380,0,150)
Main.Position = UDim2.new(0.5,-190,0.5,-75)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- Nền đất Minecraft
local BG = Instance.new("ImageLabel", Main)
BG.Size = UDim2.new(1,0,1,0)
BG.Image = "rbxassetid://354387045"
BG.ScaleType = Enum.ScaleType.Tile
BG.TileSize = UDim2.new(0,64,0,64)
BG.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

-- Logo menu
local LogoMenu = Instance.new("TextLabel", Main)
LogoMenu.Size = UDim2.new(0,50,0,50)
LogoMenu.Position = UDim2.new(0,10,0,10)
LogoMenu.BackgroundTransparency = 1
LogoMenu.Text = "MC"
MCText(LogoMenu, 26)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,-80,0,30)
Title.Position = UDim2.new(0,70,0,15)
Title.BackgroundTransparency = 1
Title.Text = "MINECRAFT MENU"
MCText(Title, 16)

-- ================== TAG NGANG ==================
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1,0,0,45)
Container.Position = UDim2.new(0,0,0,90)
Container.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Container)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0,10)

local function CreateTag(name)
    local b = Instance.new("TextButton", Container)
    b.Size = UDim2.new(0,80,0,35)
    b.BackgroundColor3 = Color3.fromRGB(70,45,25)
    b.Text = name.." : OFF"
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    MCText(b, 13)
    return b
end

local Tag1 = CreateTag("TAG 1")
local Tag2 = CreateTag("TAG 2")
local Tag3 = CreateTag("MUSIC")
local Tag4 = CreateTag("TAG 4")

-- ================== LOGIC ==================
-- Tag 4 ví dụ
local Tag4On = false
Tag4.MouseButton1Click:Connect(function()
    Click()
    Tag4On = not Tag4On
    Tag4.Text = Tag4On and "TAG 4 : ON" or "TAG 4 : OFF"
end)

-- Tag 3 bật tắt nhạc
local MusicOn = false
Tag3.MouseButton1Click:Connect(function()
    Click()
    MusicOn = not MusicOn
    if MusicOn then
        BGM:Play()
        Tag3.Text = "MUSIC : ON"
    else
        BGM:Stop()
        Tag3.Text = "MUSIC : OFF"
    end
end)

-- ================== NÚT MENU ==================
local Toggle = Instance.new("TextButton", gui)
Toggle.Size = UDim2.new(0,60,0,30)
Toggle.Position = UDim2.new(0,10,0.5,-15)
Toggle.BackgroundColor3 = Color3.fromRGB(60,40,25)
Toggle.Text = "MENU"
Toggle.BorderSizePixel = 0
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,6)
MCText(Toggle, 12)

Toggle.MouseButton1Click:Connect(function()
    Click()
    Main.Visible = not Main.Visible
    if Main.Visible and not BGM.IsPlaying then
        BGM:Play()
        MusicOn = true
        Tag3.Text = "MUSIC : ON"
    end
end)

-- ================== END ==================