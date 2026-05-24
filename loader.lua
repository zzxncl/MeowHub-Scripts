-- =============================================
-- Rey's MeowHub - All-In-One Loader
-- One loadstring = Loads ALL scripts automatically
-- =============================================

print("🔥 Rey's MeowHub Starting...")

local baseUrl = "https://raw.githubusercontent.com/zzxncl/MeowHub-Scripts/main/scripts/"

local AllScripts = {
    "cut grass for anime characters",
    "kick a lucky block",
    -- Add more scripts here later ↓
}

print("============================================")
print("Loading " .. #AllScripts .. " Scripts...")
print("============================================")

for _, scriptName in ipairs(AllScripts) do
    local encoded = scriptName:gsub(" ", "%%20")
    local url = baseUrl .. encoded
    
    print("→ Loading: " .. scriptName)
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print("✅ Successfully loaded: " .. scriptName)
    else
        warn("❌ Failed to load " .. scriptName .. " → " .. tostring(err))
    end
end

print("============================================")
print("✅ MeowHub Finished Loading All Scripts!")
print("============================================")
