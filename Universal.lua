





if getgenv().UniversalHubDestroy then getgenv().UniversalHubDestroy()end

local a=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local b=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local c=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()




local d=game:GetService("Players")
local e=game:GetService("RunService")
local f=game:GetService("TweenService")
local g=game:GetService("UserInputService")
local h=game:GetService("Lighting")
local i=game:GetService("HttpService")
local j=game:GetService("VirtualUser")
local k=game:GetService("TeleportService")
local l=game:GetService("Workspace")

local m=d.LocalPlayer

local function getHRP()
local n=m.Character or m.CharacterAdded:Wait()
return n:FindFirstChild("HumanoidRootPart"),n:FindFirstChildOfClass("Humanoid"),n
end




local n=getgenv()
n.UH=n.UH or{}
local o=n.UH
o.AutoFarm=false
o.TargetName=""
o.TargetContainer="workspace"
o.MatchMode="Exact"
o.Interaction="Touch"
o.Movement="Teleport"
o.TweenSpeed=80
o.WalkSpeedFarm=100
o.LoopDelay=0.15
o.YOffset=3
o.ReturnAfter=false
o.ReturnCFrame=nil

o.RemotePath=""
o.RemoteArgs=""

o.WalkSpeed=16
o.JumpPower=50
o.InfJump=false
o.Noclip=false
o.Fly=false
o.FlySpeed=60

o.ESP=false
o.ESPTargets="Players"
o.ESPItemName=""

o.AntiAFK=true
o.AntiRagdoll=false
o.FullBright=false
o.HitboxSize=5
o.HitboxOn=false




local function resolveContainer(p)
if p=="workspace"or p=="Workspace"then return l end
local q=game:FindFirstChild(p)
if q then return q end

local r=game
for s in string.gmatch(p,"[^%.]+")do
r=r:FindFirstChild(s)
if not r then return nil end
end
return r
end

local function nameMatches(p,q)
if o.MatchMode=="Exact"then return p==q end
return string.find(string.lower(p),string.lower(q),1,true)~=nil
end

local function findTargets()
local p=resolveContainer(o.TargetContainer)
if not p or o.TargetName==""then return{}end
local q={}
for r,s in ipairs(p:GetDescendants())do
if nameMatches(s.Name,o.TargetName)then
table.insert(q,s)
end
end
return q
end

local function getTargetCFrame(p)
if p:IsA("BasePart")then return p.CFrame end
if p:IsA("Model")then
local q=p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart")
if q then return q.CFrame end
end
if p:IsA("ProximityPrompt")or p:IsA("ClickDetector")then
local q=p.Parent
if q and q:IsA("BasePart")then return q.CFrame end
if q and q:IsA("Model")then
local r=q.PrimaryPart or q:FindFirstChildWhichIsA("BasePart")
if r then return r.CFrame end
end
end
return nil
end

local function resolveRemote()
local p=game
for q in string.gmatch(o.RemotePath,"[^%.]+")do
p=p:FindFirstChild(q)
if not p then return nil end
end
return p
end

local function buildRemoteArgs(p)
if o.RemoteArgs==""then return{p}end
local q,r=pcall(i.JSONDecode,i,o.RemoteArgs)
if not q then return{p}end
local function sub(s)
if s=="{TARGET}"then return p end
if s=="{TARGETNAME}"then return p.Name end
return s
end
local s={}
for t,u in ipairs(r)do s[t]=sub(u)end
return s
end

local function interact(p)
local q=o.Interaction
if q=="Touch"then
local r=getHRP()
local s=p:IsA("BasePart")and p or p:FindFirstChildWhichIsA("BasePart")
if r and s then
firetouchinterest(r,s,0)
task.wait()
firetouchinterest(r,s,1)
end
elseif q=="ProximityPrompt"then
local r=p:IsA("ProximityPrompt")and p or p:FindFirstChildWhichIsA("ProximityPrompt",true)
if r then fireproximityprompt(r)end
elseif q=="ClickDetector"then
local r=p:IsA("ClickDetector")and p or p:FindFirstChildWhichIsA("ClickDetector",true)
if r then fireclickdetector(r)end
elseif q=="Remote"then
local r=resolveRemote()
if r then
local s=buildRemoteArgs(p)
if r:IsA("RemoteEvent")then r:FireServer(unpack(s))
elseif r:IsA("RemoteFunction")then r:InvokeServer(unpack(s))end
end
end
end

local function moveTo(p)
local q,r=getHRP()
if not q then return end
p=p+Vector3.new(0,o.YOffset,0)
if o.Movement=="Teleport"then
q.CFrame=p
elseif o.Movement=="Tween"then
local s=(q.Position-p.Position).Magnitude
local t=math.clamp(s/o.TweenSpeed,0.05,8)
local u=f:Create(q,TweenInfo.new(t,Enum.EasingStyle.Linear),{CFrame=p})
u:Play()
u.Completed:Wait()
elseif o.Movement=="Walk"then
if r then
local s=r.WalkSpeed
r.WalkSpeed=o.WalkSpeedFarm
r:MoveTo(p.Position)
r.MoveToFinished:Wait()
r.WalkSpeed=s
end
end
end




local p=a:CreateWindow({
Title="Universal Hub",
SubTitle="v1.0",
TabWidth=160,
Size=UDim2.fromOffset(620,480),
Acrylic=false,
Theme="Dark",
MinimizeKey=Enum.KeyCode.RightControl,
})

local q={
Farm=p:AddTab({Title="Auto Farm",Icon="swords"}),
Player=p:AddTab({Title="Player",Icon="user"}),
Visual=p:AddTab({Title="Visuals",Icon="eye"}),
Misc=p:AddTab({Title="Misc",Icon="wrench"}),
Teleport=p:AddTab({Title="Teleport",Icon="map-pin"}),
Server=p:AddTab({Title="Server",Icon="server"}),
Settings=p:AddTab({Title="Settings",Icon="settings"}),
}




local r=q.Farm

r:AddSection("Target")
r:AddInput("TargetName",{Title="Target Name",Default="",Placeholder="e.g. Coin",Finished=true,
Callback=function(s)o.TargetName=s end})

r:AddDropdown("TargetContainer",{Title="Search In",Values={"workspace","ReplicatedStorage","ServerStorage","Lighting"},Default="workspace",
Callback=function(s)o.TargetContainer=s end})

r:AddInput("CustomContainer",{Title="Custom Path (optional)",Default="",Placeholder="workspace.Coins",Finished=true,
Callback=function(s)if s~=""then o.TargetContainer=s end end})

r:AddDropdown("MatchMode",{Title="Match Mode",Values={"Exact","Contains"},Default="Exact",
Callback=function(s)o.MatchMode=s end})

r:AddSection("Interaction")
r:AddDropdown("Interaction",{Title="Interaction Type",Values={"Touch","ProximityPrompt","ClickDetector","Remote"},Default="Touch",
Callback=function(s)o.Interaction=s end})

r:AddInput("RemotePath",{Title="Remote Path (if Remote)",Default="",Placeholder="ReplicatedStorage.Remotes.Collect",Finished=true,
Callback=function(s)o.RemotePath=s end})

r:AddInput("RemoteArgs",{Title="Remote Args JSON",Default="",Placeholder='["{TARGET}"]',Finished=true,
Callback=function(s)o.RemoteArgs=s end})

r:AddSection("Movement")
r:AddDropdown("Movement",{Title="Move Style",Values={"Teleport","Tween","Walk"},Default="Teleport",
Callback=function(s)o.Movement=s end})

r:AddSlider("TweenSpeed",{Title="Tween Speed",Min=16,Max=500,Default=80,Rounding=0,
Callback=function(s)o.TweenSpeed=s end})

r:AddSlider("LoopDelay",{Title="Loop Delay (s)",Min=0,Max=2,Default=0.15,Rounding=2,
Callback=function(s)o.LoopDelay=s end})

r:AddSlider("YOffset",{Title="Y Offset",Min=-10,Max=20,Default=3,Rounding=1,
Callback=function(s)o.YOffset=s end})

r:AddToggle("ReturnAfter",{Title="Return To Start After Farm Stops",Default=false,
Callback=function(s)o.ReturnAfter=s end})

r:AddSection("Run")
r:AddToggle("AutoFarm",{Title="Auto Farm",Default=false,
Callback=function(s)
o.AutoFarm=s
if s then
local t=getHRP();if t then o.ReturnCFrame=t.CFrame end
else
if o.ReturnAfter and o.ReturnCFrame then
local t=getHRP();if t then t.CFrame=o.ReturnCFrame end
end
end
end})

r:AddButton({Title="Scan Targets (count)",Callback=function()
local s=#findTargets()
a:Notify({Title="Scan",Content=s.." targets matched.",Duration=3})
end})


task.spawn(function()
while task.wait(0.05)do
if o.AutoFarm then
local s=findTargets()
for t,u in ipairs(s)do
if not o.AutoFarm then break end
local v=getTargetCFrame(u)
if v then pcall(moveTo,v)end
pcall(interact,u)
task.wait(o.LoopDelay)
end
if#s==0 then task.wait(1)end
end
end
end)




local s=q.Player

s:AddSection("Movement")
s:AddSlider("WalkSpeed",{Title="WalkSpeed",Min=16,Max=500,Default=16,Rounding=0,
Callback=function(t)o.WalkSpeed=t;local u,v=getHRP();if v then v.WalkSpeed=t end end})

s:AddSlider("JumpPower",{Title="JumpPower",Min=50,Max=500,Default=50,Rounding=0,
Callback=function(t)o.JumpPower=t;local u,v=getHRP();if v then v.JumpPower=t;v.UseJumpPower=true end end})

s:AddToggle("InfJump",{Title="Infinite Jump",Default=false,Callback=function(t)o.InfJump=t end})

g.JumpRequest:Connect(function()
if o.InfJump then local t,u=getHRP();if u then u:ChangeState(Enum.HumanoidStateType.Jumping)end end
end)

s:AddToggle("Noclip",{Title="Noclip",Default=false,Callback=function(t)o.Noclip=t end})
e.Stepped:Connect(function()
if o.Noclip then
local t,u,v=getHRP()
if v then for w,x in ipairs(v:GetDescendants())do if x:IsA("BasePart")then x.CanCollide=false end end end
end
end)

s:AddSection("Fly")
s:AddToggle("Fly",{Title="Fly (E up, Q down)",Default=false,Callback=function(u)o.Fly=u end})
s:AddSlider("FlySpeed",{Title="Fly Speed",Min=10,Max=300,Default=60,Rounding=0,
Callback=function(u)o.FlySpeed=u end})

task.spawn(function()
local u,v
while task.wait()do
local w=getHRP()
if o.Fly and w then
if not u then
u=Instance.new("BodyVelocity");u.MaxForce=Vector3.new(1e9,1e9,1e9);u.Velocity=Vector3.zero;u.Parent=w
v=Instance.new("BodyGyro");v.MaxTorque=Vector3.new(1e9,1e9,1e9);v.P=1e4;v.Parent=w
end
local x=l.CurrentCamera
local y=Vector3.zero
if g:IsKeyDown(Enum.KeyCode.W)then y=y+x.CFrame.LookVector end
if g:IsKeyDown(Enum.KeyCode.S)then y=y-x.CFrame.LookVector end
if g:IsKeyDown(Enum.KeyCode.A)then y=y-x.CFrame.RightVector end
if g:IsKeyDown(Enum.KeyCode.D)then y=y+x.CFrame.RightVector end
if g:IsKeyDown(Enum.KeyCode.E)then y=y+Vector3.new(0,1,0)end
if g:IsKeyDown(Enum.KeyCode.Q)then y=y-Vector3.new(0,1,0)end
u.Velocity=y*o.FlySpeed
v.CFrame=x.CFrame
elseif u then
u:Destroy();v:Destroy();u=nil;v=nil
end
end
end)

s:AddSection("Character")
s:AddButton({Title="Reset Character",Callback=function()m.Character:BreakJoints()end})
s:AddToggle("AntiRagdoll",{Title="Anti-Ragdoll",Default=false,Callback=function(u)o.AntiRagdoll=u end})
task.spawn(function()
while task.wait(0.2)do
if o.AntiRagdoll then
local u,v=getHRP()
if v then
v:ChangeState(Enum.HumanoidStateType.GettingUp)
pcall(function()v:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false);v:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)end)
end
end
end
end)




local u=q.Visual

local v
local function clearESP()if v then v:Destroy();v=nil end end
local function makeHL(w,x)
local y=Instance.new("Highlight")
y.Adornee=w
y.FillColor=x
y.OutlineColor=Color3.new(1,1,1)
y.FillTransparency=0.6
y.Parent=v
return y
end

u:AddSection("ESP")
u:AddToggle("ESP",{Title="ESP",Default=false,Callback=function(w)
o.ESP=w
if not w then clearESP()end
end})
u:AddDropdown("ESPTargets",{Title="ESP Targets",Values={"Players","Items"},Default="Players",
Callback=function(w)o.ESPTargets=w;clearESP()end})
u:AddInput("ESPItemName",{Title="Item Name (for Items mode)",Default="",Placeholder="Chest",Finished=true,
Callback=function(w)o.ESPItemName=w;clearESP()end})

task.spawn(function()
while task.wait(1)do
if o.ESP then
clearESP()
v=Instance.new("Folder",game:GetService("CoreGui"))
v.Name="UH_ESP"
if o.ESPTargets=="Players"then
for w,x in ipairs(d:GetPlayers())do
if x~=m and x.Character then
makeHL(x.Character,x.Team==m.Team and Color3.fromRGB(0,255,0)or Color3.fromRGB(255,0,0))
end
end
else
if o.ESPItemName~=""then
for w,x in ipairs(l:GetDescendants())do
if x.Name==o.ESPItemName and(x:IsA("Model")or x:IsA("BasePart"))then
makeHL(x,Color3.fromRGB(255,255,0))
end
end
end
end
end
end
end)

u:AddSection("World")
u:AddToggle("FullBright",{Title="FullBright",Default=false,Callback=function(w)
o.FullBright=w
if w then
h.Brightness=2;h.ClockTime=14;h.FogEnd=1e9;h.GlobalShadows=false
else
h.Brightness=1;h.GlobalShadows=true;h.FogEnd=1e5
end
end})

u:AddSlider("FOV",{Title="Camera FOV",Min=70,Max=120,Default=70,Rounding=0,
Callback=function(w)l.CurrentCamera.FieldOfView=w end})




local w=q.Misc

w:AddSection("Hitbox Expander")
w:AddToggle("HitboxOn",{Title="Expand Player Hitboxes",Default=false,
Callback=function(x)o.HitboxOn=x end})
w:AddSlider("HitboxSize",{Title="Hitbox Size",Min=1,Max=30,Default=5,Rounding=1,
Callback=function(x)o.HitboxSize=x end})

task.spawn(function()
while task.wait(0.3)do
if o.HitboxOn then
for x,y in ipairs(d:GetPlayers())do
if y~=m and y.Character then
local z=y.Character:FindFirstChild("HumanoidRootPart")
if z then z.Size=Vector3.new(o.HitboxSize,o.HitboxSize,o.HitboxSize);z.Transparency=0.7;z.CanCollide=false;z.Massless=true end
end
end
end
end
end)

w:AddSection("Remote Spy Helpers")
w:AddButton({Title="Print All Remotes in ReplicatedStorage",Callback=function()
for x,y in ipairs(game.ReplicatedStorage:GetDescendants())do
if y:IsA("RemoteEvent")or y:IsA("RemoteFunction")then print(y:GetFullName())end
end
a:Notify({Title="Remotes",Content="Printed to console (F9).",Duration=3})
end})

w:AddButton({Title="Copy HRP Position",Callback=function()
local x=getHRP();if x then setclipboard(tostring(x.Position))end
end})




local x=q.Teleport

local y={}
local z

local function refreshTPList()
local A={}
for B in pairs(y)do table.insert(A,B)end
if z then z:SetValues(A)end
end

local A=""
x:AddInput("TPName",{Title="Save Name",Default="",Placeholder="spawn",Finished=false,
Callback=function(B)A=B end})

x:AddButton({Title="Save Current Position",Callback=function()
if A==""then return end
local B=getHRP();if B then y[A]=B.CFrame;refreshTPList();a:Notify({Title="TP",Content="Saved "..A,Duration=2})end
end})

z=x:AddDropdown("TPGo",{Title="Saved Locations",Values={},Default=nil,
Callback=function(B)if y[B]then local C=getHRP();if C then C.CFrame=y[B]end end end})

x:AddSection("Players")
local B
local function refreshPlayers()
local C={}
for D,E in ipairs(d:GetPlayers())do if E~=m then table.insert(C,E.Name)end end
if B then B:SetValues(C)end
end
B=x:AddDropdown("PlayerTP",{Title="Player",Values={},Default=nil,Callback=function()end})
x:AddButton({Title="Refresh Players",Callback=refreshPlayers})
x:AddButton({Title="Teleport To Player",Callback=function()
local C=B.Value
local D=C and d:FindFirstChild(C)
if D and D.Character then local E=getHRP();if E then E.CFrame=D.Character.HumanoidRootPart.CFrame end end
end})
d.PlayerAdded:Connect(refreshPlayers);d.PlayerRemoving:Connect(refreshPlayers);refreshPlayers()




local C=q.Server

C:AddButton({Title="Rejoin Server",Callback=function()
k:TeleportToPlaceInstance(game.PlaceId,game.JobId,m)
end})

C:AddButton({Title="Server Hop (random)",Callback=function()
local D,E=pcall(function()
return i:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
end)
if not D or not E or not E.data then a:Notify({Title="Hop",Content="Failed.",Duration=3});return end
local F={}
for G,H in ipairs(E.data)do
if H.playing and H.maxPlayers and H.playing<H.maxPlayers and H.id~=game.JobId then table.insert(F,H.id)end
end
if#F==0 then a:Notify({Title="Hop",Content="No servers.",Duration=3});return end
k:TeleportToPlaceInstance(game.PlaceId,F[math.random(1,#F)],m)
end})

C:AddParagraph({Title="Server Info",Content="Place: "..tostring(game.PlaceId).."\nJob: "..tostring(game.JobId)})




local D=q.Settings

D:AddToggle("AntiAFK",{Title="Anti-AFK",Default=true,Callback=function(E)o.AntiAFK=E end})
m.Idled:Connect(function()
if o.AntiAFK then j:CaptureController();j:ClickButton2(Vector2.new())end
end)

D:AddButton({Title="Unload Script",Callback=function()if n.UniversalHubDestroy then n.UniversalHubDestroy()end end})

b:SetLibrary(a)
c:SetLibrary(a)
c:SetFolder("UniversalHub")
b:SetFolder("UniversalHub")
b:BuildConfigSection(D)
c:BuildInterfaceSection(D)
b:LoadAutoloadConfig()




n.UniversalHubDestroy=function()
o.AutoFarm=false;o.Fly=false;o.Noclip=false;o.ESP=false;o.HitboxOn=false;o.InfJump=false;o.AntiRagdoll=false
if v then v:Destroy()end
pcall(function()p:Destroy()end)
n.UniversalHubDestroy=nil
end

a:Notify({Title="Universal Hub",Content="Loaded v1.0",Duration=4})