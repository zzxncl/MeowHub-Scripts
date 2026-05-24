-- =============================================================================
-- 🐾 MeowHub - Premium GUI Loader
-- Smooth animations, search filter, modern design, dragging, and loading states
-- =============================================================================

local baseUrl = "https://raw.githubusercontent.com/zzxncl/MeowHub-Scripts/main/scripts/"

local Scripts = {
    ["Cut Grass for Anime"] = "cut grass for anime characters",
    ["Kick a Lucky Block"] = "kick a lucky block",
}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = nil

-- Attempt to find CoreGui for exploit support, fallback to PlayerGui for testing/Studio
local success, err = pcall(function()
    CoreGui = game:GetService("CoreGui")
end)
local localPlayer = Players.LocalPlayer
local targetParent = (success and CoreGui) or localPlayer:WaitForChild("PlayerGui")

-- Check if MeowHub is already running, and destroy the old instance
if targetParent:FindFirstChild("MeowHub") then
    targetParent.MeowHub:Destroy()
end

-- Create GUI Instance
local gui = Instance.new("ScreenGui")
gui.Name = "MeowHub"
gui.ResetOnSpawn = false
gui.Parent = targetParent

-- UI Configuration (Purple-Pink Neon Gradient Theme)
local Colors = {
    Background = Color3.fromRGB(15, 15, 20),
    BackgroundSecondary = Color3.fromRGB(24, 24, 30),
    SearchBg = Color3.fromRGB(25, 25, 33),
    TextActive = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(156, 163, 175),
    BorderMuted = Color3.fromRGB(45, 45, 55),
    AccentPurple = Color3.fromRGB(147, 51, 234),
    AccentPink = Color3.fromRGB(244, 114, 182),
    SuccessGreen = Color3.fromRGB(34, 197, 94),
    ErrorRed = Color3.fromRGB(239, 68, 68)
}

-- Main Frame (Dimensions: 360 width, 420 height)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 0, 0, 0) -- Starts at 0, 0 for opening animation
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center Screen (AnchorPoint will make it center)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Colors.Background
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

-- Rounded Corners for Main Frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Subtle Background Gradient (Angled)
local mainBgGradient = Instance.new("UIGradient")
mainBgGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 14))
}
mainBgGradient.Rotation = 45
mainBgGradient.Parent = mainFrame

-- Glowing Accent Border Outline
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 55)
mainStroke.Thickness = 1.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = mainFrame

-- Purple/Pink Gradient for Border Outline
local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.AccentPurple),
    ColorSequenceKeypoint.new(1, Colors.AccentPink)
}
strokeGradient.Rotation = 90
strokeGradient.Parent = mainStroke

-- =============================================================================
-- Title Bar (Header)
-- =============================================================================
local headerFrame = Instance.new("Frame")
headerFrame.Name = "HeaderFrame"
headerFrame.Size = UDim2.new(1, 0, 0, 45)
headerFrame.BackgroundTransparency = 1
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -90, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🐾 MEOW<b>HUB</b>"
titleText.RichText = true
titleText.TextColor3 = Colors.TextActive
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamMedium
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = headerFrame

-- Action Buttons Container
local controlsContainer = Instance.new("Frame")
controlsContainer.Name = "ControlsContainer"
controlsContainer.Size = UDim2.new(0, 70, 1, 0)
controlsContainer.Position = UDim2.new(1, -75, 0, 0)
controlsContainer.BackgroundTransparency = 1
controlsContainer.Parent = headerFrame

-- Helper to style control buttons
local function createControlBtn(text, xOffset, name)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 26, 0, 26)
    btn.Position = UDim2.new(0, xOffset, 0.5, -13)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Colors.TextMuted
    btn.TextSize = name == "CloseButton" and 18 or 14
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = controlsContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.BorderMuted
    stroke.Thickness = 1
    stroke.Parent = btn

    -- Hover Animations
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = name == "CloseButton" and Color3.fromRGB(180, 50, 50) or Color3.fromRGB(50, 50, 60),
            TextColor3 = Colors.TextActive
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Color = name == "CloseButton" and Color3.fromRGB(220, 80, 80) or Colors.AccentPurple
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 35),
            TextColor3 = Colors.TextMuted
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Color = Colors.BorderMuted
        }):Play()
    end)

    return btn
end

local minBtn = createControlBtn("−", 0, "MinimizeButton")
local closeBtn = createControlBtn("×", 32, "CloseButton")

-- =============================================================================
-- Search Bar Frame
-- =============================================================================
local searchContainer = Instance.new("Frame")
searchContainer.Name = "SearchContainer"
searchContainer.Size = UDim2.new(1, -30, 0, 36)
searchContainer.Position = UDim2.new(0, 15, 0, 50)
searchContainer.BackgroundColor3 = Colors.SearchBg
searchContainer.BorderSizePixel = 0
searchContainer.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchContainer

local searchStroke = Instance.new("UIStroke")
searchStroke.Color = Colors.BorderMuted
searchStroke.Thickness = 1
searchStroke.Parent = searchContainer

local searchIcon = Instance.new("TextLabel")
searchIcon.Name = "SearchIcon"
searchIcon.Size = UDim2.new(0, 20, 0, 20)
searchIcon.Position = UDim2.new(0, 10, 0.5, -10)
searchIcon.BackgroundTransparency = 1
searchIcon.Text = "🔍"
searchIcon.TextSize = 12
searchIcon.TextColor3 = Colors.TextMuted
searchIcon.Font = Enum.Font.Gotham
local centerAlign = Instance.new("UIListLayout") -- Quick visual align helper
searchIcon.Parent = searchContainer

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, -45, 1, 0)
searchBox.Position = UDim2.new(0, 35, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.Text = ""
searchBox.PlaceholderText = "Search scripts..."
searchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
searchBox.TextColor3 = Colors.TextActive
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Gotham
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.Parent = searchContainer

-- Visual Glow on Focus
searchBox.Focused:Connect(function()
    TweenService:Create(searchStroke, TweenInfo.new(0.25), {
        Color = Colors.AccentPurple
    }):Play()
end)

searchBox.FocusLost:Connect(function()
    TweenService:Create(searchStroke, TweenInfo.new(0.25), {
        Color = Colors.BorderMuted
    }):Play()
end)

-- =============================================================================
-- Scripts List Container (ScrollFrame)
-- =============================================================================
local scrollContainer = Instance.new("ScrollingFrame")
scrollContainer.Name = "ScrollContainer"
scrollContainer.Size = UDim2.new(1, -30, 1, -110)
scrollContainer.Position = UDim2.new(0, 15, 0, 96)
scrollContainer.BackgroundTransparency = 1
scrollContainer.BorderSizePixel = 0
scrollContainer.ScrollBarThickness = 3
scrollContainer.ScrollBarImageColor3 = Colors.AccentPurple
scrollContainer.ScrollBarImageTransparency = 0.4
scrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollContainer.AutomaticCanvasSize = Enum.AutomaticCanvasSize.Y
scrollContainer.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.Parent = scrollContainer

-- =============================================================================
-- Button Generation and Dynamic Animations
-- =============================================================================
local buttonsMap = {}

for displayName, fileName in pairs(Scripts) do
    -- Parent container is used to allow scale-down click animations without affecting UIListLayout
    local itemContainer = Instance.new("Frame")
    itemContainer.Name = displayName .. "_Container"
    itemContainer.Size = UDim2.new(1, 0, 0, 48)
    itemContainer.BackgroundTransparency = 1
    itemContainer.Parent = scrollContainer

    local btn = Instance.new("TextButton")
    btn.Name = displayName
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Position = UDim2.new(0.5, 0, 0.5, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Colors.BackgroundSecondary
    btn.BorderSizePixel = 0
    btn.Text = "" -- Empty text since we are using labels for premium styling
    btn.AutoButtonColor = false
    btn.Parent = itemContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Colors.BorderMuted
    btnStroke.Thickness = 1
    btnStroke.Parent = btn

    local scriptIcon = Instance.new("TextLabel")
    scriptIcon.Name = "ScriptIcon"
    scriptIcon.Size = UDim2.new(0, 24, 0, 24)
    scriptIcon.Position = UDim2.new(0, 12, 0.5, -12)
    scriptIcon.BackgroundTransparency = 1
    scriptIcon.Text = "📄"
    scriptIcon.TextSize = 14
    scriptIcon.TextColor3 = Colors.AccentPurple
    scriptIcon.Parent = btn

    local nameText = Instance.new("TextLabel")
    nameText.Name = "ScriptNameText"
    nameText.Size = UDim2.new(1, -95, 1, 0)
    nameText.Position = UDim2.new(0, 44, 0, 0)
    nameText.BackgroundTransparency = 1
    nameText.Text = displayName
    nameText.TextColor3 = Colors.TextMuted
    nameText.TextSize = 13
    nameText.Font = Enum.Font.GothamMedium
    nameText.TextXAlignment = Enum.TextXAlignment.Left
    nameText.Parent = btn

    local statusText = Instance.new("TextLabel")
    statusText.Name = "ScriptStatusText"
    statusText.Size = UDim2.new(0, 40, 1, 0)
    statusText.Position = UDim2.new(1, -50, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "→"
    statusText.TextColor3 = Colors.TextMuted
    statusText.TextSize = 15
    statusText.Font = Enum.Font.GothamBold
    statusText.TextXAlignment = Enum.TextXAlignment.Right
    statusText.Parent = btn

    buttonsMap[displayName] = itemContainer

    -- Hover Tweens
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(32, 28, 44)
        }):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Color = Colors.AccentPurple
        }):Play()
        TweenService:Create(nameText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            TextColor3 = Colors.TextActive
        }):Play()
        TweenService:Create(statusText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            TextColor3 = Colors.AccentPink,
            Position = UDim2.new(1, -45, 0, 0) -- Slide arrow right on hover
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Colors.BackgroundSecondary
        }):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Color = Colors.BorderMuted
        }):Play()
        TweenService:Create(nameText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            TextColor3 = Colors.TextMuted
        }):Play()
        TweenService:Create(statusText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            TextColor3 = Colors.TextMuted,
            Position = UDim2.new(1, -50, 0, 0) -- Return arrow to place
        }):Play()
    end)

    -- Click & Loading Logic
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0.96, 0, 0.92, 0)
        }):Play()
    end)

    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        -- Prevent clicking while already loading
        if statusText.Text == "⏳" then return end

        statusText.Text = "⏳"
        statusText.TextColor3 = Colors.AccentPurple
        nameText.TextColor3 = Color3.fromRGB(150, 150, 160)

        local encoded = fileName:gsub(" ", "%%20")
        local url = baseUrl .. encoded
        
        print("🔥 Loading: " .. displayName)

        -- Short wait so the user registers the dynamic visual transition
        task.wait(0.2)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        
        if success then
            print("✅ Loaded: " .. displayName)
            statusText.Text = "✅"
            statusText.TextColor3 = Colors.SuccessGreen
            nameText.TextColor3 = Colors.SuccessGreen
            
            task.delay(1.5, function()
                if statusText.Text == "✅" then
                    statusText.Text = "→"
                    statusText.TextColor3 = Colors.TextMuted
                    nameText.TextColor3 = Colors.TextMuted
                end
            end)
        else
            warn("❌ Failed to load " .. displayName .. " | " .. tostring(err))
            statusText.Text = "❌"
            statusText.TextColor3 = Colors.ErrorRed
            nameText.TextColor3 = Colors.ErrorRed
            
            task.delay(2.5, function()
                if statusText.Text == "❌" then
                    statusText.Text = "→"
                    statusText.TextColor3 = Colors.TextMuted
                    nameText.TextColor3 = Colors.TextMuted
                end
            end)
        end
    end)
end

-- =============================================================================
-- Dynamic Search Filtering Logic
-- =============================================================================
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBox.Text:lower()
    for displayName, container in pairs(buttonsMap) do
        if displayName:lower():find(query) then
            container.Visible = true
        else
            container.Visible = false
        end
    end
end)

-- =============================================================================
-- Minimize and Close Window Mechanics
-- =============================================================================
local isMinimized = false
local defaultFrameHeight = 420
local minimizedFrameHeight = 45

minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetHeight = isMinimized and minimizedFrameHeight or defaultFrameHeight
    
    -- Swap controls and title visibility based on state
    if isMinimized then
        minBtn.Text = "+"
        TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, targetHeight)
        }):Play()
    else
        minBtn.Text = "−"
        TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, targetHeight)
        }):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    -- Smooth Scale Down & Fade Close
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    task.delay(0.3, function()
        gui:Destroy()
    end)
end)

-- =============================================================================
-- Dragging Mechanics (Touch & Mouse Support with Smooth Tweens)
-- =============================================================================
local dragToggle = nil
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X, 
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
    -- Smooth drag tweening so it floats elegantly with movement
    TweenService:Create(mainFrame, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Position = position}):Play()
end

headerFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) 
       and UserInputService:GetFocusedTextBox() == nil then
        dragToggle = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

headerFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragToggle then
        updateInput(input)
    end
end)

-- =============================================================================
-- Entrance Animation (Smooth Scale Bounce)
-- =============================================================================
mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 360, 0, defaultFrameHeight)
}):Play()

print("✅ MeowHub GUI Loaded Successfully!")
