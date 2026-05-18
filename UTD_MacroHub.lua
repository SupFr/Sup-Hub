
if getgenv().UTDDestroy then pcall(getgenv().UTDDestroy)end

local a=game:GetService("ReplicatedStorage")
local b=game:GetService("HttpService")
local c=game:GetService("Players")
local d=game:GetService("VirtualUser")
local e=c.LocalPlayer



local f=a:WaitForChild("ByteNetReliable")
local g=a:WaitForChild("Packages"):WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
:WaitForChild("Services"):WaitForChild("DataService"):WaitForChild("RE"):WaitForChild("SetSetting")


local h,i,j,k
local l,m,n,o

task.spawn(function()
local p=a:WaitForChild("Packages"):WaitForChild("_Index")
:WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")

local q=p:WaitForChild("TowerService"):WaitForChild("RF")
h=q:WaitForChild("PlaceUnit")
i=q:WaitForChild("UpgradeUnit")
j=q:WaitForChild("SellUnit")
k=workspace:WaitForChild("Ignore"):WaitForChild("Units")

local r=p:WaitForChild("WaveService")
l=r:WaitForChild("RF"):WaitForChild("Vote")
m=r:WaitForChild("RE"):WaitForChild("VoteReplay")
n=r:WaitForChild("RE"):WaitForChild("NextMap")

o=p:WaitForChild("DataService"):WaitForChild("RF"):WaitForChild("ToggleAutoUpgrade")
end)

local p=nil
local q=nil
local r

local function loadDiffSettings()
if p then return p end
local s=a:FindFirstChild("Shared")and a.Shared:FindFirstChild("Modules")
if s then
for t,u in ipairs({"DifficultyLockUtil","DifficultySettings","DifficultyUtil","DifficultyController"})do
local v=s:FindFirstChild(u)
if v then
local w,x=pcall(require,v)
if w and type(x)=="table"and type(x.GetLockSettings)=="function"then
p=x
return p
end
end
end
end
for t,u in ipairs(getgc(true))do
if type(u)=="table"and rawget(u,"GetLockSettings")and rawget(u,"AllDifficulties")then
p=u
return p
end
end
return nil
end

task.spawn(function()task.wait(2);loadDiffSettings()end)

task.spawn(function()
task.wait(3)
for s,t in ipairs(getgc(true))do
if type(t)=="table"and rawget(t,"DataLoaded")==true and rawget(t,"Maps")then
q=t
local u=rawget(t,"EquippedChanged")
if u and type(rawget(u,"Connect"))=="function"then
pcall(function()u:Connect(function()r()end)end)
end
task.spawn(function()task.wait(0.5);r()end)
return
end
end
end)


local s="https://cdn.jsdelivr.net/gh/SupFr/Sup-Hub@main/loader.lua"

local t=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local u=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local v=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()




local w={}
do
local x="UTD_Macros/"
local y=x.."macros/"
local z=x.."map_slots.json"
local A=x.."settings.json"

if not isfolder(x)then makefolder(x)end
if not isfolder(y)then makefolder(y)end

local function jenc(B)return b:JSONEncode(B)end
local function jdec(B)
local C,D=pcall(b.JSONDecode,b,B)
return C and D or nil
end

function w.SaveMacro(B,C)writefile(y..B..".json",jenc(C))end
function w.LoadMacro(B)
local C=y..B..".json"
return isfile(C)and jdec(readfile(C))or nil
end
function w.ListMacros()
local B={}
for C,D in ipairs(listfiles(y))do
local E=D:match("([^/\\]+)%.json$")
if E then table.insert(B,E)end
end
table.sort(B)
return B
end
function w.DeleteMacro(B)
local C=y..B..".json"
if isfile(C)then
if delfile then delfile(C)else writefile(C,"{}")end
end
end
function w.SaveMapSlots(B)writefile(z,jenc(B))end
function w.LoadMapSlots()return isfile(z)and jdec(readfile(z))or{}end
function w.SaveSettings(B)writefile(A,jenc(B))end
function w.LoadSettings()return isfile(A)and jdec(readfile(A))or{}end
end




local x={}
x.__index=x

function x.new()
return setmetatable({
active=false,
actions={},
startTime=nil,
refs={},
guidToRef={},
nextRef=1,
_auState={},
},x)
end

function x:Start()
self.active=true
self.actions={}
self.startTime=nil
self.refs={}
self.guidToRef={}
self.nextRef=1
self._auState={}
if workspace:GetAttribute("Started")then
self.startTime=tick()
else
task.spawn(function()
repeat task.wait(0.05)until workspace:GetAttribute("Started")or not self.active
if self.active then self.startTime=tick()end
end)
end
end

function x:Stop()self.active=false end

function x:RecordPlace(y,z,A)
if not self.startTime then return end
local B=self.nextRef
self.nextRef=B+1
local C=tick()-self.startTime
table.insert(self.actions,{type="place",slot=y,cf={z:GetComponents()},ref=B,t=C})
self.refs[B]={cf=z,guid=A}
if A then self.guidToRef[A]=B end
end

function x:RecordUpgrade(y)
if not self.startTime then return end
local z=tick()-self.startTime
local A=self.guidToRef[y]
if not A then
local B=k:FindFirstChild(y)
if B then
local C,D=pcall(function()return B:GetPivot()end)
if C then A=self:_nearestRef(D.Position)end
end
end
if A then table.insert(self.actions,{type="upgrade",ref=A,t=z})end
end

function x:RecordSell(y)
if not self.startTime then return end
local z=tick()-self.startTime
local A=self.guidToRef[y]
if not A then
local B=k:FindFirstChild(y)
if B then
local C,D=pcall(function()return B:GetPivot()end)
if C then A=self:_nearestRef(D.Position)end
end
end
if A then
table.insert(self.actions,{type="sell",ref=A,t=z})
local B=self.refs[A]
if B and B.guid then self.guidToRef[B.guid]=nil end
self.refs[A]=nil
end
end

function x:RecordAutoUpgrade(y,z)
if not self.startTime then return end
local A=self.guidToRef[y]
if not A then
local B=k:FindFirstChild(y)
if B then
local C,D=pcall(function()return B:GetPivot()end)
if C then
local E={}
for F,G in pairs(self.guidToRef)do E[G]=true end
local F,G=nil,8
for H,I in pairs(self.refs)do
if not E[H]then
local J=(I.cf.Position-D.Position).Magnitude
if J<G then G=J;F=H end
end
end
A=F
if A then self.guidToRef[y]=A end
end
end
end
if A and self._auState[y]~=z then
self._auState[y]=z
table.insert(self.actions,{type="autoupgrade",ref=A,state=z,t=tick()-self.startTime})
end
end

function x:_nearestRef(y)
local z,A=nil,8
for B,C in pairs(self.refs)do
local D=(C.cf.Position-y).Magnitude
if D<A then A=D;z=B end
end
return z
end

function x:Export(y,z)
return{
name=y,
team=z or{},
actions=self.actions,
duration=#self.actions>0 and self.actions[#self.actions].t or 0,
created=os.time(),
version=1,
}
end




local y={}
y.__index=y

function y.new()
return setmetatable({active=false,refToGUID={},trackedGUIDs={}},y)
end

function y:Play(z,A,B)
if self.active then return end
self.active=true
self.refToGUID={}
self.trackedGUIDs={}

task.spawn(function()
for C,D in ipairs(z.actions)do
if not self.active then break end

if D.type=="place"then
local E=CFrame.new(table.unpack(D.cf))
local F=D.ref
task.spawn(function()
h:InvokeServer(D.slot,E)
local G=self:_waitForUnit(E,4)
if G then
self.refToGUID[F]=G
self.trackedGUIDs[G]=true
end
end)

elseif D.type=="upgrade"then
local E=D.ref
local F=self.refToGUID[E]
if not F then
local G=tick()+4
repeat task.wait(0.05);F=self.refToGUID[E]until F or tick()>G
end
if F then
local G=self
task.spawn(function()
local H=k:FindFirstChild(F)
local I
if H then
local J,K=pcall(function()return H:GetPivot()end)
if J then I=K.Position end
end
i:InvokeServer(F)
if not I then return end
task.delay(0.5,function()
if not G.active or k:FindFirstChild(F)then return end
local J,K=nil,5
for L,M in ipairs(k:GetChildren())do
if not G.trackedGUIDs[M.Name]then
local N,O=pcall(function()return M:GetPivot()end)
if N then
local P=(O.Position-I).Magnitude
if P<K then K=P;J=M.Name end
end
end
end
if J then
G.trackedGUIDs[F]=nil
G.trackedGUIDs[J]=true
G.refToGUID[E]=J
end
end)
end)
end

elseif D.type=="sell"then
local E=D.ref
local F=self.refToGUID[E]
if not F then
local G=tick()+4
repeat task.wait(0.05);F=self.refToGUID[E]until F or tick()>G
end
if F then
j:InvokeServer(F)
self.trackedGUIDs[F]=nil
self.refToGUID[E]=nil
end

elseif D.type=="autoupgrade"then
local E=D.ref
local F=self.refToGUID[E]
if not F then
local G=tick()+4
repeat task.wait(0.05);F=self.refToGUID[E]until F or tick()>G
end
if F then
task.spawn(function()
local G=e:GetAttribute("AutoUpgrade_"..F)~=nil
if G~=D.state then
o:InvokeServer(F)
end
end)
end
end
end
self.active=false
if B then task.spawn(B)end
end)
end

function y:Stop()self.active=false end

function y:_waitForUnit(z,A)
local B=tick()+A
while tick()<B do
local C,D=nil,6
for E,F in ipairs(k:GetChildren())do
if not self.trackedGUIDs[F.Name]then
local G,H=pcall(function()return F:GetPivot()end)
if G then
local I=(H.Position-z.Position).Magnitude
if I<D then D=I;C=F.Name end
end
end
end
if C then return C end
task.wait(0.05)
end
return nil
end




local z=true
local A=x.new()
local B=y.new()

local C
C=hookmetamethod(game,"__namecall",function(D,...)
local E=getnamecallmethod()
local F={C(D,...)}

if z and E=="InvokeServer"and A.active and not B.active then
if F[1]==true then
if rawequal(D,h)then
local G={...}
local H=F[2]
local I
if typeof(H)=="Instance"then
I=H.Name
elseif H then
I=tostring(H):match("([%x%-]+)$")or tostring(H)
end
task.spawn(function()A:RecordPlace(G[1],G[2],I)end)
elseif rawequal(D,i)then
local G={...}
task.spawn(function()A:RecordUpgrade(G[1])end)
elseif rawequal(D,j)then
local G={...}
task.spawn(function()A:RecordSell(G[1])end)
end
end
if rawequal(D,o)then
local G=tostring(({...})[1])
task.spawn(function()
task.wait(0.1)
local H=e:GetAttribute("AutoUpgrade_"..G)~=nil
A:RecordAutoUpgrade(G,H)
end)
end
end

return table.unpack(F)
end)




local function packStr(D)
return string.char(#D%256,math.floor(#D/256))..D
end

local function buildChallengeBuffer(D,E,F,G)
return buffer.fromstring(
"\x29"
..packStr(D)
.."\x01"..string.char(G or 1)
..packStr(E)
.."\x00\x00\x80\x3F"
..packStr(tostring(F))
..packStr("Easy")
..packStr("Challenge")
.."\x00\x00"
)
end

local function buildJoinBuffer(D,E,F,G,H)
local I=string.pack("<f",(H or 100)/100)
return buffer.fromstring(
"\x29"
..packStr(D)
.."\x00"
..I
..packStr(tostring(F))
.."\x00"
..packStr(G or"Easy")
.."\x00\x00"
..packStr(E)
.."\x00\x00"
)
end

local D={}

local function _parseNameFromSrc(E)
if type(E)~="string"or#E<10 then return nil end

local F=E:match('Information[^{]*(%b{})')
if not F then return nil end

return F:match('%[?"?Name"?%]?%s*=%s*"([^"]+)"')
or F:match("%[?'?Name'?%]?%s*=%s*'([^']+)'")
end

local function getDisplayName(E)
if E.ClassName~="ModuleScript"then return E.Name end
if D[E]~=nil then return D[E]or E.Name end
local F=nil

local G,H=pcall(function()return E.Source end)
if G then F=_parseNameFromSrc(H)end

if not F and type(decompile)=="function"then
local I,J=pcall(decompile,E)
if I then F=_parseNameFromSrc(J)end
end

D[E]=F or false
return F or E.Name
end


local E={}

local function _readSrc(F)
if not F then return nil end
local G,H=pcall(function()return F.Source end)
if G and type(H)=="string"and#H>10 then return H end
if type(decompile)=="function"then
local I,J=pcall(decompile,F)
if I and type(J)=="string"then return J end
end
return nil
end

local function _parseLockFromSrc(F)
if type(F)~="string"then return nil end
local G=F:match("Information[^{]*(%b{})")
if not G then return nil end
local H={}


local I=G:match('LockedDifficulty"?%]?%s*=%s*"([^"]+)"')
or G:match("LockedDifficulty'?%]?%s*=%s*'([^']+)'")
if I then
H.LockedDifficulty={I}
else
local J=G:match("LockedDifficulty[^=]*=%s*(%b{})")
if J then
local K={}
for L in J:gmatch('"([^"]+)"')do table.insert(K,L)end
for L in J:gmatch("'([^']+)'")do table.insert(K,L)end
if#K>0 then H.LockedDifficulty=K end
end
end

local J=G:match("LockedDifficultyMod[^=]*=%s*([%d%.]+)")
if J then H.LockedDifficultyMod=tonumber(J)end
local K=G:match("MinDifficultyMod[^=]*=%s*([%d%.]+)")
if K then H.MinDifficultyMod=tonumber(K)end
local L=G:match("MaxDifficultyMod[^=]*=%s*([%d%.]+)")
if L then H.MaxDifficultyMod=tonumber(L)end

return H
end

local function _lockFor(F)
if not F then return nil end
local G=E[F]
if G~=nil then return G or nil end
local H=_readSrc(F)
local I=_parseLockFromSrc(H)
E[F]=I or false
return I
end





local function getActLock(F,G)
if not(F and F.instance)then return nil end
local H=F.instance:FindFirstChild(G)
local I=_lockFor(H)or{}
local J=_lockFor(F.instance)or{}
local K={
LockedDifficulty=I.LockedDifficulty or J.LockedDifficulty,
LockedDifficultyMod=I.LockedDifficultyMod or J.LockedDifficultyMod,
MinDifficultyMod=I.MinDifficultyMod or J.MinDifficultyMod,
MaxDifficultyMod=I.MaxDifficultyMod or J.MaxDifficultyMod,
}
K.HasLockedDifficulty=K.LockedDifficulty~=nil and#K.LockedDifficulty>0
K.HasLockedMod=K.LockedDifficultyMod~=nil
K.HasCappedMod=K.MinDifficultyMod~=nil or K.MaxDifficultyMod~=nil
return K
end

local function loadAllMaps()
local F=a:WaitForChild("Shared"):WaitForChild("Data")
local G={
{key="Story",folder="Waves"},
{key="LegendStage",folder="LegendStages"},
{key="VirtualRealm",folder="VirtualRealm"},
{key="FeaturedChallenge",folder="FeaturedChallenge"},
{key="Raid",folder="Raids"},
{key="LimitedTimeModes",folder="LimitedTimeModes"},
{key="UltraBoss",folder="UltraBoss"},
{key="WorldRaid",folder="WorldRaid"},
{key="Rifts",folder="Rifts"},
}
local H,I={},{}
for J,K in ipairs(G)do
local L=F:FindFirstChild(K.folder)
if L then
for M,N in ipairs(L:GetChildren())do
if N.Name~="PackageLink"then
task.wait()
local O=getDisplayName(N)
local P=K.key.." — "..O
if not I[P]then
I[P]=true
table.insert(H,{name=N.Name,displayName=O,instance=N,category=K.key,label=P})
end
end
end
end
end
table.sort(H,function(J,K)return J.label<K.label end)
return H
end

local function getChallengeController()
for F,G in ipairs(getgc(true))do
if type(G)=="table"then
local H,I=pcall(function()return G.GetCurrentChallenges end)
if H and type(I)=="function"then return G end
end
end
return nil
end

local function buildChallengeList()
local F=getChallengeController()
if not F then return{}end
local G=F:GetCurrentChallenges()
local H={}
if G.Daily then
for I,J in ipairs(G.Daily)do
table.insert(H,{label="Daily "..I.." — "..J.Map,map=J.Map,act=J.Act,ctype="Daily",index=1})
end
end
if G.HalfHour then
for I,J in ipairs(G.HalfHour)do
table.insert(H,{label="HalfHour "..I.." — "..J.Map,map=J.Map,act=J.Act,ctype="HalfHour",index=1})
end
end
return H
end




local F=w.LoadSettings()
local G=w.LoadMapSlots()
local H=w.ListMacros()
local I=H[1]or nil
local J=false
local K=nil
local L=nil
local M=true
local N=false
local O=nil
local P={}
local Q=nil
local R=nil
local S="1"
local T=nil
local U=nil

local V={}
local W={}
local X={}
local Y={}
local Z={}
local _=nil

local aa={
"All Modes","Story","VirtualRealm","LegendStage","FeaturedChallenge",
"Raid","LimitedTimeModes","UltraBoss","WorldRaid","Rifts"
}


local ab={
Story="",
LegendStage="LegendStage:",
VirtualRealm="VirtualRealm",
FeaturedChallenge="FeaturedChallenge",
Raid="Raid",
LimitedTimeModes="LimitedTimeModes",
UltraBoss="UltraBoss",
WorldRaid="WorldRaid",
Rifts="Rifts",
}
local function mapKey(ac,ad)return ac..(ab[ad]or"")end

local ac={min=75,max=1000,def=100}
local ad={"Easy","Hard","Nightmare"}
local ae={"Easy","Normal","Hard","Nightmare"}

local af={
Story={hasDiff=true,hasMeter=true,diffGated=true,actGated=true,difficulties=ad,meter=ac},
VirtualRealm={hasDiff=true,hasMeter=true,diffGated=false,actGated=false,difficulties=ad,meter=ac},
LegendStage={hasDiff=false,hasMeter=true,diffGated=false,actGated=true,difficulties=ad,meter=ac},
UltraBoss={hasDiff=true,hasMeter=true,diffGated=false,actGated=false,difficulties=ae,meter=ac},
Raid={hasDiff=true,hasMeter=true,diffGated=false,actGated=true,difficulties=ad,meter=ac},
FeaturedChallenge={hasDiff=true,hasMeter=true,diffGated=false,actGated=false,difficulties=ad,meter=ac},
LimitedTimeModes={hasDiff=false,hasMeter=false,diffGated=false,actGated=false,difficulties=ad,meter=ac},
WorldRaid={hasDiff=false,hasMeter=false,diffGated=false,actGated=false,difficulties=ad,meter=ac},
Rifts={hasDiff=false,hasMeter=false,diffGated=false,actGated=false,difficulties=ad,meter=ac},
}



local function getMapActs(ag)
local ah={}
if not ag or not ag.instance then return{"1"}end
local ai,aj={},{}
for ak,al in ipairs(ag.instance:GetChildren())do
if al.ClassName=="ModuleScript"and al.Name~="PackageLink"then
local am=tonumber(al.Name)
if am then table.insert(ai,am)
else table.insert(aj,al.Name)end
end
end
table.sort(ai)
for ak,al in ipairs(ai)do table.insert(ah,tostring(al))end
for ak,al in ipairs(aj)do table.insert(ah,al)end
if#ah==0 then table.insert(ah,"1")end
return ah
end

local function actDisplay(ag)return tonumber(ag)and("Act "..ag)or ag end

local ag="Easy"
local ah=100
local ai=false
local aj=100
local ak=false

local function farmDisplayLabels(al,am)
for an in pairs(W)do W[an]=nil end
local an={}
al=al and al:lower()or""
for ao,ap in ipairs(V)do
local aq=ap.displayName or ap.name
local ar=not am or ap.category==am
local as=al==""
or aq:lower():find(al,1,true)
or ap.name:lower():find(al,1,true)
if ar and as then
local at=am and aq or ap.label
W[at]=ap
table.insert(an,at)
end
end
return an
end

local function slotDisplayLabels(al)
for am in pairs(X)do X[am]=nil end
local am={}
al=al and al:lower()or""
for an,ao in ipairs(V)do
local ap=ao.displayName or ao.name
local aq=al==""
or ao.label:lower():find(al,1,true)
or ap:lower():find(al,1,true)
or ao.name:lower():find(al,1,true)
if aq then
local ar=G[ao.name]
local as=ao.label..(ar and("  ["..ar.."]")or"")
X[as]=ao
table.insert(am,as)
end
end
return am
end

local function buildSlotItems()
local al={}
for am,an in pairs(G)do
table.insert(al,am.."  →  "..an)
end
table.sort(al)
return al
end


local al
local am
local an
local ao
local ap
local aq
local ar
local as
local at
local au
local av
local aw
local ax
local ay
local az
local aA
local aB
local aC
local aD
local aE
local aF

r=function()
if not aF then return end
if not q then
aF:SetDesc("Not loaded — wait 3s after inject")
return
end
local aG=rawget(q,"EquippedUnits")
local aH=rawget(q,"Inventory")
if not aG or not aH then aF:SetDesc("No data");return end
local aI={}
for aJ=1,6 do
local aK=rawget(aG,tostring(aJ))or""
if aK~=""then
local aL=rawget(aH,aK)
table.insert(aI,aJ..": "..(aL and rawget(aL,"UnitId")or"Unknown"))
else
table.insert(aI,aJ..": Empty")
end
end
aF:SetDesc(table.concat(aI,"\n"))
end

local function updateClearsDisplay()
if not aE then return end
if not q or not R then aE:SetDesc("—");return end
local aG=af[R.category]
if not aG or not aG.hasDiff then aE:SetDesc("—");return end
local aH=rawget(q,"Maps")
if not aH then aE:SetDesc("No data");return end
local aI=rawget(aH,mapKey(R.name,R.category))
if not aI then aE:SetDesc("Never played");return end
local aJ=rawget(aI,tostring(S))
if not aJ then aE:SetDesc("Act not played");return end
local aK=rawget(aJ,ag)
if not aK then aE:SetDesc("Difficulty not played");return end
local aL=rawget(aK,"Clears")or 0
local aM=rawget(aK,"FastestClear")or 0
local aN="Clears: "..tostring(aL)
if aM>0 then
aN=aN.."  |  Best: "..string.format("%dm %ds",math.floor(aM/60),aM%60)
end
if not rawget(aK,"Completed")then aN=aN.."  ⚠ Not completed"end
aE:SetDesc(aN)
end


local function getUnlockedActs(aG,aH,aI)
if not aG then return aI end
local aJ=af[aH]
if not aJ or not aJ.actGated then return aI end
if not q then return aI end
local aK=rawget(q,"Maps")
if not aK then return aI end
local aL=rawget(aK,mapKey(aG.name,aH))
if not aL then return{aI[1]}end

local aM={}
local aN=false
for aO,aP in ipairs(aI)do
local aQ=tonumber(aP)
if aQ==1 then
table.insert(aM,aP)
aN=false
local aR=rawget(aL,"1")
if aR then
for aS,aT in pairs(aR)do
if type(aT)=="table"and rawget(aT,"Completed")==true then
aN=true;break
end
end
end
elseif aQ then
if not aN then break end
table.insert(aM,aP)
aN=false
local aR=rawget(aL,tostring(aQ))
if aR then
for aS,aT in pairs(aR)do
if type(aT)=="table"and rawget(aT,"Completed")==true then
aN=true;break
end
end
end
else

local aR=0
for aS,aT in ipairs(aI)do
local aU=tonumber(aT)
if aU and aU>aR then aR=aU end
end
local aS=aR>0 and rawget(aL,tostring(aR))
local aT=aS and rawget(aS,"Nightmare")
if aT and rawget(aT,"Completed")==true then
table.insert(aM,aP)
end
end
end
if#aM==0 then aM={aI[1]}end
return aM
end

local function getUnlockedDifficulties(aG,aH,aI)
local aJ=af[aH]
local aK=(aJ and aJ.difficulties)or ad


if aJ and aJ.diffGated==false then return aK end
if not q then return aK end

local aL=rawget(q,"Maps")
if not aL then return aK end
local aM=rawget(aL,mapKey(aG,aH))
if not aM then return{aK[1]}end
local aN=rawget(aM,aI)
if not aN then return{aK[1]}end

local aO={aK[1]}
for aP=2,#aK do
local aQ=rawget(aN,aK[aP-1])
if not(aQ and rawget(aQ,"Completed")==true)then break end
table.insert(aO,aK[aP])
end
return aO
end

local aG=false
local function refreshMapSettings()
if aG or not R then return end
aG=true
local aH=R
local aI=af[aH.category]
if not aI then aG=false;return end


local aJ=getMapActs(aH)
local aK=getUnlockedActs(aH,aH.category,aJ)
local aL={}
local aM={}
for aN,aO in ipairs(aK)do
local aP=actDisplay(aO)
table.insert(aL,aP)
aM[aP]=aO
end
if aB then
aB:SetValues(aL)
aB:SetValue(aL[1])
end
Z=aM
S=aM[aL[1] ]or aK[1]or"1"

local aN=tostring(S)
local aO={}


aO=aI.hasDiff
and getUnlockedDifficulties(aH.name,aH.category,aN)
or{(aI.difficulties or ad)[1]}
if aC then
aC:SetValues(aO)
aC:SetValue(aO[1])
end
ag=aO[1]

pcall(function()
if not aD then return end
aD:SetRange(aI.meter.min,aI.meter.max)
if aI.hasMeter then
ai=false
else

local aP=aI.meter.def
ai,aj=true,aP
aD:SetValue(aP)
ah=aP
end
end)




local aP=getActLock(aH,aN)
if aP then
if aP.HasLockedDifficulty then
if aC then
aC:SetValues(aP.LockedDifficulty)
aC:SetValue(aP.LockedDifficulty[1])
end
ag=aP.LockedDifficulty[1]
end

if aP.HasLockedMod then
local aQ=math.round(aP.LockedDifficultyMod*100)
ai,aj=true,aQ
pcall(function()
if aD then aD:SetValue(aQ)end
end)
ah=aQ
elseif aP.HasCappedMod then
local aQ=math.round((aP.MinDifficultyMod or 0.75)*100)
local aR=math.round((aP.MaxDifficultyMod or 10)*100)
pcall(function()if aD then aD:SetRange(aQ,aR)end end)
end
end

updateClearsDisplay()
aG=false
end

local function updateStatus()
local aH
if A.active then
aH=A.startTime
and("● Recording — "..#A.actions.." actions")
or"● Armed — waiting for game start"
elseif B.active then
aH="▶ Playing — "..(I or"macro")
elseif J then
aH="⚙ Auto Farm active"
else
aH="Idle"
end
if az then az:SetDesc(aH)end
if aA then aA:SetDesc(aH)end
end


local aH="UTD_Macros/resume_state.json"

local function saveResumeState(aI)
getgenv().UTDAutoFarmState=aI
pcall(function()writefile(aH,b:JSONEncode(aI))end)
end

local function queueResumeOnTeleport()
local aI='if not game:IsLoaded() then game.Loaded:Wait() end\ntask.wait(1)\nloadstring(game:HttpGet("'..s..'"))()'
if queueonteleport then
queueonteleport(aI)
elseif queue_on_teleport then
queue_on_teleport(aI)
elseif syn and syn.queue_on_teleport then
syn.queue_on_teleport(aI)
end
end

local function runAutoFarmLoop()
while J do
if Q then
local aI=G[Q.map]
if not aI then
t:Notify({Title="Error",Content="No macro assigned for: "..Q.map,Duration=3})
am()
break
end
local aJ={macroName=aI,challenge=Q}
saveResumeState(aJ)
queueResumeOnTeleport()
f:FireServer(buildChallengeBuffer(
Q.map,
Q.ctype,
Q.act,
Q.index
))
return
end

if R then
local aI=T
if not aI then
t:Notify({Title="Error",Content="No macro selected — pick one from the Macro dropdown.",Duration=4})
am()
break
end
local aJ={macroName=aI,directMacro=aI,farmMap=R,farmAct=S}
saveResumeState(aJ)
queueResumeOnTeleport()
f:FireServer(buildJoinBuffer(R.name,R.category,S,ag,ah))
task.wait(1.0)
f:FireServer(buffer.fromstring(",\000"))
return
end

if not workspace:GetAttribute("Started")then
task.wait(1.0)
f:FireServer(buffer.fromstring(",\000"))
task.wait(0.5)
l:InvokeServer(true)
local aI=tick()+90
repeat task.wait(0.4)until workspace:GetAttribute("Started")or not J or tick()>aI
if not J then break end
if not workspace:GetAttribute("Started")then
t:Notify({Title="Auto Farm",Content="Game didn't start — retrying.",Duration=3})
task.wait(3)
continue
end
end

if not I then
t:Notify({Title="Error",Content="No macro selected.",Duration=3})
am()
break
end
local aI=w.LoadMacro(I)
if not aI then
t:Notify({Title="Error",Content="Failed to load: "..tostring(I),Duration=3})
am()
break
end

local aJ=workspace:GetAttribute("MatchFinished")==true
local aK=false
local aL=workspace:GetAttributeChangedSignal("MatchFinished"):Connect(function()
if workspace:GetAttribute("MatchFinished")==true then aJ=true end
end)
local aM=workspace:GetAttributeChangedSignal("Started"):Connect(function()
if not workspace:GetAttribute("Started")and not aJ then aK=true end
end)

local aN=false
B:Play(aI,F,function()aN=true end)
repeat task.wait(0.1)until aN or aJ or aK or not J

if not J then
aL:Disconnect();aM:Disconnect();B:Stop();break
end
if aK then
aL:Disconnect();aM:Disconnect();B:Stop();task.wait(1);continue
end
if not aN then B:Stop()end

if not aJ then
local aO=tick()+600
repeat task.wait(0.5)until aJ or aK or not J or tick()>aO
end
aL:Disconnect();aM:Disconnect()

if aK then B:Stop();task.wait(1);continue end
if not J then B:Stop();break end

task.wait(0.2)
local aO,aP=pcall(function()
local aO=e.PlayerGui:FindFirstChild("GameUI")
and e.PlayerGui.GameUI:FindFirstChild("MissionResultFrame")
if not aO then return false end
local aP=aO:FindFirstChild("Next",true)
return aP and aP.Visible
end)
local aQ=aO and aP

if N and aQ then
n:FireServer()
elseif M or(N and not aQ)then
m:FireServer()
else
am()
break
end

task.wait(F.replayWait or 3)
end
end

am=function()
J=false
getgenv().UTDAutoFarmState=nil
if K then task.cancel(K);K=nil end
if L then L:Disconnect();L=nil end
B:Stop()
if ao then ao:SetValue(false)end
updateStatus()
end

an=function()
J=true
if ao then ao:SetValue(true)end
updateStatus()
local aI=e.PlayerGui:WaitForChild("Rewards")
L=aI.ChildAdded:Connect(function(aJ)
aJ:Destroy()
aI.Enabled=false
end)
local aJ=e.Character or e.CharacterAdded:Wait()
aJ.ChildAdded:Connect(function(aK)
if aK.Name=="OpenParticles"and J then aK:Destroy()end
end)
workspace.CurrentCamera.ChildAdded:Connect(function(aK)
if J then aK:Destroy()end
end)
K=task.spawn(runAutoFarmLoop)
end

local function checkResumeAutoFarm()
local aI=getgenv().UTDAutoFarmState
if not aI and isfile(aH)then
local aJ,aK=pcall(function()return b:JSONDecode(readfile(aH))end)
if aJ and aK and next(aK)then aI=aK end
end
if not aI then return end

pcall(function()
if delfile then delfile(aH)else writefile(aH,"{}")end
end)
I=aI.macroName
T=aI.macroName
Q=nil
R=nil
task.wait(2)
if ap then ap:SetValue(I)end
if ar then ar:SetValue(I)end
an()
end




al=t:CreateWindow({
Title="UTD Hub",
SubTitle="v8.34",
TabWidth=160,
Size=UDim2.fromOffset(640,520),
Acrylic=false,
Theme="Dark",
MinimizeKey=Enum.KeyCode.RightControl,
})

local aI={
Main=al:AddTab({Title="Main",Icon="home"}),
Challenges=al:AddTab({Title="Challenges",Icon="target"}),
Macros=al:AddTab({Title="Macros",Icon="zap"}),
MapSlots=al:AddTab({Title="Map Slots",Icon="map"}),
Utils=al:AddTab({Title="Utils",Icon="wrench"}),
Settings=al:AddTab({Title="Settings",Icon="settings"}),
}


aI.Main:AddSection("STATUS")
az=aI.Main:AddParagraph({Title="Status",Content="Idle"})

aI.Main:AddSection("PLAYBACK")

ap=aI.Main:AddDropdown("ActiveMacro",{
Title="Active Macro",
Values=H,
Default=I,
Callback=function(aJ)I=aJ end,
})

aI.Main:AddButton({
Title="Stop All",
Callback=function()
am()
A:Stop()
B:Stop()
end,
})

aI.Main:AddSection("DIRECT FARM")
aI.Main:AddParagraph({
Title="Steps",
Content="1. Mode  2. Map  3. Act  4. Macro  5. Toggle Auto Farm\nNo map selected = lobby mode.",
})

aI.Main:AddDropdown("FarmMode",{
Title="Mode",
Values=aa,
Default="All Modes",
Callback=function(aJ)
_=(aJ=="All Modes")and nil or aJ
R=nil
if aq then aq:SetValues(farmDisplayLabels(nil,_))end


Z={}
if aB then aB:SetValues({})end
S="1"

local aK=af[_]
local aL=(aK and aK.difficulties)or ad
if aC then aC:SetValues(aL);aC:SetValue(aL[1])end
ag=aL[1]
ah=aK and aK.meter.def or 100
end,
})

aI.Main:AddInput("FarmSearch",{
Title="Search Map",
Placeholder="Type to filter...",
Finished=false,
Callback=function(aJ)
if aq then aq:SetValues(farmDisplayLabels(aJ~=""and aJ or nil,_))end
end,
})

aq=aI.Main:AddDropdown("FarmMap",{
Title="Map",
Values={},
Callback=function(aJ)
local aK=W[aJ]
if aK then
R=aK
aG=false
refreshMapSettings()
end
end,
})

aB=aI.Main:AddDropdown("FarmAct",{
Title="Act",
Values={},
Callback=function(aJ)
if not aJ then return end
S=Z[aJ]or aJ:match("^Act (.+)$")or aJ
if not aG then

updateClearsDisplay()
if R then
local aK=af[R.category]
if aK and aK.hasDiff then
local aL=getUnlockedDifficulties(R.name,R.category,tostring(S))
if aC then aC:SetValues(aL);aC:SetValue(aL[1])end
ag=aL[1]
end
end
end
end,
})

aC=aI.Main:AddDropdown("FarmDifficulty",{
Title="Difficulty",
Values={"Easy","Hard","Nightmare"},
Default="Easy",
Callback=function(aJ)ag=aJ;updateClearsDisplay()end,
})

aD=aI.Main:AddSlider("FarmMeter",{
Title="Difficulty Meter (%)",
Min=75,
Max=1000,
Default=100,
Rounding=0,
Callback=function(aJ)
if ai then
ah=aj
if not ak and aJ~=aj then
ak=true
pcall(function()aD:SetValue(aj)end)
ak=false
end
return
end
ah=aJ
end,
})

aE=aI.Main:AddParagraph({Title="Run Stats",Content="—"})

ar=aI.Main:AddDropdown("DirectMacro",{
Title="Macro",
Values=H,
Default=H[1]or nil,
Callback=function(aJ)T=aJ end,
})
T=H[1]or nil

aI.Main:AddButton({
Title="Clear Map (lobby mode)",
Callback=function()
R=nil
_=nil
if aq then aq:SetValues(farmDisplayLabels())end
t:Notify({Title="Direct Farm",Content="Map cleared — lobby mode.",Duration=2})
end,
})

aI.Main:AddSection("AUTO FARM")
aI.Main:AddParagraph({
Title="Info",
Content="Direct farm TPs to the selected map and runs the selected macro.\nNo map = joins the lobby you're already in.",
})

ao=aI.Main:AddToggle("AutoFarm",{
Title="Auto Farm",
Default=false,
Callback=function(aJ)
if aJ==J then return end
if aJ then an()else am()end
end,
})

aI.Main:AddSection("AFTER GAME ENDS")

ax=aI.Main:AddToggle("AutoRetry",{
Title="Auto Retry",
Default=true,
Callback=function(aJ)
M=aJ
if aJ and N then
N=false
if ay then ay:SetValue(false)end
end
end,
})

ay=aI.Main:AddToggle("AutoNext",{
Title="Auto Next Act",
Default=false,
Callback=function(aJ)
N=aJ
if aJ and M then
M=false
if ax then ax:SetValue(false)end
end
if aJ then
t:Notify({Title="Warning",Content="Next Act permanently advances your progress.",Duration=4})
end
end,
})


aI.Challenges:AddSection("CHALLENGE FARM")
aI.Challenges:AddParagraph({
Title="Info",
Content="Select a challenge, then enable Auto Farm on the Main tab.\nChallenges use Story maps — assign macros in Map Slots.",
})

local function buildChallengeLabels()
for aJ in pairs(Y)do Y[aJ]=nil end
local aJ={}
for aK,aL in ipairs(P)do
local aM=G[aL.map]
local aN=aL.label..(aM and("  ["..aM.."]")or"  ⚠ no macro")
Y[aN]=aL
table.insert(aJ,aN)
end
return aJ
end

local function refreshChallenges()
P=buildChallengeList()
if aw then aw:SetValues(buildChallengeLabels())end
Q=nil
end

aI.Challenges:AddButton({
Title="Refresh Challenges",
Callback=function()
refreshChallenges()
t:Notify({Title="Refreshed",Content=#P.." challenges loaded.",Duration=2})
end,
})

aw=aI.Challenges:AddDropdown("SelectedChallenge",{
Title="Current Challenges",
Values={},
Callback=function(aJ)
local aK=Y[aJ]
if aK then
Q=aK
local aL=G[aK.map]
t:Notify({
Title=aK.label,
Content=aL and("Macro: "..aL)or"No macro assigned — set in Map Slots",
Duration=3,
})
end
end,
})

aI.Challenges:AddButton({
Title="Clear Challenge (lobby mode)",
Callback=function()
Q=nil
t:Notify({Title="Challenges",Content="Challenge cleared.",Duration=2})
end,
})


aI.Macros:AddSection("STATUS")
aA=aI.Macros:AddParagraph({Title="Status",Content="Idle"})

task.spawn(function()
while z do
task.wait(0.5)
updateStatus()
end
end)

aI.Macros:AddSection("GLITCH SPAWN")
aI.Macros:AddParagraph({
Title="Info",
Content="Spawns a unit from your loadout at your current position. Works during recording.",
})

local aJ=1
aI.Macros:AddSlider("GlitchSlot",{
Title="Loadout Slot",
Min=1,
Max=6,
Default=1,
Rounding=0,
Callback=function(aK)aJ=aK end,
})

aI.Macros:AddButton({
Title="Glitch Spawn Unit",
Callback=function()
local aK=e.Character
if not aK or not aK:FindFirstChild("HumanoidRootPart")then
t:Notify({Title="Error",Content="Character not found.",Duration=2})return
end
local aL,aM=pcall(function()
return h:InvokeServer(aJ,aK.HumanoidRootPart.CFrame)
end)
if not aL or not aM then
t:Notify({Title="Failed",Content="Server rejected placement — check your slot.",Duration=2})
end
end,
})

aI.Macros:AddSection("RECORD")

local aK=aI.Macros:AddInput("MacroName",{
Title="Macro Name",
Placeholder="e.g. grassy_easy",
Finished=false,
})

aI.Macros:AddButton({
Title="Start / Stop Recording",
Callback=function()
if B.active then
t:Notify({Title="Error",Content="Stop playback first.",Duration=2})return
end
if A.active then
A:Stop()
updateStatus()
t:Notify({Title="Recorder",Content="Stopped. "..#A.actions.." actions captured.",Duration=3})
else
A:Start()
updateStatus()
t:Notify({Title="Recorder",Content="Recording started — play the game normally.",Duration=3})
end
end,
})

aI.Macros:AddButton({
Title="Save Recording",
Callback=function()
if A.active then
t:Notify({Title="Error",Content="Stop recording first.",Duration=2})return
end
if#A.actions==0 then
t:Notify({Title="Error",Content="No actions recorded.",Duration=2})return
end
local aL=aK.Value:gsub("[^%w%-%_]","_")
if aL==""or aL=="_"then
t:Notify({Title="Error",Content="Enter a valid name.",Duration=2})return
end
w.SaveMacro(aL,A:Export(aL,{}))
H=w.ListMacros()
I=aL
if ap then ap:SetValues(H);ap:SetValue(aL)end
if as then as:SetValues(H)end
if ar then ar:SetValues(H)end
if av then av:SetValues(H)end
t:Notify({Title="Saved",Content="'"..aL.."' saved ("..#A.actions.." actions).",Duration=3})
end,
})

aI.Macros:AddSection("MANAGE")

as=aI.Macros:AddDropdown("MacroSelect",{
Title="Saved Macros",
Values=H,
Default=I,
Callback=function(aL)
I=aL
if ap then ap:SetValue(aL)end
end,
})

aI.Macros:AddButton({
Title="Delete Selected",
Callback=function()
if not I then
t:Notify({Title="Error",Content="Select a macro.",Duration=2})return
end
al:Dialog({
Title="Delete Macro",
Content="Delete '"..I.."'? This cannot be undone.",
Buttons={
{
Title="Delete",
Callback=function()
w.DeleteMacro(I)
H=w.ListMacros()
I=H[1]or nil
if ap then ap:SetValues(H)end
if as then as:SetValues(H)end
if ar then ar:SetValues(H)end
if av then av:SetValues(H)end
if I and ap then ap:SetValue(I)end
t:Notify({Title="Deleted",Content="Macro removed.",Duration=2})
end,
},
{Title="Cancel",Callback=function()end},
},
})
end,
})


aI.MapSlots:AddSection("PICK MAP")
aI.MapSlots:AddParagraph({
Title="Info",
Content="Loaded live from the game. Assign macros to challenge maps here.",
})

aI.MapSlots:AddInput("SlotSearch",{
Title="Search",
Placeholder="Search maps...",
Finished=false,
Callback=function(aL)
if at then at:SetValues(slotDisplayLabels(aL~=""and aL or nil))end
end,
})

at=aI.MapSlots:AddDropdown("SlotMap",{
Title="Available Maps",
Values={},
Callback=function(aL)
local aM=X[aL]
if aM then U=aM end
end,
})

aI.MapSlots:AddButton({
Title="Reload Maps",
Callback=function()
V=loadAllMaps()
if at then at:SetValues(slotDisplayLabels())end
if aq then aq:SetValues(farmDisplayLabels(nil,_))end
t:Notify({Title="Maps",Content=#V.." maps loaded.",Duration=2})
end,
})

aI.MapSlots:AddSection("ASSIGN")

local aL=I

av=aI.MapSlots:AddDropdown("SlotMacro",{
Title="Macro to Assign",
Values=H,
Default=I,
Callback=function(aM)aL=aM end,
})

aI.MapSlots:AddButton({
Title="Assign Macro to Map",
Callback=function()
if not U then
t:Notify({Title="Error",Content="Select a map first.",Duration=2})return
end
if not aL then
t:Notify({Title="Error",Content="Select a macro.",Duration=2})return
end
G[U.name]=aL
w.SaveMapSlots(G)
if au then au:SetValues(buildSlotItems())end
if at then at:SetValues(slotDisplayLabels())end
if aq then aq:SetValues(farmDisplayLabels(nil,_))end
t:Notify({Title="Saved",Content=U.name.." → "..aL,Duration=2})
end,
})

aI.MapSlots:AddSection("ASSIGNED SLOTS")

au=aI.MapSlots:AddDropdown("SlotList",{
Title="Assigned Slots",
Values=buildSlotItems(),
Callback=function(aM)
O=aM and aM:match("^(.-)%s+→")or nil
end,
})

aI.MapSlots:AddButton({
Title="Remove Selected Slot",
Callback=function()
if not O or not G[O]then
t:Notify({Title="Error",Content="Select a slot from the list.",Duration=2})return
end
al:Dialog({
Title="Remove Slot",
Content="Remove slot for '"..O.."'?",
Buttons={
{
Title="Remove",
Callback=function()
G[O]=nil
w.SaveMapSlots(G)
if au then au:SetValues(buildSlotItems())end
O=nil
t:Notify({Title="Removed",Content="Slot removed.",Duration=2})
end,
},
{Title="Cancel",Callback=function()end},
},
})
end,
})


aI.Settings:AddSection("GAME SETTINGS")
aI.Settings:AddParagraph({
Title="Note",
Content="AutoStart & AutoRestart are forced OFF — the script controls game flow.",
})

aI.Settings:AddToggle("WaveSkip",{
Title="Wave Skip (AutoSkip)",
Default=F.autoSkip~=false,
Callback=function(aM)
F.autoSkip=aM
w.SaveSettings(F)
g:FireServer("AutoSkip",aM)
end,
})

aI.Settings:AddSection("PLAYBACK TIMING")

aI.Settings:AddSlider("SellDelay",{
Title="Sell Delay (s)",
Min=0,
Max=1,
Default=F.sellDelay or 0.1,
Rounding=2,
Callback=function(aM)F.sellDelay=aM;w.SaveSettings(F)end,
})

aI.Settings:AddSection("UNIT SCAN RADIUS")
aI.Settings:AddParagraph({
Title="Info",
Content="Max stud radius when matching a played unit to its in-game GUID.",
})

aI.Settings:AddSlider("ScanRadius",{
Title="Scan Radius (studs)",
Min=2,
Max=20,
Default=F.scanRadius or 6,
Rounding=0,
Callback=function(aM)F.scanRadius=aM;w.SaveSettings(F)end,
})

aI.Settings:AddSection("AUTO FARM DELAYS")

aI.Settings:AddSlider("LobbyWait",{
Title="Lobby Wait (s)",
Min=1,
Max=30,
Default=F.lobbyWait or 5,
Rounding=0,
Callback=function(aM)F.lobbyWait=aM;w.SaveSettings(F)end,
})

aI.Settings:AddSlider("ReplayWait",{
Title="Replay Wait (s)",
Min=1,
Max=30,
Default=F.replayWait or 3,
Rounding=0,
Callback=function(aM)F.replayWait=aM;w.SaveSettings(F)end,
})


local aM

aI.Utils:AddSection("ANTI-AFK")

aI.Utils:AddToggle("AntiAfk",{
Title="Anti-AFK",
Default=true,
Callback=function(aN)
if aM then aM:Disconnect();aM=nil end
if aN then
aM=e.Idled:Connect(function()
d:CaptureController()
d:ClickButton2(Vector2.new())
end)
end
end,
})

aI.Utils:AddSection("LOADOUT")

aF=aI.Utils:AddParagraph({Title="Equipped Units",Content="Loading..."})

aI.Utils:AddButton({
Title="Refresh Loadout",
Callback=function()r()end,
})

aI.Utils:AddSection("TOOLS")

aI.Utils:AddButton({
Title="Open Dex Explorer",
Description="Instance explorer for the current game",
Callback=function()
local aN=pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LorekeeperZinnia/Dex/master/Dex3.lua"))()
end)
if not aN then t:Notify({Title="Dex",Content="Failed to load — link may be outdated.",Duration=3})end
end,
})

aI.Utils:AddButton({
Title="Open Remote Spy",
Description="Logs all remote calls (SimpleSpy)",
Callback=function()
local aN=pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
end)
if not aN then t:Notify({Title="Remote Spy",Content="Failed to load — link may be outdated.",Duration=3})end
end,
})

aI.Utils:AddSection("CONFIG")

u:SetLibrary(t)
u:IgnoreThemeSettings()
u:SetIgnoreIndexes({
"ActiveMacro","AutoFarm",
"FarmMode","FarmSearch","FarmMap","FarmAct","DirectMacro",
"SelectedChallenge","MacroName","MacroSelect",
"SlotSearch","SlotMap","SlotMacro","SlotList",
})
u:SetFolder("UTDMacroHub/utd")
u:BuildConfigSection(aI.Utils)

v:SetLibrary(t)
v:SetFolder("UTDMacroHub")
v:BuildInterfaceSection(aI.Settings)

al:SelectTab(1)


local function Destroy()
z=false
am()
A:Stop()
B:Stop()
pcall(function()al:Destroy()end)
pcall(function()hookmetamethod(game,"__namecall",C)end)
getgenv().UTDDestroy=nil
end
getgenv().UTDDestroy=Destroy


pcall(function()g:FireServer("AutoStart",false)end)
pcall(function()g:FireServer("AutoRestart",false)end)
pcall(function()g:FireServer("AutoSkip",F.autoSkip~=false)end)
t:Notify({Title="UTD Hub",Content="Loaded. AutoStart & AutoRestart disabled.",Duration=4})


task.spawn(function()
V=loadAllMaps()
if aq then aq:SetValues(farmDisplayLabels())end
if at then at:SetValues(slotDisplayLabels())end
end)

checkResumeAutoFarm()