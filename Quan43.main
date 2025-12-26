-- ================= QUAN43 V5 | FULL =================
repeat task.wait() until game:IsLoaded()

-- ===== SERVICES =====
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

-- ===== CONFIG =====
local LINKVERTISE = "https://linkvertise.com/QUAN43KEY" -- LINK GET KEY
local KEY_DATA = "https://pastebin.com/raw/QUAN43KEY"   -- LINK LƯU KEY
local THEME_ON  = Color3.fromRGB(170,0,0)
local THEME_OFF = Color3.fromRGB(35,35,35)

-- ===== ANTI AFK =====
LP.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
end)

-- ===== CONFIG SAVE =====
local CFG_FILE = "Quan43V5_Config.json"
local CFG = {Speed=false,Jump=false,Fly=false,ESP=false}

pcall(function()
    if isfile(CFG_FILE) then
        CFG = HttpService:JSONDecode(readfile(CFG_FILE))
    end
end)

local function SaveCFG()
    writefile(CFG_FILE, HttpService:JSONEncode(CFG))
end

-- ===== GET REAL KEY =====
local function GetRealKey()
    local raw = game:HttpGet(KEY_DATA)
    local key = raw:match("KEY=(.-)\n")
    local exp = raw:match("EXPIRE=(.+)")
    return key, exp
end

local function IsExpired(date)
    local y,m,d = date:match("(%d+)%-(%d+)%-(%d+)")
    return os.time() > os.time({year=y,month=m,day=d})
end

-- ===== OPEN LINKVERTISE =====
local function OpenLink()
    setclipboard(LINKVERTISE)
    StarterGui:SetCore("SendNotification",{
        Title="QUAN43",
        Text="Đã copy link, dán vào trình duyệt để lấy KEY",
        Duration=6
    })
end

-- ===== KEY UI =====
local gui = Instance.new("ScreenGui", LP.PlayerGui)
local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0,320,0,210)
f.Position = UDim2.new(0.5,-160,0.5,-105)
f.BackgroundColor3 = Color3.fromRGB(15,15,15)
f.Active=true f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,14)

local getkey = Instance.new("TextButton", f)
getkey.Size=UDim2.new(0.5,0,0,35)
getkey.Position=UDim2.new(0.25,0,0.12,0)
getkey.Text="GET KEY"
getkey.BackgroundColor3=THEME_ON
getkey.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",getkey).CornerRadius=UDim.new(0,10)

local box = Instance.new("TextBox", f)
box.Size=UDim2.new(0.85,0,0,40)
box.Position=UDim2.new(0.075,0,0.38,0)
box.PlaceholderText="Nhập KEY"
box.BackgroundColor3=Color3.fromRGB(30,30,30)
box.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",box).CornerRadius=UDim.new(0,10)

local login = Instance.new("TextButton", f)
login.Size=UDim2.new(0.5,0,0,40)
login.Position=UDim2.new(0.25,0,0.65,0)
login.Text="LOGIN"
login.BackgroundColor3=THEME_OFF
login.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",login).CornerRadius=UDim.new(0,10)

getkey.MouseButton1Click:Connect(OpenLink)

-- ===== MAIN UI =====
local function LoadUI()
    local ui = Instance.new("ScreenGui", LP.PlayerGui)
    local bar = Instance.new("Frame", ui)
    bar.Size=UDim2.new(0,460,0,110)
    bar.Position=UDim2.new(0.5,-230,0.85,0)
    bar.BackgroundColor3=Color3.fromRGB(15,15,15)
    bar.Active=true bar.Draggable=true
    Instance.new("UICorner",bar).CornerRadius=UDim.new(0,16)

    local grid=Instance.new("UIGridLayout",bar)
    grid.CellSize=UDim2.new(0,90,0,40)
    grid.CellPadding=UDim2.new(0,8,0,8)

    local function Toggle(name,callback)
        local b=Instance.new("TextButton",bar)
        b.Text=name
        b.TextColor3=Color3.new(1,1,1)
        b.Font=Enum.Font.GothamBold
        b.TextSize=12
        local state=CFG[name] or false
        b.BackgroundColor3=state and THEME_ON or THEME_OFF
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
        callback(state)
        b.MouseButton1Click:Connect(function()
            state=not state
            CFG[name]=state
            b.BackgroundColor3=state and THEME_ON or THEME_OFF
            SaveCFG()
            callback(state)
        end)
    end

    Toggle("Speed",function(v)
        LP.Character.Humanoid.WalkSpeed = v and 100 or 16
    end)

    Toggle("Jump",function(v)
        LP.Character.Humanoid.JumpPower = v and 150 or 50
    end)

    Toggle("Fly",function(v)
        local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if v then
            local bv=Instance.new("BodyVelocity",hrp)
            bv.Name="Q43Fly"
            bv.MaxForce=Vector3.new(9e9,9e9,9e9)
            task.spawn(function()
                while bv.Parent do
                    bv.Velocity=workspace.CurrentCamera.CFrame.LookVector*60
                    task.wait()
                end
            end)
        else
            if hrp:FindFirstChild("Q43Fly") then hrp.Q43Fly:Destroy() end
        end
    end)

    Toggle("ESP",function(v)
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                if v and not p.Character:FindFirstChild("ESP") then
                    Instance.new("Highlight",p.Character).Name="ESP"
                elseif not v and p.Character:FindFirstChild("ESP") then
                    p.Character.ESP:Destroy()
                end
            end
        end
    end)
end

-- ===== LOGIN =====
login.MouseButton1Click:Connect(function()
    local REAL_KEY, EXPIRE = GetRealKey()
    if IsExpired(EXPIRE) then
        box.Text=""
        box.PlaceholderText="❌ KEY HẾT HẠN"
        return
    end
    if box.Text == REAL_KEY then
        gui:Destroy()
        LoadUI()
    else
        box.Text=""
        box.PlaceholderText="❌ KEY SAI"
    end
end)

print("🔥 QUAN43 V5 LOADED")