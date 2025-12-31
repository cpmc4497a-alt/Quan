-- TELEPORT SET + TELE (DELTA MOBILE)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SavedCFrame = nil

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportSetTele"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 180, 0, 110)
Frame.Position = UDim2.new(0, 20, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- SET BUTTON
local SetBtn = Instance.new("TextButton")
SetBtn.Parent = Frame
SetBtn.Size = UDim2.new(1, -20, 0, 40)
SetBtn.Position = UDim2.new(0, 10, 0, 10)
SetBtn.Text = "SET VỊ TRÍ"
SetBtn.TextColor3 = Color3.new(1,1,1)
SetBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
SetBtn.BorderSizePixel = 0

-- TELE BUTTON
local TeleBtn = Instance.new("TextButton")
TeleBtn.Parent = Frame
TeleBtn.Size = UDim2.new(1, -20, 0, 40)
TeleBtn.Position = UDim2.new(0, 10, 0, 60)
TeleBtn.Text = "TELE"
TeleBtn.TextColor3 = Color3.new(1,1,1)
TeleBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
TeleBtn.BorderSizePixel = 0

-- SET
SetBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        SavedCFrame = char.HumanoidRootPart.CFrame
        SetBtn.Text = "ĐÃ SET ✔"
        wait(1)
        SetBtn.Text = "SET VỊ TRÍ"
    end
end)

-- TELE
TeleBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if SavedCFrame and char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = SavedCFrame
    end
end)