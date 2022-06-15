

-- Generic Variables
local plr = game.Players.LocalPlayer
local Hum = plr.Character.Humanoid
local plrParts = plr.Character:GetChildren()
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local HumanoidRootPart = plr.Character.HumanoidRootPart

-- Version 1
if _G.AlternateVersion == "v1" then
    print("test1")
    -- Align Function
    local function align(P0, P1, Position, Rotation)
        local AlignPosition = Instance.new("AlignPosition", P0)
        AlignPosition.RigidityEnabled = true

        local AlignOrientation = Instance.new("AlignOrientation", P0)
        AlignOrientation.RigidityEnabled = true

        local Att0 = Instance.new("Attachment", P0)

        local Att1 = Instance.new("Attachment", P1)
        Att1.Position = Position or Vector3.new(0, 0, 0)
        Att1.Rotation = Rotation or Vector3.new(0, 0, 0)

        AlignPosition.Attachment0 = Att0
        AlignPosition.Attachment1 = Att1

        AlignOrientation.Attachment0 = Att0
        AlignOrientation.Attachment1 = Att1
    end

    local function alignPosition(P0, P1)
        local AlignPosition = Instance.new("AlignPosition", P0)
        AlignPosition.RigidityEnabled = true

        local Att0 = Instance.new("Attachment", P0)

        local Att1 = Instance.new("Attachment", P1)

        AlignPosition.Attachment0 = Att0
        AlignPosition.Attachment1 = Att1
    end

    print("test2")
    plr.Character.Archivable = true

    -- Clone
    local Reanim = plr.Character:Clone()
    Reanim.Parent = plr.Character
    Reanim.Name = "reanim"

    for i, v in pairs(Reanim:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            if v.Name == "Head" then
                v.face:Destroy()
            end
        elseif v:IsA("Accessory") then
            v.Handle.Transparency = 1
        end
    end

    print("test3")

    -- Noclip
    RunService.Stepped:Connect(function()
        plr.Character.Humanoid.Died:Connect(function()
            return
        end)
        for i, v in pairs(plrParts) do
            if v:IsA("BasePart") then
                if v.Name ~= "HumanoidRootPart" then
                    if v.Name ~= "Left Arm" or "Right Arm" then
                        if v.Name ~= "Left Leg" or "Right Leg" then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end
    end)

    print("test4")
    plr.Character.Torso["Right Shoulder"]:Destroy()
    plr.Character.Torso["Left Shoulder"]:Destroy()
    plr.Character.Torso["Right Hip"]:Destroy()
    plr.Character.Torso["Left Hip"]:Destroy()

    HumanoidRootPart:Destroy()

    -- Alignment
    local function InstantAlign(P0)
        align(plr.Character[P0], Reanim[P0])
    end

    local function InstantAlignHat(P0)
        align(plr.Character[P0].Handle, Reanim[P0].Handle)
    end

    --[[
    InstantAlign("Right Arm")
    InstantAlign("Left Arm")
    InstantAlign("Right Leg")
    InstantAlign("Left Leg")
    InstantAlign("Torso")
    --]]

    for i, v in pairs(plrParts) do
        if v:IsA("BasePart") then
            if v.Name ~= "HumanoidRootPart" then
                InstantAlign(v.Name)
            end
        elseif v:IsA("Accessory") then
            v.Handle.AccessoryWeld:Remove()
            InstantAlignHat(v.Name)
        end
    end

    print("test5")
    StarterGui:SetCore("SendNotification", {
        Title = "Reanimation";
        Text = "Successfully reanimated!";
        Duration = 5;
    })

    -- Netless
    RunService.Heartbeat:Connect(function()
        for i, v in pairs(plrParts) do
            if v:IsA("BasePart") then
                v.Velocity = _G.Velocity
            elseif v:IsA("Accessory") then
                pcall(function()
                    v.Handle.Velocity = _G.Velocity
                end)
            end
        end
    end)

    -- Reanim Despawn
    plr.Character = Reanim
    plr.Character.Humanoid.Died:Connect(function()
        plr.Character = game.Workspace[plr.Name]
        Reanim:Destroy()
        plr.Character.Humanoid.Health = 0
    end)

    -- Camera
    --local findClass = game.Workspace:FindFirstChildOfClass
    --findClass("Camera").CameraSubject = Reanim.Humanoid
end