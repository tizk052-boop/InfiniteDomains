-- InfiniteDomains GUI
-- Basic standalone Roblox LocalScript GUI

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "InfiniteDomains"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(340, 260)
frame.Position = UDim2.new(0.5, -170, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(45, 35, 100)
title.Text = "InfiniteDomains"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Parent = frame

local function makeButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(95, 35)
    button.Position = position
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    button.Parent = frame
    button.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", button)
    return button
end

local content = Instance.new("TextLabel")
content.Size = UDim2.new(1, -30, 0, 120)
content.Position = UDim2.fromOffset(15, 110)
content.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
content.TextColor3 = Color3.new(1, 1, 1)
content.TextSize = 16
content.TextWrapped = true
content.Parent = frame

makeButton("Main", UDim2.fromOffset(15, 60), function()
    content.Text = "Welcome to InfiniteDomains!"
end)

makeButton("Player", UDim2.fromOffset(120, 60), function()
    content.Text = "Player Settings"
end)

makeButton("Settings", UDim2.fromOffset(225, 60), function()
    content.Text = "GUI Settings"
end)

gui.Parent = player:WaitForChild("PlayerGui")
