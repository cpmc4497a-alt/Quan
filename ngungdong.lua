-- TIME STOP MOBILE (CLIENT)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local frozenParts = {}
local frozenHumanoids = {}
local stopped = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TimeStopGui"

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,160,0,50)
btn.Position = UDim2.new(0,20,0.6,0)
btn.Text = "🤓 TIME STOP"
btn.BackgroundColor3 = Color3.fromRGB(180,0,0)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.BorderSizePixel = 0
btn.Draggable = true
btn.Active = true

-- FUNCTIONS
local function stopTime()
    stopped = true
    btn.Text = "💀RESUME"
    btn.BackgroundColor3 = Color3.fromRGB(0,160,0)

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Position - hrp.Position).Magnitude < 250 then
            if not v.Anchored then
                frozenParts[v] = v.Velocity
                v.Anchored = true
            end
        elseif v:IsA("Humanoid") and v.Parent ~= char then
            frozenHumanoids[v] = {v.WalkSpeed, v.JumpPower}
            v.WalkSpeed = 0
            v.JumpPower = 0
        end
    end
end

local function resumeTime()
    stopped = false
    btn.Text = "🤓 TIME STOP"
    btn.BackgroundColor3 = Color3.fromRGB(180,0,0)

    for part,vel in pairs(frozenParts) do
        if part and part.Parent then
            part.Anchored = false
            part.Velocity = vel or Vector3.zero
        end
    end

    for hum,data in pairs(frozenHumanoids) do
        if hum and hum.Parent then
            hum.WalkSpeed = data[1]
            hum.JumpPower = data[2]
        end
    end

    frozenParts = {}
    frozenHumanoids = {}
end

-- BUTTON CLICK
btn.MouseButton1Click:Connect(function()
    if stopped then
        resumeTime()
    else
        stopTime()
    end
end)

print("✅ Time Stop Mobile Loaded")