-- =============================================
-- MeowHub - All-In-One Loader
-- One loadstring = Loads all scripts safely
-- =============================================

print("MeowHub Starting...")

local baseUrl = "https://raw.githubusercontent.com/zzxncl/MeowHub-Scripts/main/scripts/"

local AllScripts = {
    "cut grass for anime characters",
    "kick a lucky block",
}

print("============================================")
print("Loading " .. #AllScripts .. " Scripts...")
print("============================================")

for _, scriptName in ipairs(AllScripts) do
    local encoded = scriptName:gsub(" ", "%%20")
    local url = baseUrl .. encoded
    
    print("→ Loading: " .. scriptName)
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(url, true))()  -- 'true' forces fresh download
    end)
    
    if success then
        print("✅ Successfully loaded: " .. scriptName)
    else
        warn("❌ Failed to load " .. scriptName)
        warn("   Error: " .. tostring(err))
    end
end

print("============================================")
print("✅ MeowHub Finished Loading All Scripts!")
print("============================================")
