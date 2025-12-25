-- ===== PORTAL STYLE TELEPORT =====
local Players = game:GetService("Players")

-- TỌA ĐỘ 2 CỔNG
local PortalA_Pos = Vector3.new(0, 5, 0)
local PortalB_Pos = Vector3.new(120, 5, 0)

-- HÀM TẠO PORTAL
local function createPortal(name, pos, color)
    local model = Instance.new("Model", workspace)
    model.Name = name

    local frame = Instance.new("Part", model)
    frame.Size = Vector3.new(6, 8, 1)
    frame.Position = pos
    frame.Anchored = true
    frame.Material = Enum.Material.Neon
    frame.Color = color
    frame.CanCollide = false

    local ring = Instance.new("Part", model)
    ring.Shape = Enum.PartType.Cylinder
    ring.Size = Vector3.new(0.6, 9, 9)
    ring.CFrame = frame.CFrame * CFrame.Angles(0, 0, math.rad(90))
    ring.Anchored = true
    ring.Material = Enum.Material.Neon
    ring.Color = color
    ring.CanCollide = false

    -- HIỆU ỨNG XOAY
    task.spawn(function()
        while true do
            ring.CFrame = ring.CFrame * CFrame.Angles(0, math.rad(2), 0)
            task.wait()
        end
    end)

    return frame
end

-- TẠO 2 PORTAL
local PortalA = createPortal("PortalA", PortalA_Pos, Color3.fromRGB(0,170,255))
local PortalB = createPortal("PortalB", PortalB_Pos, Color3.fromRGB(255,120,0))

-- TELEPORT LOGIC
local debounce = {}

local function linkPortal(fromPortal, toPortal)
    fromPortal.Touched:Connect(function(hit)
        local char = hit.Parent
        local hum = char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if hum and hrp and not debounce[char] then
            debounce[char] = true
            hrp.CFrame = toPortal.CFrame * CFrame.new(0, 0, -4)
            task.wait(0.6)
            debounce[char] = false
        end
    end)
end

linkPortal(PortalA, PortalB)
linkPortal(PortalB, PortalA)