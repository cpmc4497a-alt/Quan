loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

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
    Image = "http://www.roblox.com/asset/?id=117401083783337",
    Size = {512, 512},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = false,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- TAB
local Tab1o = MakeTab({Name = "Script Farm"})

-- REDZ HUB
AddButton(Tab1o, {
    Name = "Redz Hub",
    Callback = function()
        local Settings = {
            JoinTeam = "Pirates",
            Translator = true
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))(Settings)
    end
})

-- TELEPORT SET & GO
AddButton(Tab1o, {
    Name = "TELEPORT (SET & GO)",
    Callback = function()

        if game.CoreGui:FindFirstChild("TeleportSet") then
            game.CoreGui.TeleportSet.Enabled = not game.CoreGui.TeleportSet.Enabled
            return
        end

        local Players = game:GetService("Players")
        local LP = Players.LocalPlayer
        local savedCFrame

        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "TeleportSet"

        local main = Instance.new("Frame", gui)
        main.Size = UDim2.new(0, 260, 0, 200)
        main.Position = UDim2.new(0.5, -130, 0.5, -100)
        main.BackgroundColor3 = Color3.fromRGB(25,25,25)
        main.BorderSizePixel = 0
        main.Active = true
        main.Draggable = true

        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(1,0,0,40)
        title.Text = "TELEPORT HUB"
        title.TextColor3 = Color3.fromRGB(255,0,0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 18

        local function button(text, y, callback)
            local b = Instance.new("TextButton", main)
            b.Size = UDim2.new(1,-20,0,35)
            b.Position = UDim2.new(0,10,0,y)
            b.Text = text
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            b.MouseButton1Click:Connect(callback)
        end

        -- SET
        button("SET VỊ TRÍ", 50, function()
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                savedCFrame = LP.Character.HumanoidRootPart.CFrame
            end
        end)

        -- TELE
        button("TELE ĐẾN VỊ TRÍ", 95, function()
            if savedCFrame and LP.Character then
                LP.Character.HumanoidRootPart.CFrame = savedCFrame
            end
        end)

        -- TELE CHUỘT
        button("TELE THEO CHUỘT", 140, function()
            local mouse = LP:GetMouse()
            mouse.Button1Down:Connect(function()
                if LP.Character then
                    LP.Character:MoveTo(mouse.Hit.p)
                end
            end)
        end)
    end
})