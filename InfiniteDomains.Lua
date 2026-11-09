-- InfiniteDomains.lua
-- Client-side practice GUI for your own Roblox game

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("InfiniteDomains")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "InfiniteDomains"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(270, 370)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 20, 40)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "INFINITE DOMAINS"
title.TextColor3 = Color3.fromRGB(80, 170, 255)
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 35)
status.Position = UDim2.fromOffset(10, 325)
status.BackgroundTransparency = 1
status.Text = "Practice features ready"
status.TextColor3 = Color3.new(1, 1, 1)
status.TextSize = 11
status.Parent = frame

local function getHumanoid()
    local character = player.Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

local function makeButton(label, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -30, 0, 38)
    button.Position = UDim2.fromOffset(15, y)
    button.BackgroundColor3 = Color3.fromRGB(40, 65, 110)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Text = label .. ": OFF"
    button.Parent = frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    local enabled = false

    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        button.Text = label .. (enabled and ": ON" or ": OFF")
        callback(enabled)
    end)

    return button
end

-- Speed
makeButton("Speed", 55, function(on)
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.WalkSpeed = on and 24 or 16
    end
end)

-- Jump
makeButton("Jump", 100, function(on)
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = on and 75 or 50
    end
end)

-- Infinite Jump
local infiniteJump = false

makeButton("Infinite Jump", 145, function(on)
    infiniteJump = on
end)

UIS.JumpRequest:Connect(function()
    if infiniteJump then
        local humanoid = getHumanoid()
        if humanoid then
            humanoid:ChangeState(
                Enum.HumanoidStateType.Jumping
            )
        end
    end
end)

-- FOV Circle
local circle = Instance.new("Frame")
circle.Name = "FOVCircle"
circle.Size = UDim2.fromOffset(240, 240)
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.Position = UDim2.fromScale(0.5, 0.5)
circle.BackgroundTransparency = 1
circle.Visible = false
circle.Parent = gui

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circle

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(70, 170, 255)
stroke.Thickness = 2
stroke.Parent = circle

makeButton("FOV Circle", 190, function(on)
    circle.Visible = on
end)

-- Camera Lock: practice NPCs only
local cameraLock = false
local target = nil

local function findTarget()
    local folder = workspace:FindFirstChild("TrainingTargets")
    if not folder then return nil end

    local closest = nil
    local shortest = 120

    for _, npc in ipairs(folder:GetChildren()) do
        local humanoid = npc:FindFirstChildOfClass("Humanoid")
        local root = npc:FindFirstChild("HumanoidRootPart")

        if humanoid and root and humanoid.Health > 0 then
            local screenPos, visible =
                camera:WorldToViewportPoint(root.Position)

            if visible then
                local center = camera.ViewportSize / 2
                local distance = (
                    Vector2.new(screenPos.X, screenPos.Y) - center
                ).Magnitude

                if distance < shortest then
                    shortest = distance
                    closest = root
                end
            end
        end
    end

    return closest
end

makeButton("Practice Camera Lock", 235, function(on)
    cameraLock = on
    target = nil
    status.Text = on and "Looking for training NPCs" or "Camera lock OFF"
end)

RunService.RenderStepped:Connect(function()
    if not cameraLock then return end

    if not target or not target.Parent then
        target = findTarget()
    end

    if target then
        camera.CFrame = CFrame.lookAt(
            camera.CFrame.Position,
            target.Position
        )
    end
end)

-- Close
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(28, 28)
close.Position = UDim2.new(1, -33, 0, 8)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
close.Parent = frame

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("Infinite Domains loaded")
