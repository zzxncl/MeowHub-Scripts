-- =============================================
-- MeowHub - GUI Loader (Safe Version)
-- One loadstring = Menu to choose scripts
-- =============================================

local baseUrl = "https://raw.githubusercontent.com/zzxncl/MeowHub-Scripts/main/scripts/"

local Scripts = {
    ["Cut Grass for Anime"] = "cut grass for anime characters",
    ["Kick a Lucky Block"] = "kick a lucky block",
}

-- Create GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "MeowHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 300)
frame.Position = UDim2.new(0.5, -175, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.Text = "🔥 Rey's MeowHub"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title.Parent = frame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.Parent = frame

for displayName, fileName in pairs(Scripts) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = displayName
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 16
    btn.Parent = frame
    
    btn.MouseButton1Click:Connect(function()
        local encoded = fileName:gsub(" ", "%%20")
        local url = baseUrl .. encoded
        
        print("🔥 Loading: " .. displayName)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        
        if success then
            print("✅ Loaded: " .. displayName)
        else
            warn("❌ Failed to load " .. displayName .. " | " .. tostring(err))
        end
    end)
end

print("✅ MeowHub GUI Loaded! Click the buttons.")
