-- InfiniteDomains.lua
-- Client-side starter GUI

if game:GetService("Players").LocalPlayer == nil then
    return
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local GUI = Instance.new("ScreenGui")
GUI.Name = "InfiniteDomains"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(260, 220)
Frame.Position = UDim2.new(0.5, -130, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(20, 25, 45)
Frame.Parent = GUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "Infinite Domains"
Title.TextColor3 = Color3.fromRGB(100, 170, 255)
Title.TextSize = 22
Title.Parent = Frame

local function makeButton(name, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 220, 0, 35)
    Button.Position = UDim2.fromOffset(20, position)
    Button.Text = name
    Button.TextSize = 16
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = Color3.fromRGB(45, 65, 110)
    Button.Parent = Frame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    Button.MouseButton1Click:Connect(callback)
end

makeButton("Speed: Normal", 55, function()
    local humanoid = Player.Character
        and Player.Character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed =
            humanoid.WalkSpeed == 16 and 24 or 16
    end
end)

makeButton("Jump: Normal", 100, function()
    local humanoid = Player.Character
        and Player.Character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.UseJumpPower = true
        humanoid.JumpPower =
            humanoid.JumpPower == 50 and 75 or 50
    end
end)

makeButton("Infinite Jump: OFF", 145, function()
    -- Infinite jump is not enabled in this starter version.
    warn("Infinite jump needs to be added to the client controller.")
end)

makeButton("Close GUI", 190, function()
    GUI:Destroy()
end)
