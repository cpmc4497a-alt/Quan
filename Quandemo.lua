-- TELEPORT SET & TELE | DELTA MOBILE
-- Executor: Delta

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")

_G.Pos = nil

-- GUI
local gui = Instance.new("ScreenGui", LP.PlayerGui)
gui.Name = "DeltaTele"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 160, 0, 110)
frame.Position = UDim2.new(0, 20, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true

local function makeBtn(text, y, func)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.Position = UDim2.new(0, 5, 0, y)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.MouseButton1Click:Connect(func)
end

-- SET
makeBtn("SET VỊ TRÍ", 5, function()
    _G.Pos = HRP.CFrame
end)

-- TELE (mượt – giảm kick)
makeBtn("TELE", 55, function()
    if _G.Pos then
        for i = 1, 8 do
            HRP.CFrame = HRP.CFrame:Lerp(_G.Pos, i/8)
            task.wait()
        end
    end
end)