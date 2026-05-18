
if getgenv().ALSDestroy then pcall(getgenv().ALSDestroy)end

local a=game:GetService("ReplicatedStorage")
local b=game:GetService("HttpService")
local c=game:GetService("Players")
local d=game:GetService("VirtualUser")
local e=c.LocalPlayer


local f=a:WaitForChild("Remotes")
local g=f:WaitForChild("PlaceTower")
local h=f:WaitForChild("Upgrade")
local i=f:WaitForChild("Sell")
local j=f:WaitForChild("UnitManager"):WaitForChild("SetAutoUpgrade")
local k=f:WaitForChild("Teleporter"):WaitForChild("Interact")
local l=f:WaitForChild("PlayerReady")




local m={}
do
local n="ALS_Macros/"
local o=n.."macros/"
local p=n.."settings.json"

if not isfolder(n)then makefolder(n)end
if not isfolder(o)then makefolder(o)end

local function jenc(q)return b:JSONEncode(q)end
local function jdec(q)
local r,s=pcall(b.JSONDecode,b,q)
return r and s or nil
end

function m.SaveMacro(q,r)writefile(o..q..".json",jenc(r))end
function m.LoadMacro(q)
local r=o..q..".json"
return isfile(r)and jdec(readfile(r))or nil
end
function m.ListMacros()
local q={}
for r,s in ipairs(listfiles(o))do
local t=s:match("([^/\\]+)%.json$")
if t then table.insert(q,t)end
end
table.sort(q)
return q
end
function m.DeleteMacro(q)
local r=o..q..".json"
if isfile(r)then
if delfile then delfile(r)else writefile(r,"{}")end
end
end
function m.SaveSettings(q)writefile(p,jenc(q))end
function m.LoadSettings()return isfile(p)and jdec(readfile(p))or{}end
end




local n={}
n.__index=n

function n.new()
return setmetatable({active=false,actions={},startTime=nil},n)
end

function n:Start()
self.active=true
self.actions={}
self.startTime=nil
task.spawn(function()
local o=e.PlayerGui

local p=o:WaitForChild("StartCountdown")
local q=p:WaitForChild("Countdown")

if p.Enabled then
repeat task.wait(0.1)until not p.Enabled or not self.active
end
if not self.active then return end

local r,s
local function check()
if p.Enabled and q.Text~=nil and q.Text~=""and self.active and not self.startTime then
self.startTime=tick()
if r then r:Disconnect()end
if s then s:Disconnect()end
end
end
r=p:GetPropertyChangedSignal("Enabled"):Connect(check)
s=q:GetPropertyChangedSignal("Text"):Connect(check)
repeat task.wait(0.05)until self.startTime or not self.active
if r then r:Disconnect()end
if s then s:Disconnect()end
end)
end

function n:Stop()self.active=false end

function n:RecordPlace(o,p)
if not self.startTime then return end
table.insert(self.actions,{
type="place",
unitID=o,
cf={p:GetComponents()},
t=tick()-self.startTime,
})
end

function n:RecordUpgrade(o)
if not self.startTime then return end
local p,q=pcall(function()return o:GetPivot()end)
if not p then return end
local r=q.Position
table.insert(self.actions,{
type="upgrade",
unitID=o.Name,
pos={r.X,r.Y,r.Z},
t=tick()-self.startTime,
})
end

function n:RecordSell(o)
if not self.startTime then return end
local p,q=pcall(function()return o:GetPivot()end)
if not p then return end
local r=q.Position
table.insert(self.actions,{
type="sell",
unitID=o.Name,
pos={r.X,r.Y,r.Z},
t=tick()-self.startTime,
})
end

function n:RecordAutoUpgrade(o,p)
if not self.startTime then return end
local q,r=pcall(function()return o:GetPivot()end)
if not q then return end
local s=r.Position
table.insert(self.actions,{
type="autoupgrade",
unitID=o.Name,
pos={s.X,s.Y,s.Z},
state=p,
t=tick()-self.startTime,
})
end

function n:Export(o)
return{
name=o,
actions=self.actions,
duration=#self.actions>0 and self.actions[#self.actions].t or 0,
created=os.time(),
version=1,
}
end




local o={}
o.__index=o

function o.new()
return setmetatable({active=false,startTime=nil,duration=0},o)
end

local function findUnit(p,q,r)
local s=Vector3.new(q[1],q[2],q[3])
local t,u=nil,r or 8
for v,w in ipairs({workspace:FindFirstChild("Towers"),workspace:FindFirstChild("GhostTowers")})do
if w then
for x,y in ipairs(w:GetChildren())do
if y.Name==p then
local z,A=pcall(function()return y:GetPivot()end)
if z then
local B=(A.Position-s).Magnitude
if B<u then u=B;t=y end
end
end
end
end
end
return t
end

function o:Play(p,q)
if self.active then return end
self.active=true

task.spawn(function()

local r=e.PlayerGui
local s=r:WaitForChild("StartCountdown")
local t=s:WaitForChild("Countdown")

if s.Enabled then
repeat task.wait(0.1)until not s.Enabled or not self.active
end
if not self.active then return end
local u=false
local v,w
local function check()
if s.Enabled and t.Text~=nil and t.Text~=""then
u=true
if v then v:Disconnect()end
if w then w:Disconnect()end
end
end
v=s:GetPropertyChangedSignal("Enabled"):Connect(check)
w=t:GetPropertyChangedSignal("Text"):Connect(check)
repeat task.wait(0.05)until u or not self.active
if v then v:Disconnect()end
if w then w:Disconnect()end
if not self.active then return end

local x=tick()
self.startTime=x
self.duration=p.duration or 0

for y,z in ipairs(p.actions)do
if not self.active then break end

local A=x+z.t-tick()
if A>0.05 then task.wait(A)end
if not self.active then break end

if z.type=="place"then
g:FireServer(z.unitID,CFrame.new(table.unpack(z.cf)))

elseif z.type=="upgrade"then
local B=findUnit(z.unitID,z.pos)
if B then h:InvokeServer(B)end

elseif z.type=="sell"then
local B=findUnit(z.unitID,z.pos)
if B then i:InvokeServer(B)end

elseif z.type=="autoupgrade"then
local B=findUnit(z.unitID,z.pos)
if B then j:FireServer(B,z.state)end
end
end

self.active=false
if q then task.spawn(q)end
end)
end

function o:Stop()self.active=false;self.startTime=nil end




local p=true
local q=n.new()
local r=o.new()

local s
s=hookmetamethod(game,"__namecall",function(t,...)
local u=getnamecallmethod()
local v={s(t,...)}

if p and q.active and not r.active then
if u=="FireServer"then
if rawequal(t,g)then
local w={...}
task.spawn(function()
local x=w[1]
local y={}
local z,A=0,math.huge
for B,C in ipairs({workspace:FindFirstChild("Towers"),workspace:FindFirstChild("GhostTowers")})do
if C then
for D,E in ipairs(C:GetChildren())do
if E.Name==x and not y[E]then
y[E]=true
z+=1
local F=E:FindFirstChild("PlacementLimit")
if F and A==math.huge then A=F.Value end
end
end
end
end
if z<A then q:RecordPlace(x,w[2])end
end)
elseif rawequal(t,j)then
local w={...}
task.spawn(function()q:RecordAutoUpgrade(w[1],w[2])end)
end
elseif u=="InvokeServer"then
if rawequal(t,h)then
local w={...}
task.spawn(function()q:RecordUpgrade(w[1])end)
elseif rawequal(t,i)then
local w={...}
task.spawn(function()q:RecordSell(w[1])end)
end
end
end

return table.unpack(v)
end)




local t=m.LoadSettings()
local u=m.ListMacros()
local v=u[1]or nil
local w=false
local x=nil

local y=nil
local z=1
local A="Normal"

local B={"Normal","Hard","Nightmare","Insane"}


local C
local D,E
local F
local G,H
local I,J
local K=false
local L=nil
local M
local N=false
local O,P

local function fmt(Q)
Q=math.floor(Q)
return string.format("%d:%02d",math.floor(Q/60),Q%60)
end

local function updateStatus()
local Q
if q.active then
if q.startTime then
local R=tick()-q.startTime
Q="● Recording — "..#q.actions.." actions  "..fmt(R)
else
Q="● Armed — waiting for game start"
end
elseif r.active then
if r.startTime then
local R=tick()-r.startTime
local S=math.max(0,r.duration-R)
Q="▶ Playing — "..fmt(R).."  /  "..fmt(r.duration).."  (-"..fmt(S)..")"
else
Q="▶ Playing — waiting for game start"
end
elseif w then
Q="⚙ Auto Farm active"
else
Q="Idle"
end
if I then I:SetDesc(Q)end
if J then J:SetDesc(Q)end
end




local Q="ALS_Macros/resume_state.json"
local R="https://raw.githubusercontent.com/SupFr/Sup-Hub/refs/heads/main/ALS_MacroHub.lua"

local function saveResumeState(S)
getgenv().ALSAutoFarmState=S
pcall(function()writefile(Q,b:JSONEncode(S))end)
end

local function queueResumeOnTeleport()
local S='if not game:IsLoaded() then game.Loaded:Wait() end\ntask.wait(1)\nloadstring(game:HttpGet("'..R..'"))()'
if queueonteleport then queueonteleport(S)
elseif queue_on_teleport then queue_on_teleport(S)
elseif syn and syn.queue_on_teleport then syn.queue_on_teleport(S)
end
end

local function waitForGameStart()
local S=e.PlayerGui
local T=S:WaitForChild("StartCountdown")
local U=T:WaitForChild("Countdown")
local function ready()return T.Enabled and U.Text~=nil and U.Text~=""end
if ready()then return true end
local V=false
local W,X
local function check()
if ready()then V=true
if W then W:Disconnect()end
if X then X:Disconnect()end
end
end
W=T:GetPropertyChangedSignal("Enabled"):Connect(check)
X=U:GetPropertyChangedSignal("Text"):Connect(check)
repeat task.wait(0.05)until V
return true
end

local function runAutoFarmLoop()
while w do
if not y or y==""then
Fluent:Notify({Title="Error",Content="No map entered.",Duration=3})
D();break
end
if not v then
Fluent:Notify({Title="Error",Content="No macro selected.",Duration=3})
D();break
end
local S=m.LoadMacro(v)
if not S then
Fluent:Notify({Title="Error",Content="Failed to load: "..tostring(v),Duration=3})
D();break
end

saveResumeState({macroName=v,map=y,act=z,difficulty=A})
queueResumeOnTeleport()

k:FireServer("Select",y,z,A,"Story")
task.wait(t.lobbyWait or 5)
l:FireServer()

if not waitForGameStart(90)then
if not w then break end
Fluent:Notify({Title="Auto Farm",Content="Game didn't start — retrying.",Duration=3})
task.wait(3);continue
end
if not w then break end

local T=false
local U=e.PlayerGui.ChildAdded:Connect(function(U)
if U.Name=="EndGameUI"then T=true end
end)

local V=false
r:Play(S,function()V=true end)
repeat task.wait(0.1)until V or T or not w

U:Disconnect()
if not w then r:Stop();break end
if not V then r:Stop()end

if not T then
repeat task.wait(0.5)until T or not w
end
if not w then break end

getgenv().ALSAutoFarmState=nil
task.wait(t.replayWait or 3)
end
end

D=function()
w=false
getgenv().ALSAutoFarmState=nil
if x then task.cancel(x);x=nil end
r:Stop()
if F then F:SetValue(false)end
updateStatus()
end

E=function()
w=true
if F then F:SetValue(true)end
updateStatus()
x=task.spawn(runAutoFarmLoop)
end

local function checkResumeAutoFarm()
local S=getgenv().ALSAutoFarmState
if not S and isfile(Q)then
local T,U=pcall(function()return b:JSONDecode(readfile(Q))end)
if T and U and next(U)then S=U end
end
if not S then return end
pcall(function()
if delfile then delfile(Q)else writefile(Q,"{}")end
end)
v=S.macroName
y=S.map
z=S.act or 1
A=S.difficulty or"Normal"
task.wait(2)
if G then G:SetValue(v)end
E()
end




local S=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local T=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local U=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

C=S:CreateWindow({
Title="ALS Hub",
SubTitle="v3.9",
TabWidth=160,
Size=UDim2.fromOffset(580,500),
Acrylic=false,
Theme="Dark",
MinimizeKey=Enum.KeyCode.RightControl,
})

local V={
Main=C:AddTab({Title="Main",Icon="home"}),
Macros=C:AddTab({Title="Macros",Icon="zap"}),
Utils=C:AddTab({Title="Utils",Icon="wrench"}),
Settings=C:AddTab({Title="Settings",Icon="settings"}),
}


V.Main:AddSection("STATUS")
I=V.Main:AddParagraph({Title="Status",Content="Idle"})

V.Main:AddSection("MACRO")

G=V.Main:AddDropdown("ActiveMacro",{
Title="Select Macro",
Values=u,
Default=v,
Callback=function(W)v=W end,
})

V.Main:AddSection("PLAYBACK")
V.Main:AddParagraph({
Title="Info",
Content="Join a game yourself and use Auto Retry — it replays the macro every game automatically.",
})

M=V.Main:AddToggle("ManualRetryMain",{
Title="Auto Retry",
Default=false,
Callback=function(W)
if W then
if w or r.active then
S:Notify({Title="Error",Content="Already running.",Duration=2})
M:SetValue(false);return
end
if not v then
S:Notify({Title="Error",Content="Select a macro.",Duration=2})
M:SetValue(false);return
end
K=true
L=task.spawn(P)
updateStatus()
else
if O then O()end
end
end,
})

V.Main:AddButton({
Title="Play Once",
Callback=function()
if r.active or w or K then
S:Notify({Title="Error",Content="Already running.",Duration=2})return
end
if not v then
S:Notify({Title="Error",Content="Select a macro.",Duration=2})return
end
local W=m.LoadMacro(v)
if not W then
S:Notify({Title="Error",Content="Failed to load macro.",Duration=2})return
end
r:Play(W,function()
updateStatus()
S:Notify({Title="Playback",Content="Done.",Duration=2})
end)
updateStatus()
end,
})

V.Main:AddButton({
Title="Stop",
Callback=function()
O()
D()
q:Stop()
r:Stop()
updateStatus()
end,
})

V.Main:AddSection("AUTO FARM  (optional — TPs to map)")
V.Main:AddParagraph({
Title="Steps",
Content="1. Enter map name  2. Set act & difficulty  3. Toggle Auto Farm",
})

V.Main:AddInput("MapName",{
Title="Map Name",
Placeholder="e.g. Abandon City Z",
Finished=false,
Callback=function(W)y=W~=""and W or nil end,
})

V.Main:AddDropdown("Act",{
Title="Act",
Values={"1","2","3","4","5","6","7","8","9","10"},
Default="1",
Callback=function(W)z=tonumber(W)or 1 end,
})

V.Main:AddDropdown("Difficulty",{
Title="Difficulty",
Values=B,
Default="Normal",
Callback=function(W)A=W end,
})

F=V.Main:AddToggle("AutoFarm",{
Title="Auto Farm",
Default=false,
Callback=function(W)
if W==w then return end
if W then E()else D()end
end,
})


V.Macros:AddSection("STATUS")
J=V.Macros:AddParagraph({Title="Status",Content="Idle"})

task.spawn(function()
while p do task.wait(0.5);updateStatus()end
end)

V.Macros:AddSection("SELECT")

H=V.Macros:AddDropdown("MacroSelect",{
Title="Saved Macros",
Values=u,
Default=v,
Callback=function(W)
v=W
if G then G:SetValue(W)end
end,
})

V.Macros:AddSection("RECORD")

local W=V.Macros:AddInput("MacroName",{
Title="Macro Name",
Placeholder="e.g. abandon_normal",
Finished=false,
Callback=function()end,
})

V.Macros:AddButton({
Title="Start / Stop Recording",
Callback=function()
if r.active then
S:Notify({Title="Error",Content="Stop playback first.",Duration=2})return
end
if q.active then
q:Stop()
updateStatus()
S:Notify({Title="Recorder",Content="Stopped — "..#q.actions.." actions.",Duration=3})
else
q:Start()
updateStatus()
S:Notify({Title="Recorder",Content="Recording started — play normally.",Duration=3})
end
end,
})

V.Macros:AddButton({
Title="Save Recording",
Callback=function()
if q.active then
S:Notify({Title="Error",Content="Stop recording first.",Duration=2})return
end
if#q.actions==0 then
S:Notify({Title="Error",Content="No actions recorded.",Duration=2})return
end
local X=W.Value:gsub("[^%w%-%_]","_")
if X==""or X=="_"then
S:Notify({Title="Error",Content="Enter a valid name.",Duration=2})return
end
m.SaveMacro(X,q:Export(X))
u=m.ListMacros()
v=X
if G then G:SetValues(u);G:SetValue(X)end
if H then H:SetValues(u)end
S:Notify({Title="Saved",Content="'"..X.."' — "..#q.actions.." actions.",Duration=3})
end,
})

V.Macros:AddSection("MANUAL PLAYBACK")
V.Macros:AddParagraph({
Title="Info",
Content="Join a game yourself, click Start in-game, then hit Play. Auto Retry loops after each game ends.",
})

O=function()
if N then return end
N=true
K=false
if L then task.cancel(L);L=nil end
r:Stop()
if M then M:SetValue(false)end
updateStatus()
N=false
end

P=function()
local X=true
while K do
if not v then O();break end
local Y=m.LoadMacro(v)
if not Y then O();break end

local Z=false
local _=e.PlayerGui.ChildAdded:Connect(function(_)
if _.Name=="EndGameUI"then Z=true end
end)

local aa=false
r:Play(Y,function()aa=true end)


if not X then
task.wait(0.5)
l:FireServer()
end
X=false

repeat task.wait(0.1)until aa or Z or not K

if not K then _:Disconnect();r:Stop();break end
if not aa then r:Stop()end
r.startTime=nil
updateStatus()


if not Z then
repeat task.wait(0.5)until Z or not K
end
_:Disconnect()
if not K then break end

task.wait(1)
pcall(function()
replicatesignal(e.PlayerGui.EndGameUI.BG.Buttons.Retry.MouseButton1Click)
end)
task.wait(1)
end
K=false
if M then M:SetValue(false)end
updateStatus()
end

V.Macros:AddButton({
Title="Delete Selected",
Callback=function()
if not v then
S:Notify({Title="Error",Content="Select a macro.",Duration=2})return
end
C:Dialog({
Title="Delete Macro",
Content="Delete '"..v.."'? Cannot be undone.",
Buttons={
{
Title="Delete",
Callback=function()
m.DeleteMacro(v)
u=m.ListMacros()
v=u[1]or nil
if G then G:SetValues(u)end
if H then H:SetValues(u)end
if v and G then G:SetValue(v)end
S:Notify({Title="Deleted",Content="Macro removed.",Duration=2})
end,
},
{Title="Cancel",Callback=function()end},
},
})
end,
})


V.Utils:AddSection("LOADOUT")

local function getLoadout()
local aa=e:FindFirstChild("Slots")
if not aa then return"Slots folder not found"end
local X={}
for Y=1,6 do
local Z=aa:FindFirstChild("Slot"..Y)
table.insert(X,Y..": "..(Z and Z.Value~=""and Z.Value or"Empty"))
end
return table.concat(X,"\n")
end

local aa=V.Utils:AddParagraph({Title="Equipped Units",Content=getLoadout()})

V.Utils:AddButton({
Title="Refresh Loadout",
Callback=function()if aa then aa:SetDesc(getLoadout())end end,
})

V.Utils:AddSection("TOOLS")

V.Utils:AddButton({
Title="Open Dex Explorer",
Callback=function()
pcall(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/LorekeeperZinnia/Dex/master/Dex3.lua"))()end)
end,
})

V.Utils:AddButton({
Title="Open Remote Spy",
Callback=function()
pcall(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()end)
end,
})

V.Utils:AddSection("CONFIG")

T:SetLibrary(S)
T:IgnoreThemeSettings()
T:SetIgnoreIndexes({"MapName","ActiveMacro","AutoFarm","MacroName","MacroSelect"})
T:SetFolder("ALSMacroHub/als")
T:BuildConfigSection(V.Utils)


local X

V.Settings:AddSection("GENERAL")
V.Settings:AddToggle("AntiAfk",{
Title="Anti-AFK",
Default=true,
Callback=function(Y)
if X then X:Disconnect();X=nil end
if Y then
X=e.Idled:Connect(function()
d:CaptureController()
d:ClickButton2(Vector2.new())
end)
end
end,
})

V.Settings:AddSection("AUTO FARM TIMING")

V.Settings:AddSlider("LobbyWait",{
Title="Lobby Wait (s)",
Min=1,
Max=30,
Default=t.lobbyWait or 5,
Rounding=0,
Callback=function(Y)t.lobbyWait=Y;m.SaveSettings(t)end,
})

V.Settings:AddSlider("ReplayWait",{
Title="Replay Wait (s)",
Min=1,
Max=30,
Default=t.replayWait or 3,
Rounding=0,
Callback=function(Y)t.replayWait=Y;m.SaveSettings(t)end,
})

V.Settings:AddSection("UNIT SCAN RADIUS")
V.Settings:AddSlider("ScanRadius",{
Title="Scan Radius (studs)",
Min=2,
Max=20,
Default=t.scanRadius or 8,
Rounding=0,
Callback=function(Y)t.scanRadius=Y;m.SaveSettings(t)end,
})

U:SetLibrary(S)
U:SetFolder("ALSMacroHub")
U:BuildInterfaceSection(V.Settings)

C:SelectTab(1)




local function Destroy()
p=false
D()
q:Stop()
r:Stop()
pcall(function()C:Destroy()end)
pcall(function()hookmetamethod(game,"__namecall",s)end)
getgenv().ALSDestroy=nil
end
getgenv().ALSDestroy=Destroy

S:Notify({Title="ALS Hub",Content="Loaded.",Duration=3})
checkResumeAutoFarm()