


local a=game:GetService("Players")
local b=game:GetService("UserInputService")
local c=game:GetService("ReplicatedStorage")
local d=game:GetService("VirtualInputManager")
local e=game:GetService("VirtualUser")
local f=game:GetService("RunService")
local g=game:GetService("PathfindingService")
local h=game:GetService("TweenService")
local i=game:GetService("HttpService")
local j=game:GetService("MarketplaceService")
local k=a.LocalPlayer
local l=k:WaitForChild("PlayerGui")

if l:FindFirstChild("SupHub_UI")then
l.SupHub_UI:Destroy()
end


local m={Backgrounds={},Texts={}}

local n={
bg=Color3.fromRGB(15,15,20),
topbar=Color3.fromRGB(22,22,28),
card=Color3.fromRGB(26,26,33),
stroke=Color3.fromRGB(40,40,50),
text=Color3.fromRGB(240,240,240),
muted=Color3.fromRGB(140,140,150),
accent=Color3.fromRGB(110,80,255),
active=Color3.fromRGB(0,230,150),
danger=Color3.fromRGB(255,70,90),
warning=Color3.fromRGB(255,180,50)
}


local o,p=650,500
local q=false

local r=Instance.new("ScreenGui")
r.Name="SupHub_UI"
r.ResetOnSpawn=false
r.DisplayOrder=999999999
r.Parent=l

local s=Instance.new("Frame")
s.Size=UDim2.new(0,o,0,p)
s.Position=UDim2.new(0.5,-o/2,0.5,-p/2)
s.BackgroundColor3=n.bg
s.BorderSizePixel=0
s.ClipsDescendants=true
s.Parent=r
Instance.new("UICorner",s).CornerRadius=UDim.new(0,6)
local t=Instance.new("UIStroke")
t.Color=n.stroke;t.Thickness=1;t.Parent=s


local u=Instance.new("Frame")
u.Size=UDim2.new(1,0,0,35)
u.BackgroundColor3=n.topbar
u.BorderSizePixel=0
u.Parent=s
local v=Instance.new("UIStroke")
v.Color=n.stroke;v.Thickness=1;v.Parent=u

local w="Hyaku Asura"
pcall(function()
local x=j:GetProductInfo(game.PlaceId)
if x and x.Name then w=x.Name end
end)

local x=Instance.new("TextLabel")
x.Size=UDim2.new(1,-80,1,0)
x.Position=UDim2.new(0,15,0,0)
x.BackgroundTransparency=1
x.Text="Sup-Hub | "..w
x.Font=Enum.Font.GothamBold
x.TextSize=14
x.TextColor3=n.accent
x.TextXAlignment=Enum.TextXAlignment.Left
x.Parent=u

local function createWinBtn(y,z,A,B)
local C=Instance.new("TextButton")
C.Size=UDim2.new(0,30,0,20)
C.Position=UDim2.new(1,A,0,7)
C.BackgroundColor3=n.card
C.Text=y
C.Font=Enum.Font.GothamBold
C.TextSize=14
C.TextColor3=z
C.Parent=u
Instance.new("UICorner",C).CornerRadius=UDim.new(0,4)
local D=Instance.new("UIStroke")
D.Color=n.stroke;D.Parent=C
C.MouseButton1Click:Connect(B)
return C
end

createWinBtn("X",n.danger,-40,function()r:Destroy()end)
createWinBtn("-",n.warning,-75,function()
q=not q
s:TweenSize(q and UDim2.new(0,o,0,35)or UDim2.new(0,o,0,p),"Out","Quad",0.3,true)
end)

local y,z,A
u.InputBegan:Connect(function(B)
if B.UserInputType==Enum.UserInputType.MouseButton1 then
y=true;z=B.Position;A=s.Position
end
end)
u.InputEnded:Connect(function(B)
if B.UserInputType==Enum.UserInputType.MouseButton1 then y=false end
end)
b.InputChanged:Connect(function(B)
if y and B.UserInputType==Enum.UserInputType.MouseMovement then
local C=B.Position-z
s.Position=UDim2.new(A.X.Scale,A.X.Offset+C.X,A.Y.Scale,A.Y.Offset+C.Y)
end
end)


local B=Instance.new("ScrollingFrame")
B.Size=UDim2.new(1,0,0,40)
B.Position=UDim2.new(0,0,0,35)
B.BackgroundColor3=n.bg
B.BorderSizePixel=0
B.ScrollBarThickness=2
B.ScrollBarImageColor3=n.accent
B.ScrollingDirection=Enum.ScrollingDirection.X
B.AutomaticCanvasSize=Enum.AutomaticSize.X
B.CanvasSize=UDim2.new(0,0,0,0)
B.Parent=s

local C=Instance.new("UIListLayout")
C.FillDirection=Enum.FillDirection.Horizontal
C.SortOrder=Enum.SortOrder.LayoutOrder
C.Parent=B

local D=Instance.new("Frame")
D.Size=UDim2.new(1,0,1,-75)
D.Position=UDim2.new(0,0,0,75)
D.BackgroundTransparency=1
D.Parent=s

local E,F,G=nil,nil,nil

local function createPage()
local H=Instance.new("ScrollingFrame")
H.Size=UDim2.new(1,0,1,0)
H.BackgroundTransparency=1
H.BorderSizePixel=0
H.ScrollBarThickness=3
H.ScrollBarImageColor3=n.accent
H.AutomaticCanvasSize=Enum.AutomaticSize.Y
H.Visible=false
H.Parent=D

local I=Instance.new("UIListLayout")
I.Padding=UDim.new(0,12)
I.Parent=H
local J=Instance.new("UIPadding")
J.PaddingTop=UDim.new(0,15);J.PaddingLeft=UDim.new(0,20);J.PaddingRight=UDim.new(0,20);J.PaddingBottom=UDim.new(0,15)
J.Parent=H
return H
end

local function createTab(H,I,J)
local K=Instance.new("TextButton")
K.Size=UDim2.new(0,115,1,0)
K.BackgroundTransparency=1
K.Text="  "..I.." "..H
K.Font=Enum.Font.GothamSemibold
K.TextSize=13
K.TextColor3=n.muted
K.Parent=B

local L=Instance.new("Frame")
L.Size=UDim2.new(1,0,0,2)
L.Position=UDim2.new(0,0,1,-2)
L.BackgroundColor3=n.accent
L.BorderSizePixel=0
L.BackgroundTransparency=1
L.Parent=K

K.MouseButton1Click:Connect(function()
if E then
E.TextColor3=n.muted
G.BackgroundTransparency=1
end
if F then F.Visible=false end

E=K;F=J;G=L
K.TextColor3=n.text
L.BackgroundTransparency=0
J.Visible=true
end)
return K
end

local function makeStatusLabel(H)
local I=Instance.new("Frame")
I.Size=UDim2.new(1,0,0,30)
I.BackgroundColor3=n.card
I.Parent=H
Instance.new("UICorner",I).CornerRadius=UDim.new(0,4)
local J=Instance.new("UIStroke");J.Color=n.stroke;J.Parent=I

local K=Instance.new("TextLabel")
K.Size=UDim2.new(1,-20,1,0)
K.Position=UDim2.new(0,10,0,0)
K.BackgroundTransparency=1
K.Text="Status: Idle"
K.Font=Enum.Font.GothamSemibold
K.TextSize=13
K.TextColor3=n.warning
K.TextXAlignment=Enum.TextXAlignment.Left
K.Parent=I
return K
end

local function makeTitle(H,I)
local J=Instance.new("TextLabel")
J.Size=UDim2.new(1,0,0,20)
J.BackgroundTransparency=1
J.Text=I
J.Font=Enum.Font.GothamBold
J.TextSize=13
J.TextColor3=n.accent
J.TextXAlignment=Enum.TextXAlignment.Left
J.Parent=H
return J
end

local function makeInfoLabel(H,I)
local J=Instance.new("TextLabel")
J.Size=UDim2.new(1,0,0,20)
J.BackgroundTransparency=1
J.Text="  "..I
J.Font=Enum.Font.GothamMedium
J.TextSize=13
J.TextColor3=n.text
J.TextXAlignment=Enum.TextXAlignment.Left
J.Parent=H
return J
end

local function makeAccentButton(H,I,J)
local K=Instance.new("TextButton")
K.Size=UDim2.new(1,0,0,40)
K.BackgroundColor3=J or n.card
K.Text=I
K.Font=Enum.Font.GothamBold
K.TextSize=14
K.TextColor3=n.text
K.Parent=H
Instance.new("UICorner",K).CornerRadius=UDim.new(0,4)
local L=Instance.new("UIStroke");L.Color=n.stroke;L.Parent=K
return K
end

local function makeTextBox(H,I)
local J=Instance.new("Frame")
J.Size=UDim2.new(1,0,0,35)
J.BackgroundColor3=n.card
J.Parent=H
Instance.new("UICorner",J).CornerRadius=UDim.new(0,4)
local K=Instance.new("UIStroke");K.Color=n.stroke;K.Parent=J

local L=Instance.new("TextBox")
L.Size=UDim2.new(1,-20,1,0)
L.Position=UDim2.new(0,10,0,0)
L.BackgroundTransparency=1
L.Text=""
L.PlaceholderText=I
L.Font=Enum.Font.GothamMedium
L.TextSize=13
L.TextColor3=n.text
L.PlaceholderColor3=n.muted
L.TextXAlignment=Enum.TextXAlignment.Left
L.Parent=J
return L
end




local H="SupHub"
local I=H.."/Settings.json"

local J={
Webhook="",
FoodBlacklist="",
InteractKeyword="",
ItemToolName="",
TargetFoodName="",
SpoofOffset="500",
BankAmt="",
BuyAmt=""
}

pcall(function()
if not isfolder(H)then makefolder(H)end
if isfile(I)then
local K=i:JSONDecode(readfile(I))
if type(K)=="table"then
for L,M in pairs(K)do
J[L]=M
end
end
end
end)

local K=J.Webhook





local L=false
local M=false
local N=false
local O=false

local P=nil
local Q=nil
local R=nil

local S=nil
local T=nil
local U=nil
local V=nil
local W=nil

local X=nil
local Y=nil

local Z=nil
local _=nil
local aa=nil

local ab=nil
local ac=0

local function setStatus(ad)
if P then P.Text="Status: "..ad end
if Q then Q.Text="Status: "..ad end
if R then R.Text="Status: "..ad end
print("[FARM STATUS]: "..ad)
end


k.Idled:Connect(function()
if L or M or N then
e:CaptureController()
e:ClickButton2(Vector2.new())
end
end)

local ad


local function SendWebhook(ae,af,ag)
if K==""or type(K)~="string"then return end

local ah,ai,aj,ak,al,am,an,ao=ad()

local ap=al and math.floor(al.Value).."¥"or"N/A"
local aq=ak and string.format("%.1f",ak.Value).."%"or"N/A"
local ar=aj and math.floor(aj.Value).."%"or"N/A"
local as=(ah and ai)and math.floor(ah.Value).."/"..math.floor(ai.Value)or"N/A"

local at=am and tostring(math.floor(am.Value))or"N/A"
local au=an and tostring(math.floor(an.Value))or"N/A"
local av=ao and tostring(math.floor(ao.Value))or"N/A"

local aw={
["embeds"]={{
["title"]=ae,
["description"]=af,
["type"]="rich",
["color"]=ag or 7229695,
["fields"]={
{["name"]="💵 Cash",["value"]=ap,["inline"]=true},
{["name"]="😴 Fatigue",["value"]=aq,["inline"]=true},
{["name"]="🍔 Hunger",["value"]=ar,["inline"]=true},
{["name"]="⚡ Stamina",["value"]=as,["inline"]=true},
{["name"]="🛡️ Durability",["value"]=at,["inline"]=true},
{["name"]="💪 Strength",["value"]=au,["inline"]=true},
{["name"]="🏃 Agility",["value"]=av,["inline"]=true}
},
["footer"]={["text"]="Sup-Hub Stealth | "..os.date("%X")}
}}
}

local ax=i:JSONEncode(aw)

task.spawn(function()
pcall(function()
local ay=(syn and syn.request)or(http and http.request)or http_request or(fluxus and fluxus.request)or request
if ay then
ay({
Url=K,
Method="POST",
Headers={["Content-Type"]="application/json"},
Body=ax
})
end
end)
end)
end


task.spawn(function()
while task.wait(600)do
if(L or M or N)and K~=""then
SendWebhook("⏱️ 10-Minute Update","Your macro is still running flawlessly. Here is your current progress.",10181046)
end
end
end)

local function EmergencyStop(ae)
L=false
M=false
X=nil

if Z then Z.Text="Auto Farm Machine: OFF";Z.BackgroundColor3=n.card;Z.TextColor3=n.text end
if _ then _.Text="Auto Item Farm: OFF";_.BackgroundColor3=n.card;_.TextColor3=n.text end

if N then
N=false
if aa then aa.Text="Farm Subway Job: OFF";aa.BackgroundColor3=n.card;aa.TextColor3=n.text end
local af=k.Character
local ag=af and af:FindFirstChild("HumanoidRootPart")
if ag and ab then
ag.Anchored=false
ag.CFrame=ag.CFrame*CFrame.new(0,-ac,0)
ab=nil
end
end

setStatus("🚨 "..ae.." 🚨")
local af=k.Character
local ag=af and af:FindFirstChild("Humanoid")
if ag and ag.Health>0 then
ag:UnequipTools()
ag:MoveTo(af.HumanoidRootPart.Position)
end
SendWebhook("🚨 AFK Emergency Stop Triggered","**Reason:** "..ae,16730698)
end


local function stealthTweenTo(ae)
local af=k.Character
local ag=af and af:FindFirstChild("HumanoidRootPart")
if not ag then return end

local ah=45
local ai=ag.Anchored

local function doTween(aj)
local ak=(ag.Position-aj.Position).Magnitude
if ak<1 then return end

local al=ak/ah
local am=TweenInfo.new(al,Enum.EasingStyle.Linear)
local an=h:Create(ag,am,{CFrame=aj})

ag.Anchored=true
an:Play()
an.Completed:Wait()
end

setStatus("Stealth Tweening (Underground)...")
doTween(CFrame.new(ag.Position.X,-50,ag.Position.Z))
doTween(CFrame.new(ae.Position.X,-50,ae.Position.Z))
doTween(ae)
ag.Anchored=ai
end


local function walkTo(ae)
if not ae then return false end
local af=k.Character
local ag=af and af:FindFirstChild("Humanoid")
local ah=af and af:FindFirstChild("HumanoidRootPart")

if not ag or not ah then return false end

setStatus("Calculating path...")

local ai=g:CreatePath({
AgentRadius=2,
AgentHeight=5,
AgentCanJump=true,
AgentCanClimb=true,
WaypointSpacing=4
})

local aj,ak=pcall(function()
ai:ComputeAsync(ah.Position,ae)
end)

if aj and ai.Status==Enum.PathStatus.Success then
local al=ai:GetWaypoints()

for am,an in ipairs(al)do
if not af or not af.Parent or ag.Health<=0 or(not L and not M)then return false end

if an.Action==Enum.PathWaypointAction.Jump then
ag.Jump=true
end

ag:MoveTo(an.Position)

local ao=3
local ap=0
local aq=false

local ar
ar=ag.MoveToFinished:Connect(function(as)
aq=true
end)

while not aq and ap<ao do
task.wait(0.1)
ap=ap+0.1
end

ar:Disconnect()

if ap>=ao then
setStatus("Path stuck! Recalibrating...")
break
end
end
return true
else
setStatus("Path failed! Walking direct...")
ag:MoveTo(ae)
task.wait(3)
return false
end
end


ad=function()
local ae,af,ag,ah,ai,aj,ak,al
if k:FindFirstChild("leaderstats")then
ai=k.leaderstats:FindFirstChild("Yen")or k.leaderstats:FindFirstChild("Cash")or k.leaderstats:FindFirstChild("Money")or k.leaderstats:FindFirstChild("Coins")
end
local am=workspace:FindFirstChild("Entities")
local an=am and am:FindFirstChild(k.Name)
local ao=an and an:FindFirstChild("MainScript")
local ap=ao and ao:FindFirstChild("Stats")

if ap then
for aq,ar in pairs(ap:GetChildren())do
local as=string.lower(ar.Name)
if string.find(as,"stamina")and not string.find(as,"max")and not string.find(as,"cost")then ae=ar end
if string.find(as,"maxstamina")then af=ar end
if string.find(as,"hunger")or string.find(as,"hungry")then ag=ar end
if string.find(as,"fatig")or string.find(as,"fatiq")then ah=ar end
if string.find(as,"durab")then aj=ar end
if string.find(as,"strength")then ak=ar end
if string.find(as,"agility")then al=ar end
if not ai and(string.find(as,"yen")or string.find(as,"cash")or string.find(as,"money"))then ai=ar end
end
end
if not ai then
for aq,ar in pairs(k:GetDescendants())do
if ar:IsA("NumberValue")or ar:IsA("IntValue")then
local as=string.lower(ar.Name)
if as=="yen"or as=="cash"or as=="money"or as=="coins"or as=="wallet"then ai=ar;break end
end
end
end
return ae,af,ag,ah,ai,aj,ak,al
end

local function atmAction(ae,af)
local ag={"ATM",{ae,af}}
pcall(function()
c:WaitForChild("Remotes"):WaitForChild("RequestFunc"):InvokeServer(unpack(ag))
end)
end

local function depositAllCash()
local ae,af,ag,ah,ai=ad()
if ai and ai.Value>0 then
local aj=math.floor(ai.Value)
if aj>0 then
setStatus("Depositing "..aj.."¥...")
atmAction("Deposit",aj)
task.wait(0.3)
end
end
end


local function getClosestMachine(ah)
local ai=k.Character
local aj=ai and ai:FindFirstChild("HumanoidRootPart")

local ak=ah or(aj and aj.Position)
if not ak then return nil,math.huge end

local al=nil
local am=math.huge
local an={}

local ao=workspace:FindFirstChild("TrainingSpots")
if ao then
for ap,aq in pairs(ao:GetChildren())do
if not string.match(aq.Name,"HospitalBed")then
table.insert(an,aq)
end
end
end

local ap=workspace:FindFirstChild("GangBase")
local aq=ap and ap:FindFirstChild("TrainingMachines")
if aq then
for ar,as in pairs(aq:GetChildren())do
for at,au in pairs(as:GetChildren())do
if au.Name~="Bed"then
table.insert(an,au)
end
end
end
end

for ar,as in pairs(an)do
local at=as:FindFirstChildWhichIsA("Seat",true)
if at and not at.Occupant then
local au=(ak-at.Position).Magnitude
if au<am then
am=au
al=as
end
end
end

return al,am
end


local function getClosestEmptyBed()
local ah=k.Character
local ai=ah and ah:FindFirstChild("HumanoidRootPart")
if not ai then return nil end

local aj=nil
local ak=math.huge
local al={}

local am=workspace:FindFirstChild("TrainingSpots")
if am then
for an,ao in pairs(am:GetChildren())do
if string.match(ao.Name,"HospitalBed")then
table.insert(al,ao)
end
end
end

local an=workspace:FindFirstChild("GangBase")
local ao=an and an:FindFirstChild("TrainingMachines")
if ao then
for ap,aq in pairs(ao:GetChildren())do
for ar,as in pairs(aq:GetChildren())do
if as.Name=="Bed"then
table.insert(al,as)
end
end
end
end

for ap,aq in pairs(al)do
local ar=aq:FindFirstChildWhichIsA("Seat",true)
if ar and not ar.Occupant then
local as=(ai.Position-ar.Position).Magnitude
if as<ak then
ak=as
aj=aq
end
end
end

return aj
end

local function getHospitalBed()
local ah=workspace:FindFirstChild("TrainingSpots")
if ah then
for ai,aj in pairs(ah:GetChildren())do
if string.match(aj.Name,"HospitalBed")then
local ak=aj:FindFirstChildWhichIsA("Seat",true)
if ak and not ak.Occupant then return aj end
end
end
end
return nil
end

local function getRequiredKeyFromUI()
local ah=k:FindFirstChild("PlayerGui")
if ah then
local ai=ah:FindFirstChild("Training")
if ai then
local aj=ai:FindFirstChild("KeyMiniGame")
if aj then
local ak=aj:FindFirstChild("KeyMinigame")
if ak then
local al=ak:FindFirstChild("TextLabel")
if al and al.Text~=""then
return al.Text
end
end
end
end
end
return nil
end


local function getClosestFoodSource(ah,ai)
local aj=nil
local ak=math.huge
local al=ai and string.lower(ai)or""

for am,an in pairs(workspace:GetDescendants())do
if an:IsA("ClickDetector")and an.Parent and an.Parent:IsA("BasePart")then
if al~=""then
if string.find(string.lower(an.Parent.Name),al)or(an.Parent.Parent and string.find(string.lower(an.Parent.Parent.Name),al))then
local ao=(ah-an.Parent.Position).Magnitude
if ao<ak then
ak=ao
aj=an
end
end
else
local ao=(ah-an.Parent.Position).Magnitude
if ao<ak then
ak=ao
aj=an
end
end
end
end
return aj
end

local function consumeFood()
local ah=k:FindFirstChild("Backpack")
local ai=k.Character
if not ah or not ai then return false end
local aj=ai:FindFirstChild("Humanoid")
if not aj then return false end

local ak=S.Text
local al={}
if ak~=""then
for am,an in pairs(string.split(ak,","))do
local ao=string.match(an,"^%s*(.-)%s*$")
if ao and ao~=""then al[string.lower(ao)]=true end
end
end

for am,an in pairs(ah:GetChildren())do
if an:IsA("Tool")then
local ao=an:FindFirstChild("Consumable")
local ap=an:FindFirstChild("ItemType")
local aq=false
if ao and(ao.Value=="Food"or ao.Value=="Whey")then aq=true end
if ap and(ap.Value=="Food"or ap.Value=="BoostFood")then aq=true end

if aq then
local ar=string.lower(an.Name)
if not al[ar]then
setStatus("Eating "..an.Name.."...")
aj:EquipTool(an)
task.wait(0.5)
d:SendMouseButtonEvent(0,0,0,true,game,1)
task.wait(0.5)
d:SendMouseButtonEvent(0,0,0,false,game,1)
task.wait(1.5)
aj:UnequipTools()
return true
end
end
end
end
return false
end




local ah=false

task.spawn(function()
while task.wait(0.2)do
if O and not ah then
local ai=k.Character
local aj=ai and ai:FindFirstChild("HumanoidRootPart")
if aj then
local ak=nil
local al=20

for am,an in pairs(workspace:GetDescendants())do
if an:IsA("ProximityPrompt")and an.Enabled then
local ao=an.Parent
if ao and ao:IsA("BasePart")then
local ap=(aj.Position-ao.Position).Magnitude
if ap<=al then
local aq=string.lower(T.Text)
local ar=string.lower(an.ActionText)
local as=string.lower(an.ObjectText)
local at=string.lower(an.Name)

if aq==""or string.find(ar,aq)or string.find(as,aq)or string.find(at,aq)then
if ap<al then
al=ap
ak=an
end
end
end
end
end
end

if ak then
ah=true
local am=ak.HoldDuration
local an=ak.ObjectText~=""and ak.ObjectText or ak.ActionText
setStatus("Holding for "..an.." ("..string.format("%.1f",am).."s)")
ak:InputHoldBegin()
task.wait(am+0.1)
ak:InputHoldEnd()
task.wait(0.5)
ah=false
end
end
end
end
end)




task.spawn(function()
while task.wait(0.1)do
if L and X then
local ai=k.Character
local aj=ai and ai:FindFirstChild("Humanoid")
if not ai or not aj or aj.Health<=0 then
setStatus("Dead or not spawned. Waiting...")
task.wait(2)
continue
end

local ak,al,am,an,ao=ad()


if an and an.Value>=100 then
setStatus("Fatigue critical! Calculating path to bed...")
SendWebhook("💤 Resting","Fatigue hit 100%. Heading to bed.",3447003)

depositAllCash()
atmAction("Withdraw",2500)
task.wait(0.2)

local ap=getClosestEmptyBed()
if ap then
local aq=ap:FindFirstChildWhichIsA("Seat",true)
local ar=ap:FindFirstChildWhichIsA("ProximityPrompt",true)
if aq and ar then
walkTo(aq.Position)
if(ai.HumanoidRootPart.Position-aq.Position).Magnitude>15 then
setStatus("Failed to reach bed. Retrying...")
task.wait(1)
continue
end
if aq.Occupant==nil then
setStatus("Getting in bed...")
while L and aq.Occupant~=aj do
if aq.Occupant~=nil and aq.Occupant~=aj then break end
local as=ar.HoldDuration
ar.HoldDuration=0
fireproximityprompt(ar,1,true)
task.wait(0.1)
ar.HoldDuration=as
task.wait(0.5)
end
if aq.Occupant~=aj then task.wait(1);continue end
if not L then continue end
setStatus("Sleeping...")
while L do
local as,at,au,av,aw=ad()
if av and av.Value<=0 then
setStatus("Waking up...")
SendWebhook("🌅 Woke Up","Fully rested! Back to the machine.",5763719)

local ax=k.PlayerGui:FindFirstChild("Training")
local ay=ax and ax:FindFirstChild("Leave")and ax.Leave:FindFirstChild("Button")
if ay then
pcall(function()
if firesignal then firesignal(ay.MouseButton1Click);firesignal(ay.MouseButton1Down);firesignal(ay.Activated)
elseif getconnections then for az,aA in pairs(getconnections(ay.MouseButton1Click))do aA:Fire()end end
end)
end
if k.Character and k.Character:FindFirstChild("Humanoid")then k.Character.Humanoid.Jump=true end
break
end
if k.Character.Humanoid.Health<=0 then break end
setStatus("Sleeping... Fatigue: "..string.format("%.1f",av.Value).."%")
task.wait(1)
end
if k.Character.Humanoid.Health>0 then task.wait(0.5);depositAllCash()end

local av=X:FindFirstChildWhichIsA("Seat",true)
if not av or(av.Occupant~=nil and av.Occupant~=aj)then
setStatus("Machine stolen! Finding neighbor...")
local aw=av and av.Position or k.Character.HumanoidRootPart.Position
local ax=getClosestMachine(aw)
if ax then
X=ax
av=X:FindFirstChildWhichIsA("Seat",true)
else
setStatus("All machines taken! Waiting...");task.wait(5);continue
end
end
if av then walkTo(av.Position)end
continue
else
setStatus("Bed taken! Retrying...");task.wait(2);continue
end
end
else
setStatus("No empty beds! Waiting...");task.wait(3);continue
end
end


if am and am.Value<25 then
local ap=consumeFood()
if not ap then
if Y and Y.Parent then
setStatus("Out of food! Buying via remote...")
depositAllCash()
atmAction("Withdraw",1000)
task.wait(0.2)
for aq=1,5 do fireclickdetector(Y);task.wait(0.5)end
depositAllCash()
if not consumeFood()then EmergencyStop("OUT OF MONEY/FOOD! MACRO STOPPED")end
else
EmergencyStop("OUT OF FOOD (NO SHOP LOCKED)! MACRO STOPPED")
end
end
task.wait(1)
continue
end


local ap=X:FindFirstChildWhichIsA("Seat",true)
local aq=X:FindFirstChildWhichIsA("RemoteEvent",true)
local ar=X:FindFirstChildWhichIsA("ProximityPrompt",true)
if ap and aq and ar and aj then
if L then
if ap.Occupant~=aj then
local av=(aj.RootPart.Position-ap.Position).Magnitude
if av>15 then setStatus("Not close to any machine! Stand closer.");task.wait(2);continue end
setStatus("Mounting machine...")
while L and ap.Occupant~=aj do
if ap.Occupant==nil then
local aw=ar.HoldDuration
ar.HoldDuration=0
fireproximityprompt(ar,1,true)
task.wait(0.1)
ar.HoldDuration=aw
end
task.wait(0.2)
end
end
if not L then continue end

setStatus("Resting Stamina...")
while L and ap.Occupant==aj do
local av,aw=ad()
if av and aw and av.Value>=(aw.Value-0.5)then break end
task.wait(0.5)
end

if not L or ap.Occupant~=aj then continue end

setStatus("Funding machine (500¥)...")
depositAllCash()
atmAction("Withdraw",500)
task.wait(0.3)

setStatus("Starting training...")
aq:FireServer("Start",{Macro=false})
task.wait(0.5)

setStatus("Playing minigame...")
local av=tick()+60
while tick()<av and L and ap.Occupant==aj do
local aw,ax,ay,az=ad()
if az and az.Value>=100 then setStatus("Fatigue limit reached! Stopping...");break end
if(aw and aw.Value<15)or(ay and ay.Value<15)then setStatus("Stats critical! Bailing out...");break end

local aA=getRequiredKeyFromUI()
if aA then
task.wait(math.random(15,30)/100)
aq:FireServer("PressKey",{Key=aA})
task.wait(0.15)
else
task.wait(0.1)
end
end
if L and ap.Occupant==aj then aq:FireServer("Leave");task.wait(0.5)end
end
else
setStatus("Error: Locked machine is broken or missing parts.")
L=false
end
end
end
end)




task.spawn(function()
while task.wait(0.1)do
if M then
local ai=k.Character
local aj=ai and ai:FindFirstChild("Humanoid")
local ak=ai and ai:FindFirstChild("HumanoidRootPart")

if not ai or not aj or not ak or aj.Health<=0 then
setStatus("Dead or not spawned. Waiting...")
task.wait(2)
continue
end

local al,am,an,ao,ap=ad()


if ao and ao.Value>=100 then
setStatus("Fatigue critical! Sneaking to hospital bed...")
SendWebhook("💤 Stealth Resting","Fatigue hit 100%. Sneaking to the hospital.",3447003)

aj:UnequipTools()
depositAllCash()

local aq=getHospitalBed()
if aq then
local ar=aq:FindFirstChildWhichIsA("Seat",true)
local av=aq:FindFirstChildWhichIsA("ProximityPrompt",true)

if ar and av then
local aw=ak.CFrame
stealthTweenTo(ar.CFrame)

if ar.Occupant==nil then
setStatus("Getting in bed...")
while M and ar.Occupant~=aj do
if ar.Occupant~=nil and ar.Occupant~=aj then break end
local ax=av.HoldDuration
av.HoldDuration=0
fireproximityprompt(av,1,true)
task.wait(0.1)
av.HoldDuration=ax
task.wait(0.5)
end

if ar.Occupant~=aj then
stealthTweenTo(aw)
task.wait(1)
continue
end

if not M then continue end

setStatus("Sleeping...")
while M do
local ax,ay,az,aA,aB=ad()
if aA and aA.Value<=0 then
setStatus("Waking up...")
SendWebhook("🌅 Woke Up","Fully rested! Sneaking back to the farm spot.",5763719)

local aC=k.PlayerGui:FindFirstChild("Training")
local aD=aC and aC:FindFirstChild("Leave")and aC.Leave:FindFirstChild("Button")
if aD then
pcall(function()
if firesignal then firesignal(aD.MouseButton1Click);firesignal(aD.MouseButton1Down);firesignal(aD.Activated)
elseif getconnections then for aE,aF in pairs(getconnections(aD.MouseButton1Click))do aF:Fire()end end
end)
end
if k.Character and k.Character:FindFirstChild("Humanoid")then k.Character.Humanoid.Jump=true end
break
end
if k.Character.Humanoid.Health<=0 then break end
setStatus("Sleeping... Fatigue: "..string.format("%.1f",aA.Value).."%")
task.wait(1)
end

if k.Character.Humanoid.Health>0 then task.wait(0.5);depositAllCash()end
setStatus("Sneaking back to farm spot...")
stealthTweenTo(aw)
continue
else
setStatus("Bed taken! Sneaking back and retrying...")
stealthTweenTo(aw)
task.wait(2)
continue
end
end
else
setStatus("No hospital beds found! Waiting...")
task.wait(3)
continue
end
end


if an and an.Value<25 then
aj:UnequipTools()
local aq=consumeFood()

if not aq then
local ar=ak.Position
if N and ab then
ar=ab.Position
end

local av=V.Text
local aw=getClosestFoodSource(ar,av)

if aw and aw.Parent then
setStatus("Out of food! Sneaking to buy 5...")

local aA=ak.CFrame
local aB=aw.Parent.Position


local aC=CFrame.new(aB.X,-50,aB.Z)
local aD=CFrame.new(aB.X,aB.Y-12,aB.Z)

stealthTweenTo(aC)
ak.Anchored=true
ak.CFrame=aD
task.wait(0.5)

depositAllCash()
atmAction("Withdraw",1000)
task.wait(0.2)

for aE=1,5 do
fireclickdetector(aw)
task.wait(0.4)
end
depositAllCash()

ak.CFrame=aC
task.wait(0.2)
setStatus("Purchase complete. Returning...")
stealthTweenTo(aA)

if not consumeFood()then
EmergencyStop("OUT OF MONEY/FOOD! MACRO STOPPED")
end
else
EmergencyStop("NO FOOD DETECTED BY THAT NAME! MACRO STOPPED")
end
end
task.wait(1)
continue
end


if al and al.Value<15 then
setStatus("Resting Stamina...")
aj:UnequipTools()
while M do
local aq,ar=ad()
if aq and ar and aq.Value>=(ar.Value-0.5)then break end
task.wait(0.5)
end
continue
end

local aq=string.lower(U.Text)
local ar=ai:FindFirstChildWhichIsA("Tool")

if ar and string.lower(ar.Name)~=aq then
aj:UnequipTools()
ar=nil
end

if not ar then
local av=k:FindFirstChild("Backpack")
if av then
for aw,aA in pairs(av:GetChildren())do
if string.lower(aA.Name)==aq then
ar=aA;aj:EquipTool(aA);task.wait(0.2);break
end
end
end
end

if ar then
depositAllCash()
setStatus("Farming with "..ar.Name.."...")

local av=ai:FindFirstChild("MainScript")
local aw=av and av:FindFirstChild("Training")
if aw and aw:IsA("RemoteEvent")then
pcall(function()aw:FireServer("Start",{Macro=false})end)
end

d:SendMouseButtonEvent(0,0,0,true,game,1)
task.wait(0.1)
d:SendMouseButtonEvent(0,0,0,false,game,1)
task.wait(0.5)
else
setStatus("Error: Tool not found in Backpack!")
task.wait(2)
end
end
end
end)





local ai=createPage()
local aj=createPage()
local ak=createPage()
local al=createPage()
local am=createPage()
local an=createPage()

local ao=createTab("Main","💻",ai)
local ap=createTab("Items","🎒",aj)
local aq=createTab("Quests","📜",ak)
local ar=createTab("Live Stats","📊",al)
local av=createTab("Tools","🛠️",am)
local aw=createTab("Config","⚙️",an)


P=makeStatusLabel(ai)
local aA=Instance.new("Frame");aA.Size=UDim2.new(1,0,0,100);aA.BackgroundColor3=n.card;aA.BorderSizePixel=0;aA.Parent=ai;Instance.new("UICorner",aA).CornerRadius=UDim.new(0,4);local aB=Instance.new("UIStroke");aB.Color=n.stroke;aB.Parent=aA
local aC=Instance.new("UIListLayout");aC.Padding=UDim.new(0,2);aC.Parent=aA;local aD=Instance.new("UIPadding");aD.PaddingTop=UDim.new(0,8);aD.PaddingLeft=UDim.new(0,10);aD.Parent=aA
local aE=makeInfoLabel(aA,"💵 Cash: Loading...")
local aF=makeInfoLabel(aA,"⚡ Stamina: Loading...")
local aG=makeInfoLabel(aA,"🍔 Hunger: Loading...")
local aH=makeInfoLabel(aA,"😴 Fatigue: Loading...")

task.spawn(function()
while task.wait(0.5)do
local aI,aJ,aK,aL,aM=ad()
if aI and aJ then aF.Text="⚡ Stamina: "..math.floor(aI.Value).." / "..math.floor(aJ.Value)end
if aK then aG.Text="🍔 Hunger: "..math.floor(aK.Value).."%"end
if aM then aE.Text="💵 Cash: "..math.floor(aM.Value).."¥"else aE.Text="💵 Cash: NOT FOUND"end
if aL then aH.Text="😴 Fatigue: "..string.format("%.1f",aL.Value).."%"else aH.Text="😴 Fatigue: NOT FOUND"end
end
end)

S=makeTextBox(ai,"Food Blacklist")
S.Text=J.FoodBlacklist or""

Z=makeAccentButton(ai,"Auto Farm Machine: OFF",n.card)
Z.MouseButton1Click:Connect(function()
L=not L
if L then
if M then M=false;if _ then _.Text="Auto Item Farm: OFF";_.BackgroundColor3=n.card;_.TextColor3=n.text end end
if N then N=false;if aa then aa.Text="Farm Subway Job: OFF";aa.BackgroundColor3=n.card;aa.TextColor3=n.text end;local aI=k.Character and k.Character:FindFirstChild("HumanoidRootPart");if aI and ab then aI.Anchored=false;aI.CFrame=aI.CFrame*CFrame.new(0,-ac,0);ab=nil end end

local aI,aJ=getClosestMachine()
if aI then
X=aI
Z.Text="Auto Farm Machine: ON";Z.BackgroundColor3=n.active;Z.TextColor3=n.bg
else
L=false
setStatus("No valid training machine found!")
end
else
Z.Text="Auto Farm Machine: OFF";Z.BackgroundColor3=n.card;Z.TextColor3=n.text
X=nil
setStatus("Idle")
end
end)

T=makeTextBox(ai,"Interact Keyword")
T.Text=J.InteractKeyword or""

local aI=makeAccentButton(ai,"Auto Interact: OFF",n.card)
aI.MouseButton1Click:Connect(function()
O=not O
if O then aI.Text="Auto Interact: ON";aI.BackgroundColor3=n.accent;aI.TextColor3=n.text;setStatus("Auto Interacting Nearby Prompts...")
else aI.Text="Auto Interact: OFF";aI.BackgroundColor3=n.card;aI.TextColor3=n.text;setStatus("Idle")end
end)


Q=makeStatusLabel(aj)
makeTitle(aj,"Item Auto Farm")

U=makeTextBox(aj,"Tool Name (e.g. Setups, Weights)")
U.Text=J.ItemToolName or""

V=makeTextBox(aj,"Food to Buy (e.g. Sandwich)")
V.Text=J.TargetFoodName or""

_=makeAccentButton(aj,"Auto Item Farm: OFF",n.card)
_.MouseButton1Click:Connect(function()
M=not M
if M then
if L then L=false;if Z then Z.Text="Auto Farm Machine: OFF";Z.BackgroundColor3=n.card;Z.TextColor3=n.text;X=nil end end
_.Text="Auto Item Farm: ON";_.BackgroundColor3=n.active;_.TextColor3=n.bg
else
_.Text="Auto Item Farm: OFF";_.BackgroundColor3=n.card;_.TextColor3=n.text
local aJ=k.Character and k.Character:FindFirstChild("Humanoid")
if aJ then aJ:UnequipTools()end
setStatus("Idle")
end
end)


R=makeStatusLabel(ak)
makeTitle(ak,"Subway Job (Zone Farm)")

W=makeTextBox(ak,"Y-Offset Studs")
W.Text=J.SpoofOffset or"500"

aa=makeAccentButton(ak,"Farm Subway Job: OFF",n.card)
aa.MouseButton1Click:Connect(function()
N=not N
local aJ=k.Character and k.Character:FindFirstChild("HumanoidRootPart")

if N then
if aJ then
if L then L=false;if Z then Z.Text="Auto Farm Machine: OFF";Z.BackgroundColor3=n.card;Z.TextColor3=n.text;X=nil end end

ac=tonumber(W.Text)or 500
ab=aJ.CFrame
aJ.CFrame=aJ.CFrame*CFrame.new(0,ac,0)
aJ.Anchored=true

aa.Text="Farm Subway Job: ON";aa.BackgroundColor3=n.active;aa.TextColor3=n.bg
setStatus("Spoofed "..ac.." Studs")
else
N=false
setStatus("Character Not Found!")
end
else
if aJ and ab then aJ.Anchored=false;aJ.CFrame=aJ.CFrame*CFrame.new(0,-ac,0)end
ab=nil
aa.Text="Farm Subway Job: OFF";aa.BackgroundColor3=n.card;aa.TextColor3=n.text
setStatus("Idle")
end
end)


local aJ=Instance.new("Frame");aJ.Size=UDim2.new(1,0,1,0);aJ.BackgroundTransparency=1;aJ.Parent=al
local aK=Instance.new("UIGridLayout");aK.CellSize=UDim2.new(0.48,0,0,30);aK.CellPadding=UDim2.new(0.04,0,0,10);aK.SortOrder=Enum.SortOrder.Name;aK.Parent=aJ
local aL={}

task.spawn(function()
while task.wait(1)do
local aM=workspace:FindFirstChild("Entities")
local aN=aM and aM:FindFirstChild(k.Name)
local aO=aN and aN:FindFirstChild("MainScript")and aN.MainScript:FindFirstChild("Stats")

if aO then
for aP,aQ in pairs(aO:GetChildren())do
if aQ:IsA("NumberValue")or aQ:IsA("IntValue")or aQ:IsA("StringValue")or aQ:IsA("BoolValue")then
if not aL[aQ.Name]then
local aR=Instance.new("Frame");aR.BackgroundColor3=n.card;Instance.new("UICorner",aR).CornerRadius=UDim.new(0,4);local aS=Instance.new("UIStroke");aS.Color=n.stroke;aS.Parent=aR
local aT=Instance.new("TextLabel");aT.Size=UDim2.new(1,-20,1,0);aT.Position=UDim2.new(0,10,0,0);aT.BackgroundTransparency=1;aT.Font=Enum.Font.GothamMedium;aT.TextSize=13;aT.TextColor3=n.text;aT.TextXAlignment=Enum.TextXAlignment.Left;aT.Parent=aR
aR.Parent=aJ;aL[aQ.Name]=aT
end
local aR=aQ.Value;if type(aR)=="number"then aR=math.floor(aR*100)/100 end
aL[aQ.Name].Text=aQ.Name..": "..tostring(aR)
end
end
end
end
end)


local aM=makeAccentButton(am,"Lock Shop Item (Stand Near)",n.card)
aM.MouseButton1Click:Connect(function()
local aN=k.Character and k.Character:FindFirstChild("HumanoidRootPart")
if not aN then return end
local aO=false
for aP,aQ in pairs(workspace:GetDescendants())do
if aQ:IsA("ClickDetector")and aQ.Parent and aQ.Parent:IsA("BasePart")then
if(aN.Position-aQ.Parent.Position).Magnitude<=10 then
Y=aQ;aM.Text="Shop Item Locked!";aM.BackgroundColor3=n.active;aM.TextColor3=n.bg;setStatus("Shop Location Locked successfully.");aO=true;break
end
end
end
if not aO then aM.Text="Failed: Stand closer to food!";aM.BackgroundColor3=n.danger;aM.TextColor3=n.text;task.wait(2);aM.Text="Lock Shop Item (Stand Near)";aM.BackgroundColor3=n.card end
end)

local aN=makeTextBox(am,"Bank Amount")
aN.Text=J.BankAmt or""

local aO=Instance.new("Frame");aO.Size=UDim2.new(1,0,0,40);aO.BackgroundTransparency=1;aO.Parent=am
local aP=makeAccentButton(aO,"Deposit Cash",n.card);aP.Size=UDim2.new(0.48,0,1,0);aP.Position=UDim2.new(0,0,0,0)
aP.MouseButton1Click:Connect(function()
local aQ=tonumber(aN.Text)
if aQ and aQ>0 then setStatus("Manually depositing "..aQ.."¥");atmAction("Deposit",aQ)else setStatus("Invalid amount entered for Bank.")end
end)

local aQ=makeAccentButton(aO,"Withdraw Cash",n.card);aQ.Size=UDim2.new(0.48,0,1,0);aQ.Position=UDim2.new(0.52,0,0,0)
aQ.MouseButton1Click:Connect(function()
local aR=tonumber(aN.Text)
if aR and aR>0 then setStatus("Manually withdrawing "..aR.."¥");atmAction("Withdraw",aR)else setStatus("Invalid amount entered for Bank.")end
end)

local aR=makeTextBox(am,"Times to Buy Food")
aR.Text=J.BuyAmt or""

local aS=makeAccentButton(am,"Buy Locked Item",n.card)
aS.MouseButton1Click:Connect(function()
local aT=tonumber(aR.Text)or 1
if Y and Y.Parent then
setStatus("Buying item "..aT.." times remotely...")
task.spawn(function()for aU=1,aT do fireclickdetector(Y);task.wait(0.2)end;setStatus("Finished remote purchasing.")end)
else
setStatus("No shop item locked! Stand near one and lock it first.")
end
end)


local aT=makeTextBox(an,"Paste your Discord Webhook URL here...")
aT.Text=J.Webhook or""

local aU=Instance.new("Frame");aU.Size=UDim2.new(1,0,0,40);aU.BackgroundTransparency=1;aU.Parent=an

local aV=makeAccentButton(aU,"Save All Settings",n.card);aV.Size=UDim2.new(0.48,0,1,0);aV.Position=UDim2.new(0,0,0,0)
aV.MouseButton1Click:Connect(function()
J.FoodBlacklist=S.Text
J.InteractKeyword=T.Text
J.ItemToolName=U.Text
J.TargetFoodName=V.Text
J.SpoofOffset=W.Text
J.BankAmt=aN.Text
J.BuyAmt=aR.Text
J.Webhook=aT.Text

K=aT.Text
pcall(function()
if not isfolder(H)then makefolder(H)end
writefile(I,i:JSONEncode(J))
end)

aV.Text="Settings Saved!";aV.BackgroundColor3=n.active;aV.TextColor3=n.bg;task.wait(2);aV.Text="Save All Settings";aV.BackgroundColor3=n.card;aV.TextColor3=n.text
end)

local aW=makeAccentButton(aU,"Test Webhook",n.card);aW.Size=UDim2.new(0.48,0,1,0);aW.Position=UDim2.new(0.52,0,0,0)
aW.MouseButton1Click:Connect(function()
if K~=""then SendWebhook("🔔 Test Alert","Your Discord Webhook is successfully connected to Sup-Hub!",7229695);aW.Text="Sent!";aW.BackgroundColor3=n.accent;task.wait(2);aW.Text="Test Webhook";aW.BackgroundColor3=n.card
else aW.Text="No URL Saved!";aW.BackgroundColor3=n.danger;task.wait(2);aW.Text="Test Webhook";aW.BackgroundColor3=n.card end
end)


task.spawn(function()
E=ao;F=ai;G=ao:FindFirstChildWhichIsA("Frame")
ao.TextColor3=n.text;G.BackgroundTransparency=0;ai.Visible=true
end)

print("Sup-Hub JSON Config & Heartbeat Edition Loaded!")