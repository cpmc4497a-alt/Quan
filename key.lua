-- ===== CONFIG =====
local VALID_KEY = "1234"
-- ==================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ================= GUI KEY =================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeyGui"

local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0,260,0,150)
f.Position = UDim2.new(0.5,-130,0.5,-75)
f.BackgroundColor3 = Color3.fromRGB(25,25,25)
f.Active, f.Draggable = true, true

local box = Instance.new("TextBox", f)
box.Size = UDim2.new(1,-20,0,35)
box.Position = UDim2.new(0,10,0,30)
box.PlaceholderText = "Nhập key"
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)

local btn = Instance.new("TextButton", f)
btn.Size = UDim2.new(1,-20,0,35)
btn.Position = UDim2.new(0,10,0,80)
btn.Text = "CHECK KEY"

-- =============== MENU SAU KEY ===============
local function LoadMenu()
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "MiniMenu"

    local m = Instance.new("Frame", sg)
    m.Size = UDim2.new(0,200,0,240)
    m.Position = UDim2.new(0,20,0,120)
    m.BackgroundColor3 = Color3.fromRGB(30,30,30)
    m.Active, m.Draggable = true, true

    local function button(txt,y)
        local b = Instance.new("TextButton", m)
        b.Size = UDim2.new(1,-10,0,35)
        b.Position = UDim2.new(0,5,0,y)
        b.Text = txt
        return b
    end

    local espBtn   = button("ESP",10)
    local tpBtn    = button("TELEPORT",50)
    local noclipBtn= button("NOCLIP",90)
    local viewBtn  = button("VIEW PLAYER",130)
    local stopView = button("STOP VIEW",170)

    -- ESP
    local esp = false
    espBtn.MouseButton1Click:Connect(function()
        esp = not esp
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                if esp then
                    local b = Instance.new("BillboardGui", p.Character.Head)
                    b.Name = "ESP"
                    b.Size = UDim2.new(0,100,0,40)
                    b.AlwaysOnTop = true
                    local t = Instance.new("TextLabel", b)
                    t.Size = UDim2.new(1,0,1,0)
                    t.Text = p.Name
                    t.TextColor3 = Color3.new(1,0,0)
                    t.BackgroundTransparency = 1
                else
                    if p.Character.Head:FindFirstChild("ESP") then
                        p.Character.Head.ESP:Destroy()
                    end
                end
            end
        end
    end)

    -- TELEPORT (tele tới người chơi đầu tiên)
    tpBtn.MouseButton1Click:Connect(function()
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame =
                    p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                break
            end
        end
    end)

    -- NOCLIP
    local noclip = false
    noclipBtn.MouseButton1Click:Connect(function()
        noclip = not noclip
    end)

    RunService.Stepped:Connect(function()
        if noclip and LP.Character then
            for _,v in pairs(LP.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)

    -- VIEW
    viewBtn.MouseButton1Click:Connect(function()
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = p.Character.Humanoid
                break
            end
        end
    end)

    stopView.MouseButton1Click:Connect(function()
        Camera.CameraSubject = LP.Character.Humanoid
    end)
end

-- CHECK KEY
btn.MouseButton1Click:Connect(function()
    if box.Text == VALID_KEY then
        gui:Destroy()
        LoadMenu()
    else
        box.Text = ""
    end
end)