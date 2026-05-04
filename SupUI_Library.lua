




































local a={}
a.__index=a
a._version="7.0.0"


local b=game:GetService("TweenService")
local c=game:GetService("UserInputService")
local d=game:GetService("RunService")
local e=game:GetService("Players")
local f=game:GetService("HttpService")
local g=game:GetService("Workspace")

local h=e.LocalPlayer


local i={
pad_xs=4,pad_sm=8,pad_md=12,pad_lg=16,pad_xl=24,
radius_sm=4,radius_md=6,radius_lg=8,
font_regular=Enum.Font.Gotham,
font_medium=Enum.Font.GothamMedium,
font_bold=Enum.Font.GothamBold,
font_mono=Enum.Font.Code,
text_xs=11,text_sm=12,text_md=14,
dur_fast=0.12,dur_med=0.18,dur_slow=0.28,
ease_out=Enum.EasingStyle.Quad,
scale_ref_y=1440,
scale_min=0.65,
scale_max=2.0,
settings_tab_order=9999,
config_tab_order=9998,
}


local j={
bg=Color3.fromRGB(16,16,20),
surface=Color3.fromRGB(22,22,28),
elevated=Color3.fromRGB(28,28,36),
hover=Color3.fromRGB(36,36,46),
border=Color3.fromRGB(48,48,58),
border_soft=Color3.fromRGB(38,38,46),
text=Color3.fromRGB(235,235,240),
text_dim=Color3.fromRGB(160,160,170),
text_muted=Color3.fromRGB(110,110,120),
accent=Color3.fromRGB(130,120,255),
accent_dim=Color3.fromRGB(90,82,190),
success=Color3.fromRGB(80,200,130),
warning=Color3.fromRGB(235,170,70),
danger=Color3.fromRGB(235,80,95),
info=Color3.fromRGB(80,170,235),
white=Color3.fromRGB(255,255,255),
black=Color3.fromRGB(0,0,0),
shadow=Color3.fromRGB(0,0,0),
}


a.Themes={
Dark=j,
Midnight={
bg=Color3.fromRGB(10,12,18),surface=Color3.fromRGB(16,18,26),elevated=Color3.fromRGB(22,24,34),
hover=Color3.fromRGB(30,34,46),border=Color3.fromRGB(42,48,64),border_soft=Color3.fromRGB(28,32,44),
text=Color3.fromRGB(220,226,240),text_dim=Color3.fromRGB(140,152,175),text_muted=Color3.fromRGB(90,100,125),
accent=Color3.fromRGB(80,140,255),accent_dim=Color3.fromRGB(50,90,180),
success=Color3.fromRGB(80,200,130),warning=Color3.fromRGB(235,170,70),danger=Color3.fromRGB(235,80,95),
info=Color3.fromRGB(80,170,235),white=Color3.fromRGB(255,255,255),black=Color3.fromRGB(0,0,0),
shadow=Color3.fromRGB(0,0,0),
},
Light={
bg=Color3.fromRGB(245,246,250),surface=Color3.fromRGB(255,255,255),elevated=Color3.fromRGB(252,252,254),
hover=Color3.fromRGB(238,240,246),border=Color3.fromRGB(218,220,228),border_soft=Color3.fromRGB(232,234,240),
text=Color3.fromRGB(20,22,28),text_dim=Color3.fromRGB(80,85,95),text_muted=Color3.fromRGB(140,145,155),
accent=Color3.fromRGB(90,80,220),accent_dim=Color3.fromRGB(70,62,175),
success=Color3.fromRGB(40,160,90),warning=Color3.fromRGB(220,145,40),danger=Color3.fromRGB(220,60,75),
info=Color3.fromRGB(50,140,215),white=Color3.fromRGB(255,255,255),black=Color3.fromRGB(0,0,0),
shadow=Color3.fromRGB(180,180,190),
},
Synthwave={
bg=Color3.fromRGB(20,14,32),surface=Color3.fromRGB(28,18,44),elevated=Color3.fromRGB(36,24,56),
hover=Color3.fromRGB(48,32,72),border=Color3.fromRGB(78,50,110),border_soft=Color3.fromRGB(46,30,68),
text=Color3.fromRGB(245,230,255),text_dim=Color3.fromRGB(200,170,230),text_muted=Color3.fromRGB(140,110,175),
accent=Color3.fromRGB(255,90,200),accent_dim=Color3.fromRGB(180,60,140),
success=Color3.fromRGB(100,240,200),warning=Color3.fromRGB(255,200,90),danger=Color3.fromRGB(255,80,120),
info=Color3.fromRGB(120,200,255),white=Color3.fromRGB(255,255,255),black=Color3.fromRGB(0,0,0),
shadow=Color3.fromRGB(0,0,0),
},
}





local function tween(k,l,m,n,o)
local p=TweenInfo.new(m or i.dur_med,n or i.ease_out,o or Enum.EasingDirection.Out)
local q=b:Create(k,p,l)
q:Play()
return q
end

local function corner(k,l)
local m=Instance.new("UICorner")
m.CornerRadius=UDim.new(0,l or i.radius_md)
m.Parent=k
return m
end

local function stroke(k,l,m,n)
local o=Instance.new("UIStroke")
o.Color=l or j.border
o.Thickness=m or 1
o.Transparency=n or 0
o.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
o.Parent=k
return o
end

local function padding(k,l,m,n,o)
local p=Instance.new("UIPadding")
p.PaddingTop=UDim.new(0,l or 0)
p.PaddingRight=UDim.new(0,m or l or 0)
p.PaddingBottom=UDim.new(0,n or l or 0)
p.PaddingLeft=UDim.new(0,o or m or l or 0)
p.Parent=k
return p
end

local function new(k,l)
local m=Instance.new(k)
if l then
for n,o in pairs(l)do
if n~="Parent"then m[n]=o end
end
if l.Parent then m.Parent=l.Parent end
end
return m
end

local function copyTable(k)
local l={}
for m,n in pairs(k)do l[m]=n end
return l
end

local function safeCall(k,...)
if type(k)~="function"then return end
local l,m=pcall(k,...)
if not l then warn("[SupUI] Callback error: "..tostring(m))end
end

local function isPointInside(k,l,m)
return k.X>=l.X and k.X<=l.X+m.X
and k.Y>=l.Y and k.Y<=l.Y+m.Y
end

local function snap(k,l)
local m=math.floor(k/l+0.5)*l
return tonumber(string.format("%.10g",m))or m
end

local function clamp01(k)
k=tonumber(k)or 0
if k<0 then return 0 end
if k>1 then return 1 end
return k
end


local function sanitizeName(k,l)
k=tostring(k or"")
k=k:gsub("[^%w_%-%.]","_")
k=k:gsub("%.+",".")
k=k:gsub("^[%.%-_]+","")
if k==""then k=l or"default"end
if#k>48 then k=k:sub(1,48)end
return k
end





a._antiAFK={enabled=false,conn=nil}

function a:EnableAntiAFK()
if self._antiAFK.enabled then return end
if not h then return end
local k
pcall(function()k=game:GetService("VirtualUser")end)
self._antiAFK.conn=h.Idled:Connect(function()
if k then
pcall(function()
k:CaptureController()
k:ClickButton2(Vector2.new())
end)
else
local l=g.CurrentCamera
if l then
pcall(function()
l.CFrame=l.CFrame*CFrame.new(0,0,0.001)
task.wait(0.05)
l.CFrame=l.CFrame*CFrame.new(0,0,-1E-3)
end)
end
end
end)
self._antiAFK.enabled=true
end

function a:DisableAntiAFK()
if self._antiAFK.conn then
pcall(function()self._antiAFK.conn:Disconnect()end)
self._antiAFK.conn=nil
end
self._antiAFK.enabled=false
end

function a:IsAntiAFKEnabled()return self._antiAFK.enabled end





local function newConnMgr()
local k={_conns={},_alive=true}
function k:Add(l)
if not self._alive then l:Disconnect();return l end
table.insert(self._conns,l)
return l
end
function k:Clear()
self._alive=false
for l,m in ipairs(self._conns)do
pcall(function()m:Disconnect()end)
end
self._conns={}
end
return k
end





local function newInputDispatcher(k)
local l,m,n={},{},{}
local o=0

k:Add(c.InputChanged:Connect(function(p)
if p.UserInputType==Enum.UserInputType.MouseMovement
or p.UserInputType==Enum.UserInputType.Touch then
for q,r in pairs(l)do pcall(r,p)end
end
end))
k:Add(c.InputEnded:Connect(function(p)
if p.UserInputType==Enum.UserInputType.MouseButton1
or p.UserInputType==Enum.UserInputType.Touch then
for q,r in pairs(m)do pcall(r,p)end
end
end))
k:Add(c.InputBegan:Connect(function(p,q)
if p.UserInputType==Enum.UserInputType.MouseButton1
or p.UserInputType==Enum.UserInputType.Touch then
for r,s in pairs(n)do pcall(s,p,q)end
end
end))

return{
onMove=function(p)
o=o+1;local q=o
l[q]=p
return function()l[q]=nil end
end,
onRelease=function(p)
o=o+1;local q=o
m[q]=p
return function()m[q]=nil end
end,
onAnyClick=function(p)
o=o+1;local q=o
n[q]=p
return function()n[q]=nil end
end,
}
end





local function newThemeEngine(k)
local l=copyTable(k)
local m={}
local function apply(n)
local o=l[n.role]
if o and n.obj then
pcall(function()n.obj[n.prop]=o end)
end
end
return{
theme=l,
tag=function(n,o,p)
local q={obj=n,prop=o,role=p}
table.insert(m,q)
apply(q)
return q
end,
set=function(n)
for o,p in pairs(n)do l[o]=p end
for o,p in ipairs(m)do apply(p)end
end,
get=function(n)return l[n]end,
clear=function()m={}end,
}
end









local function findGlobalFn(k)

local l,m
l,m=pcall(function()return getfenv(0)[k]end)
if l and type(m)=="function"then return m end
if type(rawget(_G,"getgenv"))=="function"then
l,m=pcall(function()return getgenv()[k]end)
if l and type(m)=="function"then return m end
end
if type(rawget(_G,k))=="function"then return rawget(_G,k)end
if type(rawget(shared or{},k))=="function"then return rawget(shared,k)end
return nil
end

local function newConfigStore(k)
local l=findGlobalFn("writefile")
local m=findGlobalFn("readfile")
local n=findGlobalFn("isfile")
local o=findGlobalFn("isfolder")
local p=findGlobalFn("makefolder")
local q=findGlobalFn("listfiles")
local r=findGlobalFn("delfile")

local s=l and m and n

local t="SupUI"
local u=t.."/"..sanitizeName(k,"Window")

if s and p and o then
pcall(function()
if not o(t)then p(t)end
if not o(u)then p(u)end
end)
end

local function pathFor(v)
return u.."/"..sanitizeName(v,"default")..".json"
end

local v={}
v.available=s and true or false
v.folder=u

function v.save(w,x)
if not s then return false,"file I/O not available in this executor"end
local y={
__version=a._version,
__saved_at=os.time(),
data=x,
}
local z,A=pcall(f.JSONEncode,f,y)
if not z then return false,"encode failed: "..tostring(A)end
local B=pathFor(w)
local C,D=pcall(l,B,A)
if not C then return false,"write failed: "..tostring(D)end
return true,B
end

function v.load(w)
if not s then return nil,"file I/O not available"end
local x=pathFor(w)
local y,z=pcall(n,x)
if not y or not z then return nil,"config not found"end
local A,B=pcall(m,x)
if not A then return nil,"read failed: "..tostring(B)end
local C,D=pcall(f.JSONDecode,f,B)
if not C then return nil,"decode failed (corrupted?)"end
if type(D)~="table"then return nil,"malformed config"end

if D.__version and D.data then
return D.data,D.__version
end
return D,"legacy"
end

function v.list()
if not s or not q then return{}end
local w,x=pcall(q,u)
if not w then return{}end
local y={}
for z,A in ipairs(x)do
local B=A:match("([^/\\]+)%.json$")
if B then table.insert(y,B)end
end
table.sort(y)
return y
end

function v.delete(w)
if not s or not r then return false,"delete not supported"end
local x,y=pcall(r,pathFor(w))
if not x then return false,tostring(y)end
return true
end

function v.exists(w)
if not s then return false end
local x,y=pcall(n,pathFor(w))
return x and y==true
end

return v
end





function a:CreateWindow(k)
k=k or{}
local l=k.Name or"SupUI"
local m=k.SubTitle or""
local n=math.max(420,k.Width or 640)
local o=math.max(320,k.Height or 460)

if k.AntiAFK~=false then self:EnableAntiAFK()end

local p=newConnMgr()
local q=newInputDispatcher(p)
local r=newThemeEngine(k.Theme and(function()
local r=copyTable(j)
for s,t in pairs(k.Theme)do r[s]=t end
return r
end)()or j)
local s=newConfigStore(l)

local t=h:WaitForChild("PlayerGui")
if t:FindFirstChild("SupUI_"..l)then
t["SupUI_"..l]:Destroy()
end

local u=new("ScreenGui",{
Name="SupUI_"..l,
ResetOnSpawn=false,
IgnoreGuiInset=true,
DisplayOrder=1000,
ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
Parent=t,
})

local v=new("Frame",{
Name="ScaleRoot",
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
BorderSizePixel=0,
Parent=u,
})
local w=Instance.new("UIScale")
w.Scale=1
w.Parent=v

local x=k.AutoScale~=false
local y=k.Scale

local function computeScale()
if y then
w.Scale=math.clamp(y,i.scale_min,i.scale_max)
return
end
if not x then w.Scale=1;return end
local z=g.CurrentCamera
if not z then return end
local A=z.ViewportSize
if A.Y<=0 then return end
w.Scale=math.clamp(A.Y/i.scale_ref_y,i.scale_min,i.scale_max)
end
computeScale()

if x and not y then
local z=g.CurrentCamera
if z then
p:Add(z:GetPropertyChangedSignal("ViewportSize"):Connect(computeScale))
end
p:Add(g:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
local A=g.CurrentCamera
if A then
p:Add(A:GetPropertyChangedSignal("ViewportSize"):Connect(computeScale))
end
computeScale()
end))
end

local z=new("Frame",{
Name="Main",
Size=UDim2.new(0,n,0,o),
Position=UDim2.new(0.5,-n/2,0.5,-o/2),
BorderSizePixel=0,
ClipsDescendants=true,
Parent=v,
})
r.tag(z,"BackgroundColor3","bg")
corner(z,i.radius_lg)
local A=stroke(z,nil,1)
r.tag(A,"Color","border")

local B=new("Frame",{
Name="TitleBar",
Size=UDim2.new(1,0,0,36),
BorderSizePixel=0,
Parent=z,
})
r.tag(B,"BackgroundColor3","surface")
local C=new("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0,0,1,-1),
BorderSizePixel=0,
Parent=B,
})
r.tag(C,"BackgroundColor3","border")

local D=new("Frame",{
Size=UDim2.new(1,-90,1,0),
Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,
Parent=B,
})
new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
Parent=D,
})

local E=new("Frame",{Size=UDim2.new(0,6,0,6),BorderSizePixel=0,LayoutOrder=1,Parent=D})
r.tag(E,"BackgroundColor3","accent");corner(E,3)

local F=new("TextLabel",{
AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,Text=l,
Font=i.font_medium,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2,Parent=D,
})
r.tag(F,"TextColor3","text")

if m~=""then
local G=new("TextLabel",{
AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,Text=m,
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=3,Parent=D,
})
r.tag(G,"TextColor3","text_muted")
end

local G

local function winBtn(H,I,J)
local K=new("TextButton",{
Size=UDim2.new(0,24,0,24),Position=UDim2.new(1,J,0.5,-12),
BackgroundTransparency=1,Text=H,
Font=i.font_bold,TextSize=i.text_md,
AutoButtonColor=false,Parent=B,
})
r.tag(K,"TextColor3","text_dim");corner(K,i.radius_sm)
p:Add(K.MouseEnter:Connect(function()
K.BackgroundTransparency=0
K.BackgroundColor3=r.get(I)
K.TextColor3=r.get("text")
end))
p:Add(K.MouseLeave:Connect(function()
K.BackgroundTransparency=1
K.TextColor3=r.get("text_dim")
end))
return K
end

local H=winBtn("×","danger",-28)
local I=winBtn("–","hover",-56)

p:Add(H.MouseButton1Click:Connect(function()
if G then G:Destroy()end
end))

local J=false
p:Add(I.MouseButton1Click:Connect(function()
J=not J
tween(z,{
Size=J and UDim2.new(0,n,0,36)or UDim2.new(0,n,0,o),
},i.dur_slow)
end))


do
local K,L,M=false,nil,nil
p:Add(B.InputBegan:Connect(function(N)
if G and G._positionLocked then return end
if N.UserInputType==Enum.UserInputType.MouseButton1
or N.UserInputType==Enum.UserInputType.Touch then
K=true;L=N.Position;M=z.Position
end
end))
p:Add(B.InputEnded:Connect(function(N)
if N.UserInputType==Enum.UserInputType.MouseButton1
or N.UserInputType==Enum.UserInputType.Touch then K=false end
end))
q.onMove(function(N)
if not K then return end
local O=w.Scale;if O==0 then O=1 end
local P=N.Position-L
z.Position=UDim2.new(
M.X.Scale,M.X.Offset+P.X/O,
M.Y.Scale,M.Y.Offset+P.Y/O
)
end)
end

local K=140
local L=new("Frame",{
Size=UDim2.new(0,K,1,-36),
Position=UDim2.new(0,0,0,36),
BorderSizePixel=0,Parent=z,
})
r.tag(L,"BackgroundColor3","surface")

local M=new("Frame",{
Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),
BorderSizePixel=0,Parent=L,
})
r.tag(M,"BackgroundColor3","border")

local N=new("ScrollingFrame",{
Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,
ScrollBarThickness=2,AutomaticCanvasSize=Enum.AutomaticSize.Y,
CanvasSize=UDim2.new(0,0,0,0),ScrollingDirection=Enum.ScrollingDirection.Y,
Parent=L,
})
r.tag(N,"ScrollBarImageColor3","border")
padding(N,i.pad_sm,i.pad_sm,i.pad_sm,i.pad_sm)

new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
Parent=N,
})

local O=new("Frame",{
Size=UDim2.new(1,-K,1,-36),
Position=UDim2.new(0,K,0,36),
BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=true,Parent=z,
})

local P=new("Frame",{
Name="Overlay",Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,BorderSizePixel=0,ZIndex=50,Parent=v,
})

local Q=new("Frame",{
Size=UDim2.new(0,300,1,-20),Position=UDim2.new(1,-310,0,10),
BackgroundTransparency=1,BorderSizePixel=0,ZIndex=100,Parent=v,
})
new("UIListLayout",{
Padding=UDim.new(0,i.pad_sm),
VerticalAlignment=Enum.VerticalAlignment.Bottom,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
SortOrder=Enum.SortOrder.LayoutOrder,Parent=Q,
})





G={
_screen=u,_scaleRoot=v,_uiScale=w,
_win=z,_conns=p,_input=q,_theme=r,_config=s,
_overlay=P,_notifLayer=Q,
_tabs={},_activeTab=nil,_tabCount=0,
_configTargets={},_keybinds={},
_visible=true,_positionLocked=false,_notificationsEnabled=true,
_toggleKey=k.ToggleKey or Enum.KeyCode.RightControl,
_themeName="Dark",_watermark=nil,_modalOpen=false,
_settingsTabBuilt=false,_configTabBuilt=false,
_origPosition=UDim2.new(0.5,-n/2,0.5,-o/2),
_activeNotifs={},_maxNotifs=5,_notifQueue={},
_autoLoadConfig=k.AutoLoadConfig~=false,
_defaultConfigName=k.DefaultConfig or"default",
_loadingConfig=false,
}


p:Add(c.InputBegan:Connect(function(R,S)
if S then return end
if R.UserInputType~=Enum.UserInputType.Keyboard then return end
for T,U in ipairs(G._keybinds)do
if not U._listening and U._key==R.KeyCode then
safeCall(U._cb,R.KeyCode)
end
end
end))


function G:SetScale(R)
if type(R)~="number"then return end
y=R;x=false;computeScale()
end
function G:GetScale()return w.Scale end
function G:EnableAutoScale()
y=nil;x=true;computeScale()
end


function G:_renderNotif(R)
local S=R.Type or"info"
local T={info="info",success="success",warning="warning",error="danger"}
local U=T[S]or"info"
local V=R.Duration or 4
local W=R.Title or"Notice"
local X=R.Message or""
local Y=R.Actions
local Z=Y and#Y>0
local _=Z and 92 or 64

local aa=new("Frame",{
Size=UDim2.new(1,0,0,_),
BorderSizePixel=0,ClipsDescendants=true,ZIndex=100,
Parent=self._notifLayer,
})
r.tag(aa,"BackgroundColor3","elevated")
corner(aa,i.radius_md)
local ab=stroke(aa,nil,1);r.tag(ab,"Color","border")

local ac=new("Frame",{
Size=UDim2.new(0,3,1,-8),Position=UDim2.new(0,0,0,4),
BorderSizePixel=0,ZIndex=101,Parent=aa,
})
r.tag(ac,"BackgroundColor3",U);corner(ac,2)

local ad=new("TextLabel",{
Size=UDim2.new(1,-40,0,16),Position=UDim2.new(0,i.pad_md,0,i.pad_sm),
BackgroundTransparency=1,Text=W,
Font=i.font_medium,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,ZIndex=101,Parent=aa,
})
r.tag(ad,"TextColor3","text")

local ae=new("TextLabel",{
Size=UDim2.new(1,-i.pad_md-14,0,28),
Position=UDim2.new(0,i.pad_md,0,26),
BackgroundTransparency=1,Text=X,
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
TextWrapped=true,ZIndex=101,Parent=aa,
})
r.tag(ae,"TextColor3","text_dim")

local af=false
local ag
local function closeCard()
if af then return end
af=true
if ag then pcall(function()ag:Disconnect()end);ag=nil end
for ah,ai in ipairs(self._activeNotifs)do
if ai==aa then table.remove(self._activeNotifs,ah);break end
end
tween(aa,{Position=UDim2.new(1,20,0,0),BackgroundTransparency=1},i.dur_med)
task.delay(i.dur_med+0.05,function()
if aa.Parent then aa:Destroy()end

if#self._notifQueue>0 and#self._activeNotifs<self._maxNotifs then
local ah=table.remove(self._notifQueue,1)
self:_renderNotif(ah)
end
end)
end

if Z then
local ah=new("Frame",{
Size=UDim2.new(1,-i.pad_md,0,24),
Position=UDim2.new(0,i.pad_md,1,-30),
BackgroundTransparency=1,ZIndex=101,Parent=aa,
})
new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=ah,
})
for ai,aj in ipairs(Y)do
local ak=new("TextButton",{
Size=UDim2.new(0,72,1,0),Text=aj.Text or"OK",
Font=i.font_medium,TextSize=i.text_xs,
AutoButtonColor=false,BorderSizePixel=0,
LayoutOrder=ai,ZIndex=102,Parent=ah,
})
local al=(aj.Style=="primary")or(ai==#Y and#Y==1)
if al then
r.tag(ak,"BackgroundColor3","accent");r.tag(ak,"TextColor3","white")
else
r.tag(ak,"BackgroundColor3","hover");r.tag(ak,"TextColor3","text")
end
corner(ak,i.radius_sm)
p:Add(ak.MouseButton1Click:Connect(function()
safeCall(aj.Callback);closeCard()
end))
end
end

if not Z then
local ah=new("Frame",{
Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,-2),
BorderSizePixel=0,ZIndex=101,Parent=aa,
})
r.tag(ah,"BackgroundColor3",U)
tween(ah,{Size=UDim2.new(0,0,0,2)},V,Enum.EasingStyle.Linear)
task.delay(V,closeCard)
end

ag=aa.InputBegan:Connect(function(ah)
if ah.UserInputType==Enum.UserInputType.MouseButton1 and not Z then
closeCard()
end
end)
p:Add(ag)

aa.Position=UDim2.new(1,20,0,0)
tween(aa,{Position=UDim2.new(0,0,0,0)},i.dur_slow)
table.insert(self._activeNotifs,aa)
return aa
end

function G:Notify(aa)
if not self._notificationsEnabled then return end
aa=aa or{}
if#self._activeNotifs>=self._maxNotifs then
table.insert(self._notifQueue,aa)
return
end
return self:_renderNotif(aa)
end

function G:NotifyQueue(aa)
return self:Notify(aa)
end

function G:ClearNotifications()
self._notifQueue={}
for aa,ab in ipairs(self._activeNotifs)do
if ab.Parent then ab:Destroy()end
end
self._activeNotifs={}
end

function G:SetTheme(aa)r.set(aa)end
function G:GetTheme()return copyTable(r.theme)end


function G:_registerConfig(aa,ab,ac)
table.insert(self._configTargets,{key=aa,get=ab,set=ac})
end

function G:SaveConfig(aa)
aa=aa or self._defaultConfigName
local ab={}
for ac,ad in ipairs(self._configTargets)do
local ae,af=pcall(ad.get)
if ae then ab[ad.key]=af end
end
return s.save(aa,ab)
end

function G:LoadConfig(aa)
aa=aa or self._defaultConfigName
local ab,ac=s.load(aa)
if not ab then return false,ac end
self._loadingConfig=true
for ad,ae in ipairs(self._configTargets)do
if ab[ae.key]~=nil then
pcall(ae.set,ab[ae.key])
end
end
self._loadingConfig=false
return true,ac
end

function G:ListConfigs()return s.list()end
function G:DeleteConfig(aa)return s.delete(aa)end
function G:ConfigsAvailable()return s.available end

function G:Show()
if self._visible then return end
self._visible=true;v.Visible=true
end
function G:Hide()
if not self._visible then return end
self._visible=false;v.Visible=false
end
function G:ToggleVisibility()
if self._visible then self:Hide()else self:Show()end
end
function G:IsVisible()return self._visible end

function G:SetToggleKey(aa)
if typeof(aa)~="EnumItem"then return end
self._toggleKey=aa
end
function G:GetToggleKey()return self._toggleKey end

p:Add(c.InputBegan:Connect(function(aa,ab)
if ab then return end
if aa.UserInputType~=Enum.UserInputType.Keyboard then return end
if aa.KeyCode==G._toggleKey then
for ac,ad in ipairs(G._keybinds)do
if ad._listening then return end
end
G:ToggleVisibility()
end
end))

function G:LockPosition(aa)self._positionLocked=aa and true or false end
function G:IsPositionLocked()return self._positionLocked end
function G:ResetPosition()
tween(z,{Position=self._origPosition},i.dur_med)
end

function G:SetNotificationsEnabled(aa)self._notificationsEnabled=aa and true or false end
function G:IsNotificationsEnabled()return self._notificationsEnabled end

function G:ApplyTheme(aa)
local ab
if type(aa)=="string"then
ab=a.Themes[aa]
if not ab then warn("[SupUI] Unknown theme: "..aa);return false end
self._themeName=aa
elseif type(aa)=="table"then
ab=aa;self._themeName="Custom"
else return false end
r.set(ab);return true
end
function G:GetThemeName()return self._themeName end
function G:ListThemes()
local aa={}
for ab in pairs(a.Themes)do table.insert(aa,ab)end
table.sort(aa);return aa
end

function G:Copy(aa)
aa=tostring(aa or"")
local ab={findGlobalFn("setclipboard"),findGlobalFn("toclipboard"),findGlobalFn("set_clipboard")}
for ac,ad in ipairs(ab)do
if type(ad)=="function"then
local ae=pcall(ad,aa)
if ae then return true end
end
end
return false
end


function G:Confirm(aa)
aa=aa or{}
if self._modalOpen then return end
self._modalOpen=true

local ab=new("TextButton",{
Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=1,BorderSizePixel=0,Text="",
AutoButtonColor=false,ZIndex=200,Parent=v,
})
tween(ab,{BackgroundTransparency=0.5},i.dur_med)

local ac=new("Frame",{
Size=UDim2.new(0,360,0,160),
Position=UDim2.new(0.5,-180,0.5,-80),
BorderSizePixel=0,ZIndex=201,Parent=v,
})
r.tag(ac,"BackgroundColor3","elevated")
corner(ac,i.radius_lg)
local ad=stroke(ac,nil,1);r.tag(ad,"Color","border")

local ae=new("TextLabel",{
Size=UDim2.new(1,-i.pad_lg*2,0,22),
Position=UDim2.new(0,i.pad_lg,0,i.pad_lg),
BackgroundTransparency=1,Text=aa.Title or"Confirm",
Font=i.font_medium,TextSize=i.text_md,
TextXAlignment=Enum.TextXAlignment.Left,ZIndex=202,Parent=ac,
})
r.tag(ae,"TextColor3","text")

local af=new("TextLabel",{
Size=UDim2.new(1,-i.pad_lg*2,0,60),
Position=UDim2.new(0,i.pad_lg,0,i.pad_lg+26),
BackgroundTransparency=1,Text=aa.Message or"Are you sure?",
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
TextWrapped=true,ZIndex=202,Parent=ac,
})
r.tag(af,"TextColor3","text_dim")

local ag=new("Frame",{
Size=UDim2.new(1,-i.pad_lg*2,0,28),
Position=UDim2.new(0,i.pad_lg,1,-i.pad_lg-28),
BackgroundTransparency=1,ZIndex=202,Parent=ac,
})
new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=ag,
})

local function close()
self._modalOpen=false
tween(ab,{BackgroundTransparency=1},i.dur_fast)
tween(ac,{Position=UDim2.new(0.5,-180,0.5,-90),BackgroundTransparency=1},i.dur_fast)
task.delay(i.dur_fast+0.05,function()
if ab.Parent then ab:Destroy()end
if ac.Parent then ac:Destroy()end
end)
end

local ah=new("TextButton",{
Size=UDim2.new(0,90,1,0),Text=aa.CancelText or"Cancel",
Font=i.font_medium,TextSize=i.text_xs,
AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=1,ZIndex=203,Parent=ag,
})
r.tag(ah,"BackgroundColor3","hover");r.tag(ah,"TextColor3","text")
corner(ah,i.radius_sm)

local ai=new("TextButton",{
Size=UDim2.new(0,110,1,0),Text=aa.ConfirmText or"Confirm",
Font=i.font_medium,TextSize=i.text_xs,
AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=2,ZIndex=203,Parent=ag,
})
r.tag(ai,"BackgroundColor3",aa.Destructive and"danger"or"accent")
r.tag(ai,"TextColor3","white")
corner(ai,i.radius_sm)

p:Add(ah.MouseButton1Click:Connect(function()safeCall(aa.OnCancel);close()end))
p:Add(ai.MouseButton1Click:Connect(function()safeCall(aa.OnConfirm);close()end))
p:Add(ab.MouseButton1Click:Connect(function()safeCall(aa.OnCancel);close()end))

ac.BackgroundTransparency=1
ac.Position=UDim2.new(0.5,-180,0.5,-90)
tween(ac,{BackgroundTransparency=0,Position=UDim2.new(0.5,-180,0.5,-80)},i.dur_slow)
end


function G:SetWatermark(aa)
if self._watermark then self._watermark:Destroy();self._watermark=nil end
if not aa then return nil end
local ab=aa.Text or"SupUI"
local ac,ad=aa.ShowFPS==true,aa.ShowPing==true

local ae=new("Frame",{
Name="Watermark",Size=UDim2.new(0,180,0,26),
Position=UDim2.new(0,10,0,10),BorderSizePixel=0,
AutomaticSize=Enum.AutomaticSize.X,ZIndex=80,Parent=v,
})
r.tag(ae,"BackgroundColor3","elevated");corner(ae,i.radius_sm)
local af=stroke(ae,nil,1);r.tag(af,"Color","border")
padding(ae,4,i.pad_sm,4,i.pad_sm)
new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=ae,
})
local ag=new("Frame",{Size=UDim2.new(0,5,0,5),BorderSizePixel=0,LayoutOrder=1,Parent=ae})
r.tag(ag,"BackgroundColor3","accent");corner(ag,3)
local ah=new("TextLabel",{
AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,Text=ab,
Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2,Parent=ae,
})
r.tag(ah,"TextColor3","text")

local ai,aj
if ac then
ai=new("TextLabel",{
AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,Text="fps —",
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=3,Parent=ae,
})
r.tag(ai,"TextColor3","text_dim")
end
if ad then
aj=new("TextLabel",{
AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,Text="ping —",
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=4,Parent=ae,
})
r.tag(aj,"TextColor3","text_dim")
end

local ak,al,R=0,0,os.clock()
local S=d.Heartbeat:Connect(function(S)
ak=ak+1;al=al+S
local T=os.clock()
if T-R>=0.25 then
local U=math.floor(ak/al+0.5)
if ai then ai.Text="fps "..U end
if aj then
local V,W=pcall(function()return h:GetNetworkPing()*1000 end)
aj.Text="ping "..(V and math.floor(W)or"—")
end
ak,al,R=0,0,T
end
end)
p:Add(S)

local T={}
function T:SetText(U)if ah then ah.Text=tostring(U)end end
function T:Destroy()
if S then pcall(function()S:Disconnect()end)end
if ae.Parent then ae:Destroy()end
end
self._watermark=T
return T
end
function G:ClearWatermark()
if self._watermark then self._watermark:Destroy();self._watermark=nil end
end

function G:Destroy()
p:Clear()
if self._watermark then pcall(function()self._watermark:Destroy()end);self._watermark=nil end
if u.Parent then u:Destroy()end
end





local function buildTab(aa,ab,ac,ad)
G._tabCount=G._tabCount+1
ad=ad or 0
ac=ac or G._tabCount

local ae=new("TextButton",{
Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,Text="",
AutoButtonColor=false,LayoutOrder=ac,Parent=N,
})
corner(ae,i.radius_sm)

local af=new("TextLabel",{
Size=UDim2.new(1,-8,1,0),
Position=UDim2.new(0,8+ad,0,0),
BackgroundTransparency=1,
Text=(ab and(ab.."  ")or"")..aa,
Font=i.font_medium,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=ae,
})
r.tag(af,"TextColor3","text_dim")

local ag=new("Frame",{
Size=UDim2.new(0,2,0,14),Position=UDim2.new(0,2,0.5,-7),
BorderSizePixel=0,Visible=false,Parent=ae,
})
r.tag(ag,"BackgroundColor3","accent");corner(ag,1)

local ah=new("ScrollingFrame",{
Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,
ScrollBarThickness=3,AutomaticCanvasSize=Enum.AutomaticSize.Y,
CanvasSize=UDim2.new(0,0,0,0),ScrollingDirection=Enum.ScrollingDirection.Y,
Visible=false,Parent=O,
})
r.tag(ah,"ScrollBarImageColor3","border")
padding(ah,i.pad_lg,i.pad_lg,i.pad_lg,i.pad_lg)

new("UIListLayout",{
Padding=UDim.new(0,i.pad_sm),
SortOrder=Enum.SortOrder.LayoutOrder,Parent=ah,
})

local function activate()
if G._activeTab then
local ai=G._activeTab
ai.label.TextColor3=r.get("text_dim")
ai.indicator.Visible=false;ai.page.Visible=false
tween(ai.btn,{BackgroundTransparency=1},i.dur_fast)
end
G._activeTab={btn=ae,label=af,indicator=ag,page=ah}
af.TextColor3=r.get("text")
ag.Visible=true;ah.Visible=true
ae.BackgroundColor3=r.get("hover")
tween(ae,{BackgroundTransparency=0.5},i.dur_fast)
end

p:Add(ae.MouseButton1Click:Connect(activate))
p:Add(ae.MouseEnter:Connect(function()
if G._activeTab and G._activeTab.btn==ae then return end
ae.BackgroundColor3=r.get("hover")
tween(ae,{BackgroundTransparency=0.7},i.dur_fast)
end))
p:Add(ae.MouseLeave:Connect(function()
if G._activeTab and G._activeTab.btn==ae then return end
tween(ae,{BackgroundTransparency=1},i.dur_fast)
end))

if not G._activeTab then activate()end

local ai=0
local function nextOrder()ai=ai+1;return ai end

local function makeCard(aj,ak)
local al=new("Frame",{
Size=UDim2.new(1,0,0,aj),BorderSizePixel=0,
LayoutOrder=nextOrder(),Parent=ak or ah,
})
r.tag(al,"BackgroundColor3","elevated")
corner(al,i.radius_md)
local R=stroke(al,nil,1);r.tag(R,"Color","border_soft")
return al,R
end

local function attachCommon(aj,ak,al)
al=al or{}
aj._frame=ak;aj._state=al
function aj:Destroy()
if self._frame then self._frame:Destroy();self._frame=nil end
end
function aj:SetVisible(R)if self._frame then self._frame.Visible=R end end
function aj:IsDisabled()return al.disabled==true end
function aj:SetDisabled(R)
if not self._frame then return end
al.disabled=R and true or false
for S,T in ipairs(self._frame:GetDescendants())do
if T:IsA("TextLabel")or T:IsA("TextButton")or T:IsA("TextBox")then
T.TextTransparency=R and 0.5 or 0
end
end
end
return aj
end

local aj={_page=ah,_btn=ae,_name=aa}


function aj:CreateSection(ak)
local al=new("Frame",{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,LayoutOrder=nextOrder(),Parent=ah})
local R=new("TextLabel",{
Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,4),
BackgroundTransparency=1,Text=ak:upper(),
Font=i.font_bold,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,Parent=al,
})
r.tag(R,"TextColor3","text_muted")
local S=new("Frame",{
Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-2),
BorderSizePixel=0,Parent=al,
})
r.tag(S,"BackgroundColor3","border_soft")
return attachCommon({SetText=function(T,U)R.Text=U:upper()end},al)
end

function aj:CreateDivider()
local ak=new("Frame",{Size=UDim2.new(1,0,0,1),BorderSizePixel=0,LayoutOrder=nextOrder(),Parent=ah})
r.tag(ak,"BackgroundColor3","border_soft")
return attachCommon({},ak)
end

function aj:CreateSpacer(ak)
local al=new("Frame",{Size=UDim2.new(1,0,0,ak or i.pad_sm),BackgroundTransparency=1,LayoutOrder=nextOrder(),Parent=ah})
return attachCommon({},al)
end

function aj:CreateLabel(ak,al)
local R,S=makeCard(30)
local T=new("TextLabel",{
Size=UDim2.new(1,-i.pad_md*2,1,0),
Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=ak,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,Parent=R,
})
r.tag(T,"TextColor3",al or"text")
return attachCommon({
SetText=function(U,V,W)
T.Text=V
if W then r.tag(T,"TextColor3",W)end
end,
},R)
end


function aj:CreateRichLabel(ak)
local al,R=makeCard(30)
local S=new("TextLabel",{
Size=UDim2.new(1,-i.pad_md*2,1,0),
Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,RichText=true,Text=ak or"",
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,
TextWrapped=false,
AutomaticSize=Enum.AutomaticSize.Y,Parent=al,
})
r.tag(S,"TextColor3","text")
return attachCommon({
SetText=function(T,U)S.Text=U end,
Get=function()return S.Text end,
},al)
end

function aj:CreateParagraph(ak)
ak=ak or{}
local al=ak.Title or""
local R=ak.Text or""
local S=al~=""

local T=new("Frame",{
Size=UDim2.new(1,0,0,40),BorderSizePixel=0,
LayoutOrder=nextOrder(),AutomaticSize=Enum.AutomaticSize.Y,Parent=ah,
})
r.tag(T,"BackgroundColor3","elevated")
corner(T,i.radius_md)
local U=stroke(T,nil,1);r.tag(U,"Color","border_soft")
padding(T,i.pad_md,i.pad_md,i.pad_md,i.pad_md)
new("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=T})

local V
if S then
V=new("TextLabel",{
Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=al,
Font=i.font_medium,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1,Parent=T,
})
r.tag(V,"TextColor3","text")
end

local W=new("TextLabel",{
Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,Text=R,
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,
LayoutOrder=2,Parent=T,
})
r.tag(W,"TextColor3","text_dim")

return attachCommon({
SetText=function(X,Y)W.Text=Y end,
SetTitle=function(X,Y)if V then V.Text=Y end end,
},T)
end


function aj:CreateButton(ak,al)
local R={}
local S,T=makeCard(34)
local U=new("TextButton",{
Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
Text=ak,Font=i.font_medium,TextSize=i.text_sm,
AutoButtonColor=false,Parent=S,
})
r.tag(U,"TextColor3","text")
p:Add(U.MouseEnter:Connect(function()
if R.disabled then return end
tween(S,{BackgroundColor3=r.get("hover")},i.dur_fast)
end))
p:Add(U.MouseLeave:Connect(function()
tween(S,{BackgroundColor3=r.get("elevated")},i.dur_fast)
end))
p:Add(U.MouseButton1Down:Connect(function()
if R.disabled then return end
tween(S,{BackgroundColor3=r.get("border_soft")},i.dur_fast/2)
end))
p:Add(U.MouseButton1Up:Connect(function()
tween(S,{BackgroundColor3=r.get("hover")},i.dur_fast)
end))
local V=al
p:Add(U.MouseButton1Click:Connect(function()
if R.disabled then return end
safeCall(V)
end))
return attachCommon({
SetText=function(W,X)U.Text=X end,
SetCallback=function(W,X)V=X end,
Fire=function()safeCall(V)end,
},S,R)
end


function aj:CreateToggle(ak)
ak=ak or{}
local al=ak.Name or"Toggle"
local R=ak.CurrentValue==true
local S=ak.Callback
local T=ak.Flag
local U={}

local V=makeCard(34)
local W=new("TextLabel",{
Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=V,
})
r.tag(W,"TextColor3","text")

local X=new("TextButton",{
Size=UDim2.new(0,32,0,18),Position=UDim2.new(1,-44,0.5,-9),
BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=V,
})
corner(X,9)
local Y=new("Frame",{
Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,2,0.5,-7),
BorderSizePixel=0,Parent=X,
})
r.tag(Y,"BackgroundColor3","white");corner(Y,7)

local function render()
X.BackgroundColor3=R and r.get("accent")or r.get("border")
tween(Y,{Position=R and UDim2.new(1,-16,0.5,-7)or UDim2.new(0,2,0.5,-7)},i.dur_fast)
end
render()

local function toggle()
if U.disabled then return end
R=not R;render()
safeCall(S,R)
end

p:Add(X.MouseButton1Click:Connect(toggle))
local Z=new("TextButton",{
Size=UDim2.new(1,-48,1,0),BackgroundTransparency=1,Text="",
AutoButtonColor=false,Parent=V,
})
p:Add(Z.MouseButton1Click:Connect(toggle))

local am=attachCommon({
Get=function()return R end,
Set=function(_,am,an)
R=am==true;render()
if not an and not G._loadingConfig then safeCall(S,R)end
end,
OnChanged=function(am,an)S=an end,
},V,U)

if T then
G:_registerConfig(T,
function()return R end,
function(an)am:Set(an,true)end
)
end
return am
end


function aj:CreateSlider(ak)
ak=ak or{}
local al=ak.Name or"Slider"
local am=ak.Min or 0
local an=ak.Max or 100
if an<=am then an=am+1 end
local R=math.max(ak.Increment or 1,0.0001)
local S=math.clamp(ak.Default or am,am,an)
local T=ak.Callback
local U=ak.Format or function(U)return tostring(U)end
local V=ak.Flag
local W={}

local X=makeCard(50)
local Y=new("TextLabel",{
Size=UDim2.new(0.7,-i.pad_md,0,18),
Position=UDim2.new(0,i.pad_md,0,i.pad_sm),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=X,
})
r.tag(Y,"TextColor3","text")
local Z=new("TextLabel",{
Size=UDim2.new(0.3,-i.pad_md,0,18),
Position=UDim2.new(0.7,0,0,i.pad_sm),
BackgroundTransparency=1,Text=U(S),
Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Right,Parent=X,
})
r.tag(Z,"TextColor3","text_dim")
local _=new("Frame",{
Size=UDim2.new(1,-i.pad_md*2,0,4),
Position=UDim2.new(0,i.pad_md,1,-16),
BorderSizePixel=0,Parent=X,
})
r.tag(_,"BackgroundColor3","border");corner(_,2)
local ao=new("Frame",{
Size=UDim2.new((S-am)/(an-am),0,1,0),BorderSizePixel=0,Parent=_,
})
r.tag(ao,"BackgroundColor3","accent");corner(ao,2)
local ap=new("TextButton",{
Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0.5,-8),
BackgroundTransparency=1,Text="",AutoButtonColor=false,Parent=_,
})

local function setVal(aq,ar)
aq=math.clamp(aq,am,an);aq=snap(aq,R);aq=math.clamp(aq,am,an)
S=aq
local as=(S-am)/(an-am)
ao.Size=UDim2.new(as,0,1,0);Z.Text=U(S)
if not ar and not G._loadingConfig then safeCall(T,S)end
end

local aq=false
local function updateFromInput(ar)
local as=math.clamp((ar.Position.X-_.AbsolutePosition.X)/_.AbsoluteSize.X,0,1)
setVal(am+(an-am)*as)
end
p:Add(ap.InputBegan:Connect(function(ar)
if W.disabled then return end
if ar.UserInputType==Enum.UserInputType.MouseButton1
or ar.UserInputType==Enum.UserInputType.Touch then
aq=true;updateFromInput(ar)
end
end))
q.onRelease(function()aq=false end)
q.onMove(function(ar)if aq then updateFromInput(ar)end end)

local ar=attachCommon({
Get=function()return S end,
Set=function(ar,as,at)setVal(as,at)end,
SetRange=function(ar,as,at)
am,an=as,math.max(at,as+1);setVal(S,true)
end,
OnChanged=function(ar,as)T=as end,
},X,W)

if V then
G:_registerConfig(V,
function()return S end,
function(as)ar:Set(tonumber(as)or S,true)end
)
end
return ar
end


function aj:CreateSlider2D(ak)
ak=ak or{}
local al=ak.Name or"2D Slider"
local am,an=ak.MinX or 0,ak.MaxX or 1
local ao,ap=ak.MinY or 0,ak.MaxY or 1
if an<=am then an=am+1 end
if ap<=ao then ap=ao+1 end
local aq=ak.Default or{x=(am+an)/2,y=(ao+ap)/2}
local ar=math.clamp(aq.x or aq[1]or am,am,an)
local as=math.clamp(aq.y or aq[2]or ao,ao,ap)
local at=ak.Callback
local R=ak.Flag
local S={}

local T=makeCard(120)
local U=new("TextLabel",{
Size=UDim2.new(0.6,-i.pad_md,0,16),
Position=UDim2.new(0,i.pad_md,0,6),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=T,
})
r.tag(U,"TextColor3","text")
local V=new("TextLabel",{
Size=UDim2.new(0.4,-i.pad_md,0,16),
Position=UDim2.new(0.6,0,0,6),
BackgroundTransparency=1,
Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Right,Parent=T,
})
r.tag(V,"TextColor3","text_dim")

local W=new("Frame",{
Size=UDim2.new(1,-i.pad_md*2,0,84),
Position=UDim2.new(0,i.pad_md,0,28),
BorderSizePixel=0,Parent=T,
})
r.tag(W,"BackgroundColor3","bg");corner(W,i.radius_sm)
local X=stroke(W,nil,1);r.tag(X,"Color","border_soft")

local Y=new("Frame",{
Size=UDim2.fromOffset(10,10),AnchorPoint=Vector2.new(0.5,0.5),
BorderSizePixel=0,Parent=W,
})
r.tag(Y,"BackgroundColor3","accent");corner(Y,5)

local Z=new("TextButton",{
Size=UDim2.fromScale(1,1),BackgroundTransparency=1,
Text="",AutoButtonColor=false,Parent=W,
})

local function render(_)
local au=(ar-am)/(an-am)
local av=1-(as-ao)/(ap-ao)
Y.Position=UDim2.fromScale(au,av)
V.Text=string.format("%.2f, %.2f",ar,as)
if not _ and not G._loadingConfig then
safeCall(at,{x=ar,y=as})
end
end
render(true)

local au=false
local function update(av)
local _=math.clamp((av.Position.X-W.AbsolutePosition.X)/W.AbsoluteSize.X,0,1)
local aw=math.clamp((av.Position.Y-W.AbsolutePosition.Y)/W.AbsoluteSize.Y,0,1)
ar=am+(an-am)*_
as=ao+(ap-ao)*(1-aw)
render(false)
end
p:Add(Z.InputBegan:Connect(function(av)
if S.disabled then return end
if av.UserInputType==Enum.UserInputType.MouseButton1
or av.UserInputType==Enum.UserInputType.Touch then
au=true;update(av)
end
end))
q.onRelease(function()au=false end)
q.onMove(function(av)if au then update(av)end end)

local av=attachCommon({
Get=function()return{x=ar,y=as}end,
Set=function(av,aw,_)
if type(aw)~="table"then return end
ar=math.clamp(aw.x or aw[1]or ar,am,an)
as=math.clamp(aw.y or aw[2]or as,ao,ap)
render(_)
end,
OnChanged=function(av,aw)at=aw end,
},T,S)

if R then
G:_registerConfig(R,
function()return{x=ar,y=as}end,
function(aw)av:Set(aw,true)end
)
end
return av
end


function aj:CreateTextBox(ak)
ak=ak or{}
local al=ak.Name or"Input"
local am=ak.CurrentValue or""
local an=ak.Placeholder or""
local ao=ak.Callback
local ap=ak.Flag
local aq=ak.Numeric==true

local ar=makeCard(34)
local as=new("TextLabel",{
Size=UDim2.new(0.45,0,1,0),Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=ar,
})
r.tag(as,"TextColor3","text")

local at=new("Frame",{
Size=UDim2.new(0.55,-i.pad_md,0,22),
Position=UDim2.new(0.45,0,0.5,-11),
BorderSizePixel=0,Parent=ar,
})
r.tag(at,"BackgroundColor3","bg")
corner(at,i.radius_sm)
local au=stroke(at,nil,1);r.tag(au,"Color","border")

local av=new("TextBox",{
Size=UDim2.new(1,-i.pad_sm*2,1,0),
Position=UDim2.new(0,i.pad_sm,0,0),
BackgroundTransparency=1,Text=tostring(am),PlaceholderText=an,
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=at,
})
r.tag(av,"TextColor3","text");r.tag(av,"PlaceholderColor3","text_muted")

p:Add(av.Focused:Connect(function()au.Color=r.get("accent")end))
p:Add(av.FocusLost:Connect(function(aw)
au.Color=r.get("border")
if aq then
local R=tonumber(av.Text)
if R then am=R;av.Text=tostring(R)
else av.Text=tostring(am)end
else
am=av.Text
end
if not G._loadingConfig then safeCall(ao,am,aw)end
end))

local aw=attachCommon({
Get=function()return am end,
Set=function(aw,R,S)
on=R==true;render()
if not G._loadingConfig then safeCall(ao,on)end
end,
OnChanged=function(aw,R)ao=R end,
},ar)

if ap then
G:_registerConfig(ap,
function()return am end,
function(R)aw:Set(R,true)end
)
end
return aw
end


local function createDropdownImpl(ak,al)
al=al or{}
local am=al.Name or"Dropdown"
local an=al.Options or{}
local ao=al.Callback
local ap=al.Flag
local aq={}

local ar
if ak then
ar={}
for as,at in ipairs(al.CurrentValues or{})do ar[at]=true end
else
ar={value=al.CurrentValue or an[1]}
end

local as=makeCard(34)
local at=new("TextLabel",{
Size=UDim2.new(0.45,0,1,0),Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=am,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=as,
})
r.tag(at,"TextColor3","text")
local au=new("TextLabel",{
Size=UDim2.new(0.55,-i.pad_md*2-16,1,0),
Position=UDim2.new(0.45,0,0,0),
BackgroundTransparency=1,Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Right,
TextTruncate=Enum.TextTruncate.AtEnd,Parent=as,
})
r.tag(au,"TextColor3","text_dim")
local av=new("TextLabel",{
Size=UDim2.new(0,14,1,0),
Position=UDim2.new(1,-i.pad_md-10,0,0),
BackgroundTransparency=1,Text="▾",
Font=i.font_regular,TextSize=i.text_xs,Parent=as,
})
r.tag(av,"TextColor3","text_muted")
local aw=new("TextButton",{
Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text="",
AutoButtonColor=false,ZIndex=2,Parent=as,
})

local R=new("Frame",{
Size=UDim2.new(0,100,0,0),BackgroundTransparency=0,BorderSizePixel=0,
Visible=false,ZIndex=60,Parent=P,
})
r.tag(R,"BackgroundColor3","elevated")
corner(R,i.radius_md)
local S=stroke(R,nil,1);r.tag(S,"Color","border")

local T=new("ScrollingFrame",{
Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,
ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollingDirection=Enum.ScrollingDirection.Y,ZIndex=61,Parent=R,
})
r.tag(T,"ScrollBarImageColor3","border")
padding(T,4,4,4,4)
new("UIListLayout",{Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder,Parent=T})

local U=24
local function formatValue()
if ak then
local V,W=0,{}
for X,Y in pairs(ar)do
if Y==true then V=V+1;W[#W+1]=X end
end
if V==0 then au.Text="None"
elseif V==1 then au.Text=W[1]
else au.Text=V.." selected"end
return W
else
au.Text=tostring(ar.value or"—")
return ar.value
end
end
local function fireCallback()
if G._loadingConfig then return end
if ak then
local V={}
for W,X in pairs(ar)do if X==true then V[#V+1]=W end end
safeCall(ao,V)
else
safeCall(ao,ar.value)
end
end

local V=false
local W={}
local function closeMenu()V=false;R.Visible=false;av.Rotation=0 end
local function positionMenu()
local X=as.AbsolutePosition;local Y=as.AbsoluteSize
local Z=u.AbsoluteSize
local _=w.Scale;if _==0 then _=1 end
local ax=math.min(#an,7)
local ay=(ax*(U+2)+8);local az=Y.X/_
local aA=X.Y+Y.Y+(ay*_)+8
local aB=aA<Z.Y
local aC=aB and(X.Y+Y.Y+4)or(X.Y-ay*_-4)
R.Position=UDim2.fromOffset(X.X/_,aC/_)
R.Size=UDim2.fromOffset(az,ay)
end
local function rebuildItems()
for ax,ay in ipairs(W)do ay:Destroy()end
W={}
for ax,ay in ipairs(an)do
local az=new("TextButton",{
Size=UDim2.new(1,0,0,U),BackgroundTransparency=1,
Text="",AutoButtonColor=false,LayoutOrder=ax,
ZIndex=62,Parent=T,
})
corner(az,i.radius_sm)
local aA=new("TextLabel",{
Size=UDim2.new(1,-8,1,0),Position=UDim2.new(0,8,0,0),
BackgroundTransparency=1,Text=tostring(ay),
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,ZIndex=63,Parent=az,
})
local function refreshItemColors()
local aB=ak and ar[ay]==true or ar.value==ay
aA.TextColor3=aB and r.get("accent")or r.get("text")
end
refreshItemColors()
p:Add(az.MouseEnter:Connect(function()
az.BackgroundColor3=r.get("hover");az.BackgroundTransparency=0
end))
p:Add(az.MouseLeave:Connect(function()az.BackgroundTransparency=1 end))
p:Add(az.MouseButton1Click:Connect(function()
if ak then
ar[ay]=not ar[ay]or nil
else
ar.value=ay;closeMenu()
end
formatValue()
for aB,aC in ipairs(W)do
local X=aC:FindFirstChildOfClass("TextLabel")
if X then
local Y=ak and ar[X.Text]==true or ar.value==X.Text
X.TextColor3=Y and r.get("accent")or r.get("text")
end
end
fireCallback()
end))
table.insert(W,az)
end
end
rebuildItems();formatValue()

p:Add(aw.MouseButton1Click:Connect(function()
if aq.disabled then return end
V=not V
if V then positionMenu();R.Visible=true;av.Rotation=180
else closeMenu()end
end))

q.onAnyClick(function(ax)
if not V then return end
local ay=ax.Position
if not isPointInside(ay,R.AbsolutePosition,R.AbsoluteSize)
and not isPointInside(ay,as.AbsolutePosition,as.AbsoluteSize)then
closeMenu()
end
end)

p:Add(z.AncestryChanged:Connect(function()
if not z:IsDescendantOf(game)then
if R.Parent then R:Destroy()end
end
end))

local ax
if ak then
ax=attachCommon({
Get=function()
local ay={}
for az,aA in pairs(ar)do if aA==true then ay[#ay+1]=az end end
return ay
end,
Set=function(ay,az,aA)
ar={}
for aB,aC in ipairs(az or{})do ar[aC]=true end
formatValue();rebuildItems()
if not aA and not G._loadingConfig then fireCallback()end
end,
Refresh=function(ay,az)

local aA={}
for aB,aC in ipairs(az or{})do
if ar[aC]==true then aA[aC]=true end
end
ar=aA
an=az or{}
rebuildItems();formatValue()
end,
OnChanged=function(ay,az)ao=az end,
},as,aq)
else
ax=attachCommon({
Get=function()return ar.value end,
Set=function(ay,az,aA)
ar.value=az;formatValue();rebuildItems()
if not aA and not G._loadingConfig then fireCallback()end
end,
Refresh=function(ay,az)
an=az or{}
if not table.find(an,ar.value)then ar.value=an[1]end
rebuildItems();formatValue()
end,
OnChanged=function(ay,az)ao=az end,
},as,aq)
end

if ap then
G:_registerConfig(ap,
function()return ax:Get()end,
function(ay)ax:Set(ay,true)end
)
end
return ax
end
function aj:CreateDropdown(ak)return createDropdownImpl(false,ak)end
function aj:CreateMultiDropdown(ak)return createDropdownImpl(true,ak)end


function aj:CreateColorPicker(ak)
ak=ak or{}
local al=ak.Name or"Color"
local am=ak.CurrentColor or r.get("accent")
local an=ak.Callback
local ao=ak.Flag
local ap,aq,ar=Color3.toHSV(am)
local as={}

local at=makeCard(34)
local au=new("TextLabel",{
Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=at,
})
r.tag(au,"TextColor3","text")
local av=new("TextButton",{
Size=UDim2.new(0,22,0,22),Position=UDim2.new(1,-i.pad_md-22,0.5,-11),
BorderSizePixel=0,BackgroundColor3=am,Text="",
AutoButtonColor=false,Parent=at,
})
corner(av,i.radius_sm)
local aw=stroke(av,nil,1);r.tag(aw,"Color","border")

local ax=new("Frame",{
Size=UDim2.fromOffset(200,180),BackgroundTransparency=0,
BorderSizePixel=0,Visible=false,ZIndex=60,Parent=P,
})
r.tag(ax,"BackgroundColor3","elevated");corner(ax,i.radius_md)
local ay=stroke(ax,nil,1);r.tag(ay,"Color","border")
padding(ax,i.pad_sm,i.pad_sm,i.pad_sm,i.pad_sm)

local az=new("Frame",{
Size=UDim2.new(1,0,0,110),BackgroundColor3=Color3.fromHSV(ap,1,1),
BorderSizePixel=0,ZIndex=61,Parent=ax,
})
corner(az,i.radius_sm)
new("UIGradient",{
Color=ColorSequence.new(Color3.new(1,1,1)),
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1),
}),
Rotation=0,Parent=az,
})
local aA=new("Frame",{
Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),
BorderSizePixel=0,ZIndex=62,Parent=az,
})
corner(aA,i.radius_sm)
new("UIGradient",{
Color=ColorSequence.new(Color3.new(0,0,0)),
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0),
}),
Rotation=90,Parent=aA,
})
local aB=new("Frame",{
Size=UDim2.fromOffset(10,10),AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(aq,1-ar),
BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=63,Parent=az,
})
corner(aB,5);stroke(aB,Color3.new(0,0,0),1)

local aC=new("Frame",{
Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,0,118),
BorderSizePixel=0,ZIndex=61,Parent=ax,
})
corner(aC,4)
new("UIGradient",{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0.00,Color3.fromRGB(255,0,0)),
ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),
ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),
ColorSequenceKeypoint.new(0.50,Color3.fromRGB(0,255,255)),
ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)),
ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),
ColorSequenceKeypoint.new(1.00,Color3.fromRGB(255,0,0)),
}),
Rotation=0,Parent=aC,
})
local R=new("Frame",{
Size=UDim2.new(0,4,1,4),AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(ap,0.5),
BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=62,Parent=aC,
})
corner(R,2);stroke(R,Color3.new(0,0,0),1)

local S=new("TextBox",{
Size=UDim2.new(1,0,0,22),Position=UDim2.new(0,0,0,140),
BorderSizePixel=0,Text=string.format("#%02X%02X%02X",am.R*255,am.G*255,am.B*255),
Font=i.font_medium,TextSize=i.text_xs,
ClearTextOnFocus=false,ZIndex=61,Parent=ax,
})
r.tag(S,"BackgroundColor3","bg");r.tag(S,"TextColor3","text_dim")
corner(S,i.radius_sm)

local function apply(T)
am=Color3.fromHSV(ap,aq,ar)
av.BackgroundColor3=am
az.BackgroundColor3=Color3.fromHSV(ap,1,1)
aB.Position=UDim2.fromScale(aq,1-ar)
R.Position=UDim2.fromScale(ap,0.5)
S.Text=string.format("#%02X%02X%02X",am.R*255,am.G*255,am.B*255)
if not T and not G._loadingConfig then safeCall(an,am)end
end

local function hexToColor(T)
T=T:gsub("#","")
if#T~=6 then return nil end
local U=tonumber(T:sub(1,2),16)
local V=tonumber(T:sub(3,4),16)
local W=tonumber(T:sub(5,6),16)
if U and V and W then return Color3.fromRGB(U,V,W)end
return nil
end

p:Add(S.FocusLost:Connect(function()
local T=hexToColor(S.Text)
if T then ap,aq,ar=Color3.toHSV(T);apply(false)
else apply(true)end
end))

local T,U=false,false
local function svInput(V)
local W=math.clamp((V.Position.X-az.AbsolutePosition.X)/az.AbsoluteSize.X,0,1)
local X=math.clamp((V.Position.Y-az.AbsolutePosition.Y)/az.AbsoluteSize.Y,0,1)
aq=W;ar=1-X;apply(false)
end
local function hueInput(V)
local W=math.clamp((V.Position.X-aC.AbsolutePosition.X)/aC.AbsoluteSize.X,0,1)
ap=W;apply(false)
end
p:Add(az.InputBegan:Connect(function(V)
if V.UserInputType==Enum.UserInputType.MouseButton1
or V.UserInputType==Enum.UserInputType.Touch then
T=true;svInput(V)
end
end))
p:Add(aC.InputBegan:Connect(function(V)
if V.UserInputType==Enum.UserInputType.MouseButton1
or V.UserInputType==Enum.UserInputType.Touch then
U=true;hueInput(V)
end
end))
q.onRelease(function()T=false;U=false end)
q.onMove(function(V)
if T then svInput(V)end
if U then hueInput(V)end
end)

local V=false
local function positionPanel()
local W=at.AbsolutePosition;local X=at.AbsoluteSize
local Y=u.AbsoluteSize
local Z=w.Scale;if Z==0 then Z=1 end
local _=172
local aD=W.Y+X.Y+(_*Z)+8
local aE=aD<Y.Y
local aF=aE and(W.Y+X.Y+4)or(W.Y-_*Z-4)
local aG=math.min(W.X,Y.X-208*Z)
ax.Position=UDim2.fromOffset(aG/Z,aF/Z)
end
p:Add(av.MouseButton1Click:Connect(function()
if as.disabled then return end
V=not V
if V then positionPanel();ax.Visible=true
else ax.Visible=false end
end))
q.onAnyClick(function(aD)
if not V then return end
local aE=aD.Position
if not isPointInside(aE,ax.AbsolutePosition,ax.AbsoluteSize)
and not isPointInside(aE,at.AbsolutePosition,at.AbsoluteSize)then
V=false;ax.Visible=false
end
end)

local aD=attachCommon({
Get=function()return am end,
Set=function(aD,aE,aF)
if typeof(aE)~="Color3"then return end
ap,aq,ar=Color3.toHSV(aE);apply(aF)
end,
OnChanged=function(aD,aE)an=aE end,
},at,as)

if ao then
G:_registerConfig(ao,
function()
return{r=clamp01(am.R),g=clamp01(am.G),b=clamp01(am.B)}
end,
function(aE)
if type(aE)=="table"then
local aF=clamp01(aE.r or aE[1]or 0)
local aG=clamp01(aE.g or aE[2]or 0)
local W=clamp01(aE.b or aE[3]or 0)
aD:Set(Color3.new(aF,aG,W),true)
end
end
)
end
return aD
end


function aj:CreateKeybind(ak)
ak=ak or{}
local al=ak.Name or"Keybind"
local am=ak.CurrentKey or Enum.KeyCode.RightShift
local an=ak.Callback
local ao=ak.Flag
local ap={}

local aq=makeCard(34)
local ar=new("TextLabel",{
Size=UDim2.new(0.6,0,1,0),Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=aq,
})
r.tag(ar,"TextColor3","text")
local as=new("TextButton",{
Size=UDim2.new(0,80,0,22),
Position=UDim2.new(1,-i.pad_md-80,0.5,-11),
BorderSizePixel=0,Text=am.Name,
Font=i.font_medium,TextSize=i.text_xs,
AutoButtonColor=false,Parent=aq,
})
r.tag(as,"BackgroundColor3","bg");r.tag(as,"TextColor3","text_dim")
corner(as,i.radius_sm)
local at=stroke(as,nil,1);r.tag(at,"Color","border")

local au={_key=am,_cb=an,_listening=false}
table.insert(G._keybinds,au)

p:Add(as.MouseButton1Click:Connect(function()
if ap.disabled or au._listening then return end
au._listening=true
as.Text="...";at.Color=r.get("accent")
end))
p:Add(c.InputBegan:Connect(function(av,aw)
if not au._listening then return end
if av.UserInputType==Enum.UserInputType.Keyboard then
if av.KeyCode==Enum.KeyCode.Escape then
au._listening=false
as.Text=au._key.Name
at.Color=r.get("border")
return
end
au._key=av.KeyCode
au._listening=false
as.Text=av.KeyCode.Name
at.Color=r.get("border")
end
end))

local av=attachCommon({
Get=function()return au._key end,
Set=function(av,aw)
if typeof(aw)=="EnumItem"then
au._key=aw;as.Text=aw.Name
end
end,
OnChanged=function(av,aw)au._cb=aw;an=aw end,
Fire=function()safeCall(au._cb,au._key)end,
},aq,ap)

if ao then
G:_registerConfig(ao,
function()return au._key.Name end,
function(aw)
local ax,ay=pcall(function()return Enum.KeyCode[tostring(aw)]end)
if ax and ay then av:Set(ay)end
end
)
end
return av
end


function aj:CreateList(ak)
ak=ak or{}
local al=ak.Items or{}
local am=ak.OnSelect
local an=ak.Multi==true
local ao=ak.Name
local ap=26
local aq=math.min(#al,ak.MaxVisible or 6)
local ar=math.max(aq,1)*(ap+2)+8
local as=ar+(ao and 22 or 0)+10
local at={}

local au=makeCard(as)
if ao then
local av=new("TextLabel",{
Size=UDim2.new(1,-i.pad_md*2,0,14),
Position=UDim2.new(0,i.pad_md,0,6),
BackgroundTransparency=1,Text=ao:upper(),
Font=i.font_bold,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,Parent=au,
})
r.tag(av,"TextColor3","text_muted")
end
local av=new("ScrollingFrame",{
Size=UDim2.new(1,-i.pad_sm,0,ar),
Position=UDim2.new(0,i.pad_sm/2,0,ao and 24 or 4),
BackgroundTransparency=1,BorderSizePixel=0,
ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize=Enum.AutomaticSize.Y,Parent=au,
})
r.tag(av,"ScrollBarImageColor3","border")
new("UIListLayout",{Padding=UDim.new(0,2),Parent=av})
padding(av,2,4,2,4)

local aw={}
local ax={}
local function render()
for ay,az in ipairs(ax)do
local aA=aw[ay]==true
az.BackgroundTransparency=aA and 0 or 1
az.BackgroundColor3=aA and r.get("hover")or r.get("elevated")
local aB=az:FindFirstChildOfClass("TextLabel")
if aB then
aB.TextColor3=aA and r.get("accent")or r.get("text")
end
end
end
local function buildItems()
for ay,az in ipairs(ax)do az:Destroy()end
ax={};aw={}
for ay,az in ipairs(al)do
local aA=new("TextButton",{
Size=UDim2.new(1,0,0,ap),BackgroundTransparency=1,
Text="",AutoButtonColor=false,LayoutOrder=ay,Parent=av,
})
corner(aA,i.radius_sm)
local aB=new("TextLabel",{
Size=UDim2.new(1,-i.pad_sm*2,1,0),
Position=UDim2.new(0,i.pad_sm,0,0),
BackgroundTransparency=1,Text=tostring(az),
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,Parent=aA,
})
r.tag(aB,"TextColor3","text")
p:Add(aA.MouseButton1Click:Connect(function()
if at.disabled then return end
if an then
aw[ay]=not aw[ay]or nil
local aC={}
for aD,aE in pairs(aw)do
if aE==true then aC[#aC+1]=al[aD]end
end
render();safeCall(am,aC)
else
aw={};aw[ay]=true
render();safeCall(am,al[ay],ay)
end
end))
table.insert(ax,aA)
end
render()
end
buildItems()
return attachCommon({
Get=function()
if an then
local ay={}
for az,aA in pairs(aw)do
if aA==true then ay[#ay+1]=al[az]end
end
return ay
else
for ay in pairs(aw)do return al[ay]end
return nil
end
end,
Refresh=function(ay,az)al=az or{};buildItems()end,
OnSelect=function(ay,az)am=az end,
},au,at)
end


function aj:CreateProgressBar(ak)
ak=ak or{}
local al=ak.Name or"Progress"
local am=math.clamp(ak.Value or 0,0,100)
local an=ak.Color
local ao=makeCard(44)
local ap=new("TextLabel",{
Size=UDim2.new(0.7,0,0,16),
Position=UDim2.new(0,i.pad_md,0,6),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=ao,
})
r.tag(ap,"TextColor3","text")
local aq=new("TextLabel",{
Size=UDim2.new(0.3,-i.pad_md,0,16),
Position=UDim2.new(0.7,0,0,6),
BackgroundTransparency=1,Text=math.floor(am).."%",
Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Right,Parent=ao,
})
r.tag(aq,"TextColor3","text_dim")
local ar=new("Frame",{
Size=UDim2.new(1,-i.pad_md*2,0,6),
Position=UDim2.new(0,i.pad_md,1,-16),
BorderSizePixel=0,Parent=ao,
})
r.tag(ar,"BackgroundColor3","border_soft");corner(ar,3)
local as=new("Frame",{
Size=UDim2.new(am/100,0,1,0),BorderSizePixel=0,Parent=ar,
})
if typeof(an)=="Color3"then as.BackgroundColor3=an
else r.tag(as,"BackgroundColor3","accent")end
corner(as,3)
return attachCommon({
Get=function()return am end,
Set=function(at,au)
am=math.clamp(au,0,100)
tween(as,{Size=UDim2.new(am/100,0,1,0)},i.dur_med)
aq.Text=math.floor(am).."%"
end,
},ao)
end


function aj:CreateSearchBar(ak)
ak=ak or{}
local al=ak.Placeholder or"Search..."
local am=ak.Callback
local an={}

local ao=new("Frame",{
Size=UDim2.new(1,0,0,30),BorderSizePixel=0,
LayoutOrder=nextOrder(),Parent=ah,
})
r.tag(ao,"BackgroundColor3","bg");corner(ao,i.radius_md)
local ap=stroke(ao,nil,1);r.tag(ap,"Color","border")
local aq=new("TextLabel",{
Size=UDim2.fromOffset(20,20),Position=UDim2.new(0,8,0.5,-10),
BackgroundTransparency=1,Text="⌕",
Font=i.font_regular,TextSize=i.text_md,Parent=ao,
})
r.tag(aq,"TextColor3","text_muted")
local ar=new("TextBox",{
Size=UDim2.new(1,-36,1,0),Position=UDim2.new(0,30,0,0),
BackgroundTransparency=1,Text="",PlaceholderText=al,
Font=i.font_regular,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=ao,
})
r.tag(ar,"TextColor3","text");r.tag(ar,"PlaceholderColor3","text_muted")
p:Add(ar.Focused:Connect(function()ap.Color=r.get("accent")end))
p:Add(ar.FocusLost:Connect(function()ap.Color=r.get("border")end))
local function doFilter(as)
as=as:lower()
for at,au in ipairs(an)do
if au._frame and au._searchText then
local av=as==""or au._searchText:lower():find(as,1,true)~=nil
au._frame.Visible=av
end
end
safeCall(am,as)
end
p:Add(ar:GetPropertyChangedSignal("Text"):Connect(function()doFilter(ar.Text)end))
return attachCommon({
Get=function()return ar.Text end,
Set=function(as,at)ar.Text=at or""end,
Attach=function(as,at,au)
if at then
at._searchText=au or""
table.insert(an,at)
end
end,
Clear=function()ar.Text=""end,
},ao)
end


function aj:CreateImage(ak)
ak=ak or{}
local al=(ak.Size and ak.Size.Y)or 120
local am=makeCard(al+4)
local an=new("ImageLabel",{
Size=UDim2.new(1,-i.pad_md*2,1,-i.pad_sm),
Position=UDim2.new(0,i.pad_md,0,i.pad_sm/2),
BackgroundTransparency=1,Image=ak.Image or"",
ScaleType=ak.ScaleType or Enum.ScaleType.Fit,Parent=am,
})
corner(an,i.radius_sm)
return attachCommon({
SetImage=function(ao,ap)an.Image=ap end,
Get=function()return an.Image end,
},am)
end


function aj:CreateVideo(ak)
ak=ak or{}
local al=(ak.Size and ak.Size.Y)or 200
local am=makeCard(al+4)
local an=new("VideoFrame",{
Size=UDim2.new(1,-i.pad_md*2,1,-i.pad_sm),
Position=UDim2.new(0,i.pad_md,0,i.pad_sm/2),
BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0,
Video=ak.Video or"",Looped=ak.Looped==true,
Volume=ak.Volume or 0.5,Parent=am,
})
corner(an,i.radius_sm)
if ak.AutoPlay then an.Playing=true end
return attachCommon({
Play=function()an.Playing=true end,
Pause=function()an.Playing=false end,
SetVideo=function(ao,ap)an.Video=ap end,
},am)
end


function aj:CreateCodeBox(ak)
ak=ak or{}
local al=ak.Name or"Code"
local am=ak.Language or"lua"
local an=ak.Code or""
local ao=ak.Callback
local ap=ak.Flag

local aq=makeCard(160)
local ar=new("TextLabel",{
Size=UDim2.new(0.6,0,0,16),
Position=UDim2.new(0,i.pad_md,0,6),
BackgroundTransparency=1,Text=al,
Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,Parent=aq,
})
r.tag(ar,"TextColor3","text")
local as=new("TextLabel",{
Size=UDim2.new(0.4,-i.pad_md,0,16),
Position=UDim2.new(0.6,0,0,6),
BackgroundTransparency=1,Text=am,
Font=i.font_mono,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Right,Parent=aq,
})
r.tag(as,"TextColor3","accent")

local at=new("Frame",{
Size=UDim2.new(1,-i.pad_md*2,1,-34),
Position=UDim2.new(0,i.pad_md,0,28),
BorderSizePixel=0,Parent=aq,
})
r.tag(at,"BackgroundColor3","bg")
corner(at,i.radius_sm)
local au=stroke(at,nil,1);r.tag(au,"Color","border_soft")

local av=new("ScrollingFrame",{
Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,
ScrollBarThickness=3,CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize=Enum.AutomaticSize.XY,Parent=at,
})
r.tag(av,"ScrollBarImageColor3","border")

local aw=new("TextBox",{
Size=UDim2.new(1,-8,1,-8),Position=UDim2.new(0,4,0,4),
BackgroundTransparency=1,Text=an,
Font=i.font_mono,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
MultiLine=true,ClearTextOnFocus=false,
AutomaticSize=Enum.AutomaticSize.XY,Parent=av,
})
r.tag(aw,"TextColor3","text")

p:Add(aw.Focused:Connect(function()au.Color=r.get("accent")end))
p:Add(aw.FocusLost:Connect(function()
au.Color=r.get("border_soft")
an=aw.Text
if not G._loadingConfig then safeCall(ao,an)end
end))

local ax=attachCommon({
Get=function()return aw.Text end,
Set=function(ax,ay,az)
an=tostring(ay or"");aw.Text=an
if not az and not G._loadingConfig then safeCall(ao,an)end
end,
},aq)

if ap then
G:_registerConfig(ap,
function()return aw.Text end,
function(ay)ax:Set(ay,true)end)
end
return ax
end


function aj:CreateDatePicker(ak)
ak=ak or{}
local al=ak.Name or"Date"
local am=ak.CurrentValue or os.date("%Y-%m-%d")
local an=ak.Callback
local ao=ak.Flag

local ap=makeCard(34)
local aq=new("TextLabel",{
Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0,i.pad_md,0,0),
BackgroundTransparency=1,Text=al,
Font=i.font_regular,TextSize=i.text_sm,
TextXAlignment=Enum.TextXAlignment.Left,Parent=ap,
})
r.tag(aq,"TextColor3","text")

local ar=new("Frame",{
Size=UDim2.new(0,110,0,22),
Position=UDim2.new(1,-i.pad_md-110,0.5,-11),
BorderSizePixel=0,Parent=ap,
})
r.tag(ar,"BackgroundColor3","bg")
corner(ar,i.radius_sm)
local as=stroke(ar,nil,1);r.tag(as,"Color","border")

local at=new("TextBox",{
Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),
BackgroundTransparency=1,Text=am,PlaceholderText="YYYY-MM-DD",
Font=i.font_mono,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Center,
ClearTextOnFocus=false,Parent=ar,
})
r.tag(at,"TextColor3","text");r.tag(at,"PlaceholderColor3","text_muted")

local function valid(au)
local av,aw,ax=au:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
if not av then return false end
aw,ax=tonumber(aw),tonumber(ax)
return aw>=1 and aw<=12 and ax>=1 and ax<=31
end

p:Add(at.Focused:Connect(function()as.Color=r.get("accent")end))
p:Add(at.FocusLost:Connect(function()
as.Color=r.get("border")
if valid(at.Text)then
am=at.Text
if not G._loadingConfig then safeCall(an,am)end
else
at.Text=am
end
end))

local au=attachCommon({
Get=function()return am end,
Set=function(au,av,aw)
if type(av)=="string"and valid(av)then
am=av;at.Text=av
if not aw and not G._loadingConfig then safeCall(an,am)end
end
end,
},ap)
if ao then
G:_registerConfig(ao,
function()return am end,
function(av)au:Set(av,true)end)
end
return au
end


function aj:CreateChart(ak)
ak=ak or{}
local al=ak.Name or"Chart"
local am=ak.Type or"line"
local an=ak.MaxPoints or 60
local ao=ak.Data or{}

local ap=makeCard(140)
local aq=new("TextLabel",{
Size=UDim2.new(1,-i.pad_md*2,0,16),
Position=UDim2.new(0,i.pad_md,0,6),
BackgroundTransparency=1,Text=al,
Font=i.font_medium,TextSize=i.text_xs,
TextXAlignment=Enum.TextXAlignment.Left,Parent=ap,
})
r.tag(aq,"TextColor3","text")

local ar=new("Frame",{
Size=UDim2.new(1,-i.pad_md*2,1,-34),
Position=UDim2.new(0,i.pad_md,0,28),
BorderSizePixel=0,Parent=ap,
})
r.tag(ar,"BackgroundColor3","bg");corner(ar,i.radius_sm)
local as=stroke(ar,nil,1);r.tag(as,"Color","border_soft")

local function render()
for at,au in ipairs(ar:GetChildren())do
if au:IsA("Frame")and au.Name=="DataNode"then au:Destroy()end
end
if#ao==0 then return end
local at,au=math.huge,-math.huge
for av,aw in ipairs(ao)do
if aw<at then at=aw end
if aw>au then au=aw end
end
if au==at then au=at+1 end
local av=#ao
if am=="bar"then
for aw,ax in ipairs(ao)do
local ay=(ax-at)/(au-at)
local az=1/av
local aA=new("Frame",{
Name="DataNode",
Size=UDim2.new(az*0.85,0,ay,-2),
Position=UDim2.new((aw-1)*az+az*0.075,0,1,-2),
AnchorPoint=Vector2.new(0,1),
BorderSizePixel=0,Parent=ar,
})
r.tag(aA,"BackgroundColor3","accent")
corner(aA,2)
end
else
for aw=1,av-1 do
local ax,ay=ao[aw],ao[aw+1]
local az=(ax-at)/(au-at)
local aA=(ay-at)/(au-at)
local aB=(aw-1)/(av-1)
local aC=aw/(av-1)
local aD=1-az
local aE=1-aA
local aF=(aC-aB)*ar.AbsoluteSize.X
local aG=(aE-aD)*ar.AbsoluteSize.Y
local R=math.sqrt(aF*aF+aG*aG)
local S=math.deg(math.atan2(aG,aF))
local T=new("Frame",{
Name="DataNode",
Size=UDim2.new(0,R,0,2),
Position=UDim2.new(aB,0,aD,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,Rotation=S,Parent=ar,
})
r.tag(T,"BackgroundColor3","accent")
end
end
end
render()
p:Add(ar:GetPropertyChangedSignal("AbsoluteSize"):Connect(render))

return attachCommon({
Push=function(at,au)
table.insert(ao,au)
while#ao>an do table.remove(ao,1)end
render()
end,
Set=function(at,au)ao=au or{};render()end,
Get=function()return ao end,
Clear=function()ao={};render()end,
},ap)
end

return aj
end





function G:CreateTab(aa,ab)
return buildTab(aa,ab,self._tabCount+1,0)
end

function G:CreateTabGroup(aa)
local ab=new("Frame",{
Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,
LayoutOrder=self._tabCount+1,Parent=N,
})
local ac=new("TextLabel",{
Size=UDim2.new(1,-8,1,0),Position=UDim2.new(0,8,0,0),
BackgroundTransparency=1,Text=aa:upper(),
Font=i.font_bold,TextSize=10,
TextXAlignment=Enum.TextXAlignment.Left,Parent=ab,
})
r.tag(ac,"TextColor3","text_muted")
self._tabCount=self._tabCount+1
local ad={}
function ad:CreateTab(ae,af)
return buildTab(ae,af,G._tabCount+1,12)
end
return ad
end





function G:AddConfigTab(aa,ab)
ab=ab or{}
if self._configTabBuilt and not ab.Force then return end
self._configTabBuilt=true
local ac=buildTab(aa or"Configs","💾",i.config_tab_order,0)
self:_buildConfigUI(ac)
return ac
end

function G:_buildConfigUI(aa)
aa:CreateSection("Configs")

if not self._config.available then
aa:CreateLabel("File I/O unavailable in this executor.","warning")
aa:CreateParagraph({
Title="Why?",
Text="Your executor doesn't expose writefile/readfile/isfile in a reachable global scope. SupUI checks _G, getfenv(0), getgenv(), and shared. If none expose it, configs can't persist.",
})
return
end

local ab=aa:CreateTextBox({
Name="Config name",
Placeholder=self._defaultConfigName,
CurrentValue=self._defaultConfigName,
})

local ac=aa:CreateLabel("Saved: (refresh to load)","text_dim")
local function refreshList()
local ad=self:ListConfigs()
if#ad==0 then
ac:SetText("Saved: (none)","text_muted")
else
ac:SetText("Saved: "..table.concat(ad,", "),"text_dim")
end
end
refreshList()

aa:CreateButton("Save current config",function()
local ad=sanitizeName(ab:Get(),self._defaultConfigName)
local ae,af=self:SaveConfig(ad)
self:Notify({
Title=ae and"Config saved"or"Save failed",
Message=ae and("'"..ad.."' written to disk")or("Error: "..tostring(af)),
Type=ae and"success"or"error",
})
refreshList()
end)

aa:CreateButton("Load config",function()
local ad=sanitizeName(ab:Get(),self._defaultConfigName)
local ae,af=self:LoadConfig(ad)
self:Notify({
Title=ae and"Config loaded"or"Load failed",
Message=ae and("'"..ad.."' applied")or("Error: "..tostring(af)),
Type=ae and"success"or"error",
})
end)

aa:CreateButton("Delete config",function()
local ad=sanitizeName(ab:Get(),self._defaultConfigName)
self:Confirm({
Title="Delete '"..ad.."'?",
Message="This permanently deletes the config file from disk.",
Destructive=true,
ConfirmText="Delete",
OnConfirm=function()
self:DeleteConfig(ad)
self:Notify({Title="Deleted",Message="'"..ad.."' removed",Type="info"})
refreshList()
end,
})
end)

aa:CreateButton("Refresh list",refreshList)
end





function G:AddSettingsTab(aa)
if self._settingsTabBuilt then return end
self._settingsTabBuilt=true

local ab=buildTab(aa or"Settings","⚙",i.settings_tab_order,0)


ab:CreateSection("Anti-AFK")
ab:CreateToggle({
Name="Anti-AFK enabled",
CurrentValue=a:IsAntiAFKEnabled(),
Callback=function(ac)
if ac then a:EnableAntiAFK()else a:DisableAntiAFK()end
end,
})
ab:CreateParagraph({
Text="Hooks Player.Idled and resets the idle timer via VirtualUser. Falls back to a small camera nudge if VirtualUser is unavailable.",
})


ab:CreateSection("Appearance")
ab:CreateDropdown({
Name="Theme preset",
Options=self:ListThemes(),
CurrentValue=self._themeName,
Callback=function(ac)self:ApplyTheme(ac)end,
})
ab:CreateColorPicker({
Name="Accent color",
CurrentColor=self._theme.get("accent"),
Callback=function(ac)self:SetTheme({accent=ac})end,
})

local ac,ad
ac=ab:CreateToggle({
Name="Auto-scale to viewport",
CurrentValue=(k.AutoScale~=false)and not k.Scale,
Callback=function(ae)
if ae then self:EnableAutoScale()else self:SetScale(self:GetScale())end
if ad then ad:Set(self:GetScale(),true)end
end,
})
ad=ab:CreateSlider({
Name="UI scale",
Min=i.scale_min,Max=i.scale_max,
Default=self:GetScale(),Increment=0.05,
Format=function(ae)return string.format("%.2fx",ae)end,
Callback=function(ae)
self:SetScale(ae)
if ac then ac:Set(false,true)end
end,
})


ab:CreateSection("Window")
ab:CreateButton("Toggle UI now",function()self:ToggleVisibility()end)
ab:CreateToggle({
Name="Lock window position",
CurrentValue=self._positionLocked,
Callback=function(ae)self:LockPosition(ae)end,
})
ab:CreateButton("Reset window position",function()
self:ResetPosition()
self:Notify({Title="Window reset",Message="Position recentered.",Type="info"})
end)


ab:CreateSection("Notifications")
ab:CreateToggle({
Name="Show notifications",
CurrentValue=self._notificationsEnabled,
Callback=function(ae)self:SetNotificationsEnabled(ae)end,
})
ab:CreateButton("Send test notification",function()
local ae=self._notificationsEnabled
self._notificationsEnabled=true
self:Notify({
Title="Test notification",
Message="If you see this, notifications are working.",
Type="success",
})
self._notificationsEnabled=ae
end)
ab:CreateButton("Clear all notifications",function()self:ClearNotifications()end)


ab:CreateSection("Info")
local ae=ab:CreateParagraph({
Title="SupUI "..a._version,
Text="fps —   ping —   players —",
})
do
local af,ag,ah=0,0,os.clock()
local ai=d.Heartbeat:Connect(function(ai)
af=af+1;ag=ag+ai
local aj=os.clock()
if aj-ah>=0.5 then
local ak=math.floor(af/ag+0.5)
local al
pcall(function()al=math.floor(h:GetNetworkPing()*1000)end)
local am=#e:GetPlayers()
ae:SetText(string.format("fps %d   ping %s   players %d",
ak,al and tostring(al)or"—",am))
af,ag,ah=0,0,aj
end
end)
p:Add(ai)
end
local af=findGlobalFn("identifyexecutor")
if af then
local ag,ah=pcall(af)
if ag and ah then
ab:CreateLabel("Executor: "..tostring(ah),"text_dim")
end
end


self:_buildConfigUI(ab)
self._configTabBuilt=true


ab:CreateSection("Danger zone")
ab:CreateButton("Unload script",function()
self:Confirm({
Title="Unload SupUI?",
Message="Closes every window and disconnects every event handler. Anti-AFK keeps running unless you also disable it.",
ConfirmText="Unload",CancelText="Keep",Destructive=true,
OnConfirm=function()self:Destroy()end,
})
end)

return ab
end




if k.ShowSettings~=false then
G:AddSettingsTab("Settings")
end


z.Size=UDim2.new(0,n,0,0)
z.BackgroundTransparency=1
task.defer(function()
tween(z,{Size=UDim2.new(0,n,0,o),BackgroundTransparency=0},i.dur_slow)
end)


if G._autoLoadConfig and s.available then
task.defer(function()
if s.exists(G._defaultConfigName)then
local aa,ab=G:LoadConfig(G._defaultConfigName)
if aa then
G:Notify({
Title="Config loaded",
Message="'"..G._defaultConfigName.."' auto-applied.",
Type="info",
Duration=2,
})
end
end
end)
end

return G
end

return a