local p=game.Players.LocalPlayer
local h=p:WaitForChild("PlayerGui")
local e=nil
pcall(function() e=game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("TesterRemote") end)
local function fire(a,b,c) if e then pcall(function() e:FireServer(a,b,c) print("fired",a,b,c) end) else warn("TesterRemote nil - join dungeon for stats") end end
local toggleKey=Enum.KeyCode.RightShift
local gui=Instance.new("ScreenGui",h)
gui.Name="StatHub"
gui.ResetOnSpawn=false
local main=Instance.new("Frame",gui)
main.Size=UDim2.new(0,560,0,380)
main.Position=UDim2.new(0.5,-280,0.5,-190)
main.BackgroundColor3=Color3.fromRGB(32,34,37)
main.Active=true
main.Draggable=true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",main).Color=Color3.fromRGB(60,65,75)
local title=Instance.new("TextLabel",main)
title.Size=UDim2.new(1,0,0,28)
title.BackgroundColor3=Color3.fromRGB(44,47,51)
title.Text="  stat hub • "..toggleKey.Name.." to hide"
title.TextColor3=Color3.fromRGB(220,220,220)
title.Font=Enum.Font.GothamBold
title.TextSize=13
title.TextXAlignment=Enum.TextXAlignment.Left
Instance.new("UICorner",title).CornerRadius=UDim.new(0,8)
local tabBar=Instance.new("Frame",main)
tabBar.Size=UDim2.new(1,0,0,28)
tabBar.Position=UDim2.new(0,0,0,28)
tabBar.BackgroundTransparency=1
local content=Instance.new("Frame",main)
content.Size=UDim2.new(1,-10,1,-70)
content.Position=UDim2.new(0,5,0,60)
content.BackgroundTransparency=1
local tabs={"Stats","Items","Unlocks","Settings"}
for i,name in ipairs(tabs)do
    local b=Instance.new("TextButton",tabBar)
    b.Name=name
    b.Size=UDim2.new(0.25,-5,1,0)
    b.Position=UDim2.new((i-1)*0.25,5,0,0)
    b.BackgroundColor3=Color3.fromRGB(50,53,59)
    b.Text=name
    b.TextColor3=Color3.fromRGB(220,220,220)
    b.Font=Enum.Font.GothamBold
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
end
-- STATS TAB
local stats=Instance.new("Frame",content)
stats.Name="Stats"
stats.Size=UDim2.new(1,0,1,0)
stats.BackgroundTransparency=1
local statNames={"STR","DEX","CON","INT","FTH","CHA","LCK"}
for i,s in ipairs(statNames)do
    local l=Instance.new("TextLabel",stats)
    l.Size=UDim2.new(0,40,0,24)
    l.Position=UDim2.new(0,10,0,10+(i-1)*32)
    l.BackgroundTransparency=1
    l.Text=s
    l.TextColor3=Color3.fromRGB(220,220,220)
    l.Font=Enum.Font.Gotham
    local box=Instance.new("TextBox",stats)
    box.Name=s
    box.Size=UDim2.new(0,80,0,24)
    box.Position=UDim2.new(0,50,0,10+(i-1)*32)
    box.BackgroundColor3=Color3.fromRGB(44,47,51)
    box.Text="9999"
    box.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner",box).CornerRadius=UDim.new(0,6)
end
local setAll=Instance.new("TextButton",stats)
setAll.Size=UDim2.new(0,120,0,28)
setAll.Position=UDim2.new(0,150,0,10)
setAll.BackgroundColor3=Color3.fromRGB(88,166,255)
setAll.Text="SET ALL"
setAll.TextColor3=Color3.new(1,1,1)
setAll.Font=Enum.Font.GothamBold
Instance.new("UICorner",setAll).CornerRadius=UDim.new(0,6)
setAll.MouseButton1Click:Connect(function()
    for _,s in ipairs(statNames)do
        local b=stats:FindFirstChild(s)
        fire("SetStat",s,tonumber(b.Text) or 9999)
        task.wait(0.08)
    end
end)
local godBtn=Instance.new("TextButton",stats)
godBtn.Size=UDim2.new(0,140,0,26)
godBtn.Position=UDim2.new(0,150,0,240)
godBtn.BackgroundColor3=Color3.fromRGB(50,53,59)
godBtn.Text="God Mode: OFF"
local godOn=false
local godThread
Instance.new("UICorner",godBtn).CornerRadius=UDim.new(0,6)
godBtn.MouseButton1Click:Connect(function()
    godOn=not godOn
    if godOn then
        godBtn.Text="God Mode: ON"
        godBtn.BackgroundColor3=Color3.fromRGB(88,166,255)
        godThread=task.spawn(function() while godOn do fire("FullHeal") task.wait(0.8) end end)
    else
        godBtn.Text="God Mode: OFF"
        godBtn.BackgroundColor3=Color3.fromRGB(50,53,59)
    end
end)
local expBox=Instance.new("TextBox",stats)
expBox.Size=UDim2.new(0,100,0,24)
expBox.Position=UDim2.new(0,300,0,10)
expBox.BackgroundColor3=Color3.fromRGB(44,47,51)
expBox.PlaceholderText="EXP"
Instance.new("UICorner",expBox).CornerRadius=UDim.new(0,6)
local expBtn=Instance.new("TextButton",stats)
expBtn.Size=UDim2.new(0,60,0,24)
expBtn.Position=UDim2.new(0,410,0,10)
expBtn.BackgroundColor3=Color3.fromRGB(50,53,59)
expBtn.Text="GIVE EXP"
Instance.new("UICorner",expBtn).CornerRadius=UDim.new(0,6)
expBtn.MouseButton1Click:Connect(function() fire("EXP",tonumber(expBox.Text) or 9999) end)
-- ITEMS TAB
local items=Instance.new("Frame",content)
items.Name="Items"
items.Size=UDim2.new(1,0,1,0)
items.BackgroundTransparency=1
items.Visible=false
local search=Instance.new("TextBox",items)
search.Size=UDim2.new(1,-140,0,26)
search.Position=UDim2.new(0,10,0,10)
search.BackgroundColor3=Color3.fromRGB(44,47,51)
search.PlaceholderText="search items..."
search.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",search).CornerRadius=UDim.new(0,6)
local amt=Instance.new("TextBox",items)
amt.Size=UDim2.new(0,50,0,26)
amt.Position=UDim2.new(1,-120,0,10)
amt.BackgroundColor3=Color3.fromRGB(44,47,51)
amt.Text="1"
amt.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",amt).CornerRadius=UDim.new(0,6)
local give=Instance.new("TextButton",items)
give.Size=UDim2.new(0,50,0,26)
give.Position=UDim2.new(1,-60,0,10)
give.BackgroundColor3=Color3.fromRGB(88,166,255)
give.Text="GIVE"
Instance.new("UICorner",give).CornerRadius=UDim.new(0,6)
local list=Instance.new("ScrollingFrame",items)
list.Size=UDim2.new(1,-20,1,-50)
list.Position=UDim2.new(0,10,0,45)
list.BackgroundColor3=Color3.fromRGB(24,26,28)
list.CanvasSize=UDim2.new(0,0,0,0)
Instance.new("UICorner",list).CornerRadius=UDim.new(0,6)
Instance.new("UIListLayout",list).Padding=UDim.new(0,4)
local allItems={}
pcall(function() for k,v in pairs(require(game:GetService("ReplicatedStorage").Dictionaries.Items))do table.insert(allItems,k) end end)
if #allItems==0 then allItems={"Sword in Stone","Healing Potion","Energy Potion"} end
table.sort(allItems)
local btns={}
local function refresh()
    for _,b in ipairs(btns)do b:Destroy() end
    btns={}
    local f=search.Text:lower()
    for _,name in ipairs(allItems)do
        if f=="" or name:lower():find(f)then
            local b=Instance.new("TextButton",list)
            b.Size=UDim2.new(1,-10,0,24)
            b.BackgroundColor3=Color3.fromRGB(50,53,59)
            b.Text=name
            b.TextColor3=Color3.fromRGB(220,220,220)
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
            table.insert(btns,b)
            b.MouseButton1Click:Connect(function() search.Text=name end)
        end
    end
    list.CanvasSize=UDim2.new(0,0,0,#btns*28)
end
search:GetPropertyChangedSignal("Text"):Connect(refresh)
refresh()
give.MouseButton1Click:Connect(function() if search.Text~="" then fire("GiveItem",search.Text,tonumber(amt.Text) or 1) end end)
-- UNLOCKS TAB
local unlocks=Instance.new("Frame",content)
unlocks.Name="Unlocks"
unlocks.Size=UDim2.new(1,0,1,0)
unlocks.BackgroundTransparency=1
unlocks.Visible=false
local uSearch=Instance.new("TextBox",unlocks)
uSearch.Size=UDim2.new(1,-170,0,26)
uSearch.Position=UDim2.new(0,10,0,10)
uSearch.BackgroundColor3=Color3.fromRGB(44,47,51)
uSearch.PlaceholderText="achievement / race / outfit"
Instance.new("UICorner",uSearch).CornerRadius=UDim.new(0,6)
local uBtn=Instance.new("TextButton",unlocks)
uBtn.Size=UDim2.new(0,70,0,26)
uBtn.Position=UDim2.new(1,-150,0,10)
uBtn.BackgroundColor3=Color3.fromRGB(88,166,255)
uBtn.Text="UNLOCK"
Instance.new("UICorner",uBtn).CornerRadius=UDim.new(0,6)
local allBtn=Instance.new("TextButton",unlocks)
allBtn.Size=UDim2.new(0,70,0,26)
allBtn.Position=UDim2.new(1,-70,0,10)
allBtn.BackgroundColor3=Color3.fromRGB(50,53,59)
allBtn.Text="ALL"
Instance.new("UICorner",allBtn).CornerRadius=UDim.new(0,6)
local uList=Instance.new("ScrollingFrame",unlocks)
uList.Size=UDim2.new(1,-20,1,-50)
uList.Position=UDim2.new(0,10,0,45)
uList.BackgroundColor3=Color3.fromRGB(24,26,28)
Instance.new("UICorner",uList).CornerRadius=UDim.new(0,6)
Instance.new("UIListLayout",uList).Padding=UDim.new(0,4)
local achs={}
pcall(function() for k,v in pairs(require(game:GetService("ReplicatedStorage").Dictionaries.Achievements))do table.insert(achs,k) end end)
if #achs==0 then achs={"Gigantomachy","Ultraviolence","A Small Favor"} end
table.sort(achs)
for _,a in ipairs(achs)do
    local b=Instance.new("TextButton",uList)
    b.Size=UDim2.new(1,-10,0,22)
    b.BackgroundColor3=Color3.fromRGB(50,53,59)
    b.Text=a
    b.TextColor3=Color3.fromRGB(220,220,220)
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    b.MouseButton1Click:Connect(function() uSearch.Text=a end)
end
uList.CanvasSize=UDim2.new(0,0,0,#achs*26)
uBtn.MouseButton1Click:Connect(function() if uSearch.Text~="" then fire("SetAchievement",uSearch.Text,true) fire("SetAchievement","all",true) end end)
allBtn.MouseButton1Click:Connect(function() for _,a in ipairs(achs)do fire("SetAchievement",a,true) task.wait(0.05) end end)
-- SETTINGS TAB
local settings=Instance.new("Frame",content)
settings.Name="Settings"
settings.Size=UDim2.new(1,0,1,0)
settings.BackgroundTransparency=1
settings.Visible=false
local rebind=Instance.new("TextButton",settings)
rebind.Size=UDim2.new(1,-20,0,30)
rebind.Position=UDim2.new(0,10,0,20)
rebind.BackgroundColor3=Color3.fromRGB(50,53,59)
rebind.Text="Toggle Key: "..toggleKey.Name
Instance.new("UICorner",rebind).CornerRadius=UDim.new(0,6)
local waiting=false
rebind.MouseButton1Click:Connect(function() waiting=true rebind.Text="Press any key..." end)
c.InputBegan:Connect(function(input,gp)
    if waiting and input.KeyCode~=Enum.KeyCode.Unknown then
        toggleKey=input.KeyCode
        rebind.Text="Bound: "..toggleKey.Name
        title.Text="  stat hub • "..toggleKey.Name.." to hide"
        waiting=false
        return
    end
    if not gp and input.KeyCode==toggleKey then
        gui.Enabled=not gui.Enabled
    end
end)
-- tab switching
for _,b in ipairs(tabBar:GetChildren())do
    if b:IsA("TextButton")then
        b.MouseButton1Click:Connect(function()
            for _,f in ipairs(content:GetChildren())do if f:IsA("Frame")then f.Visible=false end end
            content:FindFirstChild(b.Name).Visible=true
            for _,x in ipairs(tabBar:GetChildren())do if x:IsA("TextButton")then x.BackgroundColor3=x==b and Color3.fromRGB(88,166,255)or Color3.fromRGB(50,53,59) end end
        end)
    end
end
print("pickler! full hub loaded - Stats/Items/Unlocks/Settings ready")
