--// REDZ HUB - UNIVERSAL ALL GAME
--// Delta Mobile | SAFE | NO KEY

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Cam = workspace.CurrentCamera
local VU = game:GetService("VirtualUser")

--================ ANTI AFK ================
LP.Idled:Connect(function()
    VU:Button2Down(Vector2.new(), Cam.CFrame)
    task.wait(1)
    VU:Button2Up(Vector2.new(), Cam.CFrame)
end)

--================ SAFE CHAR GET ================
local function getChar()
    return LP.Character or LP.CharacterAdded:Wait()
end

local function getHRP()
    local c = getChar()
    return c:WaitForChild("HumanoidRootPart",5)
end

--================ UI ================
local gui = Instance.new("ScreenGui", LP.PlayerGui)
gui.Name = "RedzUniversal"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,360,0,260)
main.Position = UDim2.new(0.05,0,0.28,0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- Header
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1,0,0,34)
header.Text = "  REDZ HUB | UNIVERSAL"
header.TextXAlignment = Left
header.Font = Enum.Font.GothamBold
header.TextSize = 14
header.TextColor3 = Color3.new(1,1,1)
header.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

-- Menu
local menu = Instance.new("Frame", main)
menu.Position = UDim2.new(0,0,0,34)
menu.Size = UDim2.new(0,95,1,-34)
menu.BackgroundColor3 = Color3.fromRGB(26,26,26)

local function tab(txt,y)
    local b = Instance.new("TextButton", menu)
    b.Size = UDim2.new(1,-10,0,36)
    b.Position = UDim2.new(0,5,0,y)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    return b
end

local tPlayer = tab("Player",10)
local tMove   = tab("Move",52)
local tTele   = tab("Teleport",94)

-- Pages
local function page()
    local p = Instance.new("Frame", main)
    p.Position = UDim2.new(0,95,0,34)
    p.Size = UDim2.new(1,-95,1,-34)
    p.BackgroundTransparency = 1
    p.Visible = false
    return p
end

local pPlayer,pMove,pTele = page(),page(),page()
pPlayer.Visible = true

local function show(p)
    pPlayer.Visible=false
    pMove.Visible=false
    pTele.Visible=false
    p.Visible=true
end

tPlayer.MouseButton1Click:Connect(function() show(pPlayer) end)
tMove.MouseButton1Click:Connect(function() show(pMove) end)
tTele.MouseButton1Click:Connect(function() show(pTele) end)

--================ PLAYER PAGE ================
local list = Instance.new("ScrollingFrame", pPlayer)
list.Size = UDim2.new(1,-10,1,-10)
list.Position = UDim2.new(0,5,0,5)
list.ScrollBarThickness = 3
Instance.new("UIListLayout", list)

local function refreshPlayers()
    list:ClearAllChildren()
    Instance.new("UIListLayout", list)

    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            local b = Instance.new("TextButton", list)
            b.Size = UDim2.new(1,0,0,30)
            b.Text = plr.Name
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextColor3 = Color3.new(1,1,1)
            b.BackgroundColor3 = Color3.fromRGB(48,48,48)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

            -- SAFE GOTO
            b.MouseButton1Click:Connect(function()
                local hrp = getHRP()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
                end
            end)
        end
    end
end

refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

--================ MOVE PAGE (FLY SAFE) ================
local fly = false
local bv,bg

local flyBtn = Instance.new("TextButton", pMove)
flyBtn.Size = UDim2.new(0,150,0,36)
flyBtn.Position = UDim2.new(0,20,0,20)
flyBtn.Text = "Fly : OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
flyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", flyBtn)

flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = fly and "Fly : ON" or "Fly : OFF"

    local hrp = getHRP()

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

--================ TELEPORT PAGE (SAFE TWEEN) ================
local savedCF

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
    savedCF = getHRP().CFrame
    setBtn.Text = "Saved ✔"
    task.wait(0.5)
    setBtn.Text = "Set Position"
end)

teleBtn.MouseButton1Click:Connect(function()
    if savedCF then
        TS:Create(getHRP(), TweenInfo.new(0.4), {CFrame = savedCF}):Play()
    end
end)