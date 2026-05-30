-->>Variables<<--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Studio = RunService:IsStudio()
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")
local Executor = getexecutor and getexecutor() or identifyexecutor and identifyexecutor() or 'Unable to indentify'
local Hwid = gethwid and gethwid() or hwid and hwid() or 'N/A'

-->>Library Variables<<--
local UnnamedLibrary = {}

UnnamedLibrary.Tabs = {}
UnnamedLibrary.Initialized = false

UnnamedLibrary.CilentLang = LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
UnnamedLibrary.Font = nil
UnnamedLibrary.Debug = false
UnnamedLibrary.AllowPlayerUI = false
UnnamedLibrary.TabCount = 0

-->>Library Theme Variables<<--
UnnamedLibrary.Theme = ''
UnnamedLibrary.ButtonColour = Color3.fromRGB(0,0,0)
UnnamedLibrary.TextColour = Color3.fromRGB(0,0,0)
-->>Library Elements<<--
UnnamedLibrary.UI = nil
UnnamedLibrary.UIFrame = nil
UnnamedLibrary.TabFrame = nil
UnnamedLibrary.TabButtonsLayout = nil
UnnamedLibrary.Title = nil
-->><<--

if UnnamedLibrary.Debug then print("Client Language: ", UnnamedLibrary.CilentLang," Executor: ", Executor, " HWID: ", Hwid) end
if UnnamedLibrary.Debug then print("UnnamedLibrary Loaded") end

-->>Name Protection<<--

function UnnamedLibrary:debug()
	UnnamedLibrary.Debug = not UnnamedLibrary.Debug
	print("Debug mode: ", UnnamedLibrary.Debug)
end

function UnnamedLibrary:allowPlayerUI()
	UnnamedLibrary.AllowPlayerUI = true
end

function UnnamedLibrary:GetTabs()
	return UnnamedLibrary.Tabs
end
function UnnamedLibrary:GetTab(tabName)
	return UnnamedLibrary.Tabs[tabName]
end

function UnnamedLibrary:GetExecutor()
	return Executor
end
function UnnamedLibrary:GetHWID()
	return Hwid
end

function UnnamedLibrary:protectName(element)
	if Studio then return end
	local str = ""

	for _ = 1, math.random(36,126) do
		str ..= utf8.char(math.random(0x0001, 0xFFFF))
	end

	element.Name = str
	return 'Protected Name'
end

if Studio then UnnamedLibrary:allowPlayerUI() end

-->>Library Functions<<--
function UnnamedLibrary:createTitle(title, version)
	if not UnnamedLibrary.Initialized then 
		print("Library not initialized, call intialize function first")
		return
	end
	if UnnamedLibrary.Title then 
		print("Title already exists")
		return
	end
	local textColour = Color3.new(0,0,0)
	if UnnamedLibrary.Theme == 'dark' then 
		textColour = Color3.fromRGB(225,225,225)
	else 
        textColour = Color3.fromRGB(0,0,0)
	end
	
	if UnnamedLibrary.Debug then print("Creating Title with title: ", title, " version: ", version) end
	local titleText = Instance.new('TextLabel')
	titleText.Text = ('	'.. title.. ' - '.. version.. ' - '.. game.Name)
    titleText.TextColor3 = textColour
    titleText.BackgroundTransparency = 1
    titleText.TextScaled = true
    titleText.Size = UDim2.new(0, 450,0, 20)
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = UnnamedLibrary.UIFrame
    titleText.TextTransparency = 0.8
    titleText.Font = UnnamedLibrary.Font
	if UnnamedLibrary.Debug then print("Created Title with title: ", title, " version: ", version) end
	if UnnamedLibrary.Debug then print("Protecting Title Name") end
    UnnamedLibrary:protectName(titleText)
	if UnnamedLibrary.Debug then print("Title Name Protected") end
	UnnamedLibrary.Title = titleText
	if UnnamedLibrary.Debug then print("Title Created") end

	return 'Title Created'
end

function UnnamedLibrary:CreateTab(tabName, frameType)
	if not UnnamedLibrary.Initialized then 
		print("Library not initialized, call intialize function first")
		return
	end
	if frameType ~= 'ScrollingFrame' and frameType ~= 'Frame' then 
		frameType = 'Frame'
		print("Invalid frame type, defaulting to Frame")
	end
	if UnnamedLibrary.Debug then print("Creating Tab with name: ", tabName) end
	UnnamedLibrary.TabCount += 1
	local TabButton = Instance.new('TextButton')
	TabButton.Text = tabName
	TabButton.Font = UnnamedLibrary.Font
	TabButton.TextScaled = true
	TabButton.Parent = UnnamedLibrary.TabFrame
	TabButton.BackgroundColor3 = UnnamedLibrary.ButtonColour
	TabButton.TextColor3 = UnnamedLibrary.TextColour
	TabButton.BorderSizePixel = 0
	if UnnamedLibrary.Debug then print("Created Tab Button: ", tabName) end

	if UnnamedLibrary.Debug then print("Creating Tab Frame") end
	local Tab = Instance.new(frameType)
	Tab.Parent = UnnamedLibrary.UIFrame
	Tab.BackgroundTransparency = 1
	Tab.Size = UDim2.new(0,440,0,510)
	Tab.Position = UDim2.new(0.5,0,0.08,0)
	Tab.AnchorPoint = Vector2.new(0.5,0)
	if UnnamedLibrary.Debug then print("Created Tab Frame") end

	if UnnamedLibrary.Debug then print("Protecting Tab Elements Name") end
	UnnamedLibrary:protectName(TabButton)
	UnnamedLibrary:protectName(Tab)
	if UnnamedLibrary.Debug then print("Tab Elements Name Protected") end
	local TabCount = UnnamedLibrary.TabCount

	UnnamedLibrary.TabButtonsLayout.CellSize = UDim2.new(0,math.clamp(280 / TabCount, 35, 70),0,20)
	TabButton.Name = TabCount.. TabButton.Name

	
	UnnamedLibrary.Tabs[tabName] = {
		Button = TabButton,
		Tab = Tab,
		Type = frameType,
		Sections = {}
	}
	local TabLayout = Instance.new('UIGridLayout')
	TabLayout.Parent = Tab
	TabLayout.CellPadding = UDim2.new(0,40,0,20)
	TabLayout.CellSize = UDim2.new(0, 400,0, 200)
	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabLayout.SortOrder = Enum.SortOrder.Name
	if UnnamedLibrary.Debug then print("Tab Created: ", tabName) end
end

function UnnamedLibrary:createModule(moduleName,tabName)
	if not UnnamedLibrary.Initialized then print("Library not initialized, call intialize function first") return end
	
	local Tabs = UnnamedLibrary.Tabs[tabName]
	if not Tabs then print("Tab not found: ", tabName) return end

	local Module = Instance.new('Frame')
	Module.Parent = Tabs.Tab
	Module.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Module.BorderSizePixel = 0

	local ModuleTitle = Instance.new('TextLabel')
	ModuleTitle.Parent = Module
	ModuleTitle.Text = moduleName
	ModuleTitle.TextColor3 = UnnamedLibrary.TextColour

	return Module
end

function UnnamedLibrary:intialize(theme, font, toggleKey)
	
	if UnnamedLibrary.Debug then print("Initializing UnnamedLibrary with theme: ", theme, " font: ", font, " toggleKey: ", toggleKey) end
	if theme ~= "dark" and theme ~= "light" then 
		UnnamedLibrary.Theme = "dark"
		print("Invalid theme, defaulting to dark")
	else 
		UnnamedLibrary.Theme = theme 
	end

	if typeof(font) == "EnumItem" and font.EnumType == Enum.Font then
		UnnamedLibrary.Font = font
	else
		UnnamedLibrary.Font = Enum.Font.SourceSans
		print("Invalid font, defaulting to SourceSans")
	end

	if typeof(toggleKey) == "EnumItem" and toggleKey.EnumType == Enum.KeyCode then
		UnnamedLibrary.ToggleKey = toggleKey
	else
		UnnamedLibrary.ToggleKey = Enum.KeyCode.RightShift
		print("Invalid toggle key, defaulting to RightShift")
	end

	local UIFrameBackgroundColour = Color3.new(0,0,0)
	local TabsFrameBackgroundColour = Color3.new(0,0,0)
	if UnnamedLibrary.Theme == 'dark' then 
		UIFrameBackgroundColour = Color3.fromRGB(13,13,13) 
		TabsFrameBackgroundColour = Color3.fromRGB(30,30,30)
		UnnamedLibrary.ButtonColour = Color3.fromRGB(26, 26, 26)
		UnnamedLibrary.TextColour = Color3.fromRGB(225,225,225)
	else 
		UIFrameBackgroundColour = Color3.fromRGB(220,220,220) 
		TabsFrameBackgroundColour = Color3.fromRGB(230,230,230)
		UnnamedLibrary.ButtonColour = Color3.fromRGB(240, 240, 240)
		UnnamedLibrary.TextColour = Color3.fromRGB(0,0,0)
	end
	
	if UnnamedLibrary.Debug then print("Creating MainUI") end
    local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.ResetOnSpawn = false
	if UnnamedLibrary.Debug then print("MainUI Created") end

	if UnnamedLibrary.Debug then print("Creating GUIFrame") end
	local GUIFrame = Instance.new('Frame')
	GUIFrame.Size = UDim2.new(0,450,0,600)
	GUIFrame.Parent = ScreenGui
	GUIFrame.BorderSizePixel = 0
	GUIFrame.BackgroundColor3 = UIFrameBackgroundColour
	GUIFrame.Position = UDim2.new(0.5,0,0.5,0)
	GUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	if UnnamedLibrary.Debug then print("GUIFrame Created") end

	if UnnamedLibrary.Debug then print("Creating TabFrame") end
	local TabFrame = Instance.new('Frame')
	TabFrame.BorderSizePixel = 0
	TabFrame.Parent = GUIFrame
	TabFrame.Size = UDim2.new(0, 450,0, 20)
	TabFrame.Position = UDim2.new(0, 0,0.033, 0)
	TabFrame.BackgroundColor3 = TabsFrameBackgroundColour
	if UnnamedLibrary.Debug then print("TabFrame Created") end

	if UnnamedLibrary.Debug then print("Creating TabLayout") end
	local TabLayout = Instance.new('UIGridLayout')
	TabLayout.Parent = TabFrame
	TabLayout.CellSize = UDim2.new(0, 100,0, 20)
	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabLayout.SortOrder = Enum.SortOrder.Name
	if UnnamedLibrary.Debug then print("TabLayout Created") end
	
	if UnnamedLibrary.Debug then print("Connecting InputBegan event") end
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == toggleKey then
			ScreenGui.Enabled = not ScreenGui.Enabled
		end
	end)
	if UnnamedLibrary.Debug then print("InputBegan event connected") end

	if UnnamedLibrary.Debug then print("Protecting MainUI Names") end
	UnnamedLibrary:protectName(ScreenGui)
	UnnamedLibrary:protectName(GUIFrame)
	UnnamedLibrary:protectName(TabFrame)
	UnnamedLibrary:protectName(TabLayout)
	if UnnamedLibrary.Debug then print("MainUI Names Protected") end
	ScreenGui.Parent = (UnnamedLibrary.AllowPlayerUI and PlayerGui) or CoreGui
	UnnamedLibrary.UI = ScreenGui
	UnnamedLibrary.UIFrame = GUIFrame
	UnnamedLibrary.TabFrame = TabFrame
	UnnamedLibrary.TabButtonsLayout = TabLayout
	UnnamedLibrary.Initialized = true
	if UnnamedLibrary.Debug then print("Initialization Complete") end


	return 'Initialized'
end


function UnnamedLibrary:Unload()
	if not UnnamedLibrary.Initialized then print("Library not initialized, call intialize function first") return end
	UnnamedLibrary.UI:Destroy()
	print("UnnamedLibrary Unloaded")
end

return UnnamedLibrary
