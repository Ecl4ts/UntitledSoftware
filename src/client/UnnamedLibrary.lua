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

-->>Library<<--
local UnamedLibrary = {}


UnamedLibrary.CilentLang = LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)

UnamedLibrary.Theme = ''
UnamedLibrary.UI = nil
UnamedLibrary.UIFrame = nil
UnamedLibrary.Font = nil

UnamedLibrary.Debug = false

if UnamedLibrary.Debug then print("Client Language: ", UnamedLibrary.CilentLang," Executor: ", Executor, " HWID: ", Hwid) end
if UnamedLibrary.Debug then print("UnamedLibrary Loaded") end

-->>Name Protection<<--

function UnamedLibrary:debug()
	UnamedLibrary.Debug = not UnamedLibrary.Debug
end
function UnamedLibrary:protectName(element)
	local str = ""

	for _ = 1, math.random(36,126) do
		str ..= utf8.char(math.random(0x0001, 0xFFFF))
	end

	element.Name = str
	return 'Protected Name'
end

-->>Library Functions<<--
function UnamedLibrary:intialize(theme, font, toggleKey)
	if UnamedLibrary.Debug then print("Initializing UnamedLibrary with theme: ", theme, " font: ", font, " toggleKey: ", toggleKey) end
	if theme ~= "dark" and theme ~= "light" then 
		UnamedLibrary.Theme = "dark"
		print("Invalid theme, defaulting to dark")
	else 
		UnamedLibrary.Theme = theme 
	end

	if typeof(font) == "EnumItem" and font.EnumType == Enum.Font then
		UnamedLibrary.Font = font
	else
		UnamedLibrary.Font = Enum.Font.SourceSans
		print("Invalid font, defaulting to SourceSans")
	end

	if typeof(toggleKey) == "EnumItem" and toggleKey.EnumType == Enum.KeyCode then
		UnamedLibrary.ToggleKey = toggleKey
	else
		UnamedLibrary.ToggleKey = Enum.KeyCode.RightShift
		print("Invalid toggle key, defaulting to RightShift")
	end

	local bgColour = Color3.new(0,0,0)
	if UnamedLibrary.Theme == 'dark' then 
		bgColour = Color3.fromRGB(13,13,13) 
	else 
		bgColour = Color3.fromRGB(220,220,220) 
	end
	
	if UnamedLibrary.Debug then print("Creating MainUI") end
    local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = PlayerGui
	ScreenGui.ResetOnSpawn = false
	if UnamedLibrary.Debug then print("MainUI Created") end

	if UnamedLibrary.Debug then print("Creating GUIFrame") end
	local GUIFrame = Instance.new('Frame')
	GUIFrame.Size = UDim2.new(0,450,0,600)
	GUIFrame.Parent = ScreenGui
	GUIFrame.BorderSizePixel = 0
	GUIFrame.BackgroundColor3 = bgColour
	GUIFrame.Position = UDim2.new(0.5,0,0.5,0)
	GUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	if UnamedLibrary.Debug then print("GUIFrame Created") end
	
	UnamedLibrary.UI = ScreenGui
	UnamedLibrary.UIFrame = GUIFrame

	if UnamedLibrary.Debug then print("Creating TabFrame") end
	local TabFrame = Instance.new('Frame')
	TabFrame.BorderSizePixel = 0
	TabFrame.Parent = GUIFrame
	TabFrame.Size = UDim2.new(0, 450,0, 20)
	TabFrame.Position = UDim2.new(0, 0,0.033, 0)
	TabFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	if UnamedLibrary.Debug then print("TabFrame Created") end

	if UnamedLibrary.Debug then print("Creating TabLayout") end
	local TabLayout = Instance.new('UIGridLayout')
	TabLayout.Parent = TabFrame
	TabLayout.CellSize = UDim2.new(0, 100,0, 20)
	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	if UnamedLibrary.Debug then print("TabLayout Created") end


	if UnamedLibrary.Debug then print("Creating HomeTabButton") end
	local HomeTabButton = Instance.new('TextButton')
	HomeTabButton.Text = 'Home'
	HomeTabButton.Parent = TabFrame
	HomeTabButton.Size = UDim2.new(0, 100,0, 20)
	HomeTabButton.BorderSizePixel = 0
	HomeTabButton.BackgroundColor3 = Color3.fromRGB(26,26,26)
	HomeTabButton.TextColor3 = Color3.fromRGB(225,225,225)
	HomeTabButton.Font = UnamedLibrary.Font
	HomeTabButton.TextScaled = true
	if UnamedLibrary.Debug then print("HomeTabButton Created") end

	if UnamedLibrary.Debug then print("Creating HomeTab") end
	local HomeTab = Instance.new('Frame')
	HomeTab.BorderSizePixel = 0
	HomeTab.Parent = GUIFrame
	HomeTab.Size = UDim2.new(0, 450,0, 580)
	HomeTab.Position = UDim2.new(0, 0,0.066, 0)
	HomeTab.BackgroundTransparency = 1
	if UnamedLibrary.Debug then print("HomeTab Created") end
	
	if UnamedLibrary.Debug then print("Connecting InputBegan event") end
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == toggleKey then
			ScreenGui.Enabled = not ScreenGui.Enabled
		end
	end)
	if UnamedLibrary.Debug then print("InputBegan event connected") end

	print("Protecting Names")
	UnamedLibrary:protectName(ScreenGui)
	UnamedLibrary:protectName(GUIFrame)
	UnamedLibrary:protectName(TabFrame)
	UnamedLibrary:protectName(TabLayout)
	UnamedLibrary:protectName(HomeTabButton)
	UnamedLibrary:protectName(HomeTab)
	print("Names Protected")
	print("Initialization Complete")
	return 'Initialized'
end

function UnamedLibrary:createTitle(title, version)
	local bgColour = Color3.new(0,0,0)
	local textColour = Color3.new(0,0,0)
	if UnamedLibrary.Theme == 'dark' then 
		bgColour = Color3.fromRGB(26,26,26)
		textColour = Color3.fromRGB(225,225,225)
	else 
		bgColour = Color3.fromRGB(210,210,210) 
        textColour = Color3.fromRGB(0,0,0)
	end
	local titleFrame = Instance.new('Frame')
	titleFrame.BorderSizePixel = 0
	titleFrame.Parent = UnamedLibrary.UIFrame
	titleFrame.Size = UDim2.new(0,450,0,20)
	titleFrame.BackgroundColor3 = bgColour
	
	local titleText = Instance.new('TextLabel')
	titleText.Text = ('	'.. title.. ' - '.. version.. ' - '.. game.Name)
    titleText.TextColor3 = textColour
    titleText.BackgroundTransparency = 1
    titleText.TextScaled = true
    titleText.Size = UDim2.new(0, 450,0, 20)
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleFrame
    titleText.TextTransparency = 0.8
    titleText.Font = UnamedLibrary.Font
    UnamedLibrary:protectName(titleFrame)
    UnamedLibrary:protectName(titleText)

	return 'Title Created'
end


return UnamedLibrary