








local a=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local b=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local c=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

if getgenv().SellLemonsDestroy then getgenv().SellLemonsDestroy()end


pcall(function()if setthreadidentity then setthreadidentity(8)end end)
pcall(function()if syn and syn.set_thread_identity then syn.set_thread_identity(8)end end)

local function safeSetDesc(d,e)
pcall(function()d:SetDesc(e)end)
end

local d=game:GetService("Players")
local e=game:GetService("RunService")
local f=game:GetService("Workspace")
local g=game:GetService("TweenService")
local h=game:GetService("VirtualUser")
local i=game:GetService("CollectionService")
local j=d.LocalPlayer

local k=a:CreateWindow({
Title="Sell Lemons",
SubTitle="v3.0",
TabWidth=160,
Size=UDim2.fromOffset(520,420),
Acrylic=false,
Theme="Dark",
MinimizeKey=Enum.KeyCode.RightControl,
})

local l=k:AddTab({Title="Main",Icon="apple"})
local m=k:AddTab({Title="Tycoon",Icon="hammer"})
local n=k:AddTab({Title="Settings",Icon="settings"})

l:AddSection("Auto Collect")

local o=l:AddParagraph({Title="Stats",Content="Collected: 0"})
local p=0

getgenv().LemonMode=getgenv().LemonMode or"Teleport"
getgenv().LemonSpeed=getgenv().LemonSpeed or 150
getgenv().LemonDelay=getgenv().LemonDelay or 0.1
getgenv().LemonSettle=getgenv().LemonSettle or 0.2
getgenv().LemonFireCount=getgenv().LemonFireCount or 3

local function getHRP()
local q=j.Character or j.CharacterAdded:Wait()
return q:FindFirstChild("HumanoidRootPart"),q
end

local function findLemons()
local q={}
for r,s in ipairs(f:GetDescendants())do
if s.Name=="LemonTree"then
for t,u in ipairs(s:GetChildren())do
if u.Name=="Fruit"then
local v=u:FindFirstChild("ClickPart")
if v then
local w=v:FindFirstChildOfClass("ClickDetector")
if w then
table.insert(q,{part=v,detector=w})
end
end
end
end
end
end
return q
end

local function moveTo(q)
local r=getHRP()
if not r then return false end


local s=q.Position+Vector3.new(0,-3,0)
local t,u,v=r.CFrame:ToOrientation()
local w=CFrame.new(s)*CFrame.Angles(0,u,0)

if getgenv().LemonMode=="Teleport"then
r.CFrame=w
return true
else
local x=(r.Position-s).Magnitude
local y=math.max(x/getgenv().LemonSpeed,0.05)
local z=g:Create(r,TweenInfo.new(y,Enum.EasingStyle.Linear),{CFrame=w})
z:Play()
z.Completed:Wait()
return true
end
end

task.spawn(function()
while task.wait(0.1)do
if getgenv().AutoCollectLemons then
local q=findLemons()
for r,s in ipairs(q)do
if not getgenv().AutoCollectLemons then break end
if s.part and s.part.Parent then
local u=s.part.CFrame
moveTo(u)
task.wait(getgenv().LemonSettle or 0.2)
for v=1,(getgenv().LemonFireCount or 3)do
pcall(fireclickdetector,s.detector)
task.wait(0.05)
end
if not s.part.Parent then
p+=1
safeSetDesc(o,"Collected: "..p)
end
end
task.wait(getgenv().LemonDelay or 0.1)
end
end
end
end)

l:AddToggle("AutoCollectLemons",{Title="Auto Collect Lemons",Default=false,Callback=function(q)
getgenv().AutoCollectLemons=q
end})

l:AddDropdown("LemonMode",{Title="Movement Mode",Values={"Teleport","Tween"},Default="Teleport",Callback=function(q)
getgenv().LemonMode=q
end})

l:AddSlider("LemonSpeed",{Title="Tween Speed (studs/s)",Min=20,Max=500,Default=150,Rounding=0,Callback=function(q)
getgenv().LemonSpeed=q
end})

l:AddSlider("LemonDelay",{Title="Per-Fruit Delay (s)",Min=0.05,Max=1,Default=0.1,Rounding=2,Callback=function(q)
getgenv().LemonDelay=q
end})

l:AddSlider("LemonSettle",{Title="Settle Before Click (s)",Min=0.05,Max=1,Default=0.2,Rounding=2,Callback=function(q)
getgenv().LemonSettle=q
end})

l:AddSlider("LemonFireCount",{Title="Fire Clicks Per Fruit",Min=1,Max=10,Default=3,Rounding=0,Callback=function(q)
getgenv().LemonFireCount=q
end})

l:AddButton({Title="Collect Once",Callback=function()
local q=findLemons()
for r,s in ipairs(q)do
if s.part and s.part.Parent then
moveTo(s.part.CFrame)
pcall(fireclickdetector,s.detector)
p+=1
end
end
safeSetDesc(o,"Collected: "..p)
a:Notify({Title="Sell Lemons",Content="Fired "..#q.." lemons",Duration=2})
end})

l:AddButton({Title="Reset Counter",Callback=function()
p=0
safeSetDesc(o,"Collected: 0")
end})

m:AddSection("Auto Buy Buttons")

local q=m:AddParagraph({Title="Stats",Content="Bought: 0 | Plot: none"})
local r=0

local function getMyTycoon()
for s,u in ipairs(i:GetTagged("Tycoon"))do
local v=u:FindFirstChild("Owner")
if v and v:IsA("ObjectValue")and v.Value==j then
return u
end
end
return nil
end

local s=game:GetService("ReplicatedStorage")

local function tryRequire(u)
local v,w=pcall(function()return require(u)end)
if v then return w end
return nil
end

local u=tryRequire(s.Modules.Tycoon.Tycoon)
local v=tryRequire(s.Modules.Tycoon.Component.TycoonAnalyzer)
local w=tryRequire(s.Modules.Tycoon.Component.TycoonBalances)
local x=tryRequire(s.Balance)

local function getNextPurchase()
if not(u and v and w and x)then return nil end
local y=u.getLocal()
if not y then return nil end
local z=y:GetComponent(v)
local A=y:GetComponent(w)
if not(z and A)then return nil end
local B=z:GetPurchases()
local C=A:GetCash()
for D,E in ipairs(x.PurchaseOrder or{})do
local F=B[E]
if F and F:IsEnabled()and not F:IsPurchased()then
local G=F:GetPrice()
if G and G<=C then
return F
end
end
end
return nil
end

local function tpToInstance(y)
local z=getHRP()
if not z or not y then return false end
local A
if y:IsA("BasePart")then
A=y.CFrame+Vector3.new(0,3,0)
elseif y:IsA("Model")then
local B=y.PrimaryPart or y:FindFirstChildWhichIsA("BasePart",true)
if B then A=B.CFrame+Vector3.new(0,3,0)end
end
if not A then return false end
if getgenv().LemonMode=="Teleport"then
z.CFrame=A
else
local B=(z.Position-A.Position).Magnitude
local C=math.max(B/(getgenv().LemonSpeed or 150),0.05)
local D=g:Create(z,TweenInfo.new(C,Enum.EasingStyle.Linear),{CFrame=A})
D:Play()
D.Completed:Wait()
end
return true
end

local function getPurchaseRemotes(y)
local z={}
for A,B in ipairs(y:GetDescendants())do
if B:IsA("RemoteFunction")and B.Name=="Purchase"then
table.insert(z,B)
end
end
return z
end

getgenv().BuyDelay=getgenv().BuyDelay or 0.2

task.spawn(function()
while task.wait(getgenv().BuyDelay or 0.2)do
if getgenv().AutoBuyButtons then
local y=getNextPurchase()
if y then
local z=y.Button or y.Instance
local A=tpToInstance(z)
task.wait(getgenv().LemonSettle or 0.2)
task.spawn(function()
local B=pcall(function()y.PurchaseRemote:InvokeServer(false)end)
if B then r+=1 end
end)
safeSetDesc(q,"Bought: "..r.." | Next: "..(y.Name or"?").." | TP'd: "..tostring(A))
else
local z=getMyTycoon()
if z then
safeSetDesc(q,"Bought: "..r.." | Nothing affordable/enabled in "..z.Name)
else
safeSetDesc(q,"Bought: "..r.." | NOT CLAIMED — claim a tycoon first")
end
end
end
end
end)

m:AddToggle("AutoBuyButtons",{Title="Auto Buy All Buttons",Default=false,Callback=function(y)
getgenv().AutoBuyButtons=y
end})

m:AddSlider("BuyDelay",{Title="Buy Delay (s)",Min=0.05,Max=2,Default=0.2,Rounding=2,Callback=function(y)
getgenv().BuyDelay=y
end})

m:AddButton({Title="Buy Next Once",Callback=function()
local y=getNextPurchase()
if not y then
a:Notify({Title="Sell Lemons",Content="Nothing affordable/enabled",Duration=3})
return
end
local z=y.Button or y.Instance
tpToInstance(z)
task.wait(getgenv().LemonSettle or 0.2)
pcall(function()y.PurchaseRemote:InvokeServer(false)end)
r+=1
a:Notify({Title="Sell Lemons",Content="Bought: "..tostring(y.Name),Duration=3})
end})

m:AddButton({Title="Reset Counter",Callback=function()
r=0
end})

m:AddSection("Auto Upgrade Buildings")

local y=m:AddParagraph({Title="Upgrades",Content="Upgraded: 0"})
local z=0

local A={}
local B=1.2

local function getCheapestEarner()
if not(u and v and w)then return nil end
local C=u.getLocal()
if not C then return nil end
local D=C:GetComponent(v)
local E=C:GetComponent(w)
if not(D and E)then return nil end
local F=E:GetCash()
local G=os.clock()
local H,I,J=nil,nil,nil
for K,L in pairs(D:GetEarners()or{})do
local M=L.Name
if not(A[M]and G-A[M]<B)then
local N,O=pcall(function()return L:GetUpgradeLevel()end)
if N and O then
local P,Q,R=pcall(function()return L:GetUpgradePrice(O,1)end)
if P and Q and R and R>0 and Q<=F then
if not H or Q<I then
H,I,J=L,Q,O
end
end
end
end
end
return H,I,J
end

getgenv().UpgradeDelay=getgenv().UpgradeDelay or 0.3
getgenv().UpgradeStack=getgenv().UpgradeStack or 1

task.spawn(function()
while task.wait(getgenv().UpgradeDelay or 0.3)do
if getgenv().AutoUpgrade then
local C,D,E=getCheapestEarner()
if C and C.UpgradeRemote then
local F=getgenv().UpgradeStack or 1
A[C.Name]=os.clock()
task.spawn(function()
pcall(function()C.UpgradeRemote:InvokeServer(F)end)
z+=1
end)
safeSetDesc(y,"Upgraded: "..z.." | x"..F.." | lvl "..tostring(E).." | "..tostring(C.Name or"?"))
else
safeSetDesc(y,"Upgraded: "..z.." | Nothing affordable or all on cooldown")
end
end
end
end)

m:AddToggle("AutoUpgrade",{Title="Auto Upgrade Buildings",Default=false,Callback=function(C)
getgenv().AutoUpgrade=C
end})

m:AddSlider("UpgradeDelay",{Title="Upgrade Delay (s)",Min=0.05,Max=2,Default=0.3,Rounding=2,Callback=function(C)
getgenv().UpgradeDelay=C
end})

m:AddSlider("UpgradeStack",{Title="Upgrade Stack Count",Min=1,Max=100,Default=1,Rounding=0,Callback=function(C)
getgenv().UpgradeStack=C
end})

m:AddButton({Title="Upgrade Cheapest Once",Callback=function()
local C,D,E=getCheapestEarner()
if not C then
a:Notify({Title="Sell Lemons",Content="Nothing affordable to upgrade",Duration=3})
return
end
local F=getgenv().UpgradeStack or 1
A[C.Name]=os.clock()
pcall(function()C.UpgradeRemote:InvokeServer(F)end)
z+=1
a:Notify({Title="Sell Lemons",Content="Upgraded "..tostring(C.Name).." x"..F.." (lvl "..tostring(E)..")",Duration=3})
end})

n:AddToggle("AntiAFK",{Title="Anti-AFK",Default=true,Callback=function(C)getgenv().AntiAFK=C end})
getgenv().AntiAFK=true
j.Idled:Connect(function()
if getgenv().AntiAFK then
h:CaptureController()
h:ClickButton2(Vector2.new())
end
end)

b:SetLibrary(a)
c:SetLibrary(a)
c:SetFolder("SellLemons")
b:SetFolder("SellLemons")
b:BuildConfigSection(n)
c:BuildInterfaceSection(n)
b:LoadAutoloadConfig()

a:Notify({Title="Sell Lemons",Content="Loaded v3.0",Duration=3})

getgenv().SellLemonsDestroy=function()
getgenv().AutoCollectLemons=false
getgenv().AutoBuyButtons=false
getgenv().AutoUpgrade=false
getgenv().AntiAFK=false
k:Destroy()
getgenv().SellLemonsDestroy=nil
end