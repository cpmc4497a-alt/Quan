loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

-- ===== WINDOW =====
local Window = MakeWindow({
    Hub = {
        Title = "TỔNG HỢP",
        Animation = "Youtube: TỔNG HỢP"
    },
    Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            Incorrectkey = "The key is incorrect",
            CopyKeyLink = "Copied to Clipboard"
        }
    }
})

MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=6239940100",
    Size = {30, 30},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = false,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- ===== TABS =====
local Tab1o = MakeTab({Name = "Script Farm"})
local Tab2o = MakeTab({Name = "Misc"})
local Tag3o = MakeTab({Name = "Điều Khiển"})
local Tag4o = MakeTab({Name = "speed / jump"}) -- ✅ TAG 4 ĐÃ TẠO
local Tag5o = MakeTab({Name = "ESP"})
local Tag6o = MakeTab({Name = "FLOAT"})

-- ===== TAB 1 =====
AddButton(Tab1o,{
    Name = "Redz Hub",
    Callback = function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"
        ))({
            JoinTeam = "Pirates",
            Translator = true
        })
    end
})

-- ===== TAB 2 =====
AddButton(Tab2o,{
    Name = "FREEZE",
    Callback = function()
        local player = game.Players.LocalPlayer

        if player.PlayerGui:FindFirstChild("FreezeGUI") then
            player.PlayerGui.FreezeGUI:Destroy()
        end

        local frozen = false
        local gui = Instance.new("ScreenGui", player.PlayerGui)
        gui.Name = "FreezeGUI"
        gui.ResetOnSpawn = false

        local btn = Instance.new("TextButton", gui)
        btn.Size = UDim2.new(0,160,0,45)
        btn.Position = UDim2.new(0,20,0.5,-25)
        btn.Text = "❄️ FREEZE"
        btn.TextScaled = true
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BorderSizePixel = 0

        btn.MouseButton1Click:Connect(function()
            local char = player.Character or player.CharacterAdded:Wait()
            frozen = not frozen
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Anchored = frozen
                end
            end
            btn.Text = frozen and "🔥 UNFREEZE" or "❄️ FREEZE"
        end)
    end
})

-- ===== TAG 3 : ĐIỀU KHIỂN DPAD =====
AddButton(Tag3o,{
    Name = "BẬT / TẮT ĐIỀU KHIỂN",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local plr = Players.LocalPlayer
        local cam = workspace.CurrentCamera

        if _G.DPAD then
            _G.DPAD:Destroy()
            _G.DPAD = nil
            _G.MoveDir = Vector3.zero
            if _G.MoveConn then
                _G.MoveConn:Disconnect()
                _G.MoveConn = nil
            end
            return
        end

        local char = plr.Character or plr.CharacterAdded:Wait()
        local hum = char:WaitForChild("Humanoid")

        _G.MoveDir = Vector3.zero
        local speed = 1.5

        local gui = Instance.new("ScreenGui", plr.PlayerGui)
        gui.Name = "DPAD"
        gui.ResetOnSpawn = false
        _G.DPAD = gui

        local function btn(txt,pos)
            local b = Instance.new("TextButton", gui)
            b.Size = UDim2.new(0,70,0,70)
            b.Position = pos
            b.Text = txt
            b.TextScaled = true
            b.BackgroundColor3 = Color3.fromRGB(30,30,30)
            b.TextColor3 = Color3.fromRGB(255,170,0)
            b.BorderSizePixel = 0
            return b
        end

        local x,y = 0.05,0.65
        local Up = btn("▲",UDim2.new(x+0.07,0,y-0.12,0))
        local Down = btn("▼",UDim2.new(x+0.07,0,y+0.12,0))
        local Left = btn("◀",UDim2.new(x-0.02,0,y,0))
        local Right = btn("▶",UDim2.new(x+0.16,0,y,0))

        local function hold(b,vec)
            b.MouseButton1Down:Connect(function()
                _G.MoveDir = vec()
            end)
            b.MouseButton1Up:Connect(function()
                _G.MoveDir = Vector3.zero
            end)
        end

        hold(Up,function() return cam.CFrame.LookVector end)
        hold(Down,function() return -cam.CFrame.LookVector end)
        hold(Left,function() return -cam.CFrame.RightVector end)
        hold(Right,function() return cam.CFrame.RightVector end)

        _G.MoveConn = RunService.RenderStepped:Connect(function()
            hum:Move(_G.MoveDir * speed,false)
        end)
    end
})

-- ===== TAG 4 : SPEED & JUMP TOGGLE =====

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local SpeedJumpEnabled = false
local CustomSpeed = 100      -- chỉnh speed ở đây
local CustomJump = 120       -- chỉnh jump ở đây

AddButton(Tag4o,{
    Name = "BẬT / TẮT SPEED & JUMP",
    Callback = function()
        SpeedJumpEnabled = not SpeedJumpEnabled

        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end

        if SpeedJumpEnabled then
            hum.WalkSpeed = CustomSpeed
            hum.JumpPower = CustomJump

            game.StarterGui:SetCore("SendNotification",{
                Title = "Speed & Jump",
                Text = "ĐÃ BẬT",
                Duration = 2
            })
        else
            hum.WalkSpeed = 16
            hum.JumpPower = 50

            game.StarterGui:SetCore("SendNotification",{
                Title = "Speed & Jump",
                Text = "ĐÃ TẮT",
                Duration = 2
            })
        end
    end
})

-- GIỮ SPEED & JUMP KHI CHẾT / HỒI SINH
player.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:WaitForChild("Humanoid")

    if SpeedJumpEnabled then
        hum.WalkSpeed = CustomSpeed
        hum.JumpPower = CustomJump
    end
end)

-- ===== TAG 5 : ESP & CHAMS =====
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ESP_Player = false
local ESP_Item = false
local Chams_On = false

local ESP_Objects = {}

local function ClearESP()
    for _,v in pairs(ESP_Objects) do
        if v then v:Destroy() end
    end
    ESP_Objects = {}
end

-- ===== ESP PLAYER =====
AddButton(Tag5o,{
    Name = "ESP PLAYER",
    Callback = function()
        ESP_Player = not ESP_Player
        ClearESP()

        if not ESP_Player then return end

        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local function espChar(char)
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end

                    local box = Instance.new("BoxHandleAdornment")
                    box.Size = hrp.Size + Vector3.new(2,3,2)
                    box.Adornee = hrp
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Transparency = 0.5
                    box.Color3 = Color3.fromRGB(255,0,0)
                    box.Parent = hrp

                    table.insert(ESP_Objects, box)
                end

                if plr.Character then
                    espChar(plr.Character)
                end
                plr.CharacterAdded:Connect(espChar)
            end
        end
    end
})


-- ===== ESP ITEM (Tool) =====
AddButton(Tag5o,{
    Name = "ESP ITEM",
    Callback = function()
        ESP_Item = not ESP_Item
        ClearESP()

        if not ESP_Item then return end

        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = v.Handle.Size
                box.Adornee = v.Handle
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Transparency = 0.5
                box.Color3 = Color3.fromRGB(0,255,0)
                box.Parent = v.Handle
                table.insert(ESP_Objects, box)
            end
        end
    end
})

-- ===== CHAMS =====
AddButton(Tag5o,{
    Name = "CHAMS",
    Callback = function()
        Chams_On = not Chams_On

        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                for _,p in pairs(plr.Character:GetChildren()) do
                    if p:IsA("BasePart") then
                        if Chams_On then
                            p.Material = Enum.Material.ForceField
                            p.Color = Color3.fromRGB(255,0,255)
                        else
                            p.Material = Enum.Material.Plastic
                        end
                    end
                end
            end
        end
    end
})

-- ===== TAG 6 : FLOAT =====
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local Floating = false
local FloatConn
local BV

AddButton(Tag6o,{
    Name = "FLOAT MAIN",
    Callback = function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        Floating = not Floating

        if Floating then
            BV = Instance.new("BodyVelocity")
            BV.Name = "FLOAT_VELOCITY"
            BV.MaxForce = Vector3.new(0, math.huge, 0)
            BV.Velocity = Vector3.new(0, 2.5, 0)
            BV.Parent = hrp

            FloatConn = RunService.RenderStepped:Connect(function()
                if BV then
                    BV.Velocity = Vector3.new(0, 2.5, 0)
                end
            end)

            game.StarterGui:SetCore("SendNotification",{
                Title = "FLOAT",
                Text = "ĐÃ BẬT FLOAT",
                Duration = 2
            })
        else
            if FloatConn then FloatConn:Disconnect() end
            if BV then BV:Destroy() end

            game.StarterGui:SetCore("SendNotification",{
                Title = "FLOAT",
                Text = "ĐÃ TẮT FLOAT",
                Duration = 2
            })
        end
    end
})