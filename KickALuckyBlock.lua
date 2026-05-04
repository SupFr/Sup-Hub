local a=game:GetService("Players")
local b=game:GetService("ReplicatedStorage")

local c=a.LocalPlayer
local d=c.PlayerGui
local e=b:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")

local function fireRemote(f,...)
e:WaitForChild(f):FireServer(...)
end

local f={
["Golden"]=1,["Diamond"]=2,["Plasma"]=3,["Molten"]=4,
["Radioactive"]=5,["Virus"]=6,["Shadow"]=7,["Electrified"]=8,["Rainbow"]=9,["Void"]=10,
}

local g={
["Golden"]=1.5,["Diamond"]=2,["Plasma"]=4,["Molten"]=6,
["Radioactive"]=8,["Virus"]=10,["Shadow"]=12,["Electrified"]=16,["Rainbow"]=30,["Void"]=10,
}

local h={
"Common","Rare","Epic","Legendary","Mythic",
"Godly","Secret","Divine","Hacked","OG","Celestial","Rainbow","Demon","Exclusive"
}

local i={
"None","Golden","Diamond","Plasma","Molten",
"Radioactive","Virus","Shadow","Electrified","Rainbow","Void"
}

local function getRarity(j)
local k={
["Noobini Pizzanini"]="Common",["Lirili Larila"]="Common",["Tim Cheese"]="Common",
["Talpa Di Fero"]="Common",["Svinina Bombardino"]="Common",["Pipi Kiwi"]="Common",
["Fruli Frula"]="Common",["Trippi Troppi"]="Common",["Gangster Footera"]="Rare",
["Bobrito Bandito"]="Rare",["Boneca Ambalabu"]="Rare",["Ta Ta Ta Ta Sahur"]="Rare",
["Ballerina Cappuccina"]="Rare",["Cappuccino Assassino"]="Rare",["Brr Brr Patapim"]="Rare",
["Cacto Hipopotamo"]="Rare",["Garamararam"]="Epic",["Madung"]="Epic",["Waterdino"]="Epic",
["Pesto Mortioni"]="Epic",["Pannaburro"]="Epic",["Orcalero"]="Epic",
["Mangolini Parrocini"]="Epic",["John Pork"]="Epic",["Gattatino Nyanino"]="Epic",
["Chimpanzini Bananini"]="Legendary",["Plan Red"]="Legendary",["Plan Blue"]="Legendary",
["Capi Taco"]="Legendary",["Trulimero Trulicina"]="Legendary",["Bambini Crostini"]="Legendary",
["Elefantucci Bananucci"]="Legendary",["Bananita Dolphinita"]="Legendary",
["Salamino Pinguino"]="Legendary",["Penguino Cocosino"]="Mythic",["67"]="Mythic",
["Burbaloni Luliloli"]="Mythic",["Chef Crabracadabra"]="Mythic",["Capybara Eggplant"]="Mythic",
["Bangello"]="Mythic",["Elefanto Frigo"]="Mythic",["Rinooccio Verdini"]="Mythic",
["Glorbo Fruttodrillo"]="Mythic",["Udin Din Din Dun"]="Godly",["Pandaccini Bananini"]="Godly",
["Octopusini Bluberini"]="Godly",["Strawberelli Flamingelli"]="Godly",["Sigma Boy"]="Godly",
["Frigo Camelo"]="Godly",["Orangutini Ananasini"]="Godly",["Rhino Toasterino"]="Godly",
["Bombardiro Crocodilo"]="Godly",["Bombini Gusini"]="Secret",["Tuff Toucan"]="Secret",
["Fryuro"]="Secret",["Burguro"]="Secret",["Guest666"]="Secret",
["Zibra Zubra Zibralini"]="Secret",["Cavallo Virtuso"]="Secret",
["Gorillo Watermelondrillo"]="Secret",["Cocofanto Elefanto"]="Secret",
["Girafa Celeste"]="Divine",["Tralalero Tralala"]="Divine",["Tralalerita Tralala"]="Divine",
["Peant Jarro"]="Divine",["Dipperi Chiperini"]="Divine",["Rexosaurus"]="Divine",
["1x1x1x1"]="Divine",["Matteo"]="Divine",["Espresso Signora"]="Divine",
["Alessio"]="Hacked",["Tripi Tropi Tropa Tripa"]="Hacked",["SWAG SODA"]="Hacked",
["Stoppo Luminino"]="Hacked",["Torrtuginni Dragonfrutini"]="Hacked",["Tictac Sahur"]="Hacked",
["Los Primos Blue"]="Hacked",["Cactus Pingu"]="Hacked",
["La Vacca Saturno Saturnita"]="Hacked",["Agarrini La Palini"]="Hacked",
["Karkerkar Kurkur"]="OG",["Blackhole Goat"]="OG",["Cappuccino Clownino"]="OG",
["Compactoroni Diskaloni"]="OG",["Nuclearo Dinossauro"]="OG",["Chillin Chilli"]="OG",
["Crazylone Pizaione"]="OG",["Corn Sahur"]="OG",["Meowl"]="OG",
["Strawberry Elephant"]="OG",["Dragonfrutina Dolphinita"]="Celestial",
["Guerriro Digitale"]="Celestial",["Chicleteira Bicicleteira"]="Celestial",
["Pot Hotspot"]="Celestial",["Krupuk Pagi Pagi"]="Celestial",["Beluga Beluga"]="Celestial",
["Tralaledon"]="Celestial",["Anpali Babel"]="Celestial",
["Mastodontico Telepiedone"]="Celestial",["Ketupat Kepat"]="Celestial",
}
return k[j]or"Common"
end

local j={
["Common"]=1,["Rare"]=2,["Epic"]=3,["Legendary"]=4,["Mythic"]=5,
["Godly"]=6,["Secret"]=7,["Divine"]=8,["Hacked"]=9,["OG"]=10,
["Celestial"]=11,["Rainbow"]=12,["Demon"]=13,["Exclusive"]=14
}

local k={
["Noobini Pizzanini"]=2,["Lirili Larila"]=3,["Tim Cheese"]=3,["Talpa Di Fero"]=4,
["Svinina Bombardino"]=5,["Pipi Kiwi"]=6,["Fruli Frula"]=7,["Trippi Troppi"]=7,
["Gangster Footera"]=15,["Bobrito Bandito"]=17,["Boneca Ambalabu"]=17,
["Ta Ta Ta Ta Sahur"]=18,["Ballerina Cappuccina"]=19,["Cappuccino Assassino"]=22,
["Brr Brr Patapim"]=22,["Cacto Hipopotamo"]=26,["Garamararam"]=40,["Madung"]=44,
["Waterdino"]=50,["Pesto Mortioni"]=52,["Pannaburro"]=62,["Orcalero"]=64,
["Mangolini Parrocini"]=64,["John Pork"]=72,["Gattatino Nyanino"]=76,
["Chimpanzini Bananini"]=100,["Plan Red"]=130,["Plan Blue"]=140,["Capi Taco"]=150,
["Trulimero Trulicina"]=160,["Bambini Crostini"]=160,["Elefantucci Bananucci"]=170,
["Bananita Dolphinita"]=210,["Salamino Pinguino"]=230,["Penguino Cocosino"]=450,
["67"]=500,["Burbaloni Luliloli"]=550,["Chef Crabracadabra"]=600,
["Capybara Eggplant"]=650,["Bangello"]=725,["Elefanto Frigo"]=775,
["Rinooccio Verdini"]=880,["Glorbo Fruttodrillo"]=920,["Udin Din Din Dun"]=1850,
["Pandaccini Bananini"]=2000,["Octopusini Bluberini"]=2150,
["Strawberelli Flamingelli"]=2300,["Sigma Boy"]=2450,["Frigo Camelo"]=2600,
["Orangutini Ananasini"]=2700,["Rhino Toasterino"]=2950,["Bombardiro Crocodilo"]=3100,
["Bombini Gusini"]=4750,["Tuff Toucan"]=5300,["Fryuro"]=5850,["Burguro"]=6250,
["Guest666"]=7000,["Zibra Zubra Zibralini"]=7750,["Cavallo Virtuso"]=8500,
["Gorillo Watermelondrillo"]=9500,["Cocofanto Elefanto"]=10000,
["Girafa Celeste"]=16500,["Tralalero Tralala"]=17500,["Tralalerita Tralala"]=18000,
["Peant Jarro"]=19500,["Dipperi Chiperini"]=20000,["Rexosaurus"]=22500,
["1x1x1x1"]=23000,["Matteo"]=25000,["Espresso Signora"]=27500,
["Alessio"]=27500,["Tripi Tropi Tropa Tripa"]=28000,["SWAG SODA"]=29000,
["Stoppo Luminino"]=30000,["Torrtuginni Dragonfrutini"]=32000,["Tictac Sahur"]=38000,
["Los Primos Blue"]=44500,["Cactus Pingu"]=44500,["La Vacca Saturno Saturnita"]=49500,
["Agarrini La Palini"]=53500,["Karkerkar Kurkur"]=120000,["Blackhole Goat"]=125000,
["Cappuccino Clownino"]=135000,["Compactoroni Diskaloni"]=135000,
["Nuclearo Dinossauro"]=190000,["Chillin Chilli"]=220000,["Crazylone Pizaione"]=225000,
["Corn Sahur"]=225000,["Meowl"]=275000,["Strawberry Elephant"]=420000,
["Dragonfrutina Dolphinita"]=475000,["Guerriro Digitale"]=490000,
["Chicleteira Bicicleteira"]=500000,["Pot Hotspot"]=525000,["Krupuk Pagi Pagi"]=540000,
["Beluga Beluga"]=575000,["Tralaledon"]=625000,["Anpali Babel"]=750000,
["Mastodontico Telepiedone"]=850000,["Ketupat Kepat"]=1000000,
}

local function getBaseCPS(l)return k[l]or 0 end
local function getRarityRank(l)return j[getRarity(l)]or 0 end

local function getSlotScore(l,m)
local n=k[l]or((j[getRarity(l)]or 0)*100)
local o=(m and g[m])or 1
return n*o
end

local function getMyPlot()
local l=workspace:FindFirstChild("Plots")
if not l then return nil end
for m,n in ipairs(l:GetChildren())do
if n:GetAttribute("Owner")==c.Name then return n end
end
return nil
end

local function getSlotsWithMutation()
local l={}
local m=getMyPlot()
if not m then return l end
local n=m:FindFirstChild("Slots")
if not n then return l end
for o,p in ipairs(n:GetChildren())do
local q=p:FindFirstChild("PlacedPart")
local r=tonumber(p.Name:match("%d+"))
if r then
if q then
local s=q:GetAttribute("ID")
local t=q:GetAttribute("Level")or 1
local u=q:GetAttribute("Mutation")
if u==""then u=nil end
table.insert(l,{
index=r,
name=s,
level=t,
cps=getBaseCPS(s),
mutation=u,
score=getSlotScore(s,u),
empty=false,
})
else
table.insert(l,{index=r,empty=true,score=0})
end
end
end
return l
end

local function getWeakestSlotScored()
local l=nil
for m,n in ipairs(getSlotsWithMutation())do
if not n.empty then
if not l or n.score<l.score then
l=n
end
end
end
return l
end

local function getEmptySlot()
for l,m in ipairs(getSlotsWithMutation())do
if m.empty then return m.index end
end
end

local function placeIntoSlot(l,m,n)
local o
for p,q in ipairs(c.Backpack:GetChildren())do
if q.Name==l then
local r=q:GetAttribute("Mutation")
if r==""then r=nil end
if r==m then
o=q
break
end
end
end
if o then
o.Parent=c.Character
task.wait(0.1)
fireRemote("rev_S_Interact",n)
task.wait(0.2)
end
end

local function getGymTool()
for l,m in ipairs(c.Backpack:GetChildren())do
if m:IsA("Tool")then
local n=m:GetAttributes()
local o=0
for p in pairs(n)do o+=1 end
if o==0 then return m end
end
end
if c.Character then
for l,m in ipairs(c.Character:GetChildren())do
if m:IsA("Tool")then
local n=m:GetAttributes()
local o=0
for p in pairs(n)do o+=1 end
if o==0 then return m end
end
end
end
end

local function equipTool(l)
if l and c.Character then l.Parent=c.Character end
end

local function getKickReadyPosition()
local l=workspace:FindFirstChild("Areas")
local m=l and l:FindFirstChild("KickReady")
if m then return m.CFrame end
return nil
end




local function getKickUpgrades()
return d:FindFirstChild("KickUpgrades")
end

local function suppressExistingBonus(l)
local m=getKickUpgrades()
if not m then return end
for n,o in ipairs(m:GetChildren())do
if o.Name=="Bonus"then
l[o]=true
o.Visible=false
end
end
end

local function clickBonusBtn(l)
pcall(function()
local m=l:FindFirstChildWhichIsA("ClickDetector")
or l:FindFirstChildOfClass("ClickDetector")
if m then
fireclickdetector(m)
return
end
local n=l.AbsolutePosition+l.AbsoluteSize/2
local o=game:GetService("VirtualInputManager")
o:SendMouseButtonEvent(n.X,n.Y,0,true,game,0)
o:SendMouseButtonEvent(n.X,n.Y,0,false,game,0)
end)
end

local function scanAndClickNewBonus(l)
local m=0
local n=getKickUpgrades()
if not n then return 0 end
for o,p in ipairs(n:GetChildren())do
if p.Name=="Bonus"and not l[p]then
clickBonusBtn(p)
m+=1
end
end
return m
end




local l=loadstring(game:HttpGet(
"https://raw.githubusercontent.com/SupFr/Sup-Hub/refs/heads/main/SupUI_Library.lua"
))()

local m=l:CreateWindow({
Name="LuckyBlock Farm - Sup Hub",
SubTitle="v7.0",
Width=620,
Height=580,
AutoScale=true,
AntiAFK=true,
ShowSettings=true,
AutoLoadConfig=true,
DefaultConfig="default",
})

local n=m:CreateTab("Kick","⚽")
local o=m:CreateTab("Farm","💰")
local p=m:CreateTab("Upgrade","⬆")

local q={
autoKick=false,
autoCollect=false,
autoUpgrade=false,
autoTrain=false,
autoReplace=false,
autoRebirth=false,
upgradeDelay=0.1,
trainDelay=0.5,
kickMinRarity="Common",
kickMinMutation="None",
}


local function makeStatus(r,s)
return r:CreateLabel(s,"text_dim")
end




n:CreateSection("Brainrot Filter")

n:CreateDropdown({
Name="Min Rarity",
Options=h,
CurrentValue="Common",
Flag="kick_min_rarity",
Callback=function(r)q.kickMinRarity=r end,
})

n:CreateDropdown({
Name="Min Mutation",
Options=i,
CurrentValue="None",
Flag="kick_min_mutation",
Callback=function(r)q.kickMinMutation=r end,
})

n:CreateSection("Auto Kick")
local r=makeStatus(n,"● Idle")

n:CreateToggle({
Name="Auto Kick (Timing Bypass)",
Flag="auto_kick",
Callback=function(s)
q.autoKick=s
if not s then
r:SetText("● Stopped","text_dim")
return
end
task.spawn(function()
task.wait(0.1)
local t={
["Common"]={Speed=11,Start_X=549.768},
["Rare"]={Speed=18,Start_X=372.268},
["Epic"]={Speed=32,Start_X=132.268},
["Legendary"]={Speed=45,Start_X=-142.731},
["Mythic"]={Speed=55,Start_X=-462.731},
["Godly"]={Speed=68,Start_X=-809.732},
["Secret"]={Speed=80,Start_X=-1196.231},
["Rainbow"]={Speed=90,Start_X=-1631.231},
["Hacked"]={Speed=100,Start_X=-2111.231},
["Demon"]={Speed=110,Start_X=-2586.231},
["Celestial"]={Speed=125,Start_X=-3287.86},
}

local function detectWaveRarity()
local u=workspace:FindFirstChild("Waves")
if not u then return nil end
for v,w in ipairs(u:GetChildren())do
if t[w.Name]then return w.Name end
end
return nil
end

local function calcWaveTravelTime(u,v)
local w=t[u]
if not w then return nil end
return math.abs(w.Start_X-v)/w.Speed
end

while q.autoKick do
local u=c.Character
local v=u and u:FindFirstChild("HumanoidRootPart")
if not v then
r:SetText("⚠ No character found","warning")
task.wait(1)
continue
end

local w=workspace:FindFirstChild("Areas")
local x=w and w:FindFirstChild("KickReady")
if not x then
r:SetText("⚠ KickReady not found","warning")
task.wait(1)
continue
end

local y=x.Position.X
local z=x.Position
local A=Vector3.new(z.X+2000,z.Y,z.Z)


u:PivotTo(CFrame.new(z))
task.wait(0.4)


r:SetText("→ Firing kick remote","info")
fireRemote("rev_KickEvent",1)

local B=d:FindFirstChild("HUD")
local C=B and B:FindFirstChild("Run")

if not C then
r:SetText("⚠ HUD/Run GUI not found","warning")
else

local D=tick()+50
while not C.Visible and q.autoKick and tick()<D do
task.wait(0.1)
end
if tick()>=D then
r:SetText("⚠ Run GUI timeout","warning")
continue
end


task.wait(0.2)

local E=tick()
u=c.Character
v=u and u:FindFirstChild("HumanoidRootPart")

local F=c:GetAttribute("InGame")or""
local G,H=F:match("^(.+),(.+)$")
G=G or""
H=H or"None"
local I=H

local J=j[getRarity(G)]or 0
local K=(I and f[I])or 0

local L=j[q.kickMinRarity]or 0
local M=(q.kickMinMutation~="None"and f[q.kickMinMutation])or 0

local N=G..(I and(" ["..I.."]")or"")


if J<L or K<M then
r:SetText("✗ Skip: "..N.." — killing","text_dim")
local O=c.Character and c.Character:FindFirstChildOfClass("Humanoid")
if O then O.Health=0 end
while C.Visible and q.autoKick do task.wait(0.2)end
continue
end

r:SetText("✓ Keeping: "..N,"success")

if v then
u:PivotTo(CFrame.new(A))
r:SetText("→ Morphed — moved to safe spot","info")


local O=Instance.new("Part")
O.Size=Vector3.new(20,1,20)
O.Anchored=true
O.CanCollide=true
O.Transparency=0.5
O.Position=Vector3.new(A.X,A.Y-3,A.Z)
O.Parent=workspace


task.spawn(function()
while C.Visible and q.autoKick do
task.wait(0.1)
end
O:Destroy()
end)
end


local O=detectWaveRarity()
local P=10

if O then
P=calcWaveTravelTime(O,y)
r:SetText(
"→ Wave: "..O.." — travel time: "..string.format("%.1f",P).."s",
"info"
)
else
r:SetText("⚠ Wave rarity not detected — 10s fallback","warning")
end


local Q=tick()-E
local R=(P+1.5)-Q
if R>0 then
r:SetText(
"⏳ Waiting "..string.format("%.1f",R).."s for wave to pass...",
"info"
)
task.wait(R)
end


if C.Visible and q.autoKick then
fireRemote("rev_KickCollect")
r:SetText("⚡ Collect fired!","success")
end


while C.Visible and q.autoKick do
task.wait(0.1)
end
end

pcall(function()
workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
workspace.CurrentCamera.CameraSubject=c.Character:FindFirstChild("Humanoid")
end)

r:SetText("✓ Cycle done","text_dim")
end
r:SetText("● Idle","text_dim")
end)
end,
})




o:CreateSection("Auto Collect")
local s=makeStatus(o,"● Idle")

o:CreateToggle({
Name="Auto Collect Money",
Flag="auto_collect",
Callback=function(t)
q.autoCollect=t
if not t then
s:SetText("● Stopped","text_dim")
return
end
task.spawn(function()
while q.autoCollect do
local u=getMyPlot()
if not u then
s:SetText("⚠ Plot not found — retrying...","warning")
task.wait(2)
continue
end
local v=u:FindFirstChild("Buttons")
if not v then
s:SetText("⚠ Buttons container missing","warning")
task.wait(1)
continue
end
local w=0
for x,y in ipairs(v:GetChildren())do
local z=tonumber(y.Name:match("%d+"))
if z then
fireRemote("rev_B_Collect",z)
w+=1
task.wait(0.05)
end
end
s:SetText("✓ Collected "..w.." slot(s)","success")
task.wait(0.5)
end
s:SetText("● Idle","text_dim")
end)
end,
})

o:CreateSection("Auto Rebirth")

o:CreateToggle({
Name="Auto Rebirth",
Flag="auto_rebirth",
Callback=function(t)
q.autoRebirth=t
if not t then return end
task.spawn(function()
while q.autoRebirth do
fireRemote("rev_RebirthRequest")
task.wait(3)
end
end)
end,
})

o:CreateSection("Auto Train")
local t=makeStatus(o,"● Idle")

o:CreateSlider({
Name="Train Remote Delay",Min=0.05,Max=2,Default=0.5,Increment=0.05,
Flag="train_delay",
Callback=function(u)q.trainDelay=u end,
})

o:CreateToggle({
Name="Auto Train + Bonus Click",
Flag="auto_train",
Callback=function(u)
q.autoTrain=u
if not u then
if c.Character then
for v,w in ipairs(c.Character:GetChildren())do
if w:IsA("Tool")then w.Parent=c.Backpack end
end
end
t:SetText("● Stopped — tool unequipped","text_dim")
return
end
task.spawn(function()
local v={}
local w=getKickUpgrades()
if w then
suppressExistingBonus(v)
local x=0
for y in pairs(v)do x+=1 end
t:SetText("→ Masked "..x.." pre-existing btn(s)","info")
else
t:SetText("⚠ KickUpgrades GUI not found — proceeding","warning")
end
task.wait(0.3)
local x=getGymTool()
if x then
equipTool(x)
t:SetText("→ Gym tool equipped","info")
else
t:SetText("⚠ Gym tool not found in backpack","warning")
end
local y=c.Character and c.Character:FindFirstChild("HumanoidRootPart")
if y then y.Anchored=false end
local z=0
local A=0
while q.autoTrain do
local B=getGymTool()
if B and B.Parent~=c.Character then equipTool(B)end
fireRemote("rev_TaviMishkal")
A+=1
local C=scanAndClickNewBonus(v)
z+=C
if C>0 then
t:SetText(
"⚡ Cycle "..A.." — clicked "..C.." bonus [total: "..z.."]",
"success"
)
else
t:SetText("→ Cycle "..A.." — training","text_dim")
end
task.wait(q.trainDelay)
end
end)
end,
})




p:CreateSection("Auto Upgrade")
local u=makeStatus(p,"● Idle")

p:CreateSlider({
Name="Upgrade Delay",Min=0.05,Max=2,Default=0.1,Increment=0.05,
Flag="upgrade_delay",
Callback=function(v)q.upgradeDelay=v end,
})

local v={}
p:CreateMultiDropdown({
Name="Upgrade Rarity Whitelist",
Options=h,
CurrentValues=h,
Flag="upgrade_rarity_filter",
Callback=function(w)
v={}
for x,y in ipairs(w)do v[y]=true end
end,
})
for w,x in ipairs(h)do v[x]=true end

local w={}
p:CreateMultiDropdown({
Name="Upgrade Mutation Whitelist",
Options=i,
CurrentValues=i,
Flag="upgrade_mutation_filter",
Callback=function(x)
w={}
for y,z in ipairs(x)do w[z]=true end
end,
})
for x,y in ipairs(i)do w[y]=true end

p:CreateToggle({
Name="Auto Upgrade All Slots",
Flag="auto_upgrade",
Callback=function(x)
q.autoUpgrade=x
if not x then
u:SetText("● Stopped","text_dim")
return
end
task.spawn(function()
while q.autoUpgrade do
local y=getSlotsWithMutation()
if#y==0 then
u:SetText("⚠ No slots found — is plot loaded?","warning")
task.wait(2)
continue
end
local z=math.huge
for A,B in ipairs(y)do
if not B.empty and B.level<z then
z=B.level
end
end
local A=0
for B,C in ipairs(y)do
if not q.autoUpgrade then break end
if not C.empty and C.level==z and C.level<75 then
local D=getRarity(C.name)
local E=C.mutation or"None"
if v[D]and w[E]then
fireRemote("rev_B_Upgrade",C.index)
A+=1
task.wait(q.upgradeDelay)
end
end
end
u:SetText(
A>0
and("✓ Upgraded "..A.." slot(s)")
or"→ No slots match filters",
A>0 and"success"or"text_dim"
)
task.wait(0.3)
end
u:SetText("● Idle","text_dim")
end)
end,
})

p:CreateSection("Auto Replace (Best Rarity)")
local x=makeStatus(p,"● Idle")

local y={}
p:CreateMultiDropdown({
Name="Replace Rarity Whitelist",
Options=h,
CurrentValues=h,
Flag="replace_rarity_filter",
Callback=function(z)
y={}
for A,B in ipairs(z)do y[B]=true end
end,
})
for z,A in ipairs(h)do y[A]=true end

local z={}
p:CreateMultiDropdown({
Name="Replace Mutation Whitelist",
Options=i,
CurrentValues=i,
Flag="replace_mutation_filter",
Callback=function(A)
z={}
for B,C in ipairs(A)do z[C]=true end
end,
})
for A,B in ipairs(i)do z[B]=true end

p:CreateToggle({
Name="Auto Replace Weakest Slot",
Flag="auto_replace",
Callback=function(A)
q.autoReplace=A
if not A then
x:SetText("● Stopped","text_dim")
return
end
task.spawn(function()
while q.autoReplace do
local B={}
for C,D in ipairs(c.Backpack:GetChildren())do
if k[D.Name]then
local E=D:GetAttribute("Mutation")
if E==""then E=nil end
local F=E or"None"
local G=getRarity(D.Name)
if z[F]and y[G]then
table.insert(B,{
name=D.Name,
mutation=E,
score=getSlotScore(D.Name,E),
})
end
end
end

if#B==0 then
x:SetText("⚠ No matching tools in backpack","warning")
task.wait(2)
continue
end

table.sort(B,function(C,D)return C.score>D.score end)

local C=0
for D,E in ipairs(B)do
if not q.autoReplace then break end
local F=E.name..(E.mutation and(" ["..E.mutation.."]")or"")

local G=getEmptySlot()
if G then
placeIntoSlot(E.name,E.mutation,G)
C+=1
x:SetText("→ Placed "..F.." in empty slot","info")
task.wait(0.3)
else
local H=getWeakestSlotScored()
if not H then
x:SetText("⚠ No weakest slot found","warning")
break
end
if not y[getRarity(H.name)]then
x:SetText("→ Weakest rarity not in filter — skipping","text_dim")
break
end
if E.score>H.score then
local I=H.name..(H.mutation and(" ["..H.mutation.."]")or"")
m:Notify({Title="Replacing",Message=I.." → "..F,Type="success",Duration=3})
x:SetText("⬆ "..I.." → "..F,"success")
placeIntoSlot(E.name,E.mutation,H.index)
C+=1
task.wait(0.3)
break
else
x:SetText("→ "..E.name.." ("..E.score..") ≤ weakest ("..H.score..") — done","text_dim")
break
end
end
end

if C==0 then
x:SetText("→ Nothing to replace","text_dim")
end
task.wait(1)
end
x:SetText("● Idle","text_dim")
end)
end,
})

m:Notify({Title="LuckyBlock Farm",Message="Loaded — v7.0",Type="success"})