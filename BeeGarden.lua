



local a=loadstring(game:HttpGet("https://raw.githubusercontent.com/SupFr/Sup-Hub/refs/heads/main/SupUI_Library.lua"))()

local b=a:CreateWindow({
Name="Bee Garden Hub",
SubTitle="V3.5 - Config Sync",
Width=600,
Height=520,
AntiAFK=true,
ShowSettings=true,
AutoScale=true,
ToggleKey=Enum.KeyCode.RightControl,
AutoLoadConfig=true,
DefaultConfig="default",
})

b:SetWatermark({Text="Bee Garden Hub V3.5",ShowFPS=true,ShowPing=true})




local c=game:GetService("Players")
local d=game:GetService("ReplicatedStorage")
local e=game:GetService("TweenService")
local f=game:GetService("HttpService")
local g=c.LocalPlayer

local h=false
local i=false
local j=false
local k={}
local l=false
local m=false
local n=false
local o=false
local p=false
local q=false
local r=false
local s=false
local t=0
local u={}
local v={}
local w

local x=""
local y=false

local z=setmetatable({},{__mode="k"})
local A=5
local B=1.2
local C=0.5
local D=0.3

local E=(syn and syn.request)or(http and http.request)or http_request or(fluxus and fluxus.request)or request




local F=d:WaitForChild("Events")
local G=F:WaitForChild("Swatter")
local H=F:WaitForChild("EquipItem")
local I=F:WaitForChild("UnequipItem")




local J=d:WaitForChild("UserGenerated"):WaitForChild("Analytics"):WaitForChild("ClientKit")
local K=J:WaitForChild("Ping")
local L=J:WaitForChild("FocusState")
local M=J:WaitForChild("Accept")

task.spawn(function()
while task.wait(162)do
pcall(function()K:FireServer(19,tick())end)
end
end)

local N=getrawmetatable(game)
setreadonly(N,false)
local O=N.__namecall
N.__namecall=newcclosure(function(P,...)
local Q=getnamecallmethod()
local R={...}
if Q=="FireServer"then
if P==L then
R[1]=true
return O(P,table.unpack(R))
end
if P==M then
local S=R[1]
if type(S)=="table"and S.GuiService then
S.GuiService.MenuIsOpen=false
S.GuiService.IsModalDialog=false
end
return O(P,table.unpack(R))
end
end
return O(P,...)
end)
setreadonly(N,true)




local P="BeeHub"
local Q=P.."/activepairs.json"

local function savePairs()
if not writefile then return end
if not isfolder(P)then makefolder(P)end
pcall(function()writefile(Q,f:JSONEncode(u))end)
end

local function loadPairs()
if not readfile or not isfile(Q)then return end
local R,S=pcall(function()return f:JSONDecode(readfile(Q))end)
if not R or type(S)~="table"then return end
u={};v={}
for T,U in ipairs(S)do
table.insert(u,{Egg=U.Egg,Mod=U.Mod,Display=U.Display})
table.insert(v,U.Display)
end
end




local R={"None","Any"}
local S={}

local T=d:WaitForChild("Storage",5)
if T then
local U=T:WaitForChild("EggModifiers",5)
if U then
for V,W in pairs(U:GetChildren())do table.insert(S,W.Name)end
table.sort(S)
for V,W in ipairs(S)do table.insert(R,W)end
end
end




local U={
["[Any] Any Egg"]="any",
["[Common] Seedling Egg"]="seedling egg",
["[Uncommon] Leafy Egg"]="leafy egg",
["[Rare] Buzzing Egg"]="buzzing egg",
["[Rare] Icey Egg"]="icey egg",
["[Epic] Blaze Egg"]="blaze egg",
["[Epic] Crystal Egg"]="crystal egg",
["[Legendary] Toxic Egg"]="toxic egg",
["[Legendary] Prism Egg"]="prism egg",
["[Mythical] Void Egg"]="void egg",
["[Mythical] Radiant Egg"]="radiant egg",
["[Mythical] Permafrost Egg"]="permafrost egg",
["[Mythical] Solar Egg"]="solar egg",
["[Secret] Mystery Egg"]="mystery egg",
["[Divine] Fairy Egg"]="fairy egg",
["[Divine] Alien Egg"]="alien egg",
["[Event] Inspector Egg"]="inspector egg",
["[Event] Meteor Egg"]="meteor egg",
["[Event] Pumpkin Egg"]="pumpkin egg",
["[Event] Brainrot Egg"]="brainrot egg",
["[Event] Christmas Egg"]="christmas egg",
["[Event] Arcade Egg"]="arcade egg",
["[Event] Arcade Event Egg"]="arcade event egg",
["[Event] Easter Egg"]="easter egg",
["[Event] Spring Egg"]="spring egg",
["[Event] Spring Event Egg"]="spring event egg",
["[Event] Snowy Egg"]="snowy egg",
["[Premium] VIP Egg"]="vip egg",
["[Premium] Duality Egg"]="duality egg",
["[Premium] Duality Eclipse Egg"]="duality eclipse egg",
["[Premium] Spirit Egg"]="spirit egg",
["[Premium] Dino Egg"]="dino egg",
["[Premium] Playtime Eggift"]="playtime eggift",
}

local V={
["Any"]=0,["Common"]=1,["Uncommon"]=2,["Rare"]=3,["Epic"]=4,
["Legendary"]=5,["Mythical"]=6,["Divine"]=7,["Secret"]=8,
["Event"]=9,["Premium"]=10
}

local W={}
for X in pairs(U)do table.insert(W,X)end
table.sort(W,function(X,Y)
local Z=V[string.match(X,"%[(.-)%]")]or 99
local _=V[string.match(Y,"%[(.-)%]")]or 99
return Z==_ and X<Y or Z<_
end)




local function setStatus(X,Y)
if w then w:SetText("Status: "..X,Y)end
end

local function stripRichText(X)
if type(X)~="string"then return""end
return string.gsub(X,"<[^>]+>","")
end

local function parseMoney(X)
if type(X)~="string"then X=tostring(X)end
X=string.gsub(X,"[, ]","")
local Y,Z=string.match(string.upper(X),"^([%d%.]+)(%a*)$")
local _=tonumber(Y)
if not _ then return tonumber(X)or 0 end
local aa={
K=1e3,M=1e6,B=1e9,T=1e12,QA=1e15,QI=1e18,SX=1e21,SP=1e24,OC=1e27,NO=1e30,DC=1e33
}
if Z and Z~=""and aa[Z]then return _*aa[Z]end
return _
end

local function getMyCoins()
if g:FindFirstChild("leaderstats")then
local aa=g.leaderstats:FindFirstChild("Coins")
or g.leaderstats:FindFirstChild("Money")
or g.leaderstats:FindFirstChild("Cash")
if aa then return parseMoney(aa.Value)end
end
return 0
end

local function getMyPlotID()
local aa=workspace:FindFirstChild("Core")
and workspace.Core:FindFirstChild("Scriptable")
and workspace.Core.Scriptable:FindFirstChild("Plots")
if not aa then return nil end
for X,Y in pairs(aa:GetChildren())do
local Z=Y:FindFirstChild("Eggs")
if Z then
for _,ab in pairs(Z:GetChildren())do
if ab:GetAttribute("plotOwner")==g.Name then return Y.Name end
end
end
end
return nil
end

local function isSafeLocation(aa)
if not aa then return false end
return aa.Position.Y>=t
end

local function isHoneypot(aa)
return string.find(aa.Name,"Honeypot",1,true)~=nil
end

local function snapAndFire(aa,ab,X)
aa.CFrame=ab
aa.Anchored=true
aa.Anchored=false
task.wait(0.3)
X()
end

local function tweenTo(aa,ab,X)
local Y=e:Create(
aa,
TweenInfo.new(X or D,Enum.EasingStyle.Linear),
{CFrame=ab}
)
Y:Play()
Y.Completed:Wait()
end

local aa={"FastGhost","NormalGhost","SlowGhost"}
local function isGhost(ab)
for X,Y in ipairs(aa)do
if string.find(ab,Y,1,true)then return true end
end
return false
end

local function isPacmanSlappable(ab)
local X,Y=pcall(function()
return ab:FindFirstChild("Main")
and ab.Main:FindFirstChild("InfoAttachment")
and ab.Main.InfoAttachment:FindFirstChild("Info")
and ab.Main.InfoAttachment.Info:FindFirstChild("Main")
and ab.Main.InfoAttachment.Info.Main:FindFirstChild("TitleInfo")
and ab.Main.InfoAttachment.Info.Main.TitleInfo.Active
end)
return X and Y==true
end




local function sendWebhook(ab,X,Y)
if not y or x==""or not E then return end
local Z={
["username"]="Bee Garden Hub",
["avatar_url"]="https://tr.rbxcdn.com/1ce84050eb54de560835f6f3630f9a35/150/150/Image/Webp",
["embeds"]={{
["title"]="🎉 New Egg Sniped!",
["color"]=65280,
["fields"]={
{["name"]="Egg",["value"]=ab,["inline"]=true},
{["name"]="Modifier",["value"]=X,["inline"]=true},
{["name"]="Price",["value"]=tostring(Y).." Coins",["inline"]=false},
},
["footer"]={["text"]="Bee Garden Hub V3.5 • Player: "..g.Name}
}}
}
task.spawn(function()
pcall(function()
E({Url=x,Method="POST",Headers={["Content-Type"]="application/json"},Body=f:JSONEncode(Z)})
end)
end)
end






task.spawn(function()
while task.wait(0.2)do
if h and#u>0 then
local ab=getMyPlotID()
if not ab then
setStatus("Waiting for plot ID...","warning")
task.wait(2);continue
end
setStatus("Scanning...","success")
local X=workspace.Core.Scriptable.Plots[ab].Eggs
for Y,Z in pairs(X:GetChildren())do
local _=Z:FindFirstChild("AssetName",true)
local ac=_ and _:IsA("TextLabel")and string.lower(stripRichText(_.Text))or""
local ad={}
local ae=Z:FindFirstChild("PrimaryPart")
if ae then
for af,ag in ipairs(ae:GetChildren())do
if ag:IsA("Folder")then table.insert(ad,string.lower(ag.Name))end
end
end
local af=#ad>0 and table.concat(ad,", ")or"None"
if ac~=""then
local ag=false
for ah,ai in ipairs(u)do
local aj=(ai.Egg=="any")or string.find(ac,ai.Egg,1,true)
local ak=false
if ai.Mod=="any"then
ak=true
elseif ai.Mod=="none"and#ad==0 then
ak=true
elseif ai.Mod~="none"then
for al,am in ipairs(ad)do
if string.find(am,ai.Mod,1,true)then ak=true;break end
end
end
if aj and ak then ag=true;break end
end
if ag then
local ah=Z:GetAttribute("finalPrice")or 0
if getMyCoins()>=parseMoney(ah)then
pcall(function()d.Events.PurchaseConveyorEgg:FireServer(Z.Name,ab)end)
setStatus("Bought: "..ac,"success")
sendWebhook(ac,af,ah)
task.wait(0.3)
else
setStatus("Need coins for: "..ac,"danger")
end
end
end
end
elseif h and#u==0 then
setStatus("Whitelist empty! Add combos.","danger")
end
end
end)


task.spawn(function()
while task.wait(2)do
if i then
pcall(function()d.Events.ClaimCoins:FireServer("Collect_Coins")end)
end
end
end)


local ab={
["Common"]={1,2},["Uncommon"]={3,4},["Rare"]={5,6},
["Epic"]={7,8},["Legendary"]={9,10},["Mythical"]={11,12},["Secret"]={13}
}

task.spawn(function()
while task.wait(1)do
if j and#k>0 then
pcall(function()
local ac=g.PlayerGui:FindFirstChild("Main")
and g.PlayerGui.Main:FindFirstChild("Frames")
and g.PlayerGui.Main.Frames:FindFirstChild("BeeShop")
and g.PlayerGui.Main.Frames.BeeShop:FindFirstChild("List")
if not ac then return end
for ad,ae in ipairs(k)do
if not j then break end
local af=ab[ae]
if af then
for ag,ah in ipairs(af)do
local ai=ac:FindFirstChild("StockItem_"..ah)
if ai then
local aj=ai:FindFirstChild("MainFrame")and ai.MainFrame:FindFirstChild("Stock")
if aj and aj:IsA("TextLabel")then
local ak=tonumber(string.match(aj.Text,"%d+"))
if ak and ak>0 then
d:WaitForChild("Events"):WaitForChild("BeeShopHandler"):FireServer("Purchase",{slotIndex=ah,quantity=1})
task.wait(0.5)
end
end
end
end
end
end
end)
end
end
end)


task.spawn(function()
while task.wait(5)do
if l then
pcall(function()d.Events.BeeHandler:InvokeServer("EquipBest")end)
end
end
end)


task.spawn(function()
while task.wait(0.5)do
if m then
for ac,ad in ipairs(workspace:GetChildren())do
if not m then break end
if not ad:IsA("Model")then continue end
if not string.find(ad.Name,"MeteoronPickup",1,true)then continue end
if isHoneypot(ad)then continue end
if(z[ad]or 0)>=A then continue end
pcall(function()
local ae=g.Character and g.Character:FindFirstChild("HumanoidRootPart")
local af=ad:FindFirstChild("NoticePart")or ad:FindFirstChildWhichIsA("BasePart",true)
local ag=ad:FindFirstChildWhichIsA("ProximityPrompt",true)
if ae and af and ag and isSafeLocation(af)then
snapAndFire(ae,af.CFrame+Vector3.new(0,1,0),function()
fireproximityprompt(ag)
z[ad]=(z[ad]or 0)+1
end)
task.wait(C)
end
end)
end
end
end
end)


task.spawn(function()
while task.wait(0.5)do
if o then
for ac,ad in ipairs(workspace:GetChildren())do
if not o then break end
if not ad:IsA("Model")then continue end
if not string.find(ad.Name,"SnowflakePickup",1,true)then continue end
if isHoneypot(ad)then continue end
if(z[ad]or 0)>=A then continue end
pcall(function()
local ae=g.Character and g.Character:FindFirstChild("HumanoidRootPart")
local af=ad.PrimaryPart or ad:FindFirstChildWhichIsA("BasePart",true)
local ag=af and(af:FindFirstChild("PickUpPrompt")or ad:FindFirstChildWhichIsA("ProximityPrompt",true))
if ae and af and ag and isSafeLocation(af)then
snapAndFire(ae,af.CFrame+Vector3.new(0,1,0),function()
fireproximityprompt(ag)
z[ad]=(z[ad]or 0)+1
end)
task.wait(C)
end
end)
end
end
end
end)


task.spawn(function()
while task.wait(0.5)do
if n then
local ac={}
for ad,ae in ipairs(workspace:GetChildren())do
if ae:IsA("Model")and isGhost(ae.Name)and not isHoneypot(ae)then
table.insert(ac,ae)
end
end
if#ac==0 then continue end
pcall(function()H:InvokeServer("Swatter",0)end)
task.wait(0.3)
for ad,ae in ipairs(ac)do
if not n then break end
pcall(function()
local af=g.Character and g.Character:FindFirstChild("HumanoidRootPart")
local ag=ae.PrimaryPart or ae:FindFirstChildWhichIsA("BasePart",true)
if af and ag and isSafeLocation(ag)then
snapAndFire(af,ag.CFrame+Vector3.new(0,1,0),function()
G:FireServer()
end)
task.wait(C)
end
end)
end
pcall(function()I:FireServer()end)
end
end
end)


task.spawn(function()
while task.wait(1)do
if p then
pcall(function()
local ac=workspace.Core.Scriptable.TouchParts.ArcadeProximityPart.ArcadePrompt
if ac and ac:IsA("ProximityPrompt")then fireproximityprompt(ac)end
end)
end
end
end)


task.spawn(function()
while task.wait(0.3)do
if not r and not s and not q then continue end
local ac=workspace:FindFirstChild("Events")
if not ac then continue end

local ad={}
local ae={}
local af={}

if r then
local ag=ac:FindFirstChild("ArcadeTickets")
if ag then
for ah,ai in ipairs(ag:GetChildren())do
if ai:IsA("Model")and not isHoneypot(ai)
and(z[ai]or 0)<A then
table.insert(ad,ai)
end
end
end
end

if s then
local ag=ac:FindFirstChild("Pacmans")
if ag then
for ah,ai in ipairs(ag:GetChildren())do
if ai:IsA("Model")and not isHoneypot(ai)
and isPacmanSlappable(ai)then
table.insert(ae,ai)
end
end
end
end

if q then
local ag=ac:FindFirstChild("ArcadeSpheres")
if ag then
for ah,ai in ipairs(ag:GetChildren())do
if not isHoneypot(ai)then
table.insert(af,ai)
end
end
end
end


if#ad>0 then
local ag=ad[1]
pcall(function()
local ah=g.Character and g.Character:FindFirstChild("HumanoidRootPart")
local ai=ag.PrimaryPart or ag:FindFirstChildWhichIsA("BasePart",true)
local aj=ag:FindFirstChild("UI")
local ak=(aj and aj:FindFirstChild("PickUpPrompt"))
or ag:FindFirstChildWhichIsA("ProximityPrompt",true)
if ah and ai and ak and isSafeLocation(ai)then
snapAndFire(ah,ai.CFrame+Vector3.new(0,1,0),function()
fireproximityprompt(ak)
z[ag]=(z[ag]or 0)+1
end)
task.wait(C)
end
end)
continue
end


if#ae>0 then
local ag=ae[1]
pcall(function()H:InvokeServer("Swatter",0)end)
task.wait(0.3)
pcall(function()
local ah=g.Character and g.Character:FindFirstChild("HumanoidRootPart")
local ai=ag.PrimaryPart or ag:FindFirstChildWhichIsA("BasePart",true)
if ah and ai and isSafeLocation(ai)then
snapAndFire(ah,ai.CFrame+Vector3.new(0,1,0),function()
G:FireServer()
end)
task.wait(B)
end
end)
pcall(function()I:FireServer()end)
continue
end


if#af>0 then
local ag=af[1]
pcall(function()
local ah=g.Character and g.Character:FindFirstChild("HumanoidRootPart")
local ai=ag:IsA("BasePart")and ag or ag:FindFirstChildWhichIsA("BasePart")
if ah and ai and isSafeLocation(ai)then
tweenTo(ah,ai.CFrame+Vector3.new(0,1,0),D)
task.wait(0.1)
end
end)
end
end
end)




local ac=b:CreateTab("Main Farm","🐝")
local ad=b:CreateTab("Bees","🍯")
local ae=b:CreateTab("Events","⏰")
local af=b:CreateTab("Config","⚙️")




w=ac:CreateLabel("Status: Idle","warning")
ac:CreateSection("COMBO BUILDER")

local ag={}
local ah={}
local ai=nil

ac:CreateMultiDropdown({Name="1. Select Eggs",Options=W,CurrentValues={},Callback=function(aj)ag=aj end})
ac:CreateMultiDropdown({Name="2. Select Modifiers",Options=R,CurrentValues={},Callback=function(aj)ah=aj end})

local aj=ac:CreateList({
Name="Active Whitelist",Items=v,MaxVisible=8,
OnSelect=function(aj,ak)ai=ak end
})

ac:CreateButton("➕ Add Combinations",function()
if#ag==0 or#ah==0 then
b:Notify({Title="Error",Message="Select at least 1 Egg and 1 Modifier.",Duration=3,Type="error"});return
end
local ak=0
for al,am in ipairs(ag)do
for X,Y in ipairs(ah)do
local Z="["..Y.."] "..am
local _=false
for an,ao in ipairs(v)do if ao==Z then _=true;break end end
if not _ then
table.insert(u,{Egg=U[am],Mod=string.lower(Y),Display=Z})
table.insert(v,Z);ak=ak+1
end
end
end
if ak>0 then
aj:Refresh(v);savePairs()
b:Notify({Title="Success",Message="Added "..ak.." combination(s).",Duration=3,Type="success"})
end
end)

ac:CreateButton("➖ Remove Selected",function()
if not ai or not v[ai]then return end
b:Confirm({
Title="Remove Combo",Message="Remove \""..v[ai].."\"?",
ConfirmText="Remove",CancelText="Cancel",Destructive=true,
OnConfirm=function()
table.remove(u,ai);table.remove(v,ai)
ai=nil;aj:Refresh(v);savePairs()
end
})
end)

ac:CreateButton("🗑️ Clear Whitelist",function()
b:Confirm({
Title="Clear Whitelist",Message="Remove all active combinations?",
ConfirmText="Clear",CancelText="Cancel",Destructive=true,
OnConfirm=function()
u={};v={};ai=nil
aj:Refresh(v);savePairs()
b:Notify({Title="Cleared",Message="Whitelist cleared.",Duration=3,Type="info"})
end
})
end)

ac:CreateSpacer(10)
ac:CreateSection("AUTOMATIONS")

ac:CreateToggle({Name="Auto-Buy Whitelisted Combos",CurrentValue=false,Flag="auto_buy",
Callback=function(ak)h=ak;if not ak then setStatus("Idle","warning")end end})
ac:CreateToggle({Name="Auto Collect Money",CurrentValue=false,Flag="auto_collect",
Callback=function(ak)i=ak end})




ad:CreateSection("🛒 AUTO BUY BEES")
ad:CreateMultiDropdown({
Name="Select Rarities to Buy",
Options={"Common","Uncommon","Rare","Epic","Legendary","Mythical","Secret"},
CurrentValues={},Flag="bee_rarities",
Callback=function(ak)k=ak end
})
ad:CreateToggle({Name="Enable Auto Buy Bees",CurrentValue=false,Flag="auto_buy_bees",
Callback=function(ak)j=ak end})
ad:CreateSpacer(10)
ad:CreateSection("⚙️ GENERAL")
ad:CreateToggle({Name="Auto Equip Best Bees",CurrentValue=false,Flag="auto_equip_bees",
Callback=function(ak)l=ak end})




ae:CreateSection("☄️ METEOR EVENT")
ae:CreateToggle({Name="Auto Collect Meteors",CurrentValue=false,Flag="auto_meteors",
Callback=function(ak)m=ak end})

ae:CreateSpacer(5)
ae:CreateSection("👻 GHOST HUNTING")
ae:CreateToggle({Name="Auto Ghost Hunt",CurrentValue=false,Flag="auto_ghost",
Callback=function(ak)n=ak end})

ae:CreateSpacer(5)
ae:CreateSection("❄️ BLIZZARD")
ae:CreateToggle({Name="Auto Blizzard Event",CurrentValue=false,Flag="auto_blizzard",
Callback=function(ak)o=ak end})

ae:CreateSpacer(5)
ae:CreateSection("🕹️ ARCADE EVENT")
ae:CreateToggle({Name="Auto Arcade Mini Game",CurrentValue=false,Flag="arcade_mini",Callback=function(ak)p=ak end})
ae:CreateToggle({Name="Auto Collect Arcade Tickets",CurrentValue=false,Flag="arcade_tickets",Callback=function(ak)r=ak end})
ae:CreateToggle({Name="Auto Slap Pacmans",CurrentValue=false,Flag="slap_pacmans",Callback=function(ak)s=ak end})
ae:CreateToggle({Name="Auto Collect Arcade Spheres",CurrentValue=false,Flag="arcade_spheres",Callback=function(ak)q=ak end})
ae:CreateLabel("Priority: Tickets → Pacmans → Spheres","text_muted")
ae:CreateSpacer(5)
ae:CreateLabel("More events added as they go live.","text_muted")




af:CreateSection("🛡️ ANTI-BAN")
af:CreateTextBox({
Name="Safe Y Level",Placeholder="0",CurrentValue="0",Flag="safe_y",
Callback=function(ak)
local al=tonumber(ak)
if al then t=al;b:Notify({Title="Updated",Message="Safe Y Level: "..al,Duration=3,Type="info"})end
end
})
af:CreateLabel("Ignores pickups below this Y coordinate (honeypot protection).","text_muted")

af:CreateSpacer(10)
af:CreateSection("DISCORD INTEGRATION")

if not E then
af:CreateLabel("⚠️ Executor does not support HTTP. Webhooks disabled.","danger")
else
af:CreateTextBox({Name="Webhook URL",Placeholder="https://discord.com/api/webhooks/...",CurrentValue="",Flag="webhook_url",
Callback=function(ak)x=ak end})
af:CreateToggle({Name="Enable Purchase Webhooks",CurrentValue=false,Flag="webhook_enabled",
Callback=function(ak)y=ak end})
af:CreateButton("🧪 Test Webhook",function()
if x==""then b:Notify({Title="Error",Message="Enter a Webhook URL first.",Duration=3,Type="error"});return end
local ak=y;y=true;sendWebhook("Test Egg","Test Modifier","0");y=ak
b:Notify({Title="Sent",Message="Test webhook dispatched!",Duration=3,Type="info"})
end)
end

af:CreateSpacer(10)
af:CreateSection("WHITELIST CONFIGS")
af:CreateLabel("Whitelist → workspace/BeeHub/activepairs.json","text_dim")
af:CreateLabel("Toggle/settings → Settings tab (bottom sidebar)","text_muted")

af:CreateButton("💾 Save Whitelist",function()
savePairs()
b:Notify({Title="Saved ✅",Message="Active pairs saved to disk.",Duration=3,Type="success"})
end)

af:CreateButton("📂 Reload Whitelist",function()
loadPairs();aj:Refresh(v)
b:Notify({Title="Loaded ✅",Message="Whitelist reloaded from disk.",Duration=3,Type="success"})
end)




task.defer(function()
loadPairs()
if aj then aj:Refresh(v)end
if#u>0 then
b:Notify({Title="Auto-Loaded ✅",Message=#u.." combo(s) restored.",Duration=4,Type="info"})
end
end)