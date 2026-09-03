local p=game.Players.LocalPlayer
local h=p:WaitForChild("PlayerGui")
local e=nil pcall(function() e=game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("TesterRemote") end)
local function fire(a,b,c) if e then pcall(function() e:FireServer(a,b,c) end) end end
local toggleKey=Enum.KeyCode.RightShift
if h:FindFirstChild("StatHub")then h.StatHub:Destroy()end
local gui=Instance.new("ScreenGui",h)gui.Name="StatHub"gui.ResetOnSpawn=false
local main=Instance.new("Frame",gui)main.Size=UDim2.new(0,600,0,400)main.Position=UDim2.new(0.5,-300,0.5,-200)main.BackgroundColor3=Color3.fromRGB(24,26,30)main.Active=true main.Draggable=true Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",main).Color=Color3.fromRGB(80,85,95)
local title=Instance.new("TextLabel",main)title.Size=UDim2.new(1,0,0,28)title.BackgroundColor3=Color3.fromRGB(18,20,24)title.Text="  stat hub • "..toggleKey.Name.." to hide"title.TextColor3=Color3.fromRGB(255,255,255)title.Font=Enum.Font.GothamBold title.TextSize=13 title.TextXAlignment=Enum.TextXAlignment.Left Instance.new("UICorner",title).CornerRadius=UDim.new(0,8)
local tabBar=Instance.new("Frame",main)tabBar.Size=UDim2.new(1,0,0,30)tabBar.Position=UDim2.new(0,0,0,28)tabBar.BackgroundTransparency=1
local content=Instance.new("Frame",main)content.Size=UDim2.new(1,-10,1,-70)content.Position=UDim2.new(0,5,0,60)content.BackgroundTransparency=1
local sBtn=Instance.new("TextButton",tabBar)sBtn.Name="Stats"sBtn.Size=UDim2.new(0.25,-5,1,0)sBtn.Position=UDim2.new(0,5,0,0)sBtn.BackgroundColor3=Color3.fromRGB(88,166,255)sBtn.Text="Stats"Instance.new("UICorner",sBtn).CornerRadius=UDim.new(0,6)
local iBtn=Instance.new("TextButton",tabBar)iBtn.Name="Items"iBtn.Size=UDim2.new(0.25,-5,1,0)iBtn.Position=UDim2.new(0.25,5,0,0)iBtn.BackgroundColor3=Color3.fromRGB(50,53,59)iBtn.Text="Items"Instance.new("UICorner",iBtn).CornerRadius=UDim.new(0,6)
local uBtn=Instance.new("TextButton",tabBar)uBtn.Name="Unlocks"uBtn.Size=UDim2.new(0.25,-5,1,0)uBtn.Position=UDim2.new(0.5,5,0,0)uBtn.BackgroundColor3=Color3.fromRGB(50,53,59)uBtn.Text="Unlocks"Instance.new("UICorner",uBtn).CornerRadius=UDim.new(0,6)
local setBtn=Instance.new("TextButton",tabBar)setBtn.Name="Settings"setBtn.Size=UDim2.new(0.25,-5,1,0)setBtn.Position=UDim2.new(0.75,5,0,0)setBtn.BackgroundColor3=Color3.fromRGB(50,53,59)setBtn.Text="Settings"Instance.new("UICorner",setBtn).CornerRadius=UDim.new(0,6)
local stats=Instance.new("Frame",content)stats.Name="Stats"stats.Size=UDim2.new(1,0,1,0)stats.BackgroundTransparency=1
local items=Instance.new("Frame",content)items.Name="Items"items.Size=UDim2.new(1,0,1,0)items.BackgroundTransparency=1 items.Visible=false
local unlocks=Instance.new("Frame",content)unlocks.Name="Unlocks"unlocks.Size=UDim2.new(1,0,1,0)unlocks.BackgroundTransparency=1 unlocks.Visible=false
local settings=Instance.new("Frame",content)settings.Name="Settings"settings.Size=UDim2.new(1,0,1,0)settings.BackgroundTransparency=1 settings.Visible=false
local function show(which) stats.Visible=which=="Stats" items.Visible=which=="Items" unlocks.Visible=which=="Unlocks" settings.Visible=which=="Settings" sBtn.BackgroundColor3=which=="Stats"and Color3.fromRGB(88,166,255)or Color3.fromRGB(50,53,59) iBtn.BackgroundColor3=which=="Items"and Color3.fromRGB(88,166,255)or Color3.fromRGB(50,53,59) uBtn.BackgroundColor3=which=="Unlocks"and Color3.fromRGB(88,166,255)or Color3.fromRGB(50,53,59) setBtn.BackgroundColor3=which=="Settings"and Color3.fromRGB(88,166,255)or Color3.fromRGB(50,53,59) end
sBtn.MouseButton1Click:Connect(function() show("Stats") end) iBtn.MouseButton1Click:Connect(function() show("Items") end) uBtn.MouseButton1Click:Connect(function() show("Unlocks") end) setBtn.MouseButton1Click:Connect(function() show("Settings") end)
-- STATS - high contrast boxes (white bg, black text)
local statNames={"STR","DEX","CON","INT","FTH","CHA","LCK"}
for i,s in ipairs(statNames)do local l=Instance.new("TextLabel",stats)l.Size=UDim2.new(0,40,0,26)l.Position=UDim2.new(0,10,0,10+(i-1)*34)l.BackgroundTransparency=1 l.Text=s l.TextColor3=Color3.fromRGB(255,255,255)l.Font=Enum.Font.GothamBold;local b=Instance.new("TextBox",stats)b.Name=s;b.Size=UDim2.new(0,90,0,26)b.Position=UDim2.new(0,50,0,10+(i-1)*34)b.BackgroundColor3=Color3.fromRGB(255,255,255)b.Text="9999"b.TextColor3=Color3.fromRGB(0,0,0)b.Font=Enum.Font.GothamBold Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)end
local setAll=Instance.new("TextButton",stats)setAll.Size=UDim2.new(0,120,0,28)setAll.Position=UDim2.new(0,160,0,15)setAll.BackgroundColor3=Color3.fromRGB(88,166,255)setAll.Text="SET ALL"setAll.TextColor3=Color3.new(1,1,1)setAll.Font=Enum.Font.GothamBold Instance.new("UICorner",setAll).CornerRadius=UDim.new(0,6)setAll.MouseButton1Click:Connect(function() for _,s in ipairs(statNames)do local b=stats:FindFirstChild(s) fire("SetStat",s,tonumber(b.Text) or 9999) task.wait(0.05) end end)
local godBtn=Instance.new("TextButton",stats)godBtn.Size=UDim2.new(0,140,0,26)godBtn.Position=UDim2.new(0,160,0,50)godBtn.BackgroundColor3=Color3.fromRGB(50,53,59)godBtn.Text="God Mode: OFF"Instance.new("UICorner",godBtn).CornerRadius=UDim.new(0,6)local godOn=false;godBtn.MouseButton1Click:Connect(function() godOn=not godOn;godBtn.Text=godOn and "God Mode: ON" or "God Mode: OFF";godBtn.BackgroundColor3=godOn and Color3.fromRGB(88,166,255) or Color3.fromRGB(50,53,59) if godOn then task.spawn(function() while godOn do fire("FullHeal") task.wait(0.8) end end) end end)
-- ITEMS - high contrast search (white) + owned check
local search=Instance.new("TextBox",items)search.Size=UDim2.new(1,-80,0,26)search.Position=UDim2.new(0,10,0,10)search.BackgroundColor3=Color3.fromRGB(255,255,255)search.PlaceholderText="search items..."search.TextColor3=Color3.fromRGB(0,0,0)search.Font=Enum.Font.GothamBold Instance.new("UICorner",search).CornerRadius=UDim.new(0,6)
local give=Instance.new("TextButton",items)give.Size=UDim2.new(0,60,0,26)give.Position=UDim2.new(1,-60,0,10)give.BackgroundColor3=Color3.fromRGB(88,166,255)give.Text="GIVE"Instance.new("UICorner",give).CornerRadius=UDim.new(0,6)
local iList=Instance.new("ScrollingFrame",items)iList.Size=UDim2.new(1,-20,1,-50)iList.Position=UDim2.new(0,10,0,45)iList.BackgroundColor3=Color3.fromRGB(18,20,24)iList.CanvasSize=UDim2.new(0,0,0,0)Instance.new("UICorner",iList).CornerRadius=UDim.new(0,6)Instance.new("UIListLayout",iList).Padding=UDim.new(0,4)
local allItems={}pcall(function() for k,v in pairs(require(game:GetService("ReplicatedStorage").Dictionaries.Items))do table.insert(allItems,k) end end)if #allItems==0 then allItems={"Sword in Stone","Healing Potion"} end;table.sort(allItems)
local invCache={}pcall(function() local plrData=game:GetService("ReplicatedStorage"):FindFirstChild("PlayerData") end)
local function hasItem(name) return false end -- server check not exposed, show all as not owned initially
local iBtns={}
local function refreshItems()
    for _,b in ipairs(iBtns)do b:Destroy() end;iBtns={}
    local f=search.Text:lower()
    for _,name in ipairs(allItems)do
        if f=="" or name:lower():find(f)then
            local b=Instance.new("TextButton",iList)b.Size=UDim2.new(1,-10,0,24)b.BackgroundColor3=Color3.fromRGB(255,255,255)b.Text=name.."  [GIVE]"b.TextColor3=Color3.fromRGB(0,0,0)b.Font=Enum.Font.Gotham b.TextSize=11;Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)table.insert(iBtns,b)b.MouseButton1Click:Connect(function() search.Text=name end)
        end
    end
    iList.CanvasSize=UDim2.new(0,0,0,#iBtns*28)
end
search:GetPropertyChangedSignal("Text"):Connect(refreshItems)refreshItems()
give.MouseButton1Click:Connect(function() if search.Text~="" then fire("GiveItem",search.Text,1) print("gave",search.Text) end end)
-- UNLOCKS - 3 columns: Achievements / Races / Outfits - white bg opposed to dark
local uSearch=Instance.new("TextBox",unlocks)uSearch.Size=UDim2.new(1,-90,0,26)uSearch.Position=UDim2.new(0,10,0,10)uSearch.BackgroundColor3=Color3.fromRGB(255,255,255)uSearch.PlaceholderText="search unlocks..."uSearch.TextColor3=Color3.fromRGB(0,0,0)Instance.new("UICorner",uSearch).CornerRadius=UDim.new(0,6)
local uGo=Instance.new("TextButton",unlocks)uGo.Size=UDim2.new(0,80,0,26)uGo.Position=UDim2.new(1,-80,0,10)uGo.BackgroundColor3=Color3.fromRGB(88,166,255)uGo.Text="UNLOCK"Instance.new("UICorner",uGo).CornerRadius=UDim.new(0,6)
local uList=Instance.new("ScrollingFrame",unlocks)uList.Size=UDim2.new(1,-20,1,-50)uList.Position=UDim2.new(0,10,0,45)uList.BackgroundColor3=Color3.fromRGB(18,20,24)Instance.new("UICorner",uList).CornerRadius=UDim.new(0,6)Instance.new("UIListLayout",uList).Padding=UDim.new(0,4)
local achs,races,outs={}, {}, {}
pcall(function() for k,v in pairs(require(game:GetService("ReplicatedStorage").Dictionaries.Achievements))do table.insert(achs,k) end end)
pcall(function() for k,v in pairs(require(game:GetService("ReplicatedStorage").Dictionaries.Races))do if k~="Order" then table.insert(races,k) end end end)
pcall(function() for k,v in pairs(require(game:GetService("ReplicatedStorage").Dictionaries.Outfits))do table.insert(outs,k) end end)
table.sort(achs) table.sort(races) table.sort(outs)
local combined={}
for _,a in ipairs(achs)do table.insert(combined,"[ACH] "..a) end
for _,r in ipairs(races)do table.insert(combined,"[RACE] "..r) end
for _,o in ipairs(outs)do table.insert(combined,"[OUTFIT] "..o) end
local uBtns={}
local function refreshU()
    for _,b in ipairs(uBtns)do b:Destroy() end;uBtns={}
    local f=uSearch.Text:lower()
    for _,name in ipairs(combined)do
        if f=="" or name:lower():find(f)then
            local b=Instance.new("TextButton",uList)b.Size=UDim2.new(1,-10,0,22)b.BackgroundColor3=Color3.fromRGB(255,255,255)b.Text=name;b.TextColor3=Color3.fromRGB(0,0,0)b.Font=Enum.Font.Gotham b.TextSize=11;Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)table.insert(uBtns,b)b.MouseButton1Click:Connect(function() uSearch.Text=name:gsub("%[.-%] ","") end)
        end
    end
    uList.CanvasSize=UDim2.new(0,0,0,#uBtns*26)
end
uSearch:GetPropertyChangedSignal("Text"):Connect(refreshU)refreshU()
uGo.MouseButton1Click:Connect(function()
    local n=uSearch.Text
    if n=="" then return end
    if n:find("%[ACH%]") or table.find(achs,n) then fire("SetAchievement",n:gsub("%[ACH%] ",""),true)
    elseif table.find(races,n) then fire("SetAchievement",n,true) -- races unlock via achievement gating
    else fire("GiveItem",n,1) end
    print("unlock attempt",n)
end)
-- SETTINGS
local rebind=Instance.new("TextButton",settings)rebind.Size=UDim2.new(1,-20,0,30)rebind.Position=UDim2.new(0,10,0,20)rebind.BackgroundColor3=Color3.fromRGB(255,255,255)rebind.TextColor3=Color3.fromRGB(0,0,0)rebind.Text="Toggle Key: "..toggleKey.Name Instance.new("UICorner",rebind).CornerRadius=UDim.new(0,6)
local waiting=false
rebind.MouseButton1Click:Connect(function() waiting=true rebind.Text="Press any key..." end)
game:GetService("UserInputService").InputBegan:Connect(function(input,gp) if waiting and input.KeyCode~=Enum.KeyCode.Unknown then toggleKey=input.KeyCode rebind.Text="Bound: "..toggleKey.Name title.Text="  stat hub • "..toggleKey.Name.." to hide" waiting=false return end if not gp and input.KeyCode==toggleKey then gui.Enabled=not gui.Enabled end end)
print("pickler! full hub loaded - high contrast")
