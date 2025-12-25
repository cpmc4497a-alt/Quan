--// REDZ GOD HUB V∞ | Delta Mobile | Stable Build

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local LP=Players.LocalPlayer
local Cam=workspace.CurrentCamera

-- ===== CHAR SAFE =====
local Char,HRP,Hum
local function bind(c)
    Char=c; HRP=c:WaitForChild("HumanoidRootPart"); Hum=c:WaitForChild("Humanoid")
end
bind(LP.Character or LP.CharacterAdded:Wait())
LP.CharacterAdded:Connect(bind)

-- ===== ANTI AFK =====
pcall(function() for _,v in pairs(getconnections(LP.Idled)) do v:Disable() end end)

-- ===== GUI =====
local gui=Instance.new("ScreenGui",game.CoreGui)
gui.Name="REDZ_V_INF"

local main=Instance.new("Frame",gui)
main.Size=UDim2.fromScale(0.5,0.65)
main.Position=UDim2.fromScale(0.02,0.18)
main.BackgroundColor3=Color3.fromRGB(14,14,14)
main.Active,main.Draggable=true,true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,16)

local title=Instance.new("TextLabel",main)
title.Size=UDim2.fromScale(1,0.08)
title.Text="REDZ GOD HUB  V ∞"
title.TextScaled=true
title.TextColor3=Color3.fromRGB(255,60,60)
title.BackgroundTransparency=1

-- Tabs
local tabs=Instance.new("Frame",main)
tabs.Size=UDim2.fromScale(1,0.08)
tabs.Position=UDim2.fromScale(0,0.08)
tabs.BackgroundTransparency=1

local pages={}
local function page(n)
    local f=Instance.new("Frame",main)
    f.Size=UDim2.fromScale(1,0.84)
    f.Position=UDim2.fromScale(0,0.16)
    f.BackgroundTransparency=1
    f.Visible=false
    pages[n]=f
end
page("MAIN"); page("PLAYER"); page("MOVE"); page("ESP"); page("MISC")
pages.MAIN.Visible=true

local function tab(txt,x,cb)
    local b=Instance.new("TextButton",tabs)
    b.Size=UDim2.fromScale(0.18,1)
    b.Position=UDim2.fromScale(x,0)
    b.Text=txt; b.TextScaled=true
    b.BackgroundColor3=Color3.fromRGB(28,28,28)
    b.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
    b.MouseButton1Click:Connect(cb)
end
local function show(n) for _,p in pairs(pages) do p.Visible=false end pages[n].Visible=true end
tab("MAIN",0.01,function()show("MAIN")end)
tab("PLAYER",0.21,function()show("PLAYER")end)
tab("MOVE",0.41,function()show("MOVE")end)
tab("ESP",0.61,function()show("ESP")end)
tab("MISC",0.81,function()show("MISC")end)

local function btn(p,txt,y)
    local b=Instance.new("TextButton",p)
    b.Size=UDim2.fromScale(0.92,0.1)
    b.Position=UDim2.fromScale(0.04,y)
    b.Text=txt; b.TextScaled=true
    b.BackgroundColor3=Color3.fromRGB(26,26,26)
    b.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,12)
    return b
end

-- ===== STATE =====
local S={
    fly=false,fs=60,bv=nil,bg=nil,
    noclip=false,ws=16,jp=50,
    saveCF=nil,
    esp=false,espC={},
    players={},idx=1,view=false
}
local function refresh() S.players=Players:GetPlayers(); if S.idx>#S.players then S.idx=1 end end
refresh()
Players.PlayerAdded:Connect(refresh); Players.PlayerRemoving:Connect(refresh)
local function cur()
    refresh()
    local p=S.players[S.idx]
    if p==LP then S.idx=S.idx%#S.players+1; p=S.players[S.idx] end
    return p
end

-- ===== MAIN =====
local fly=btn(pages.MAIN,"FLY : OFF",0.06)
local fs=btn(pages.MAIN,"FLY SPEED : 60",0.18)
local nc=btn(pages.MAIN,"NOCLIP : OFF",0.30)
local set=btn(pages.MAIN,"SET POSITION",0.42)
local tp=btn(pages.MAIN,"TELEPORT",0.54)
local hide=btn(pages.MAIN,"HIDE / SHOW",0.66)

fly.MouseButton1Click:Connect(function()
    S.fly=not S.fly; fly.Text=S.fly and "FLY : ON" or "FLY : OFF"
    if S.fly then
        S.bv=Instance.new("BodyVelocity",HRP)
        S.bg=Instance.new("BodyGyro",HRP)
        S.bv.MaxForce=Vector3.new(9e9,9e9,9e9)
        S.bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
        RunService.RenderStepped:Connect(function()
            if S.fly and HRP then
                S.bv.Velocity=Cam.CFrame.LookVector*S.fs
                S.bg.CFrame=Cam.CFrame
            end
        end)
    else
        if S.bv then S.bv:Destroy() end
        if S.bg then S.bg:Destroy() end
    end
end)
fs.MouseButton1Click:Connect(function()
    S.fs+=20; if S.fs>200 then S.fs=40 end
    fs.Text="FLY SPEED : "..S.fs
end)
nc.MouseButton1Click:Connect(function()
    S.noclip=not S.noclip
    nc.Text=S.noclip and "NOCLIP : ON" or "NOCLIP : OFF"
end)
RunService.Stepped:Connect(function()
    if S.noclip and Char then
        for _,v in pairs(Char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
end)
set.MouseButton1Click:Connect(function() S.saveCF=HRP and HRP.CFrame end)
tp.MouseButton1Click:Connect(function()
    if S.saveCF and HRP then HRP.CFrame=S.saveCF+Vector3.new(0,3,0) end
end)
local hidden=false
hide.MouseButton1Click:Connect(function() hidden=not hidden; main.Visible=not hidden end)

-- ===== PLAYER =====
local prev=btn(pages.PLAYER,"<< PREV",0.18)
local info=btn(pages.PLAYER,"PLAYER : -",0.30)
local next=btn(pages.PLAYER,"NEXT >>",0.42)
local view=btn(pages.PLAYER,"VIEW ON/OFF",0.54)
local go=btn(pages.PLAYER,"GOTO PLAYER",0.66)
local function upd() local p=cur(); info.Text="PLAYER : "..(p and p.Name or "-") end
upd()
prev.MouseButton1Click:Connect(function() S.idx-=1 if S.idx<1 then S.idx=#S.players end upd() end)
next.MouseButton1Click:Connect(function() S.idx+=1 if S.idx>#S.players then S.idx=1 end upd() end)
view.MouseButton1Click:Connect(function()
    S.view=not S.view
    local p=cur()
    Cam.CameraSubject=(S.view and p and p.Character and p.Character:FindFirstChildOfClass("Humanoid")) or Hum
end)
go.MouseButton1Click:Connect(function()
    local p=cur()
    if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        HRP.CFrame=p.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-3)
    end
end)

-- ===== MOVE =====
local sp=btn(pages.MOVE,"WALK SPEED : 16",0.26)
local jp=btn(pages.MOVE,"JUMP POWER : 50",0.40)
sp.MouseButton1Click:Connect(function()
    S.ws+=8; if S.ws>48 then S.ws=16 end
    Hum.WalkSpeed=S.ws; sp.Text="WALK SPEED : "..S.ws
end)
jp.MouseButton1Click:Connect(function()
    S.jp+=20; if S.jp>140 then S.jp=50 end
    Hum.JumpPower=S.jp; jp.Text="JUMP POWER : "..S.jp
end)

-- ===== ESP =====
local espb=btn(pages.ESP,"ESP : OFF",0.32)
local function addESP(p)
    if p==LP or S.espC[p] then return end
    local bb=Instance.new("BillboardGui")
    bb.Size=UDim2.new(0,220,0,40); bb.AlwaysOnTop=true
    local tl=Instance.new("TextLabel",bb)
    tl.Size=UDim2.fromScale(1,1); tl.BackgroundTransparency=1
    tl.TextScaled=true; tl.TextColor3=Color3.fromRGB(255,80,80)
    RunService.RenderStepped:Connect(function()
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d=(HRP.Position-p.Character.HumanoidRootPart.Position).Magnitude
            tl.Text=p.Name.." ["..math.floor(d).."]"
        end
    end)
    if p.Character and p.Character:FindFirstChild("Head") then bb.Parent=p.Character.Head end
    S.espC[p]=bb
end
local function clr() for _,g in pairs(S.espC) do pcall(function() g:Destroy() end) end S.espC={} end
espb.MouseButton1Click:Connect(function()
    S.esp=not S.esp; espb.Text=S.esp and "ESP : ON" or "ESP : OFF"
    clr()
    if S.esp then
        for _,p in pairs(Players:GetPlayers()) do addESP(p) end
        Players.PlayerAdded:Connect(function(p) if S.esp then addESP(p) end end)
    end
end)

-- ===== MISC =====
btn(pages.MISC,"STATUS : V∞ ONLINE",0.4)