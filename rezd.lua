--// REDZ HUB | UNIVERSAL PRO FULL
--// UI CLONE REDZ | DELTA MOBILE | SAFE

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Cam = workspace.CurrentCamera
local VU = game:GetService("VirtualUser")

--================ ANTI AFK =================
LP.Idled:Connect(function()
    VU:Button2Down(Vector2.new(), Cam.CFrame)
    task.wait(1)
    VU:Button2Up(Vector2.new(), Cam.CFrame)
end)

--================ CHAR =================
local function Char()
    return LP.Character or LP.CharacterAdded:Wait()
end

local function HRP()
    return Char():WaitForChild("HumanoidRootPart")
end

--================ UI ROOT =================
local gui = Instance.new("ScreenGui", LP.PlayerGui)
gui.Name = "RedzHubClone"
gui.ResetOnSpawn = false

-- Main
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,260)
main.Position = UDim2.new(0.05,0,0.28,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,8)

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,28)
header.BackgroundColor3 = Color3.fromRGB(180,180,180)
Instance.new("UICorner", header).CornerRadius = UDim.new(0,8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,0,1,0)
title.Text = "REDZ HUB | UNIVERSAL"
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(20,20,20)
title.BackgroundTransparency = 1

-- Menu Left
local menu = Instance.new("Frame", main)
menu.Position = UDim2.new(0,0,0,28)
menu.Size = UDim2.new(0,90,1,-28)
menu.BackgroundColor3 = Color3.fromRGB(22,22,22)

-- Content
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,90,0,28)
content.Size = UDim2.new(1,-90,1,-28)
content.BackgroundColor3 = Color3.fromRGB(10,10,10)

--================ BUTTON =================
local function MenuBtn(txt,y)
    local b = Instance.new("TextButton", menu)
    b.Size = UDim2.new(1,-10,0,34)
    b.Position = UDim2.new(0,5,0,y)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b)
    return b
end

local bPlayer = MenuBtn("Player",10)
local bMove   = MenuBtn("Move",52)
local bTele   = MenuBtn("Teleport",94)
local bHide   = MenuBtn("Hide",136)

--================ PAGE =================
local function Page()
    local p = Instance.new("Frame", content)
    p.Size = UDim2.new(1,0,1,0)
    p.BackgroundTransparency = 1
    p.Visible = false
    return p
end

local pPlayer,pMove,pTele = Page(),Page(),Page()
pPlayer.Visible = true

local function Show(p)
    pPlayer.Visible=false
    pMove.Visible=false
    pTele.Visible=false
    p.Visible=true
end

bPlayer.MouseButton1Click:Connect(function() Show(pPlayer) end)
bMove.MouseButton1Click:Connect(function() Show(pMove) end)
bTele.MouseButton1Click:Connect(function() Show(pTele) end)
bHide.MouseButton1Click:Connect(function() main.Visible = false end)

--================ PLAYER =================
local list = Instance.new("ScrollingFrame", pPlayer)
list.Size = UDim2.new(1,-10,1,-10)
list.Position = UDim2.new(0,5,0,5)
list.ScrollBarThickness = 3
local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,6)

local function Refresh()
    list:ClearAllChildren()
    layout.Parent = list
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            local b = Instance.new("TextButton", list)
            b.Size = UDim2.new(1,0,0,30)
            b.Text = plr.Name
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextColor3 = Color3.new(1,1,1)
            b.BackgroundColor3 = Color3.fromRGB(50,50,50)
            Instance.new("UICorner", b)

            b.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    HRP().CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
                end
            end)
        end
    end
end

Refresh()
Players.PlayerAdded:Connect(Refresh)
Players.PlayerRemoving:Connect(Refresh)

--================ FLY =================
local fly=false
local bv,bg

local flyBtn = Instance.new("TextButton", pMove)
flyBtn.Size = UDim2.new(0,160,0,36)
flyBtn.Position = UDim2.new(0,20,0,20)
flyBtn.Text = "Fly : OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
flyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", flyBtn)

flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = fly and "Fly : ON" or "Fly : OFF"
    local hrp = HRP()

    if fly then
        bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)

        bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)

        RS.RenderStepped:Connect(function()
            if fly then
                bv.Velocity = Cam.CFrame.LookVector * 40
                bg.CFrame = Cam.CFrame
            end
        end)
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)

--================ TELEPORT =================
local saveCF

local setBtn = Instance.new("TextButton", pTele)
setBtn.Size = UDim2.new(0,160,0,36)
setBtn.Position = UDim2.new(0,20,0,20)
setBtn.Text = "Set Position"
setBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
setBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", setBtn)

local teleBtn = Instance.new("TextButton", pTele)
teleBtn.Size = UDim2.new(0,160,0,36)
teleBtn.Position = UDim2.new(0,20,0,70)
teleBtn.Text = "Teleport"
teleBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
teleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", teleBtn)

setBtn.MouseButton1Click:Connect(function()
    saveCF = HRP().CFrame
    setBtn.Text = "Saved ✔"
    task.wait(0.6)
    setBtn.Text = "Set Position"
end)

teleBtn.MouseButton1Click:Connect(function()
    if saveCF then
        TS:Create(HRP(), TweenInfo.new(0.4), {CFrame = saveCF}):Play()
    end
end)