
if getgenv().UTDDestroy then pcall(getgenv().UTDDestroy)end

local a=game:GetService("ReplicatedStorage")
local b=game:GetService("HttpService")
local c=game:GetService("Players")
local d=c.LocalPlayer


local e=a
:WaitForChild("Packages"):WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
:WaitForChild("Services"):WaitForChild("TowerService"):WaitForChild("RF")

local f=e:WaitForChild("PlaceUnit")
local g=e:WaitForChild("UpgradeUnit")
local h=e:WaitForChild("SellUnit")
local i=workspace:WaitForChild("Ignore"):WaitForChild("Units")

local j=a:WaitForChild("ByteNetReliable")
local k=a:WaitForChild("Packages"):WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
:WaitForChild("Services"):WaitForChild("WaveService")
local l=k:WaitForChild("RF"):WaitForChild("Vote")
local m=k:WaitForChild("RE"):WaitForChild("VoteReplay")
local n=k:WaitForChild("RE"):WaitForChild("NextMap")

local o=a:WaitForChild("Packages"):WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
:WaitForChild("Services"):WaitForChild("DataService"):WaitForChild("RE"):WaitForChild("SetSetting")

local p=a:WaitForChild("Packages"):WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
:WaitForChild("Services"):WaitForChild("DataService"):WaitForChild("RF"):WaitForChild("ToggleAutoUpgrade")

local q=loadstring(game:HttpGet("https://raw.githubusercontent.com/SupFr/Sup-Hub/refs/heads/main/SupUI_Library.lua"))()




local r={}
do
local s="UTD_Macros/"
local t=s.."macros/"
local u=s.."map_slots.json"
local v=s.."settings.json"

if not isfolder(s)then makefolder(s)end
if not isfolder(t)then makefolder(t)end

local function jenc(w)return b:JSONEncode(w)end
local function jdec(w)
local x,y=pcall(b.JSONDecode,b,w)
return x and y or nil
end

function r.SaveMacro(w,x)writefile(t..w..".json",jenc(x))end
function r.LoadMacro(w)
local x=t..w..".json"
return isfile(x)and jdec(readfile(x))or nil
end
function r.ListMacros()
local w={}
for x,y in ipairs(listfiles(t))do
local z=y:match("([^/\\]+)%.json$")
if z then table.insert(w,z)end
end
table.sort(w)
return w
end
function r.DeleteMacro(w)
local x=t..w..".json"
if isfile(x)then
if delfile then delfile(x)else writefile(x,"{}")end
end
end
function r.SaveMapSlots(w)writefile(u,jenc(w))end
function r.LoadMapSlots()return isfile(u)and jdec(readfile(u))or{}end
function r.SaveSettings(w)writefile(v,jenc(w))end
function r.LoadSettings()return isfile(v)and jdec(readfile(v))or{}end
end




local s={}
s.__index=s

function s.new()
return setmetatable({
active=false,
actions={},
startTime=0,
refs={},
guidToRef={},
nextRef=1,
_auState={},
},s)
end

function s:Start()
self.active=true
self.actions={}
self.startTime=tick()
self.refs={}
self.guidToRef={}
self.nextRef=1
self._auState={}
end

function s:Stop()
self.active=false
end

function s:RecordPlace(t,u,v)
local w=self.nextRef
self.nextRef=w+1
local x=tick()-self.startTime
table.insert(self.actions,{type="place",slot=t,cf={u:GetComponents()},ref=w,t=x})
self.refs[w]={cf=u,guid=v}
if v then self.guidToRef[v]=w end
end

function s:RecordUpgrade(t)
local u=tick()-self.startTime
local v=self.guidToRef[t]
if not v then
local w=i:FindFirstChild(t)
if w then
local x,y=pcall(function()return w:GetPivot()end)
if x then v=self:_nearestRef(y.Position)end
end
end
if v then table.insert(self.actions,{type="upgrade",ref=v,t=u})end
end


function s:RecordSell(t)
local u=tick()-self.startTime
local v=self.guidToRef[t]
if not v then
local w=i:FindFirstChild(t)
if w then
local x,y=pcall(function()return w:GetPivot()end)
if x then v=self:_nearestRef(y.Position)end
end
end
if v then
table.insert(self.actions,{type="sell",ref=v,t=u})
local w=self.refs[v]
if w and w.guid then self.guidToRef[w.guid]=nil end
self.refs[v]=nil
end
end

function s:RecordAutoUpgrade(t,u)
local v=self.guidToRef[t]
if not v then
local w=i:FindFirstChild(t)
if w then
local x,y=pcall(function()return w:GetPivot()end)
if x then v=self:_nearestRef(y.Position)end
end
end

if v and self._auState[t]~=u then
self._auState[t]=u
table.insert(self.actions,{type="autoupgrade",ref=v,state=u,t=tick()-self.startTime})
end
end

function s:_nearestRef(t)
local u,v=nil,8
for w,x in pairs(self.refs)do
local y=(x.cf.Position-t).Magnitude
if y<v then v=y;u=w end
end
return u
end

function s:Export(t,u)
return{
name=t,
team=u or{},
actions=self.actions,
duration=#self.actions>0 and self.actions[#self.actions].t or 0,
created=os.time(),
version=1,
}
end




local t={}
t.__index=t

function t.new()
return setmetatable({active=false,refToGUID={},trackedGUIDs={}},t)
end

function t:Play(u,v,w)
if self.active then return end
self.active=true
self.refToGUID={}
self.trackedGUIDs={}

local x=(v and v.sellDelay)or 0.1

task.spawn(function()
local y=tick()
for z,A in ipairs(u.actions)do
if not self.active then break end
local B=A.t-(tick()-y)
if B>0.01 then task.wait(B)end
if not self.active then break end

if A.type=="place"then
local C=CFrame.new(table.unpack(A.cf))
local D=A.ref
task.spawn(function()
f:InvokeServer(A.slot,C)
local E=self:_waitForUnit(C,4)
if E then
self.refToGUID[D]=E
self.trackedGUIDs[E]=true
end
end)

elseif A.type=="upgrade"then
local C=A.ref
local D=self.refToGUID[C]
if not D then
local E=tick()+4
repeat task.wait(0.05);D=self.refToGUID[C]until D or tick()>E
end
if D then
local E=self
task.spawn(function()

local F=i:FindFirstChild(D)
local G
if F then
local H,I=pcall(function()return F:GetPivot()end)
if H then G=I.Position end
end
g:InvokeServer(D)
if not G then return end

task.delay(0.5,function()
if not E.active or i:FindFirstChild(D)then return end
local H,I=nil,5
for J,K in ipairs(i:GetChildren())do
if not E.trackedGUIDs[K.Name]then
local L,M=pcall(function()return K:GetPivot()end)
if L then
local N=(M.Position-G).Magnitude
if N<I then I=N;H=K.Name end
end
end
end
if H then
E.trackedGUIDs[D]=nil
E.trackedGUIDs[H]=true
E.refToGUID[C]=H
end
end)
end)
end

elseif A.type=="sell"then
local C=A.ref
local D=self.refToGUID[C]
if not D then
local E=tick()+4
repeat task.wait(0.05);D=self.refToGUID[C]until D or tick()>E
end
if D then
h:InvokeServer(D)
task.wait(x)
self.trackedGUIDs[D]=nil
self.refToGUID[C]=nil
end

elseif A.type=="autoupgrade"then
local C=A.ref
local D=self.refToGUID[C]
if not D then
local E=tick()+4
repeat task.wait(0.05);D=self.refToGUID[C]until D or tick()>E
end
if D then
task.spawn(function()
local E=d:FindFirstChild("AutoUpgradeUnits")
local F=E~=nil and E:GetAttribute(D)~=nil
if F~=A.state then
p:InvokeServer(D)
end
end)
end
end
end
self.active=false
if w then task.spawn(w)end
end)
end

function t:Stop()self.active=false end

function t:_waitForUnit(u,v)
local w=tick()+v
while tick()<w do
local x,y=nil,6
for z,A in ipairs(i:GetChildren())do
if not self.trackedGUIDs[A.Name]then
local B,C=pcall(function()return A:GetPivot()end)
if B then
local D=(C.Position-u.Position).Magnitude
if D<y then y=D;x=A.Name end
end
end
end
if x then return x end
task.wait(0.05)
end
return nil
end




local u=true
local v=s.new()
local w=t.new()

local x
x=hookmetamethod(game,"__namecall",function(y,...)
local z=getnamecallmethod()
local A={x(y,...)}

if u and z=="InvokeServer"and v.active and not w.active then
if A[1]==true then
if rawequal(y,f)then
local B={...}
local C=A[2]
local D
if typeof(C)=="Instance"then
D=C.Name
elseif C then
D=tostring(C):match("([%x%-]+)$")or tostring(C)
end
task.spawn(function()v:RecordPlace(B[1],B[2],D)end)
elseif rawequal(y,g)then
local B={...}
task.spawn(function()v:RecordUpgrade(B[1])end)
elseif rawequal(y,h)then
local B={...}
task.spawn(function()v:RecordSell(B[1])end)
end
end
if rawequal(y,p)then
local B=tostring(({...})[1])
task.spawn(function()
task.wait(0.1)
local C=d:FindFirstChild("AutoUpgradeUnits")
local D=C~=nil and C:GetAttribute(B)~=nil
v:RecordAutoUpgrade(B,D)
end)
end
end

return table.unpack(A)
end)




local function packStr(y)
return string.char(#y%256,math.floor(#y/256))..y
end

local function buildChallengeBuffer(y,z,A,B)
return buffer.fromstring(
"\x29"
..packStr(y)
.."\x01"..string.char(B or 1)
..packStr(z)
.."\x00\x00\x80\x3F"
..packStr(tostring(A))
..packStr("Easy")
..packStr("Challenge")
.."\x00\x00"
)
end

local function getChallengeController()
for y,z in ipairs(getgc(true))do
if type(z)=="table"then
local A,B=pcall(function()return z.GetCurrentChallenges end)
if A and type(B)=="function"then return z end
end
end
return nil
end

local function buildChallengeList()
local y=getChallengeController()
if not y then return{}end
local z=y:GetCurrentChallenges()
local A={}
if z.Daily then
for B,C in ipairs(z.Daily)do
table.insert(A,{label="Daily "..B.." — "..C.Map,map=C.Map,act=C.Act,ctype="Daily",index=1})
end
end
if z.HalfHour then
for B,C in ipairs(z.HalfHour)do
table.insert(A,{label="HalfHour "..B.." — "..C.Map,map=C.Map,act=C.Act,ctype="HalfHour",index=1})
end
end
return A
end




local y=r.LoadSettings()
local z=r.LoadMapSlots()
local A=r.ListMacros()
local B=A[1]or nil
local C=false
local D=nil
local E=nil
local F=true
local G=false
local H=nil
local I={}
local J=nil


local K=nil
local L=nil
local M=nil
local N=nil
local O=nil
local P=nil


local Q
local R
local S
local T

T=function()
local U,V
if v.active then
U="● Recording — "..#v.actions.." actions"
V="warning"
elseif w.active then
U="▶ Playing macro..."
V="success"
elseif C then
U="Auto Farm active"
V="info"
else
U="Idle"
V="text_dim"
end
if K then K:SetText(U,V)end
if L then L:SetText(U,V)end
end


local function runAutoFarmLoop()
while C do

if J then
local U=z[J.map]
if not U then
Q:Notify({Title="Error",Message="No macro assigned for: "..J.map,Type="error",Duration=3})
R()
break
end
getgenv().UTDAutoFarmState={
macroName=U,
challenge=J,
}
j:FireServer(buildChallengeBuffer(
J.map,
J.ctype,
J.act,
J.index
))
return
end


if not workspace:GetAttribute("Started")then
task.wait(0.5)
j:FireServer(buffer.fromstring(",\000"))
task.wait(0.3)
l:InvokeServer(true)
local U=tick()+90
repeat task.wait(0.4)until workspace:GetAttribute("Started")or not C or tick()>U
if not C then break end
if not workspace:GetAttribute("Started")then
Q:Notify({Title="Auto Farm",Message="Game didn't start — retrying.",Type="warning",Duration=3})
task.wait(3)
continue
end
end


if not B then
Q:Notify({Title="Error",Message="No macro selected.",Type="error",Duration=3})
R()
break
end
local U=r.LoadMacro(B)
if not U then
Q:Notify({Title="Error",Message="Failed to load: "..tostring(B),Type="error",Duration=3})
R()
break
end


local V=workspace:GetAttribute("MatchFinished")==true
local W=false
local X=workspace:GetAttributeChangedSignal("MatchFinished"):Connect(function()
if workspace:GetAttribute("MatchFinished")==true then
V=true
end
end)
local Y=workspace:GetAttributeChangedSignal("Started"):Connect(function()
if not workspace:GetAttribute("Started")and not V then
W=true
end
end)

local Z=false
w:Play(U,y,function()Z=true end)
repeat task.wait(0.1)until Z or V or W or not C

if not C then
X:Disconnect();Y:Disconnect()
w:Stop()
break
end

if W then
X:Disconnect();Y:Disconnect()
w:Stop()
task.wait(1)
continue
end

if not Z then w:Stop()end


if not V then
local _=tick()+600
repeat
task.wait(0.5)
until V or W or not C or tick()>_
end
X:Disconnect();Y:Disconnect()

if W then
w:Stop()
task.wait(1)
continue
end

if not C then w:Stop();break end

task.wait(0.2)

local _,aa=pcall(function()
return d.PlayerGui.GameUI.MissionResultFrame.Main.Content.Description.Actions.Container.Next.Visible
end)
local ab=_ and aa

if G and ab then
n:FireServer()
elseif F or(G and not ab)then
m:FireServer()
else
R()
break
end

task.wait(y.replayWait or 3)
end
end

R=function()
C=false
getgenv().UTDAutoFarmState=nil
if D then task.cancel(D);D=nil end
if E then E:Disconnect();E=nil end
w:Stop()
if M then M:Set(false,true)end
T()
end

S=function()
C=true
local aa=d.PlayerGui:WaitForChild("Rewards")
E=aa.ChildAdded:Connect(function(ab)
ab:Destroy()
aa.Enabled=false
end)
local ab=d.Character or d.CharacterAdded:Wait()
ab.ChildAdded:Connect(function(U)
if U.Name=="OpenParticles"and C then
U:Destroy()
end
end)
workspace.CurrentCamera.ChildAdded:Connect(function(U)
if C then U:Destroy()end
end)
T()
D=task.spawn(runAutoFarmLoop)
end

local function checkResumeAutoFarm()
local aa=getgenv().UTDAutoFarmState
if not aa then return end
B=aa.macroName
J=nil
task.wait(2)
S()
end




Q=q:CreateWindow({
Name="UTD Hub",
SubTitle="v5.2",
Width=640,Height=480,
Theme={accent=Color3.fromRGB(88,166,255)},
AutoScale=true,
ToggleKey=Enum.KeyCode.RightControl,
AntiAFK=true,
ShowSettings=true,
})


local aa=Q:CreateTab("Main","🏠")

aa:CreateSection("STATUS")
K=aa:CreateLabel("Idle","text_dim")

aa:CreateSection("PLAYBACK")

local ab=aa:CreateDropdown({
Name="Active Macro",
Options=A,
CurrentValue=B,
Callback=function(ab)B=ab end,
})

aa:CreateButton("⏹  Stop All",function()
R()
v:Stop()
w:Stop()
T()
end)

aa:CreateDivider()
aa:CreateSection("AUTO FARM")
aa:CreateLabel("Join the act lobby or select a challenge in the Challenges tab, then toggle on.","text_dim")

M=aa:CreateToggle({
Name="Auto Farm",
CurrentValue=false,
Callback=function(U)
if U then S()else R()end
end,
})

aa:CreateSection("AFTER GAME ENDS")

local U,V

U=aa:CreateToggle({
Name="Auto Retry",
CurrentValue=true,
Callback=function(W)
F=W
if W and G then
G=false
if V then V:Set(false,true)end
end
end,
})

V=aa:CreateToggle({
Name="Auto Next Act",
CurrentValue=false,
Callback=function(W)
G=W
if W and F then
F=false
if U then U:Set(false,true)end
end
if W then
Q:Notify({Title="Warning",Message="Next Act permanently advances your progress.",Type="warning",Duration=4})
end
end,
})


local W=Q:CreateTab("Challenges","🎯")

W:CreateSection("CHALLENGE FARM")
W:CreateLabel("Select a challenge, then enable Auto Farm on the Main tab.","text_dim")

N=W:CreateLabel("No challenge selected","text_dim")
O=W:CreateLabel("","text_muted")

local function refreshChallenges()
I=buildChallengeList()
local X={}
for Y,Z in ipairs(I)do table.insert(X,Z.label)end
if P then P:Refresh(X)end
J=nil
N:SetText("Select a challenge below","text_dim")
O:SetText("","text_muted")
end

W:CreateButton("🔄  Refresh Challenges",function()
refreshChallenges()
Q:Notify({Title="Refreshed",Message=#I.." challenges loaded.",Type="info",Duration=2})
end)

P=W:CreateList({
Name="Current Challenges",
Items={},
MaxVisible=6,
OnSelect=function(X)
for Y,Z in ipairs(I)do
if Z.label==X then
J=Z
local _=z[Z.map]
N:SetText(Z.label,"text")
O:SetText(
_ and("Macro: ".._)or"No macro assigned — set in Map Slots",
_ and"success"or"warning"
)
break
end
end
end,
})

W:CreateButton("✕  Clear Challenge (use act mode)",function()
J=nil
N:SetText("No challenge selected","text_dim")
O:SetText("","text_muted")
end)


local X=Q:CreateTab("Macros","⚡")

X:CreateSection("STATUS")
L=X:CreateLabel("Idle","text_dim")
X:CreateDivider()

X:CreateSection("GLITCH SPAWN")
X:CreateLabel("Spawns a unit from your loadout at your current position. Works during recording.","text_dim")

local Y=1
X:CreateSlider({
Name="Loadout Slot",
Min=1,Max=5,
Default=1,
Increment=1,
Callback=function(Z)Y=Z end,
})

X:CreateButton("⚡ Glitch Spawn Unit",function()
local Z=d.Character
if not Z or not Z:FindFirstChild("HumanoidRootPart")then
Q:Notify({Title="Error",Message="Character not found.",Type="error",Duration=2})return
end
local _,ac=pcall(function()
return f:InvokeServer(Y,Z.HumanoidRootPart.CFrame)
end)
if not _ or not ac then
Q:Notify({Title="Failed",Message="Server rejected placement — check your slot.",Type="warning",Duration=2})
end
end)

X:CreateDivider()
X:CreateSection("RECORD")

local ac=X:CreateTextBox({
Name="Macro Name",
Placeholder="e.g. grassy_easy",
CurrentValue="",
})

local Z
local _

_=X:CreateButton("●  Start Recording",function()
if w.active then
Q:Notify({Title="Error",Message="Stop playback first.",Type="error",Duration=2})return
end
if v.active then
v:Stop()
_:SetText("●  Start Recording")
T()
Q:Notify({Title="Recorder",Message="Stopped. "..#v.actions.." actions captured.",Type="info",Duration=3})
else
v:Start()
_:SetText("⏹  Stop Recording")
T()
Q:Notify({Title="Recorder",Message="Recording started — play the game normally.",Type="success",Duration=3})
end
end)

task.spawn(function()
while u do
task.wait(0.5)
if v.active then T()end
end
end)

X:CreateButton("💾  Save Recording",function()
if v.active then
Q:Notify({Title="Error",Message="Stop recording first.",Type="error",Duration=2})return
end
if#v.actions==0 then
Q:Notify({Title="Error",Message="No actions recorded.",Type="error",Duration=2})return
end
local ad=ac:Get():gsub("[^%w%-%_]","_")
if ad==""or ad=="_"then
Q:Notify({Title="Error",Message="Enter a valid name.",Type="error",Duration=2})return
end
r.SaveMacro(ad,v:Export(ad,{}))
A=r.ListMacros()
ab:Refresh(A)
if Z then Z:Refresh(A)end
B=ad
ab:Set(ad,true)
Q:Notify({Title="Saved",Message="'"..ad.."' saved ("..#v.actions.." actions).",Type="success",Duration=3})
end)

X:CreateDivider()
X:CreateSection("MANAGE")

Z=X:CreateList({
Name="Saved Macros",
Items=A,
MaxVisible=7,
OnSelect=function(ad)
B=ad
ab:Set(ad,true)
end,
})

X:CreateButton("🗑  Delete Selected",function()
if not B then
Q:Notify({Title="Error",Message="Select a macro.",Type="error",Duration=2})return
end
Q:Confirm({
Title="Delete Macro",
Message="Delete '"..B.."'? This cannot be undone.",
ConfirmText="Delete",
Destructive=true,
OnConfirm=function()
r.DeleteMacro(B)
A=r.ListMacros()
B=A[1]or nil
ab:Refresh(A)
Z:Refresh(A)
if B then ab:Set(B,true)end
Q:Notify({Title="Deleted",Message="Macro removed.",Type="info",Duration=2})
end,
})
end)


local ad=Q:CreateTab("Map Slots","🗺")
ad:CreateSection("MAP → MACRO")
ad:CreateLabel("Assign a default macro to each map. Used by Challenge Auto Farm.","text_dim")

local ae=ad:CreateTextBox({
Name="Map Name",
Placeholder="e.g. Grassy Fields",
CurrentValue="",
})

local af=ad:CreateDropdown({
Name="Macro to Assign",
Options=A,
CurrentValue=B,
Callback=function()end,
})

local ag

local function buildSlotItems()
local ah={}
for ai,aj in pairs(z)do
table.insert(ah,ai.."  →  "..aj)
end
table.sort(ah)
return ah
end

ad:CreateButton("➕  Add / Update Slot",function()
local ah=ae:Get()
if ah==""then
Q:Notify({Title="Error",Message="Enter a map name.",Type="error",Duration=2})return
end
local ai=af:Get()
if not ai then
Q:Notify({Title="Error",Message="Select a macro.",Type="error",Duration=2})return
end
z[ah]=ai
r.SaveMapSlots(z)
ag:Refresh(buildSlotItems())
Q:Notify({Title="Saved",Message=ah.." → "..ai,Type="success",Duration=2})
end)

ag=ad:CreateList({
Name="Assigned Slots",
Items=buildSlotItems(),
MaxVisible=8,
OnSelect=function(ah)
H=ah:match("^(.-)%s+→")or nil
end,
})

ad:CreateButton("🗑  Remove Selected Slot",function()
if not H or not z[H]then
Q:Notify({Title="Error",Message="Select a slot from the list.",Type="error",Duration=2})return
end
Q:Confirm({
Title="Remove Slot",
Message="Remove slot for '"..H.."'?",
ConfirmText="Remove",
Destructive=true,
OnConfirm=function()
z[H]=nil
r.SaveMapSlots(z)
ag:Refresh(buildSlotItems())
H=nil
Q:Notify({Title="Removed",Message="Slot removed.",Type="info",Duration=2})
end,
})
end)


local ah=Q:CreateTab("Settings","⚙")

ah:CreateSection("GAME SETTINGS")
ah:CreateLabel("AutoStart is forced OFF — the script controls when the game begins.","warning")
ah:CreateLabel("AutoRestart is forced OFF — the script controls replay / next act.","warning")

ah:CreateToggle({
Name="Wave Skip (AutoSkip)",
CurrentValue=y.autoSkip or false,
Callback=function(ai)
y.autoSkip=ai
r.SaveSettings(y)
o:FireServer("AutoSkip",ai)
end,
})

ah:CreateDivider()
ah:CreateSection("PLAYBACK TIMING")

ah:CreateSlider({
Name="Sell Delay (s)",
Min=0,Max=1,
Default=y.sellDelay or 0.1,
Increment=0.05,
Format=function(ai)return string.format("%.2f s",ai)end,
Callback=function(ai)y.sellDelay=ai;r.SaveSettings(y)end,
})

ah:CreateDivider()
ah:CreateSection("UNIT SCAN RADIUS")
ah:CreateLabel("Max stud radius when matching a played unit to its in-game GUID.","text_dim")

ah:CreateSlider({
Name="Scan Radius (studs)",
Min=2,Max=20,
Default=y.scanRadius or 6,
Increment=1,
Callback=function(ai)y.scanRadius=ai;r.SaveSettings(y)end,
})

ah:CreateDivider()
ah:CreateSection("AUTO FARM DELAYS")

ah:CreateSlider({
Name="Lobby Wait (s)",
Min=1,Max=30,
Default=y.lobbyWait or 5,
Increment=1,
Format=function(ai)return string.format("%d s",ai)end,
Callback=function(ai)y.lobbyWait=ai;r.SaveSettings(y)end,
})

ah:CreateSlider({
Name="Replay Wait (s)",
Min=1,Max=30,
Default=y.replayWait or 3,
Increment=1,
Format=function(ai)return string.format("%d s",ai)end,
Callback=function(ai)y.replayWait=ai;r.SaveSettings(y)end,
})


local function Destroy()
u=false
R()
v:Stop()
w:Stop()
pcall(function()Q:Destroy()end)
pcall(function()hookmetamethod(game,"__namecall",x)end)
getgenv().UTDDestroy=nil
end
getgenv().UTDDestroy=Destroy


o:FireServer("AutoStart",false)
o:FireServer("AutoRestart",false)
o:FireServer("AutoSkip",y.autoSkip or false)
Q:Notify({Title="Game Settings",Message="AutoStart & AutoRestart disabled. Script is in control.",Type="info",Duration=4})

checkResumeAutoFarm()