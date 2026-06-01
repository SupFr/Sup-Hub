local a=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local b=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local c=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

if getgenv().AWIIIDestroy then getgenv().AWIIIDestroy()end


getgenv().AutoFarm=false
getgenv().AutoRaid=false
getgenv().AutoQuest=false
getgenv().AutoStory=false
getgenv().RaidPriority=false
getgenv().FarmTargets={}
getgenv().QuestFarmTargets={}
getgenv().QuestWorld=nil
getgenv().EnabledRaids={}
getgenv().CurrentRaid=nil

local d=game:GetService("Players")
local e=game:GetService("VirtualUser")
local f=d.LocalPlayer
local g=f:WaitForChild("PlayerGui")
local h=game:GetService("ReplicatedStorage")


local i={}
local j={}

local k,l=pcall(function()
return require(h.src.common.content.world.worlds)
end)
if k and l and l.worldsContent then
local m={}
for n,o in pairs(l.worldsContent)do table.insert(m,o)end
table.sort(m,function(n,o)return(n.order or 0)<(o.order or 0)end)
for n,o in ipairs(m)do
local p=o.displayName or o.id
local q=o.enemies
if not q then continue end
for r,s in ipairs(q.normal or{})do i[s]=p table.insert(j,s)end
for r,s in ipairs(q.miniBoss or{})do i[s]=p table.insert(j,s)end
for r,s in ipairs(q.boss or{})do i[s]=p table.insert(j,s)end
end
end


local m={}
local n={}
local o={}

local p,q=pcall(function()
return require(h.src.common.content.gamemodes.raids)
end)
if p and q and q.raidsContent then
local r={}
for s,t in pairs(q.raidsContent)do
table.insert(r,{name=s,index=t.index or 999,key=t.key})
end
table.sort(r,function(s,t)return s.index<t.index end)
for s,t in ipairs(r)do
table.insert(n,t.name)
if t.key then m[t.name]=t.key end
end
end

local r,s=pcall(function()
return require(h.src.common.content.humans.enemies)
end)
if r and s and s.enemiesContent then
local t={}
for u,v in pairs(m)do t[v]=u end
for u,v in pairs(s.enemiesContent)do
if not v.world or not v.world.dropsPool then continue end
for w,x in ipairs(v.world.dropsPool)do
if x.reward and x.reward.type=="item"then
local y=t[x.reward.id]
if y then
if not o[y]then o[y]={}end
table.insert(o[y],{name=u,chance=x.chance})
end
end
end
end
for u,v in pairs(o)do
table.sort(v,function(w,x)return w.chance>x.chance end)
end
end


local t
pcall(function()t=require(h.src.common.store.players.datastore)end)

local function getMyData()
if not t then return nil end
return t.getPlayerData(tostring(f.UserId))
end


local u
pcall(function()u=require(h.src.common.store.gamemodes.raids)end)


local v
pcall(function()v=require(h.src.common.content.world.quests).questsContent end)


local w={"PlanetNemak","FutureCity","SandVillage","SkyIslandQuest"}

local function isRaidInProgress()
if not u then return true end
local x=u.getRaidByPlayer(tostring(f.UserId))
return x~=nil and x.state=="in-progress"
end

local function hasRaidKey(x)
local y=m[x]
if not y then return false end
local z=getMyData()
if not z then return true end
local A=z.items and z.items[y]
return A~=nil and(A.amount or 0)>0
end


local x={}

local function refreshCooldownCache()
local y=getMyData()
if not y then return end
local z=y.stats and y.stats.raidCooldowns or{}
for A,B in ipairs(n)do
local C=z[B]or 0
if C>os.time()then
x[B]=C
else
x[B]=nil
end
end
end

local function getRaidCooldownLeft(y)
local z=x[y]
if not z then return 0 end
local A=z-os.time()
if A<=0 then x[y]=nil return 0 end
return A
end

local function setRaidCooldown(y,z)
x[y]=os.time()+z
end


local y=a:CreateWindow({
Title="Anime Warriors III",
SubTitle="v10.1",
TabWidth=160,
Size=UDim2.fromOffset(580,460),
Acrylic=false,
Theme="Dark",
MinimizeKey=Enum.KeyCode.RightControl,
})

local z={
Main=y:AddTab({Title="Main",Icon="sword"}),
Quest=y:AddTab({Title="Quest",Icon="scroll-text"}),
Raid=y:AddTab({Title="Raid",Icon="shield"}),
Eggs=y:AddTab({Title="Eggs",Icon="egg"}),
Teleport=y:AddTab({Title="Teleports",Icon="map"}),
Settings=y:AddTab({Title="Settings",Icon="settings"}),
}

local A,B,C,D,E
local F,G,H,I,J
local K,L
local M,N,O,P
local Q,R

local function getHRP()
local S=f.Character
return S and S:FindFirstChild("HumanoidRootPart")
end


local function getNearestTarget(S)
local T=getHRP()
if not T or not M then return nil end
local U={}
for V,W in pairs(g:GetChildren())do
local X=W.Name:match("^enemy%-overhead%-(.+)$")
if not X or not W.Enabled then continue end
local Y=W:FindFirstChild("Frame")
local Z=Y and Y:FindFirstChild("TextLabel")
if Z and S[Z.Text]then U[X]=true end
end
local V,W=nil,math.huge
for X,Y in pairs(M:GetChildren())do
if not Y:IsA("BasePart")then continue end
local Z=Y.Name:match("^enemy@(.+)$")
if not Z or not U[Z]then continue end
local _=(T.Position-Y.Position).Magnitude
if _<W then V=Y W=_ end
end
return V
end


local function getRaidMobHitbox(S)
local T=getHRP()
if not T or not M or not N then return nil end
local U,V=nil,math.huge
for W,X in pairs(M:GetChildren())do
if not X:IsA("BasePart")then continue end
if S and S[X.Name]then continue end
local Y=X.Name:match("^enemy@(.+)$")
if not Y then continue end
local Z=g:FindFirstChild("enemy-overhead-"..Y)
if not Z or not Z.Enabled then continue end
local _=N:FindFirstChild(Y)
if not _ or not _:FindFirstChildOfClass("Humanoid")then continue end
local aa=(T.Position-X.Position).Magnitude
if aa<V then U=X V=aa end
end
return U
end

local function getRaidBossHitbox(aa)
local S=getHRP()
if not S or not M or not N then return nil end
local T,U=nil,math.huge
for V,W in pairs(M:GetChildren())do
if not W:IsA("BasePart")then continue end
if aa and aa[W.Name]then continue end
local X=W.Name:match("^enemy@(.+)$")
if not X then continue end
local Y=N:FindFirstChild(X)
if not Y then continue end
if Y:FindFirstChildOfClass("Humanoid")then continue end
if not Y:FindFirstChild("Root")then continue end
local Z=(S.Position-W.Position).Magnitude
if Z<U then T=W U=Z end
end
return T
end

local function waitForGround(aa)
local S=f.Character
local T=S and S:FindFirstChildOfClass("Humanoid")
if not T then task.wait(0.8)return end
local U=tick()+(aa or 1.5)
while tick()<U do
if T.FloorMaterial~=Enum.Material.Air then return end
task.wait(0.05)
end
end



local function sweepIsland(aa,S,T)
if not S then return end
local U=S.Position
local V=6
local W=12
local X=250
local Y=25


local Z=getHRP()
if not Z then return end
Z.CFrame=CFrame.new(U.X,U.Y,U.Z)
task.wait(4)
local _=getHRP()and getHRP().Position.Y or U.Y

local ab=Instance.new("Part")
ab.Size=Vector3.new(8,1,8)
ab.Anchored=true
ab.CanCollide=true
ab.Transparency=1
ab.CastShadow=false
ab.Parent=workspace

local ac=false
for ad=0,V-1 do
if ac then break end
if not T and getgenv().RaidPriority then break end
if not getgenv().AutoFarm and not getgenv().AutoQuest and not getgenv().AutoStory then break end
local ae=_+ad*Y
for af=0,W-1 do
if not T and getgenv().RaidPriority then ac=true break end
if not getgenv().AutoFarm and not getgenv().AutoQuest and not getgenv().AutoStory then ac=true break end
local ag=getHRP()
if not ag then ac=true break end
local ah=(af/W)*math.pi*2
local ai=U.X+X*math.cos(ah)
local aj=U.Z+X*math.sin(ah)
ab.CFrame=CFrame.new(ai,ae-3,aj)
ag.CFrame=CFrame.new(ai,ae,aj)
task.wait(0.3)
if aa and aa()then ac=true break end
end
end

ab:Destroy()
end

local function bobHitboxes(aa,ab,ac,ad)
if not M then return end
for ae,af in pairs(M:GetChildren())do
if not af:IsA("BasePart")or not af.Name:match("^enemy@")then continue end
if ab and(af.Position-ab).Magnitude>(ac or 500)then continue end
if not ad and getgenv().RaidPriority then return end
local ag=getHRP()
if not ag then return end
ag.CFrame=CFrame.new(af.Position)
for ah=1,5 do
task.wait(0.1)
if getgenv().RaidPriority then return end
end
if aa and aa()then return end
end
end

local function applyAutomations()
if not B then return end
B:FireServer("clicker",getgenv().AutoClicker~=false)
B:FireServer("attack",getgenv().AutoAttack~=false)
if C then C:FireServer(getgenv().AutoWeaponUlt~=false)end
if D then D:FireServer(getgenv().AutoWarriorUlt~=false)end
end


task.spawn(function()
local aa=h:WaitForChild("rbxts_include"):WaitForChild("node_modules")
:WaitForChild("@rbxts"):WaitForChild("remo"):WaitForChild("src"):WaitForChild("container")

A=aa:WaitForChild("settings.set")
B=aa:WaitForChild("automation.setState")
C=aa:WaitForChild("automation.setWeaponAbility")
D=aa:WaitForChild("automation.setWarriorAbilities")
E=aa:WaitForChild("toolbar.equip")
F=aa:WaitForChild("bossRaids.create")
G=aa:WaitForChild("lobbies.start")
H=aa:WaitForChild("quests.takeQuest")
I=aa:WaitForChild("quests.claimPart")
J=aa:WaitForChild("quests.favoriteQuest")
K=aa:WaitForChild("eggs.open")
L=aa:WaitForChild("eggs.setAuto")
refreshCooldownCache()

local ab=workspace:WaitForChild("World")
M=ab:WaitForChild("Hitboxes")
N=ab:WaitForChild("Enemies")
O=ab:WaitForChild("Teleports"):WaitForChild("Centers")
P=ab:WaitForChild("Teleports"):WaitForChild("Locations")

A:FireServer("enemy_render_distance","500 Studs")
f.CharacterAdded:Connect(function()
A:FireServer("enemy_render_distance","500 Studs")
applyAutomations()
end)
applyAutomations()


local ac=z.Teleport
local function mkTpBtn(ad,ae)
ad:AddButton({Title=ae.Name,Callback=function()
local af=getHRP()
if af then af.CFrame=ae.CFrame+Vector3.new(0,5,0)end
end})
end

ac:AddSection("Worlds")
for ad,ae in pairs(O:GetChildren())do
if ae:IsA("BasePart")then mkTpBtn(ac,ae)end
end

ac:AddSection("Eggs")
local ad=h:FindFirstChild("Assets")and h.Assets:FindFirstChild("Eggs")
if ad then
for ae,af in pairs(ad:GetChildren())do
local ag=af:IsA("BasePart")and af
or af.PrimaryPart
or af:FindFirstChildWhichIsA("BasePart",true)
if ag then
ac:AddButton({Title=af.Name,Callback=function()
local ah=getHRP()
if ah then ah.CFrame=ag.CFrame+Vector3.new(0,5,0)end
end})
end
end
end

ac:AddSection("Incubators")
for ae,af in pairs(P:GetChildren())do
if af:IsA("BasePart")and af.Name:lower():find("incubator")then
mkTpBtn(ac,af)
end
end

ac:AddSection("Locations")
for ae,af in pairs(P:GetChildren())do
if af:IsA("BasePart")and not af.Name:lower():find("incubator")and not af.Name:find("-")then
mkTpBtn(ac,af)
end
end


local ae=z.Eggs
local af=h:FindFirstChild("Assets")and h.Assets:FindFirstChild("Eggs")
local ag={}
if af then
for ah,ai in pairs(af:GetChildren())do table.insert(ag,ai.Name)end
table.sort(ag)
end

if#ag>0 then
getgenv().SelectedEgg=ag[1]

ae:AddDropdown("EggSelect",{
Title="Select Egg",
Values=ag,
Default=ag[1],
Callback=function(ah)
local ai=getgenv().SelectedEgg
getgenv().SelectedEgg=ah
end,
})

ae:AddSection("Actions")

local function tpToEgg(ah)
local ai=getHRP()
if not ai then return end
local aj=af:FindFirstChild(ah)
local S=aj and(aj:IsA("BasePart")and aj
or aj.PrimaryPart
or aj:FindFirstChildWhichIsA("BasePart",true))
if S then ai.CFrame=S.CFrame+Vector3.new(0,5,0)end
end

ae:AddButton({
Title="Teleport",
Callback=function()
local ah=getgenv().SelectedEgg or""
if ah~=""then tpToEgg(ah)end
end,
})

ae:AddButton({
Title="Open Once",
Callback=function()
local ah=getgenv().SelectedEgg or""
if ah==""then return end
pcall(function()K:InvokeServer(ah)end)
end,
})

ae:AddToggle("AutoEgg",{
Title="Auto Open",
Default=false,
Callback=function(ah)
getgenv().AutoEgg=ah
local ai=getgenv().SelectedEgg or""
if ai==""then return end
if ah then
tpToEgg(ai)
task.wait(1)
pcall(function()L:FireServer(ai,true)end)
else
pcall(function()L:FireServer(ai,false)end)
end
end,
})
else
ae:AddParagraph({Title="Note",Content="No eggs found in RS.Assets.Eggs."})
end
end)


local function getFarmTargets()
local aa=getgenv().AutoQuest or getgenv().AutoStory
if aa then
local ab=getgenv().QuestFarmTargets or{}
if next(ab)~=nil then return ab,true end
return{},true
end
if getgenv().AutoFarm then return getgenv().FarmTargets or{},false end
return{},false
end

task.spawn(function()
while task.wait(0.1)do
if getgenv().RaidPriority then continue end
if not O then continue end

local aa=getgenv().AutoQuest or getgenv().AutoStory
if not getgenv().AutoFarm and not aa then continue end

local ab,ac=getFarmTargets()
if next(ab)==nil then
if R then R:SetDesc("Idle")end
continue
end


local ad={}
local ae={}
for af in pairs(ab)do
local ag=i[af]
if ag and not ae[ag]then
ae[ag]=true
local ah=O:FindFirstChild(ag)
if ah then ad[#ad+1]=ah end
end
end

if#ad==0 and ac and getgenv().QuestWorld then
local af=O:FindFirstChild(getgenv().QuestWorld)
if af then ad[#ad+1]=af end
end
if#ad==0 then continue end


if R then
local af={}
for ag in pairs(ab)do table.insert(af,ag)end
R:SetDesc(table.concat(af,", "))
end

local af=getHRP()
if not af then continue end
if E then E:FireServer("weapon")end
af.CFrame=CFrame.new(ad[1].Position+Vector3.new(0,5,0))
task.wait(1)

local function shouldContinue()
if getgenv().RaidPriority then return false end
local ag=getgenv().AutoQuest or getgenv().AutoStory
if ag~=ac then return false end
if ac then return ag end
return getgenv().AutoFarm
end

while shouldContinue()do
task.wait(0.3)
if not shouldContinue()then break end

local ag=getFarmTargets()
if next(ag)==nil then break end

local ah=getNearestTarget(ag)

if not ah then
for ai,aj in ipairs(ad)do
if not shouldContinue()then break end
sweepIsland(function()
return getNearestTarget(getFarmTargets())~=nil
end,aj,ac)
end
continue
end

af=getHRP()
if not af then break end
if E then E:FireServer("weapon")end
af.CFrame=CFrame.new(ah.Position)
waitForGround(1.5)

local ai=ah.Name:match("^enemy@(.+)$")
while shouldContinue()do
local aj=ai and g:FindFirstChild("enemy-overhead-"..ai)
if not aj or not aj.Enabled or not ah.Parent then break end
task.wait(0.2)
end
end
end
end)

local function isRaidEnabled(aa)
return getgenv().AutoRaid and(getgenv().EnabledRaids or{})[aa]
end

local function runRaid(aa)
if not hasRaidKey(aa)then

local ab=o[aa]or{}
local ac=(getgenv().RaidKeyEnemy or{})[aa]or{}
local ad={}
if type(ac)=="table"and next(ac)~=nil then
for ae in pairs(ac)do table.insert(ad,{name=ae})end
elseif type(ac)=="string"and ac~=""then
ad={{name=ac}}
else
ad=ab
end
if#ad==0 then return end

while isRaidEnabled(aa)and not hasRaidKey(aa)do
for ae,af in ipairs(ad)do
if not isRaidEnabled(aa)or hasRaidKey(aa)then break end
local ag=af.name
local ah={[ag]=true}
local ai=i[ag]
local aj=ai and O and O:FindFirstChild(ai)
local S=getHRP()
if not S then break end
if E then E:FireServer("weapon")end
if B then
B:FireServer("clicker",true)
B:FireServer("attack",true)
end
if aj then
S.CFrame=CFrame.new(aj.Position+Vector3.new(0,5,0))
task.wait(1)
end

local T=tick()+10
local U=nil
while tick()<T and isRaidEnabled(aa)and not hasRaidKey(aa)do
task.wait(0.3)
U=getNearestTarget(ah)
if U then break end
bobHitboxes(function()return getNearestTarget(ah)~=nil or hasRaidKey(aa)end,aj and aj.Position,aj and 500,true)
end
if not U then continue end
S=getHRP()
if not S then break end
if E then E:FireServer("weapon")end
S.CFrame=CFrame.new(U.Position)
waitForGround(1.5)
local V=U.Name:match("^enemy@(.+)$")
while isRaidEnabled(aa)and not hasRaidKey(aa)do
local W=V and g:FindFirstChild("enemy-overhead-"..V)
if not W or not W.Enabled or not U.Parent then break end
task.wait(0.2)
end

end
end
end

if not isRaidEnabled(aa)then return end


local ab={}
if M then
for ac,ad in pairs(M:GetChildren())do ab[ad.Name]=true end
end

pcall(function()F:InvokeServer(aa,{friendsOnly=false,spawnNormal=false})end)
task.wait(4)
pcall(function()G:FireServer()end)
if B then
B:FireServer("clicker",true)
B:FireServer("attack",true)
end

local ac=tick()+600
while isRaidEnabled(aa)and isRaidInProgress()and tick()<ac do
task.wait(0.3)
if not isRaidInProgress()then break end
local ad=getRaidMobHitbox(ab)or getRaidBossHitbox(ab)
if not ad then continue end
local ae=ad.Name:match("^enemy@(.+)$")
local af=getHRP()
if not af then break end
if E then E:FireServer("weapon")end
af.CFrame=CFrame.new(ad.Position)
waitForGround(1.5)
while isRaidEnabled(aa)and isRaidInProgress()do
local ag=ae and g:FindFirstChild("enemy-overhead-"..ae)
if not ag or not ag.Enabled or not ad.Parent then break end
task.wait(0.2)
end
task.wait(0.5)
end

setRaidCooldown(aa,1200)
end


task.spawn(function()
while task.wait(1)do
if not getgenv().AutoRaid then continue end
if not F or not G or not O then continue end

refreshCooldownCache()
local aa=getgenv().EnabledRaids or{}
local ab={}
for ac,ad in ipairs(n)do
if aa[ad]and getRaidCooldownLeft(ad)==0 then
table.insert(ab,ad)
end
end

table.sort(ab,function(ac,ad)
local ae,af=hasRaidKey(ac),hasRaidKey(ad)
if ae~=af then return ae end
return false
end)

if#ab==0 then
getgenv().RaidPriority=false
task.wait(5)
continue
end

getgenv().RaidPriority=true
for ac,ad in ipairs(ab)do
if not getgenv().AutoRaid then break end
getgenv().CurrentRaid=ad
runRaid(ad)
end
getgenv().CurrentRaid=nil
getgenv().RaidPriority=false
applyAutomations()
task.wait(5)
end
end)


local function getCurrentQuestData()
local aa=getMyData()
if not aa or not aa.quests then return nil end

for ab,ac in pairs(aa.quests)do
if ac.favorited and not ac.untracked then return ac end
end

local ab={}
for ac,ad in pairs(aa.quests)do table.insert(ab,ad)end
table.sort(ab,function(ac,ad)return(ac.lastChanged or 0)>(ad.lastChanged or 0)end)
for ac,ad in ipairs(ab)do
if not ad.untracked and v then
local ae=v[ad.id]
if ae then
local af=0
for ag in pairs(ae.parts or{})do af+=1 end
if(ad.currentPart or 1)<=af then return ad end
end
end
end
return nil
end

local function getQuestPartEnemies(aa)
if not v then return{}end
local ab=v[aa.id]
if not ab then return{}end
local ac=aa.currentPart or 1
local ad=ab.parts and ab.parts[ac]
if not ad then return{}end
local ae=aa.parts and aa.parts[tostring(ac)]
local af={}
for ag,ah in pairs(ad.tasks or{})do
if ah.tracker=="enemy-kills"and ah.enemy then
local ai=ae and ae.tasks and ae.tasks[tostring(ag)]
local aj=ai and ai.amount or 0
if aj<(ah.required or 0)then
af[ah.enemy]=true
end
end
end
return af
end

local function isQuestPartComplete(aa)
if not v then return false end
local ab=v[aa.id]
if not ab then return false end
local ac=aa.currentPart or 1
local ad=ab.parts and ab.parts[ac]
if not ad then return true end
local ae=aa.parts and aa.parts[tostring(ac)]
if ae and ae.claimed then return true end
for af,ag in pairs(ad.tasks or{})do
if ag.tracker=="enemy-kills"then
local ah=ae and ae.tasks and ae.tasks[tostring(af)]
local ai=ah and ah.amount or 0
if ai<(ag.required or 0)then return false end
end
end
return true
end



local function findQuestNPC(aa)
local ab=workspace:FindFirstChild("World")
if not ab then return nil end
local ac=aa:find("Quest$")and aa or(aa.."Quest")
local ad=ab:FindFirstChild(ac,true)or ab:FindFirstChild(aa,true)
return ad
end

local function claimQuestPart(aa)
local ab=findQuestNPC(aa)
if ab then
local ac=getHRP()
local ad=ab.PrimaryPart or ab:FindFirstChild("HumanoidRootPart",true)
if ac and ad then
ac.CFrame=ad.CFrame+Vector3.new(0,5,0)
task.wait(1)
end
local ae=ab:FindFirstChildWhichIsA("ProximityPrompt",true)
if ae then
fireproximityprompt(ae)
task.wait(0.5)
end
end
pcall(function()I:InvokeServer(aa)end)
end

local function getStoryQuestData()
if not v then return nil end
local aa=getMyData()
local ab=aa and aa.quests or{}
for ac,ad in ipairs(w)do
local ae=v[ad]
if not ae then continue end
local af=0
for ag in pairs(ae.parts or{})do af+=1 end
local ag=ab[ad]
if not ag then return{id=ad}end
if(ag.currentPart or 1)<=af then return ag end

end
return nil
end


task.spawn(function()
while task.wait(1)do
local aa=getgenv().AutoStory
local ab=getgenv().AutoQuest
if not aa and not ab then
getgenv().QuestFarmTargets={}
continue
end
if not H or not I then continue end

local ac=(aa and getStoryQuestData())or(ab and getCurrentQuestData())
if not ac then
getgenv().QuestFarmTargets={}
local ad=aa and"All story quests complete!"or"No active quest"
if Q then Q:SetDesc(ad)end
continue
end

local ad=v and v[ac.id]
if not ad then continue end


if not ac.favorited and J then
J:FireServer(ac.id)
end

local ae=0
for af in pairs(ad.parts or{})do ae+=1 end


if not ac.currentPart then
local af=findQuestNPC(ac.id)
if af then
local ag=getHRP()
local ah=af.PrimaryPart or af:FindFirstChild("HumanoidRootPart",true)
if ag and ah then
ag.CFrame=ah.CFrame+Vector3.new(0,5,0)
task.wait(1)
end
local ai=af:FindFirstChildWhichIsA("ProximityPrompt",true)
if ai then
fireproximityprompt(ai)
task.wait(1)
end
end
pcall(function()H:InvokeServer(ac.id)end)
task.wait(1)
continue
end

if ac.currentPart>ae then
getgenv().QuestFarmTargets={}
local af=ad.title or ac.id
if Q then Q:SetDesc(af..": Complete!")end
if not aa then continue end
task.wait(1)
continue
end


local af=getQuestPartEnemies(ac)
getgenv().QuestFarmTargets=next(af)~=nil and af or{}
getgenv().QuestWorld=ad.location


local ag=ad.title or ac.id
local ah=ad.parts[ac.currentPart]
local ai={string.format("%s  (Part %d/%d)",ag,ac.currentPart,ae)}
for aj,S in pairs(ah.tasks or{})do
if S.tracker=="enemy-kills"then
local T=ac.parts and ac.parts[tostring(ac.currentPart)]
local U=T and T.tasks and T.tasks[tostring(aj)]
local V=U and U.amount or 0
table.insert(ai,string.format("%s: %d/%d",S.enemy,V,S.required or 0))
end
end
if Q then Q:SetDesc(table.concat(ai,"\n"))end


if isQuestPartComplete(ac)then
claimQuestPart(ac.id)
task.wait(2)
end
end
end)


getgenv().AntiAFK=true
f.Idled:Connect(function()
if getgenv().AntiAFK then
e:CaptureController()
e:ClickButton2(Vector2.new())
end
end)


local aa=z.Main
aa:AddSection("Status")
R=aa:AddParagraph({Title="Farming",Content="Idle"})

aa:AddSection("Farming")
aa:AddToggle("AutoFarm",{
Title="Auto Farm",
Default=false,
Callback=function(ab)getgenv().AutoFarm=ab end,
})

aa:AddDropdown("FarmTargets",{
Title="Target Enemies",
Values=j,
Multi=true,
Default={},
Callback=function(ab)getgenv().FarmTargets=ab end,
})

aa:AddSection("Automation")
aa:AddToggle("AutoClicker",{
Title="Auto Clicker",
Default=true,
Callback=function(ab)
getgenv().AutoClicker=ab
if B then B:FireServer("clicker",ab)end
end,
})
aa:AddToggle("AutoAttack",{
Title="Auto Attack",
Default=true,
Callback=function(ab)
getgenv().AutoAttack=ab
if B then B:FireServer("attack",ab)end
end,
})
aa:AddToggle("AutoWeaponUlt",{
Title="Auto Weapon Ultimate",
Default=true,
Callback=function(ab)
getgenv().AutoWeaponUlt=ab
if C then C:FireServer(ab)end
end,
})
aa:AddToggle("AutoWarriorUlt",{
Title="Auto Warrior Ultimate",
Default=true,
Callback=function(ab)
getgenv().AutoWarriorUlt=ab
if D then D:FireServer(ab)end
end,
})


local ab=z.Quest
ab:AddSection("Status")
Q=ab:AddParagraph({Title="Active Quest",Content="Idle"})

ab:AddSection("Favorited Quest")
ab:AddToggle("AutoQuest",{
Title="Auto Quest",
Default=false,
Callback=function(ac)
getgenv().AutoQuest=ac
if not ac and not getgenv().AutoStory then
getgenv().QuestFarmTargets={}
Q:SetDesc("Idle")
end
end,
})

ab:AddSection("World Story Chain")
ab:AddParagraph({Title="Info",Content="Automatically chains through all world story quests\nin order: Planet Nemak → Future City → Sand Village → Sky Island"})
ab:AddToggle("AutoStory",{
Title="Auto Story",
Default=false,
Callback=function(ac)
getgenv().AutoStory=ac
if not ac and not getgenv().AutoQuest then
getgenv().QuestFarmTargets={}
Q:SetDesc("Idle")
end
end,
})


getgenv().RaidKeyEnemy={}

local ac=z.Raid

ac:AddSection("Select Raids")
if#n>0 then
ac:AddDropdown("EnabledRaids",{
Title="Active Raids",
Values=n,
Multi=true,
Default={},
Callback=function(ad)getgenv().EnabledRaids=ad end,
})
else
ac:AddParagraph({Title="Note",Content="Raids failed to load — restart the script."})
end


if#n>0 then
ac:AddSection("Key Enemies")
for ad,ae in ipairs(n)do
local af=ae:gsub("[%s%(%)%[%]]","_")
local ag=o[ae]or{}
getgenv().RaidKeyEnemy[ae]={}

if#ag>0 then
local ah={}
for ai,aj in ipairs(ag)do table.insert(ah,aj.name)end
ac:AddDropdown("KeyEnemy_"..af,{
Title=ae,
Values=ah,
Multi=true,
Default={},
Callback=function(ai)getgenv().RaidKeyEnemy[ae]=ai end,
})
else
ac:AddInput("KeyEnemy_"..af,{
Title=ae,
Placeholder="e.g. Genyu",
Finished=false,
Callback=function(ah)getgenv().RaidKeyEnemy[ae]=ah end,
})
end
end
end

ac:AddSection("Control")
local ad=ac:AddParagraph({Title="Status",Content="Idle"})

ac:AddToggle("AutoRaid",{
Title="Auto Raid",
Default=false,
Callback=function(ae)
getgenv().AutoRaid=ae
if not ae then
getgenv().RaidPriority=false
applyAutomations()
ad:SetDesc("Idle")
else
local af=getgenv().EnabledRaids or{}
if next(af)==nil then
a:Notify({Title="Auto Raid",Content="No raids selected — pick raids above first.",Duration=4})
ad:SetDesc("No raids selected")
end
end
end,
})

task.spawn(function()
while task.wait(1)do
if not getgenv().AutoRaid then continue end
local ae=getgenv().EnabledRaids or{}
local af={}
for ag,ah in ipairs(n)do
if not ae[ah]then continue end
local ai=getRaidCooldownLeft(ah)
local aj=getgenv().CurrentRaid==ah
if aj then
if not hasRaidKey(ah)then
table.insert(af,ah..": farming key")
else
table.insert(af,ah..": in raid")
end
elseif ai>0 then
local S=math.floor(ai/60)
local T=ai%60
table.insert(af,string.format("%s: cooldown %dm%ds",ah,S,T))
else
table.insert(af,ah..": ready")
end
end
ad:SetDesc(#af>0 and table.concat(af,"\n")or"No raids selected")
end
end)


local ae=z.Settings
ae:AddSection("General")
ae:AddToggle("AntiAFK",{
Title="Anti-AFK",
Default=true,
Callback=function(af)getgenv().AntiAFK=af end,
})

b:SetLibrary(a)
c:SetLibrary(a)
c:SetFolder("AnimeWarriorsIII")
b:SetFolder("AnimeWarriorsIII")
b:BuildConfigSection(ae)
c:BuildInterfaceSection(ae)
b:LoadAutoloadConfig()

getgenv().AWIIIDestroy=function()
getgenv().AutoFarm=false
getgenv().AutoRaid=false
getgenv().AutoQuest=false
getgenv().AutoStory=false
getgenv().RaidPriority=false
getgenv().QuestFarmTargets={}
getgenv().QuestWorld=nil
if getgenv().AutoEgg then
local af=getgenv().SelectedEgg or""
if af~=""and L then
pcall(function()L:FireServer(af,false)end)
end
end
getgenv().AutoEgg=false
getgenv().SelectedEgg=nil
getgenv().AWIIIDestroy=nil
y:Destroy()
end