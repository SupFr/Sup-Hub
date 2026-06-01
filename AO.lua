

local a=game:GetService("Players")
local b=game:GetService("RunService")
local c=game:GetService("TweenService")
local d=game:GetService("UserInputService")
local e=game:GetService("HttpService")
local f=a.LocalPlayer
local g=f:WaitForChild("PlayerGui")


if _G.MacroConnection then _G.MacroConnection:Disconnect()end
_G.MacroConnection=f.OnTeleport:Connect(function()
if g:FindFirstChild("SimpleTDMacro")then
g.SimpleTDMacro:Destroy()
end
end)


local function bufToStr(h)
local i,j=pcall(buffer.tostring,h)
if i then return j end
local k={}
for l=0,buffer.len(h)-1 do table.insert(k,string.char(buffer.readu8(h,l)))end
return table.concat(k)
end

local function strToBuf(h)
local i,j=pcall(buffer.fromstring,h)
if i then return j end
local k=buffer.create(#h)
for l=1,#h do buffer.writeu8(k,l-1,string.byte(h,l))end
return k
end

local function hasDecreaseYen(h)
if type(h)=="string"and h:find("decreaseYen")then return true end
if type(h)=="table"then
for i,j in pairs(h)do if hasDecreaseYen(j)then return true end end
end
return false
end


local h={}
local function registerRemote(i)
if i:IsA("RemoteEvent")or i:IsA("RemoteFunction")then h[i.Name]=i end
end
for i,j in ipairs(game:GetDescendants())do pcall(registerRemote,j)end
game.DescendantAdded:Connect(function(i)pcall(registerRemote,i)end)


local function serArgs(i)
local j={};local k=0
for l,m in pairs(i)do
if type(l)=="number"and l>k then k=l end
local n=typeof(m)
if n=="Vector3"then j[tostring(l)]={_t="v3",x=m.X,y=m.Y,z=m.Z}
elseif n=="CFrame"then j[tostring(l)]={_t="cf",d={m:GetComponents()}}
elseif n=="Instance"then pcall(function()j[tostring(l)]={_t="inst",p=m:GetFullName()}end)
elseif n=="buffer"then
local o=buffer.len(m);local p={}
for q=0,o-1 do p[q+1]=buffer.readu8(m,q)end
j[tostring(l)]={_t="buf",d=p}
elseif n=="table"then j[tostring(l)]={_t="tbl",d=serArgs(m)}
else j[tostring(l)]={_t="val",d=m}end
end
j._max=k;return j
end

local function deserArgs(i)
local j={};local k=i._max or 0
for l,m in pairs(i)do
if l~="_max"then
local n=tonumber(l);local o
if type(m)~="table"then o=m
elseif m._t=="v3"then o=Vector3.new(m.x,m.y,m.z)
elseif m._t=="cf"then o=CFrame.new(table.unpack(m.d))
elseif m._t=="inst"then
local p=m.p:split(".");local q=game
for r=1,#p do if not q then break end q=q:FindFirstChild(p[r])end
o=q
elseif m._t=="buf"then
local p=buffer.create(#m.d)
for q,r in ipairs(m.d)do buffer.writeu8(p,q-1,r)end
o=p
elseif m._t=="tbl"then o=deserArgs(m.d)
else o=m.d end
if n then j[n]=o else j[l]=o end
end
end
return j,k
end


local i={
recording=false,
playing=false,
looping=false,
actions={},
hookHandle=nil,
webhookURL="",
}
local j=nil
local k=nil

task.spawn(function()
while not h["reflex_RELIABLE"]do task.wait(1)end
h["reflex_RELIABLE"].OnClientEvent:Connect(function(l,m)
if i.recording and k then
if bufToStr(l):find("decreaseYen")or hasDecreaseYen(m)then
table.insert(i.actions,k)
k=nil
end
end
end)
end)

task.spawn(function()
local l=game:GetService("Workspace"):WaitForChild("placedTowers")
l.ChildAdded:Connect(function(m)
if i.recording and j then
if m:IsA("Model")and m.Name:find("tower%-")then
local n=j;j=nil
task.spawn(function()
task.wait(0.5)
n.recordedCFrame=tostring(m:GetAttribute("CustomCFrame"))
n.oldId=m:GetAttribute("uniqueId")or m.Name:gsub("tower%-","")
table.insert(i.actions,n)
end)
end
end
end)
end)

local function startHook()
if not hookmetamethod or i.hookHandle then return end
local l
l=hookmetamethod(game,"__namecall",function(m,...)
local n=getnamecallmethod()
if i.recording and(n=="FireServer"or n=="InvokeServer")then
local o={...}
if m.Name=="sync_RELIABLE"then
j={remote=m.Name,args=serArgs(o)}
elseif m.Name=="towers_RELIABLE"then
k={remote=m.Name,args=serArgs(o)}
end
end
return l(m,...)
end)
i.hookHandle=l
end
startHook()


local function playMacro(l)
if#i.actions==0 or i.playing then return end
i.playing=true
task.spawn(function()
local m={}
local n=game:GetService("Workspace"):FindFirstChild("placedTowers")
for o,p in ipairs(i.actions)do
if not i.playing then break end
local q=h[p.remote]
if not q then continue end
local r,s=deserArgs(p.args)
for t,u in pairs(r)do
if typeof(u)=="buffer"then
local v=bufToStr(u)
for w,x in pairs(m)do
local y=w:gsub("[%-%^%$%(%)%%%.%[%]%*%+%?]","%%%1")
if v:find(w,1,true)then v=v:gsub(y,x)end
end
r[t]=strToBuf(v)
end
end
local t=false;local u=0;local v
if q.Name=="sync_RELIABLE"then
v=n.ChildAdded:Connect(function(w)
if w.Name:find("tower%-")then t=true end
end)
elseif q.Name=="towers_RELIABLE"then
v=h["reflex_RELIABLE"].OnClientEvent:Connect(function(w,x)
if bufToStr(w):find("decreaseYen")or hasDecreaseYen(x)then t=true end
end)
end
while not t and i.playing do
if tick()-u>=0.5 then
q:FireServer(unpack(r,1,s))
u=tick()
end
task.wait(0.05)
end
if v then v:Disconnect()end
if q.Name=="sync_RELIABLE"and p.recordedCFrame and p.oldId then
task.wait(0.5)
for w,x in ipairs(n:GetChildren())do
if tostring(x:GetAttribute("CustomCFrame"))==p.recordedCFrame then
m[p.oldId]=x:GetAttribute("uniqueId")or x.Name:gsub("tower%-","")
break
end
end
end
end
i.playing=false
if l then l()end
if i.looping then
task.wait(1)
playMacro(l)
end
end)
end

local function sendWebhook(l)
if i.webhookURL==""then return end
pcall(function()
e:PostAsync(i.webhookURL,e:JSONEncode({
content=l,
username="AO Macro",
}),Enum.HttpContentType.ApplicationJson)
end)
end




if g:FindFirstChild("SimpleTDMacro")then
g.SimpleTDMacro:Destroy()
end

local l={
bg=Color3.fromRGB(18,18,24),
panel=Color3.fromRGB(25,25,33),
sidebar=Color3.fromRGB(22,22,29),
card=Color3.fromRGB(30,30,40),
hover=Color3.fromRGB(40,40,55),
active=Color3.fromRGB(45,55,85),
border=Color3.fromRGB(55,55,75),
text=Color3.fromRGB(240,240,245),
muted=Color3.fromRGB(140,140,160),
red=Color3.fromRGB(255,69,58),
green=Color3.fromRGB(48,209,88),
yellow=Color3.fromRGB(255,214,10),
blue=Color3.fromRGB(10,132,255),
orange=Color3.fromRGB(255,159,10),
purple=Color3.fromRGB(191,90,242),
gray=Color3.fromRGB(99,99,102),
white=Color3.fromRGB(255,255,255),
}

local m=520
local n=380
local o=140

local p=Instance.new("ScreenGui")
p.Name="SimpleTDMacro"
p.DisplayOrder=999999
p.ResetOnSpawn=false
p.IgnoreGuiInset=true
p.Parent=g


local q=Instance.new("Frame")
q.Name="Win"
q.Size=UDim2.new(0,m,0,n)
q.Position=UDim2.new(0.5,-m/2,0.5,-n/2)
q.BackgroundColor3=l.bg
q.BorderSizePixel=0
q.ClipsDescendants=true
q.Parent=p
Instance.new("UICorner",q).CornerRadius=UDim.new(0,10)
local r=Instance.new("UIStroke")
r.Color=l.border;r.Thickness=1;r.Parent=q


local s=Instance.new("Frame")
s.Size=UDim2.new(1,0,0,35)
s.BackgroundColor3=l.panel
s.BorderSizePixel=0
s.Parent=q

local t=Instance.new("TextLabel")
t.Size=UDim2.new(1,0,1,0)
t.BackgroundTransparency=1
t.Text="AO Macro Hub"
t.Font=Enum.Font.GothamBold
t.TextSize=14
t.TextColor3=l.text
t.TextXAlignment=Enum.TextXAlignment.Center
t.Parent=s


local u,v,w
s.InputBegan:Connect(function(x)
if x.UserInputType==Enum.UserInputType.MouseButton1 then
u=true;v=x.Position;w=q.Position
end
end)
s.InputEnded:Connect(function(x)
if x.UserInputType==Enum.UserInputType.MouseButton1 then u=false end
end)
d.InputChanged:Connect(function(x)
if u and x.UserInputType==Enum.UserInputType.MouseMovement then
local y=x.Position-v
q.Position=UDim2.new(w.X.Scale,w.X.Offset+y.X,w.Y.Scale,w.Y.Offset+y.Y)
end
end)


local x=Instance.new("ScrollingFrame")
x.Size=UDim2.new(0,o,1,-35)
x.Position=UDim2.new(0,0,0,35)
x.BackgroundColor3=l.sidebar
x.BorderSizePixel=0
x.ScrollBarThickness=2
x.AutomaticCanvasSize=Enum.AutomaticSize.Y
x.CanvasSize=UDim2.new(0,0,0,0)
x.Parent=q

local y=Instance.new("UIListLayout")
y.SortOrder=Enum.SortOrder.LayoutOrder
y.Padding=UDim.new(0,5)
y.Parent=x

local z=Instance.new("UIPadding")
z.PaddingTop=UDim.new(0,10)
z.PaddingLeft=UDim.new(0,10)
z.PaddingRight=UDim.new(0,10)
z.PaddingBottom=UDim.new(0,10)
z.Parent=x


local A=Instance.new("Frame")
A.Size=UDim2.new(1,-o,1,-35)
A.Position=UDim2.new(0,o,0,35)
A.BackgroundTransparency=1
A.BorderSizePixel=0
A.Parent=q

local function createPage()
local B=Instance.new("ScrollingFrame")
B.Size=UDim2.new(1,0,1,0)
B.BackgroundTransparency=1
B.BorderSizePixel=0
B.ScrollBarThickness=4
B.AutomaticCanvasSize=Enum.AutomaticSize.Y
B.CanvasSize=UDim2.new(0,0,0,0)
B.Visible=false
B.Parent=A

local C=Instance.new("UIListLayout")
C.SortOrder=Enum.SortOrder.LayoutOrder
C.Padding=UDim.new(0,10)
C.Parent=B

local D=Instance.new("UIPadding")
D.PaddingTop=UDim.new(0,15)
D.PaddingLeft=UDim.new(0,15)
D.PaddingRight=UDim.new(0,15)
D.PaddingBottom=UDim.new(0,15)
D.Parent=B

return B
end

local B=createPage()
local C=createPage()
local D=createPage()
local E=createPage()
local F=createPage()
local G=createPage()
local H=createPage()


local I=nil
local J=nil

local function createTab(K,L,M,N)
local O=Instance.new("TextButton")
O.Size=UDim2.new(1,0,0,35)
O.BackgroundColor3=l.card
O.BackgroundTransparency=1
O.BorderSizePixel=0
O.Text=""
O.LayoutOrder=N
O.Parent=x
Instance.new("UICorner",O).CornerRadius=UDim.new(0,6)

local P=Instance.new("TextLabel")
P.Size=UDim2.new(1,-35,1,0)
P.Position=UDim2.new(0,35,0,0)
P.BackgroundTransparency=1
P.Text=K
P.Font=Enum.Font.GothamSemibold
P.TextSize=13
P.TextColor3=l.muted
P.TextXAlignment=Enum.TextXAlignment.Left
P.Parent=O

local Q=Instance.new("TextLabel")
Q.Size=UDim2.new(0,35,1,0)
Q.BackgroundTransparency=1
Q.Text=L
Q.Font=Enum.Font.GothamBold
Q.TextSize=14
Q.TextColor3=l.muted
Q.Parent=O

O.MouseButton1Click:Connect(function()
if I then
I.BackgroundTransparency=1
I:FindFirstChild("TextLabel").TextColor3=l.muted
end
if J then J.Visible=false end

I=O
J=M

O.BackgroundTransparency=0
P.TextColor3=l.text
M.Visible=true
end)

return O
end

local function createHeader(K,L)
local M=Instance.new("TextLabel")
M.Size=UDim2.new(1,0,0,20)
M.BackgroundTransparency=1
M.Text=K
M.Font=Enum.Font.GothamBold
M.TextSize=11
M.TextColor3=l.gray
M.TextXAlignment=Enum.TextXAlignment.Left
M.LayoutOrder=L
M.Parent=x
end


createHeader("CORE",1)
local K=createTab("Macro","◉",B,2)
createTab("Auto Loop","↺",C,3)

createHeader("GAME MODES",4)
createTab("Challenges","⚔",D,5)
createTab("Raids","☠",E,6)
createTab("Events","★",F,7)

createHeader("SYSTEM",8)
createTab("Hook","⚡",G,9)
createTab("Webhook","↑",H,10)


local function makeTitle(L,M,N)
local O=Instance.new("TextLabel")
O.Size=UDim2.new(1,0,0,20)
O.BackgroundTransparency=1
O.Text=M
O.Font=Enum.Font.GothamBold
O.TextSize=12
O.TextColor3=l.text
O.TextXAlignment=Enum.TextXAlignment.Left
O.LayoutOrder=N
O.Parent=L
return O
end

local function makeButton(L,M,N,O)
local P=Instance.new("TextButton")
P.Size=UDim2.new(1,0,0,40)
P.BackgroundColor3=N
P.BorderSizePixel=0
P.Text=M
P.Font=Enum.Font.GothamBold
P.TextSize=14
P.TextColor3=l.white
P.LayoutOrder=O
P.Parent=L
Instance.new("UICorner",P).CornerRadius=UDim.new(0,8)
return P
end


makeTitle(B,"Macro Controls",1)
local L=makeButton(B,"● Record",l.red,2)
local M=makeButton(B,"▶ Play",l.green,3)
local N=makeButton(B,"✕ Clear Actions",l.gray,4)

makeTitle(B,"Status Info",5)
local O=Instance.new("Frame")
O.Size=UDim2.new(1,0,0,40)
O.BackgroundColor3=l.card
O.LayoutOrder=6
O.Parent=B
Instance.new("UICorner",O).CornerRadius=UDim.new(0,8)

local P=Instance.new("TextLabel")
P.Size=UDim2.new(1,-20,1,0)
P.Position=UDim2.new(0,10,0,0)
P.BackgroundTransparency=1
P.Text="Ready to record."
P.Font=Enum.Font.Gotham
P.TextSize=13
P.TextColor3=l.muted
P.TextXAlignment=Enum.TextXAlignment.Left
P.Parent=O


makeTitle(D,"Challenges Setup (Coming Soon)",1)
makeTitle(E,"Raids Setup (Coming Soon)",1)
makeTitle(F,"Events Setup (Coming Soon)",1)
makeTitle(C,"Auto-Loop Config (Coming Soon)",1)
makeTitle(H,"Discord Webhook Setup (Coming Soon)",1)
makeTitle(G,"Remote Hook Diagnostics (Coming Soon)",1)


L.MouseButton1Click:Connect(function()
if i.playing then return end
i.recording=not i.recording
if i.recording then i.actions={}end
end)

M.MouseButton1Click:Connect(function()
if i.playing then i.playing=false;return end
if i.recording then return end
playMacro()
end)

N.MouseButton1Click:Connect(function()
if not i.recording and not i.playing then i.actions={}end
end)

b.RenderStepped:Connect(function()
local Q=#i.actions
local R=i.recording
local S=i.playing

P.Text=R and("Recording... ("..Q.." actions)")or S and"Playing macro..."or("Ready ("..Q.." actions saved)")
L.Text=R and"■ Stop Recording"or"● Record"
M.Text=S and"⏹ Stop Playback"or"▶ Play"
end)


K.BackgroundTransparency=0
K:FindFirstChild("TextLabel").TextColor3=l.text
B.Visible=true
I=K
J=B

print("[AO Hub] Loaded Successfully!")