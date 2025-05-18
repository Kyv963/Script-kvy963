local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- UI
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "PlayerToolsGUI"

-- Conteneur principal HUD
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 420)
mainFrame.Position = UDim2.new(0, -360, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false

local appearTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 10, 0.5, -210)})
mainFrame.Visible = true
appearTween:Play()

-- Titre
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "Nique les Chnew"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)

-- Paramètres bouton ⚙️
local settingsBtn = Instance.new("TextButton", mainFrame)
settingsBtn.Size = UDim2.new(0, 30, 0, 30)
settingsBtn.Position = UDim2.new(1, -70, 0, 5)
settingsBtn.Text = "⚙️"
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 16
settingsBtn.TextColor3 = Color3.new(1,1,1)
settingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local settingsFrame = Instance.new("Frame", screenGui)
settingsFrame.Size = UDim2.new(0, 300, 0, 50)
settingsFrame.Position = UDim2.new(0, 360, 0.5, -200)
settingsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
settingsFrame.Visible = false
settingsFrame.ZIndex = 10

local hotkeyLabel = Instance.new("TextLabel", settingsFrame)
hotkeyLabel.Size = UDim2.new(1, 0, 0.5, 0)
hotkeyLabel.Position = UDim2.new(0, 0, 0.5, -50)
hotkeyLabel.Text = "Hotkey to Toggle HUD: [K]"
hotkeyLabel.Font = Enum.Font.Gotham
hotkeyLabel.TextSize = 14
hotkeyLabel.TextColor3 = Color3.new(1,1,1)
hotkeyLabel.BackgroundTransparency = 1

local changeKeyBtn = Instance.new("TextButton", settingsFrame)
changeKeyBtn.Size = UDim2.new(1, 0, 0.5, 0)
changeKeyBtn.Position = UDim2.new(0, 0, 0.5, 0)
changeKeyBtn.Text = "Click to change hotkey"
changeKeyBtn.Font = Enum.Font.Gotham
changeKeyBtn.TextSize = 14
changeKeyBtn.TextColor3 = Color3.new(1,1,1)
changeKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

settingsBtn.MouseButton1Click:Connect(function()
	settingsFrame.Visible = not settingsFrame.Visible
end)

local currentKey = Enum.KeyCode.K
local changingKey = false

changeKeyBtn.MouseButton1Click:Connect(function()
	changingKey = true
	changeKeyBtn.Text = "Press any key..."
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if changingKey and not gpe then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			currentKey = input.KeyCode
			hotkeyLabel.Text = "Hotkey to Toggle HUD: [" .. input.KeyCode.Name .. "]"
			changeKeyBtn.Text = "Click to change hotkey"
			changingKey = false
		end
	elseif input.KeyCode == currentKey and not gpe then
		mainFrame.Visible = not mainFrame.Visible
	end
end)

-- Fermer
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
	Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
	Camera.CameraType = Enum.CameraType.Custom
	screenGui:Destroy()
end)

-- Côté gauche catégories
local categoryFrame = Instance.new("Frame", mainFrame)
categoryFrame.Size = UDim2.new(0, 60, 1, -40)
categoryFrame.Position = UDim2.new(0, 0, 0, 40)
categoryFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Contenu panels
local panels = {}

-- Fonction pour gérer le changement de catégorie
local function switchTo(panel)
	for _, p in pairs(panels) do
		p.Visible = false
	end
	panel.Visible = true
end

-- Catégorie Player
local playerBtn = Instance.new("TextButton", categoryFrame)
playerBtn.Size = UDim2.new(1, 0, 0, 40)
playerBtn.Text = "👤"
playerBtn.Font = Enum.Font.Gotham
playerBtn.TextSize = 22
playerBtn.TextColor3 = Color3.new(1,1,1)
playerBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local playerPanel = Instance.new("ScrollingFrame", mainFrame)
playerPanel.Size = UDim2.new(1, -60, 1, -40)
playerPanel.Position = UDim2.new(0, 60, 0, 40)
playerPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
playerPanel.BorderSizePixel = 0
playerPanel.ScrollBarThickness = 6
playerPanel.Visible = true

panels["Player"] = playerPanel

local UIListLayout = Instance.new("UIListLayout", playerPanel)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Créer un bouton joueur
local function createPlayerButton(player)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -10, 0, 30)
	container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	local nameBtn = Instance.new("TextButton", container)
	nameBtn.Size = UDim2.new(1, 0, 1, 0)
	nameBtn.Text = player.Name
	nameBtn.Font = Enum.Font.Gotham
	nameBtn.TextSize = 14
	nameBtn.TextColor3 = Color3.fromRGB(255,255,255)
	nameBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

	local optionsFrame = Instance.new("Frame")
	optionsFrame.Size = UDim2.new(0, 160, 0, 180)
	optionsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	optionsFrame.BorderSizePixel = 0
	optionsFrame.Visible = false
	optionsFrame.ZIndex = 20
	optionsFrame.Parent = screenGui

	local closeOptions = Instance.new("TextButton", optionsFrame)
	closeOptions.Size = UDim2.new(0, 162, 0, 20)
	closeOptions.Position = UDim2.new(1, -25, 0, 5)
	closeOptions.Text = "CLOSE"
	closeOptions.Font = Enum.Font.GothamBold
	closeOptions.TextSize = 14
	closeOptions.TextColor3 = Color3.new(1, 1, 1)
	closeOptions.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	closeOptions.ZIndex = 22
	Instance.new("UICorner", closeOptions).CornerRadius = UDim.new(1, 0)
	closeOptions.MouseButton1Click:Connect(function()
		optionsFrame.Visible = false
	end)

	local UIList = Instance.new("UIListLayout", optionsFrame)
	UIList.SortOrder = Enum.SortOrder.LayoutOrder
	UIList.Padding = UDim.new(0, 2)

	local function createOption(text, callback)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 25)
		btn.Text = text
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 12
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		btn.ZIndex = 21
		btn.MouseButton1Click:Connect(callback)
		btn.Parent = optionsFrame
	end

	createOption("TP", function()
		LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
	end)

	createOption("Copy Avatar", function()
		local success, description = pcall(function()
			return Players:GetHumanoidDescriptionFromUserId(player.UserId)
		end)
		if success and description then
			local localHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if localHumanoid then
				localHumanoid:ApplyDescription(description)
			end
		end
	end)

	createOption("Copy Username", function()
		if setclipboard then
			setclipboard(player.Name)
		end
	end)

	createOption("Send MP", function()
		local ChatRemote = game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
		if ChatRemote then
			ChatRemote:FireServer("/w " .. player.Name .. " Hello!", "All")
		end
	end)

	createOption("Spectate", function()
		Camera.CameraSubject = player.Character:FindFirstChild("Humanoid")
	end)

	createOption("Unspectate", function()
		Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
	end)

	nameBtn.MouseButton1Click:Connect(function()
		for _, frame in ipairs(screenGui:GetChildren()) do
			if frame:IsA("Frame") and frame ~= mainFrame and frame ~= settingsFrame and frame ~= playerPanel then
				frame.Visible = false
			end
		end
		optionsFrame.Position = UDim2.new(0, nameBtn.AbsolutePosition.X + nameBtn.AbsoluteSize.X + 10, 0, nameBtn.AbsolutePosition.Y)
		optionsFrame.Visible = not optionsFrame.Visible
	end)

	container.Parent = playerPanel
end

for _, player in pairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		createPlayerButton(player)
	end
end

Players.PlayerAdded:Connect(function(player)
	createPlayerButton(player)
end)

playerBtn.MouseButton1Click:Connect(function()
	switchTo(playerPanel)
end)

-- Catégorie Voice Chat
local voiceBtn = Instance.new("TextButton", categoryFrame)
voiceBtn.Size = UDim2.new(1, 0, 0, 40)
voiceBtn.Position = UDim2.new(0, 0, 0, 40)
voiceBtn.Text = "🔊"
voiceBtn.Font = Enum.Font.Gotham
voiceBtn.TextSize = 22
voiceBtn.TextColor3 = Color3.new(1,1,1)
voiceBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local voicePanel = Instance.new("Frame", mainFrame)
voicePanel.Size = UDim2.new(1, -60, 1, -40)
voicePanel.Position = UDim2.new(0, 60, 0, 40)
voicePanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
voicePanel.BorderSizePixel = 0
voicePanel.Visible = false

-- Bouton Unban VC
local unbanVC = Instance.new("TextButton", voicePanel)
unbanVC.Size = UDim2.new(0, 200, 0, 40)
unbanVC.Position = UDim2.new(0.5, -100, 0, 10)
unbanVC.Text = "Unban VC"
unbanVC.Font = Enum.Font.GothamBold
unbanVC.TextSize = 16
unbanVC.TextColor3 = Color3.new(1,1,1)
unbanVC.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", unbanVC)

unbanVC.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		game:GetService("VoiceChatService"):joinVoice()
	end)
	if not success then
		warn("Erreur lors de l'unban VC : " .. tostring(err))
	end
end)

panels["Voice"] = voicePanel

voiceBtn.MouseButton1Click:Connect(function()
	switchTo(voicePanel)
end)

-- Catégorie Fun
local funBtn = Instance.new("TextButton", categoryFrame)
funBtn.Size = UDim2.new(1, 0, 0, 40)
funBtn.Position = UDim2.new(0, 0, 0, 80)
funBtn.Text = "🎉"
funBtn.Font = Enum.Font.Gotham
funBtn.TextSize = 22
funBtn.TextColor3 = Color3.new(1,1,1)
funBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local funPanel = Instance.new("ScrollingFrame", mainFrame)
funPanel.Size = UDim2.new(1, -60, 1, -40)
funPanel.Position = UDim2.new(0, 60, 0, 40)
funPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
funPanel.BorderSizePixel = 0
funPanel.ScrollBarThickness = 6
funPanel.Visible = false

panels["Fun"] = funPanel

local funLayout = Instance.new("UIListLayout", funPanel)
funLayout.Padding = UDim.new(0, 5)
funLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createFunButton(text, callback)
	local btn = Instance.new("TextButton", funPanel)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.MouseButton1Click:Connect(callback)
end

-- TP random
createFunButton("🚀 Random TP", function()
	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if root then
		local x = math.random(-300, 300)
		local z = math.random(-300, 300)
		local y = 50
		root.CFrame = CFrame.new(x, y, z)
	end
end)

-- Changer couleur du corps
createFunButton("🎨 Random colors", function()
	local char = LocalPlayer.Character
	if char then
		for _, part in ipairs(char:GetChildren()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.Color = Color3.new(math.random(), math.random(), math.random())
			end
		end
	end
end)

-- Danse
createFunButton("💃 danse", function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://507771019" -- exemple animation "Dance"
		local track = humanoid:LoadAnimation(anim)
		track:Play()
	end
end)

-- Saut en boucle
createFunButton("🦘 infini jump", function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		coroutine.wrap(function()
			for i = 1, 999 do
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				wait(0.5)
			end
		end)()
	end
end)

funBtn.MouseButton1Click:Connect(function()
	switchTo(funPanel)
end)

-- Fly toggle
local flying = false
local flyVelocity

createFunButton("🕊️ Fly", function()
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		flying = not flying

		if flying then
			flyVelocity = Instance.new("BodyVelocity")
			flyVelocity.Velocity = Vector3.new(0, 0, 0)
			flyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			flyVelocity.Parent = root

			game:GetService("RunService").RenderStepped:Connect(function()
				if flying and root and flyVelocity then
					local direction = Vector3.new()

					if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += Camera.CFrame.LookVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction -= Camera.CFrame.LookVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction -= Camera.CFrame.RightVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += Camera.CFrame.RightVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0, 1, 0) end
					if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.new(0, 1, 0) end

					flyVelocity.Velocity = direction.Unit * 80
				end
			end)
		else
			if flyVelocity then
				flyVelocity:Destroy()
			end
		end
	end
end)

-- Super Jump toggle
local superJump = false
createFunButton("🦘 Toggle Super Jump", function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		superJump = not superJump
		humanoid.JumpPower = superJump and 150 or 50
	end
end)

-- Super Speed toggle
local superSpeed = false
createFunButton("⚡ Toggle Super Speed", function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		superSpeed = not superSpeed
		humanoid.WalkSpeed = superSpeed and 100 or 16
	end
end)

-- Catégorie PvP
local pvpBtn = Instance.new("TextButton", categoryFrame)
pvpBtn.Size = UDim2.new(1, 0, 0, 40)
pvpBtn.Position = UDim2.new(0, 0, 0, 120)
pvpBtn.Text = "⚔️"
pvpBtn.Font = Enum.Font.Gotham
pvpBtn.TextSize = 22
pvpBtn.TextColor3 = Color3.new(1,1,1)
pvpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local pvpPanel = Instance.new("ScrollingFrame", mainFrame)
pvpPanel.Size = UDim2.new(1, -60, 1, -40)
pvpPanel.Position = UDim2.new(0, 60, 0, 40)
pvpPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
pvpPanel.BorderSizePixel = 0
pvpPanel.ScrollBarThickness = 6
pvpPanel.Visible = false
panels["PvP"] = pvpPanel

local pvpList = Instance.new("UIListLayout", pvpPanel)
pvpList.Padding = UDim.new(0, 5)
pvpList.SortOrder = Enum.SortOrder.LayoutOrder

-- Fonction générique de création de boutons
local function createPvPButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.Parent = pvpPanel
	btn.MouseButton1Click:Connect(callback)
end

-- 🎯 Aimbot
local aimbotEnabled = false
createPvPButton("🎯 Toggle Aimbot", function()
	aimbotEnabled = not aimbotEnabled
	if aimbotEnabled then
		game:GetService("RunService").RenderStepped:Connect(function()
			if not aimbotEnabled then return end
			local closest, shortest = nil, math.huge
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
					local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
					if onScreen and dist < shortest and dist < 150 then
						shortest = dist
						closest = player
					end
				end
			end
			if closest then
				Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.Head.Position)
			end
		end)
	end
end)

-- 📦 Hitbox Expander
local hitboxExpanded = false
createPvPButton("📦 Toggle Hitbox Expander", function()
	hitboxExpanded = not hitboxExpanded
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				hrp.Size = hitboxExpanded and Vector3.new(7, 7, 7) or Vector3.new(2, 2, 1)
				hrp.Transparency = hitboxExpanded and 0.5 or 1
				hrp.Material = hitboxExpanded and Enum.Material.Neon or Enum.Material.Plastic
			end
		end
	end
end)

-- 🖱️ Auto Clicker
local autoClick = false
createPvPButton("🖱️ Toggle Auto Clicker", function()
	autoClick = not autoClick
	if autoClick then
		spawn(function()
			while autoClick do
				local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if tool then
					tool:Activate()
				end
				wait(0.1)
			end
		end)
	end
end)

-- 🔫 Triggerbot
local triggerBot = false
createPvPButton("🔫 Toggle Triggerbot", function()
	triggerBot = not triggerBot
	if triggerBot then
		game:GetService("RunService").RenderStepped:Connect(function()
			if not triggerBot then return end
			local mouse = LocalPlayer:GetMouse()
			local target = mouse.Target
			if target and target.Parent and Players:GetPlayerFromCharacter(target.Parent) then
				local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if tool then
					tool:Activate()
				end
			end
		end)
	end
end)

-- 🛡️ Godmode
createPvPButton("🛡️ Enable Godmode", function()
	local char = LocalPlayer.Character
	if char then
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Name = "God"
			local clone = humanoid:Clone()
			humanoid:Destroy()
			clone.Parent = char
		end
	end
end)

pvpBtn.MouseButton1Click:Connect(function()
	switchTo(pvpPanel)
end)
