-- NTT HUB MINI - DELTA | GUI V3
-- View + GoTo (Anti Kick) + Fly

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NTT_HUB_MINI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 230, 0, 300)
main.Position = UDim2.new(0, 10, 0.28, 0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,26)
title.Text = "NTT HUB MINI | V3"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

-- Buttons top
local stopView = Instance.new("TextButton", main)
stopView.Size = UDim2.new(0.48,0,0,24)
stopView.Position = UDim2.new(0.02,0,0,28)
stopView.Text = "STOP VIEW"
stopView.TextScaled = true
stopView.BackgroundColor3 = Color3.fromRGB(150,60,60)
stopView.TextColor3 = Color3.new(1,1,1)

local flyBtn = Instance.new("TextButton", main)
flyBtn.Size = UDim2.new(0.48,0,0,24)
flyBtn.Position = UDim2.new(0.5,0,0,28)
flyBtn.Text = "FLY : OFF"
flyBtn.TextScaled = true
flyBtn.BackgroundColor3 = Color3.fromRGB(60,120,200)
flyBtn.TextColor3 = Color3.new(1,1,1)

-- Player list
local list = Instance.new("ScrollingFrame", main)
list.Position = UDim2.new(0,5,0,60)
list.Size = UDim2.new(1,-10,1,-65)
list.CanvasSize = UDim2.new(0,0,0,0)
list.ScrollBarImageTransparency = 0

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,5)

-- STOP VIEW
stopView.MouseButton1Click:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        Cam.CameraSubject = LP.Character.Humanoid
    end
end)

-- SAFE GOTO
local function safeGoto(plr)
    if not (LP.Character and plr.Character) then return end
    local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
    local thrp = plr.Character:FindFirstChild("HumanoidRootPart")
    if not (hrp and thrp) then return end

    hrp.Velocity = Vector3.zero
    TweenService:Create(
        hrp,
        TweenInfo.new(0.25, Enum.EasingStyle.Linear),
        {CFrame = thrp.CFrame * CFrame.new(0,0,-4)}
    ):Play()
end

-- FLY
local flying = false
local bv, bg
local flySpeed = 60

local function startFly()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(1e5,1e5,1e5)

    bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(1e5,1e5,1e5)

    flying = true
    flyBtn.Text = "FLY : ON"
end

local function stopFly()
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    flying = false
    flyBtn.Text = "FLY : OFF"
end

flyBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

RunService.RenderStepped:Connect(function()
    if flying and bv and bg then
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            bv.Velocity = Cam.CFrame.LookVector * flySpeed
            bg.CFrame = Cam.CFrame
        end
    end
end)

-- PLAYER LIST
local function refresh()
    for _,v in ipairs(list:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local item = Instance.new("Frame", list)
            item.Size = UDim2.new(1,0,0,46)
            item.BackgroundColor3 = Color3.fromRGB(35,35,35)

            local name = Instance.new("TextLabel", item)
            name.Size = UDim2.new(1,0,0,18)
            name.Text = plr.Name
            name.TextScaled = true
            name.TextColor3 = Color3.new(1,1,1)
            name.BackgroundTransparency = 1

            local view = Instance.new("TextButton", item)
            view.Size = UDim2.new(0.48,0,0,22)
            view.Position = UDim2.new(0.01,0,0.5,0)
            view.Text = "VIEW"
            view.TextScaled = true
            view.BackgroundColor3 = Color3.fromRGB(70,120,200)
            view.TextColor3 = Color3.new(1,1,1)

            local gotoBtn = Instance.new("TextButton", item)
            gotoBtn.Size = UDim2.new(0.48,0,0,22)
            gotoBtn.Position = UDim2.new(0.51,0,0.5,0)
            gotoBtn.Text = "GOTO"
            gotoBtn.TextScaled = true
            gotoBtn.BackgroundColor3 = Color3.fromRGB(70,200,120)
            gotoBtn.TextColor3 = Color3.new(1,1,1)

            view.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    Cam.CameraSubject = plr.Character.Humanoid
                end
            end)

            gotoBtn.MouseButton1Click:Connect(function()
                safeGoto(plr)
            end)
        end
    end

    task.wait()
    list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 5)
end

refresh()
Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)