-- AAC STAT HUB V2 - execute as LocalScript
local p=game.Players.LocalPlayer
local h=p:WaitForChild("PlayerGui")
if h:FindFirstChild("StatHubV2") then h:FindFirstChild("StatHubV2"):Destroy() end
if h:FindFirstChild("StatHub") then h:FindFirstChild("StatHub"):Destroy() end
local RS=game:GetService("ReplicatedStorage")
local UIS=game:GetService("UserInputService")

-- SMART REMOTE FINDER - fixes "nothing works"
local remotes={}
for _,v in ipairs(game:GetDescendants()) do if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then remotes[v.Name:lower()]=v end end
local function find(names) for _,n in ipairs(names) do if remotes[n:lower()] then return remotes[n:lower()] end for k,v in pairs(remotes) do if k:find(n:lower()) then return v end end end return nil end
local statRemote=find({"SetStat","Stat","AddStat","UpdateStat","StatsRemote","Data"})
local itemRemote=find({"GiveItem","AddItem","GetItem","Item","Inventory"})
local unlockRemote=find({"SetAchievement","Achievement","Unlock"})
local generic=RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("TesterRemote") or find({"Remote","Event"})
local function fire(r,...) if r then pcall(function() if r:IsA("RemoteEvent") then r:FireServer(...) else r:InvokeServer(...) end end) end end
local function smart(cat,...) if cat=="stat" then fire(statRemote or generic,...) fire(generic,"SetStat",...) end if cat=="item" then fire(itemRemote or generic,...) fire(generic,"GiveItem",...) end if cat=="unlock" then fire(unlockRemote or generic,...) fire(generic,"SetAchievement",...) end end

-- SMART DICT FINDER
local function loadKeys(dictName, fallback)
    for _,v in ipairs(RS:GetDescendants()) do if v.Name:lower()==dictName:lower() and v:IsA("ModuleScript") then local ok,res=pcall(require,v) if ok and type(res)=="table" then local t={} for k,_ in pairs(res) do table.insert(t,k) end if #t>3 then table.sort(t) return t end end end end
    return fallback
end
local allItems=loadKeys("Items",{"Sword in Stone","Giant's Greatsword","Healing Potion","Energy Potion","Summoning Star","Dragonite Chip","Gemstone","Ectoplasm","Whetstone","Honey Glazed Carp"})
local achs=loadKeys("Achievements",{"Gigantomachy","Ultraviolence","A Small Favor","Hero of Elfkin"})
local races=loadKeys("Races",{"Human","Elf","Dwarf","Kobold","Lunaeia","Withered"})
local outs=loadKeys("Outfits",{"Adventurer","Wandering Maiden","Veteran Armor","Monk Robes"})

-- GUI
local gui=Instance.new("ScreenGui",h) gui.Name="StatHubV2" gui.ResetOnSpawn=false
local main=Instance.new("Frame",gui) main.Size=UDim2.new(0,640,0,460) main.Position=UDim2.new(0.5,-320,0.5,-230) main.BackgroundColor3=Color3.fromRGB(245,245,245) main.Active=true main.Draggable=true Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)
local title=Instance.new("TextLabel",main) title.Size=UDim2.new(1,0,0,28) title.BackgroundColor3=Color3.fromRGB(22,22,22) title.Text="  STAT HUB V2 • AAC" title.TextColor3=Color3.new(1,1,1) title.Font=Enum.Font.GothamBold title.TextSize=13 title.TextXAlignment=Enum.TextXAlignment.Left Instance.new("UICorner",title).CornerRadius=UDim.new(0,8)
local tabBar=Instance.new("Frame",main) tabBar.Size=UDim2.new(1,0,0,32) tabBar.Position=UDim2.new(0,0,0,30) tabBar.BackgroundTransparency=1
local content=Instance.new("Frame",main) content.Size=UDim2.new(1,-10,1,-75) content.Position=UDim2.new(0,5,0,65) content.BackgroundTransparency=1

local tabs={"Stats","Items","Unlocks","Settings"}
local pages={} local btns={}
for i,name in ipairs(tabs) do
    local b=Instance.new("TextButton",tabBar) b.Size=UDim2.new(0.25,-5,1,0) b.Position=UDim2.new((i-1)*0.25+0.005,0,0,0) b.BackgroundColor3=i==1 and Color3.fromRGB(0,122,255) or Color3.fromRGB(220,220,220) b.Text=name b.Font=Enum.Font.GothamBold Instance.new("UICorner",b).CornerRadius=UDim.new(0,8) btns[name]=b
    local pg=Instance.new("Frame",content) pg.Name=name pg.Size=UDim2.new(1,0,1,0) pg.BackgroundTransparency=1 pg.Visible=i==1 pages[name]=pg
end
local function show(w) for k,pg in pairs(pages) do pg.Visible=k==w end for k,b in pairs(btns) do b.BackgroundColor3=k==w and Color3.fromRGB(0,122,255) or Color3.fromRGB(220,220,220) b.TextColor3=k==w and Color3.new(1,1,1) or Color3.fromRGB(0,0,0) end end
for k,b in pairs(btns) do b.MouseButton1Click:Connect(function() show(k) end) end

-- STATS: any value
local statNames={"STR","DEX","CON","INT","FTH","CHA","LCK"}
for i,s in ipairs(statNames) do
    Instance.new("TextLabel",pages.Stats).Text=s Instance.new("TextLabel",pages.Stats).Size=UDim2.new(0,50,0,28) Instance.new("TextLabel",pages.Stats).Position=UDim2.new(0,10,0,10+(i-1)*36) -- simplified for brevity, full version below
end
-- Re-create properly:
for _,c in ipairs(pages.Stats:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
for i,s in ipairs(statNames) do
    local l=Instance.new("TextLabel",pages.Stats) l.Size=UDim2.new(0,50,0,28) l.Position=UDim2.new(0,10,0,10+(i-1)*36) l.BackgroundTransparency=1 l.Text=s l.Font=Enum.Font.GothamBold l.TextColor3=Color3.fromRGB(0,0,0)
    local b=Instance.new("TextBox",pages.Stats) b.Name=s b.Size=UDim2.new(0,110,0,28) b.Position=UDim2.new(0,60,0,10+(i-1)*34) b.BackgroundColor3=Color3.new(1,1,1) b.Text="9999" b.TextColor3=Color3.fromRGB(0,0,0) b.Font=Enum.Font.GothamBold Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) Instance.new("UIStroke",b).Color=Color3.fromRGB(0,0,0)
    local go=Instance.new("TextButton",pages.Stats) go.Size=UDim2.new(0,60,0,28) go.Position=UDim2.new(0,175,0,10+(i-1)*34) go.BackgroundColor3=Color3.fromRGB(30,30,30) go.Text="SET" go.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",go).CornerRadius=UDim.new(0,6)
    go.MouseButton1Click:Connect(function() smart("stat","SetStat",s,tonumber(b.Text) or 9999) fire(statRemote,s,tonumber(b.Text) or 9999) end)
end
local setAll=Instance.new("TextButton",pages.Stats) setAll.Size=UDim2.new(0,180,0,34) setAll.Position=UDim2.new(0,260,0,20) setAll.BackgroundColor3=Color3.fromRGB(0,122,255) setAll.Text="SET ALL (custom)" setAll.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",setAll).CornerRadius=UDim.new(0,8)
setAll.MouseButton1Click:Connect(function() for _,s in ipairs(statNames) do smart("stat","SetStat",s,tonumber(pages.Stats:FindFirstChild(s).Text) or 9999) task.wait(0.06) end end)

-- ITEMS: dropdown search + amount
local search=Instance.new("TextBox",pages.Items) search.Size=UDim2.new(1,-140,0,28) search.Position=UDim2.new(0,10,0,10) search.BackgroundColor3=Color3.new(1,1,1) search.PlaceholderText="search items..." Instance.new("UICorner",search).CornerRadius=UDim.new(0,6)
local amt=Instance.new("TextBox",pages.Items) amt.Size=UDim2.new(0,60,0,28) amt.Position=UDim2.new(1,-130,0,10) amt.BackgroundColor3=Color3.new(1,1,1) amt.Text="1" Instance.new("UICorner",amt).CornerRadius=UDim.new(0,6)
local give=Instance.new("TextButton",pages.Items) give.Size=UDim2.new(0,60,0,28) give.Position=UDim2.new(1,-65,0,10) give.BackgroundColor3=Color3.fromRGB(0,122,255) give.Text="GIVE" give.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",give).CornerRadius=UDim.new(0,6)
local iList=Instance.new("ScrollingFrame",pages.Items) iList.Size=UDim2.new(1,-20,1,-50) iList.Position=UDim2.new(0,10,0,45) iList.BackgroundColor3=Color3.fromRGB(230,230,230) Instance.new("UICorner",iList).CornerRadius=UDim.new(0,8) Instance.new("UIListLayout",iList).Padding=UDim.new(0,4)
local iBtns={} local function refreshI() for _,b in ipairs(iBtns) do b:Destroy() end iBtns={} local f=search.Text:lower() for _,n in ipairs(allItems) do if f=="" or n:lower():find(f,1,true) then local b=Instance.new("TextButton",iList) b.Size=UDim2.new(1,-10,0,26) b.BackgroundColor3=Color3.new(1,1,1) b.Text=n b.TextColor3=Color3.fromRGB(0,0,0) Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) table.insert(iBtns,b) b.MouseButton1Click:Connect(function() search.Text=n end) end end iList.CanvasSize=UDim2.new(0,0,0,#iBtns*30) end
search:GetPropertyChangedSignal("Text"):Connect(refreshI) refreshI()
give.MouseButton1Click:Connect(function() if search.Text~="" then smart("item","GiveItem",search.Text,tonumber(amt.Text) or 1) end end)

-- UNLOCKS: achievements + races + outfits
local uSearch=Instance.new("TextBox",pages.Unlocks) uSearch.Size=UDim2.new(1,-90,0,26) uSearch.Position=UDim2.new(0,10,0,10) uSearch.BackgroundColor3=Color3.new(1,1,1) uSearch.PlaceholderText="search achievements / races / outfits..." Instance.new("UICorner",uSearch).CornerRadius=UDim.new(0,6)
local uGo=Instance.new("TextButton",pages.Unlocks) uGo.Size=UDim2.new(0,80,0,26) uGo.Position=UDim2.new(1,-80,0,10) uGo.BackgroundColor3=Color3.fromRGB(0,122,255) uGo.Text="UNLOCK" uGo.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",uGo).CornerRadius=UDim.new(0,6)
local uList=Instance.new("ScrollingFrame",pages.Unlocks) uList.Size=UDim2.new(1,-20,1,-50) uList.Position=UDim2.new(0,10,0,45) uList.BackgroundColor3=Color3.fromRGB(230,230,230) Instance.new("UICorner",uList).CornerRadius=UDim.new(0,8) Instance.new("UIListLayout",uList).Padding=UDim.new(0,4)
local combined={} for _,a in ipairs(achs) do table.insert(combined,"[ACH] "..a) end for _,r in ipairs(races) do table.insert(combined,"[RACE] "..r) end for _,o in ipairs(outs) do table.insert(combined,"[OUTFIT] "..o) end table.sort(combined)
local uBtns={} local function refreshU() for _,b in ipairs(uBtns) do b:Destroy() end uBtns={} local f=uSearch.Text:lower() for _,n in ipairs(combined) do if f=="" or n:lower():find(f,1,true) then local b=Instance.new("TextButton",uList) b.Size=UDim2.new(1,-10,0,24) b.BackgroundColor3=Color3.new(1,1,1) b.Text=n Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) table.insert(uBtns,b) b.MouseButton1Click:Connect(function() uSearch.Text=n:gsub("%[.-%] ","") end) end end uList.CanvasSize=UDim2.new(0,0,0,#uBtns*28) end
uSearch:GetPropertyChangedSignal("Text"):Connect(refreshU) refreshU()
uGo.MouseButton1Click:Connect(function() local n=uSearch.Text if n=="" then return end smart("unlock","SetAchievement",n,true) fire(generic,"UnlockRace",n) fire(generic,"GiveOutfit",n) end)
local allBtn=Instance.new("TextButton",pages.Unlocks) allBtn.Size=UDim2.new(1,-20,0,26) allBtn.Position=UDim2.new(0,10,1,-32) allBtn.BackgroundColor3=Color3.fromRGB(30,30,30) allBtn.Text="UNLOCK ALL (filtered)" allBtn.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",allBtn).CornerRadius=UDim.new(0,6)
allBtn.MouseButton1Click:Connect(function() for _,name in ipairs(combined) do local n=name:gsub("%[.-%] ","") if uSearch.Text=="" or name:lower():find(uSearch.Text:lower(),1,true) then smart("unlock","SetAchievement",n,true) task.wait(0.04) end end end)

-- SETTINGS: COME / GO keys
local comeKey=Enum.KeyCode.Insert
local goKey=Enum.KeyCode.Delete
local toggleKey=Enum.KeyCode.RightShift
local waiting=nil
local bToggle=Instance.new("TextButton",pages.Settings) bToggle.Size=UDim2.new(1,-20,0,32) bToggle.Position=UDim2.new(0,10,0,20) bToggle.BackgroundColor3=Color3.new(1,1,1) bToggle.Text="TOGGLE: RightShift (click to rebind)" Instance.new("UICorner",bToggle).CornerRadius=UDim.new(0,8)
local bCome=Instance.new("TextButton",pages.Settings) bCome.Size=UDim2.new(1,-20,0,32) bCome.Position=UDim2.new(0,10,0,58) bCome.BackgroundColor3=Color3.new(1,1,1) bCome.Text="COME (show): Insert (click to rebind)" Instance.new("UICorner",bCome).CornerRadius=UDim.new(0,8)
local bGo=Instance.new("TextButton",pages.Settings) bGo.Size=UDim2.new(1,-20,0,32) bGo.Position=UDim2.new(0,10,0,96) bGo.BackgroundColor3=Color3.new(1,1,1) bGo.Text="GO (hide): Delete (click to rebind)" Instance.new("UICorner",bGo).CornerRadius=UDim.new(0,8)
bToggle.MouseButton1Click:Connect(function() waiting="toggle" bToggle.Text="Press any key..." end)
bCome.MouseButton1Click:Connect(function() waiting="come" bCome.Text="Press any key..." end)
bGo.MouseButton1Click:Connect(function() waiting="go" bGo.Text="Press any key..." end)
UIS.InputBegan:Connect(function(input,gp)
    if waiting and input.KeyCode~=Enum.KeyCode.Unknown then
        if waiting=="toggle" then toggleKey=input.KeyCode bToggle.Text="TOGGLE: "..toggleKey.Name else if waiting=="come" then comeKey=input.KeyCode bCome.Text="COME (show): "..comeKey.Name else goKey=input.KeyCode bGo.Text="GO (hide): "..goKey.Name end end
        waiting=nil title.Text="  STAT HUB V2 • "..toggleKey.Name.."/"..comeKey.Name.."/"..goKey.Name return
    end
    if not gp then if input.KeyCode==toggleKey then gui.Enabled=not gui.Enabled elseif input.KeyCode==comeKey then gui.Enabled=true elseif input.KeyCode==goKey then gui.Enabled=false end end
end)
print("AAC StatHub V2 loaded")
