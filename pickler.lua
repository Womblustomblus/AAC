local p=game.Players.LocalPlayer
local h=p:WaitForChild("PlayerGui")
local e=nil
pcall(function() e=game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("TesterRemote") end)
local function fire(a,b,c) if e then pcall(function() e:FireServer(a,b,c) end) end end
local toggleKey=Enum.KeyCode.RightShift
if h:FindFirstChild("StatHub")then h.StatHub:Destroy()end
local gui=Instance.new("ScreenGui",h)gui.Name="StatHub"gui.ResetOnSpawn=false
local main=Instance.new("Frame",gui)main.Size=UDim2.new(0,560,0,380)main.Position=UDim2.new(0.5,-280,0.5,-190)main.BackgroundColor3=Color3.fromRGB(32,34,37)main.Active=true main.Draggable=true Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
local title=Instance.new("TextLabel",main)title.Size=UDim2.new(1,0,0,28)title.BackgroundColor3=Color3.fromRGB(44,47,51)title.Text="  stat hub • "..toggleKey.Name.." to hide"title.TextColor3=Color3.fromRGB(220,220,220)title.Font=Enum.Font.GothamBold Instance.new("UICorner",title).CornerRadius=UDim.new(0,8)
local tabBar=Instance.new("Frame",main)tabBar.Size=UDim2.new(1,0,0,28)tabBar.Position=UDim2.new(0,0,0,28)tabBar.BackgroundTransparency=1
local content=Instance.new("Frame",main)content.Size=UDim2.new(1,-10,1,-70)content.Position=UDim2.new(0,5,0,60)content.BackgroundTransparency=1
-- buttons
local sBtn=Instance.new("TextButton",tabBar)sBtn.Name="Stats"sBtn.Size=UDim2.new(0.25,-5,1,0)sBtn.Position=UDim2.new(0,5,0,0)sBtn.BackgroundColor3=Color3.fromRGB(88,166,255)sBtn.Text="Stats"Instance.new("UICorner",sBtn).CornerRadius=UDim.new(0,6)
local iBtn=Instance.new("TextButton",tabBar)iBtn.Name="Items"iBtn.Size=UDim2.new(0.25,-5,1,0)iBtn.Position=UDim2.new(0.25,5,0,0)iBtn.BackgroundColor3=Color3.fromRGB(50,53,59)iBtn.Text="Items"Instance.new("UICorner",iBtn).CornerRadius=UDim.new(0,6)
local uBtn=Instance.new("TextButton",tabBar)uBtn.Name="Unlocks"uBtn.Size=UDim2.new(0.25,-5,1,0)uBtn.Position=UDim2.new(0.5,5,0,0)uBtn.BackgroundColor3=Color3.fromRGB(50,53,59)uBtn.Text="Unlocks"Instance.new("UICorner",uBtn).CornerRadius=UDim.new(0,6)
local setBtn=Instance.new("TextButton",tabBar)setBtn.Name="Settings"setBtn.Size=UDim2.new(0.25,-5,1,0)setBtn.Position=UDim2.new(0.75,5,0,0)setBtn.BackgroundColor3=Color3.fromRGB(50,53,59)setBtn.Text="Settings"Instance.new("UICorner",setBtn).CornerRadius=UDim.new(0,6)
-- frames
local stats=Instance.new("Frame",content)stats.Name="Stats"stats.Size=UDim2.new(1,0,1,0)stats.BackgroundTransparency=1
local items=Instance.new("Frame",content)items.Name="Items"items.Size=UDim2.new(1,0,1,0)items.BackgroundTransparency=1 items.Visible=false
local unlocks=Instance.new("Frame",content)unlocks.Name="Unlocks"unlocks.Size=UDim2.new(1,0,1,0)unlocks.BackgroundTransparency=1 unlocks.Visible=false
local settings=Instance.new("Frame",content)settings.Name="Settings"settings.Size=UDim2.new(1,0,1,0)settings.BackgroundTransparency=1 settings.Visible=false
-- handlers (NO loop)
local function show(which)
    stats.Visible = which=="Stats"
    items.Visible = which=="Items"
    unlocks.Visible = which=="Unlocks"
    settings.Visible = which=="Settings"
    sBtn.BackgroundColor3 = which=="Stats" and Color3.fromRGB(88,166,255) or Color3.fromRGB(50,53,59)
    iBtn.BackgroundColor3 = which=="Items" and Color3.fromRGB(88,166,255) or Color3.fromRGB(50,53,59)
    uBtn.BackgroundColor3 = which=="Unlocks" and Color3.fromRGB(88,166,255) or Color3.fromRGB(50,53,59)
    setBtn.BackgroundColor3 = which=="Settings" and Color3.fromRGB(88,166,255) or Color3.fromRGB(50,53,59)
    print("tab:",which)
end
sBtn.MouseButton1Click:Connect(function() show("Stats") end)
iBtn.MouseButton1Click:Connect(function() show("Items") end)
uBtn.MouseButton1Click:Connect(function() show("Unlocks") end)
setBtn.MouseButton1Click:Connect(function() show("Settings") end)
-- fill Stats
local statNames={"STR","DEX","CON","INT","FTH","CHA","LCK"}
for i,s in ipairs(statNames)do local l=Instance.new("TextLabel",stats)l.Size=UDim2.new(0,40,0,24)l.Position=UDim2.new(0,10,0,10+(i-1)*32)l.BackgroundTransparency=1 l.Text=s;local b=Instance.new("TextBox",stats)b.Name=s;b.Size=UDim2.new(0,80,0,24)b.Position=UDim2.new(0,50,0,10+(i-1)*32)b.BackgroundColor3=Color3.fromRGB(44,47,51)b.Text="9999"Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)end
local setAll=Instance.new("TextButton",stats)setAll.Size=UDim2.new(0,100,0,26)setAll.Position=UDim2.new(0,160,0,10)setAll.BackgroundColor3=Color3.fromRGB(88,166,255)setAll.Text="SET ALL"Instance.new("UICorner",setAll).CornerRadius=UDim.new(0,6)setAll.MouseButton1Click:Connect(function() for _,s in ipairs(statNames)do local b=stats:FindFirstChild(s) fire("SetStat",s,tonumber(b.Text) or 9999) task.wait(0.05) end end)
-- fill Items
local search=Instance.new("TextBox",items)search.Size=UDim2.new(1,-70,0,24)search.Position=UDim2.new(0,10,0,10)search.BackgroundColor3=Color3.fromRGB(44,47,51)search.PlaceholderText="item name"Instance.new("UICorner",search).CornerRadius=UDim.new(0,6)
local give=Instance.new("TextButton",items)give.Size=UDim2.new(0,50,0,24)give.Position=UDim2.new(1,-50,0,10)give.BackgroundColor3=Color3.fromRGB(88,166,255)give.Text="GIVE"Instance.new("UICorner",give).CornerRadius=UDim.new(0,6)give.MouseButton1Click:Connect(function() if search.Text~="" then fire("GiveItem",search.Text,1) end end)
-- fill Unlocks
local uSearch=Instance.new("TextBox",unlocks)uSearch.Size=UDim2.new(1,-80,0,24)uSearch.Position=UDim2.new(0,10,0,10)uSearch.BackgroundColor3=Color3.fromRGB(44,47,51)uSearch.PlaceholderText="achievement"Instance.new("UICorner",uSearch).CornerRadius=UDim.new(0,6)
local uGo=Instance.new("TextButton",unlocks)uGo.Size=UDim2.new(0,70,0,24)uGo.Position=UDim2.new(1,-70,0,10)uGo.BackgroundColor3=Color3.fromRGB(88,166,255)uGo.Text="UNLOCK"Instance.new("UICorner",uGo).CornerRadius=UDim.new(0,6)uGo.MouseButton1Click:Connect(function() if uSearch.Text~="" then fire("SetAchievement",uSearch.Text,true) end end)
-- fill Settings
local rebind=Instance.new("TextButton",settings)rebind.Size=UDim2.new(1,-20,0,30)rebind.Position=UDim2.new(0,10,0,20)rebind.BackgroundColor3=Color3.fromRGB(50,53,59)rebind.Text="Rebind: "..toggleKey.Name;Instance.new("UICorner",rebind).CornerRadius=UDim.new(0,6)
local waiting=false
rebind.MouseButton1Click:Connect(function() waiting=true rebind.Text="Press any key..." end)
game:GetService("UserInputService").InputBegan:Connect(function(input,gp) if waiting and input.KeyCode~=Enum.KeyCode.Unknown then toggleKey=input.KeyCode rebind.Text="Bound: "..toggleKey.Name title.Text="  stat hub • "..toggleKey.Name.." to hide" waiting=false return end if not gp and input.KeyCode==toggleKey then gui.Enabled=not gui.Enabled end end)
print("pickler! full hub loaded - test tabs now")
