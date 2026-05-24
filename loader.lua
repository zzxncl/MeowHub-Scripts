-- =============================================
-- Rey's MeowHub - Safe GUI Loader
-- =============================================

print("🔥 Rey's MeowHub GUI Loading...")

local baseUrl = "https://raw.githubusercontent.com/zzxncl/MeowHub-Scripts/main/scripts/"

local Scripts = {
    ["Cut Grass for Anime"] = "cut grass for anime characters",
    ["Kick a Lucky Block"] = "kick a lucky block",
}

-- GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ReyMeowHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 280)
frame.Position = UDim2.new(0.5, -190, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
title.Text = "🔥 Rey's MeowHub"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.Parent = frame

for displayName, filename in pairs(Scripts) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 55)
    button.Position = UDim2.new(0, 10, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Text = displayName
    button.TextColor3 = Color3.new(1,1,1)
    button.TextSize = 16
    button.Parent = frame
    
    button.MouseButton1Click:Connect(function()
        button.Text = "Loading..."
        local encoded = filename:gsub(" ", "%%20")
        local url = baseUrl .. encoded
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        
        if success then
            button.Text = displayName .. " ✅"
            print("✅ Loaded: " .. displayName)
        else
            button.Text = displayName .. " ❌"
            warn("Failed to load " .. displayName .. " | " .. tostring(err))
        end
    end)
end

print("✅ MeowHub GUI is ready! Click the buttons to load scripts.")
