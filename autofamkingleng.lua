--==================================================
-- KING LEGACY | PRO FULL + ANTI KICK/AFK | GUI DỌC
-- Mobile Delta | Auto Level Max + Quest + Boss + ESP Fruit
--==================================================

-- TRÁNH CHẠY 2 LẦN
if game.CoreGui:FindFirstChild("KL_PRO_GUI") then
    game.CoreGui.KL_PRO_GUI:Destroy()
end

-- ====== SETTINGS ======
getgenv().AutoLevel = false
getgenv().AutoQuest = false
getgenv().AutoBoss  = false
getgenv().ESPFruit  = false
getgenv().AntiDie   = true

-- ====== SERVICES ======
local Players = game:GetService("Players")
local VU = game:GetService("VirtualUser")
local plr = Players.LocalPlayer

local function getChar()
    return plr.Character or plr.CharacterAdded:Wait()
end
local char = getChar()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

plr.CharacterAdded:Connect(function(c)
    char = c
    hrp = c:WaitForChild("HumanoidRootPart")
    hum = c:WaitForChild("Humanoid")
end)

-- ====== ANTI AFK / ANTI KICK ======
plr.Idled:Connect(function()
    VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ====== GUI (2 CỘT DỌC) ======
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KL_PRO_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,360,0,360)
frame.Position = UDim2.new(0.05,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "👑 KING LEGACY PRO FULL"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)

local leftCol = Instance.new("Frame", frame)
leftCol.Position = UDim2.new(0,10,0,50)
leftCol.Size = UDim2.new(0.5,-15,1,-60)
leftCol.BackgroundTransparency = 1

local rightCol = Instance.new("Frame", frame)
rightCol.Position = UDim2.new(0.5,5,0,50)
rightCol.Size = UDim2.new(0.5,-15,1,-60)
rightCol.BackgroundTransparency = 1

local function makeBtn(parent, text, y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,0,0,40)
    b.Position = UDim2.new(0,0,0,y)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    return b
end

-- NÚT CỘT TRÁI (FARM)
local btnFarm  = makeBtn(leftCol, "AUTO LEVEL : OFF", 0)
local btnQuest = makeBtn(leftCol, "AUTO QUEST : OFF", 50)
local btnBoss  = makeBtn(leftCol, "AUTO BOSS : OFF", 100)

-- NÚT CỘT PHẢI (TIỆN ÍCH)
local btnESP   = makeBtn(rightCol, "ESP FRUIT : OFF", 0)
local btnSafe  = makeBtn(rightCol, "TELE SAFE", 50)
local btnClose = makeBtn(rightCol, "CLOSE GUI", 100)

-- EVENTS
btnFarm.MouseButton1Click:Connect(function()
    AutoLevel = not AutoLevel
    btnFarm.Text = AutoLevel and "AUTO LEVEL : ON" or "AUTO LEVEL : OFF"
end)
btnQuest.MouseButton1Click:Connect(function()
    AutoQuest = not AutoQuest
    btnQuest.Text = AutoQuest and "AUTO QUEST : ON" or "AUTO QUEST : OFF"
end)
btnBoss.MouseButton1Click:Connect(function()
    AutoBoss = not AutoBoss
    btnBoss.Text = AutoBoss and "AUTO BOSS : ON" or "AUTO BOSS : OFF"
end)
btnESP.MouseButton1Click:Connect(function()
    ESPFruit = not ESPFruit
    btnESP.Text = ESPFruit and "ESP FRUIT : ON" or "ESP FRUIT : OFF"
end)
btnSafe.MouseButton1Click:Connect(function()
    hrp.CFrame = CFrame.new(0,500,0)
end)
btnClose.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ====== LEVEL TABLE ======
local MobByLevel = {
    {Min=1, Max=300, Name="Bandit"},
    {Min=301, Max=700, Name="Pirate"},
    {Min=701, Max=1500, Name="Marine"},
    {Min=1501, Max=3000, Name="Fishman"},
    {Min=3001, Max=5000, Name="Sky Pirate"},
}
local function getLevel()
    local ls = plr:FindFirstChild("leaderstats")
    return ls and ls:FindFirstChild("Level") and ls.Level.Value or 1
end
local function pickMob()
    local lv = getLevel()
    for _,m in ipairs(MobByLevel) do
        if lv >= m.Min and lv <= m.Max then return m.Name end
    end
    return MobByLevel[#MobByLevel].Name
end

-- ====== ANTI DIE ======
task.spawn(function()
    while true do
        if AntiDie and hum and hum.Health < hum.MaxHealth*0.4 then
            hum.Health = hum.MaxHealth
        end
        task.wait(0.5)
    end
end)

-- ====== AUTO FARM (LEVEL) ======
task.spawn(function()
    while true do
        if AutoLevel then
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then
                local name = pickMob()
                for _,mob in ipairs(enemies:GetChildren()) do
                    if mob.Name == name
                    and mob:FindFirstChild("HumanoidRootPart")
                    and mob:FindFirstChild("Humanoid")
                    and mob.Humanoid.Health > 0 then
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                        VU:Button1Down(Vector2.new(0,0))
                    end
                end
            end
        end
        task.wait(0.15)
    end
end)

-- ====== AUTO BOSS ======
task.spawn(function()
    while true do
        if AutoBoss then
            local bosses = workspace:FindFirstChild("Bosses")
            if bosses then
                for _,b in ipairs(bosses:GetChildren()) do
                    if b:FindFirstChild("HumanoidRootPart")
                    and b:FindFirstChild("Humanoid")
                    and b.Humanoid.Health > 0 then
                        hrp.CFrame = b.HumanoidRootPart.CFrame * CFrame.new(0,0,6)
                        VU:Button1Down(Vector2.new(0,0))
                    end
                end
            end
        end
        task.wait(0.25)
    end
end)

-- ====== ESP FRUIT ======
task.spawn(function()
    while true do
        if ESPFruit then
            for _,v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Tool") and v.Name:lower():find("fruit") then
                    if not v:FindFirstChild("ESP") then
                        local bg = Instance.new("BillboardGui", v)
                        bg.Name = "ESP"
                        bg.AlwaysOnTop = true
                        bg.Size = UDim2.new(0,120,0,40)
                        local tl = Instance.new("TextLabel", bg)
                        tl.Size = UDim2.new(1,0,1,0)
                        tl.BackgroundTransparency = 1
                        tl.Text = "FRUIT: "..v.Name
                        tl.TextColor3 = Color3.fromRGB(255,170,0)
                    end
                end
            end
        else
            for _,v in ipairs(workspace:GetDescendants()) do
                if v:FindFirstChild("ESP") then v.ESP:Destroy() end
            end
        end
        task.wait(1)
    end
end)