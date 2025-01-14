-- Load OrionLib
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Key System Configuration
local correctKey = "yaboidemon200"  -- The key/password for access
local isKeyEntered = false

-- Create the main window
local Window = OrionLib:MakeWindow({
    Name = "Demon Hud",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "DemonHudConfig",
    IntroText = "Enter your key to proceed"
})

-- Create a Tab for Key System
local KeyTab = Window:MakeTab({
    Name = "Key System",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- TextBox for the Key input
KeyTab:AddTextbox({
    Name = "Enter Key",
    Default = "",
    TextDisappear = true,
    Callback = function(input)
        if input == correctKey then
            isKeyEntered = true
            OrionLib:MakeNotification({
                Name = "Access Granted",
                Content = "You have successfully entered the key!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            enableFeatures()
        else
            OrionLib:MakeNotification({
                Name = "Access Denied",
                Content = "Incorrect key, please try again.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end
})

-- Function to enable features after successful key entry
function enableFeatures()
    -- Features Tab
    local FeaturesTab = Window:MakeTab({
        Name = "Features",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Aimbot UI
    local aimbotEnabled = false
    FeaturesTab:AddSection({Name = "Aimbot"})

    FeaturesTab:AddButton({
        Name = "Activate Aimbot",
        Callback = function()
            aimbotEnabled = true
            print("Aimbot Activated")
        end
    })

    FeaturesTab:AddButton({
        Name = "Stop Aimbot",
        Callback = function()
            aimbotEnabled = false
            print("Aimbot Deactivated")
        end
    })

    -- Aimbot Logic
    game:GetService("RunService").Heartbeat:Connect(function()
        if aimbotEnabled then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local target = nil
                local closestDistance = math.huge
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if dist < closestDistance then
                            closestDistance = dist
                            target = otherPlayer.Character
                        end
                    end
                end
                if target then
                    local targetHead = target:FindFirstChild("Head")
                    if targetHead then
                        player.Character.HumanoidRootPart.CFrame = CFrame.lookAt(player.Character.HumanoidRootPart.Position, targetHead.Position)
                    end
                end
            end
        end
    end)

    -- WalkSpeed UI
    FeaturesTab:AddSlider({
        Name = "WalkSpeed",
        Min = 10,
        Max = 100,
        Default = 16,
        Color = Color3.fromRGB(255, 100, 100),
        Increment = 1,
        ValueName = "Speed",
        Callback = function(Value)
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = Value
                print("WalkSpeed set to:", Value)
            else
                warn("Failed to set WalkSpeed: Character or Humanoid not found.")
            end
        end
    })

    -- Tool Grabber
    FeaturesTab:AddButton({
        Name = "Tool Grabber",
        Callback = function()
            local player = game.Players.LocalPlayer
            if player and player.Character then
                for _, tool in pairs(workspace:GetDescendants()) do
                    if tool:IsA("Tool") and tool.Parent == workspace then
                        tool.Parent = player.Backpack
                    end
                end
            end
        end
    })

    -- Name Tag UI
    FeaturesTab:AddTextbox({
        Name = "Set Name Tag",
        Default = "",
        TextDisappear = true,
        Callback = function(name)
            local player = game.Players.LocalPlayer
            if player and player.Character then
                local nameTag = player.Character:FindFirstChild("NameTag")
                if not nameTag then
                    nameTag = Instance.new("BillboardGui")
                    nameTag.Name = "NameTag"
                    nameTag.Size = UDim2.new(0, 100, 0, 50)
                    nameTag.Parent = player.Character.Head
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Text = name
                    textLabel.Parent = nameTag
                end
                nameTag.TextLabel.Text = name
            end
        end
    })

    -- Money Spawn
    FeaturesTab:AddButton({
        Name = "Spawn Money",
        Callback = function()
            local money = Instance.new("Part")
            money.Size = Vector3.new(1, 1, 1)
            money.Shape = Enum.PartType.Ball
            money.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
            money.Color = Color3.fromRGB(255, 223, 0)
            money.Parent = workspace
            print("Money Spawned!")
        end
    })

    -- Discord Invite
    FeaturesTab:AddButton({
        Name = "Join Discord - Look in Clipboard!",
        Callback = function()
            setclipboard("https://discord.gg/bNkgCxtbMT")
            print("Discord invite copied to clipboard!")
        end
    })

    -- Credit UI
    local CreditsTab = Window:MakeTab({
        Name = "Credits",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    CreditsTab:AddTextbox({
        Name = "Owner",
        Default = "[😈] Demon",
        TextDisappear = false,
        Callback = function()
            -- Textbox is not editable
        end
    })
end

-- Initialize the UI
OrionLib:Init()
