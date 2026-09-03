local p=game.Players.LocalPlayer
local g=Instance.new("ScreenGui",p:WaitForChild("PlayerGui"))
g.Name="StatHub"
g.ResetOnSpawn=false
local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,400,0,200)
f.Position=UDim2.new(0.5,-200,0.5,-100)
f.BackgroundColor3=Color3.fromRGB(32,34,37)
f.Active=true
f.Draggable=true
Instance.new("UICorner",f)
local t=Instance.new("TextLabel",f)
t.Size=UDim2.new(1,0,0,30)
t.BackgroundColor3=Color3.fromRGB(44,47,51)
t.Text=" stat hub - if you see this, UI works - press SET"
t.TextColor3=Color3.new(1,1,1)
local b=Instance.new("TextButton",f)
b.Size=UDim2.new(0,100,0,30)
b.Position=UDim2.new(0.5,-50,0.5,-15)
b.BackgroundColor3=Color3.fromRGB(88,166,255)
b.Text="SET STR 9999"
b.MouseButton1Click:Connect(function()
    local r=game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("TesterRemote")
    if r then r:FireServer("SetStat","STR",9999) print("fired SetStat") else warn("no TesterRemote in tavern - join dungeon") end
    b.Text="SENT!"
end)
print("pickler! minimal hub loaded - look middle screen")
