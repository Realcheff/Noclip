local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Plr = Players.LocalPlayer
local Clipon = false
local Stepped

-- GUI
local Noclip = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleHolder = Instance.new("Frame")
local Toggle = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local Watermark = Instance.new("TextLabel")

Noclip.Name = "Blaze_GUI"
Noclip.Parent = CoreGui

-- FUNDO
BG.Parent = Noclip
BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
BG.BackgroundTransparency = 1
BG.BorderSizePixel = 0

-- TAMANHO MENOR
BG.Position = UDim2.new(0.138,0,0.145,0)
BG.Size = UDim2.new(0,120,0,56)

BG.Active = true
BG.Draggable = true

local BGCorner = Instance.new("UICorner")
BGCorner.CornerRadius = UDim.new(0,8)
BGCorner.Parent = BG

TweenService:Create(
	BG,
	TweenInfo.new(0.2),
	{
		BackgroundTransparency = 0.35
	}
):Play()

-- TÍTULO
Title.Parent = BG
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0

Title.AnchorPoint = Vector2.new(0.5,0)
Title.Position = UDim2.new(0.5,0,0,3)

Title.Size = UDim2.new(0,90,0,14)

Title.Font = Enum.Font.GothamBold
Title.Text = "Blaze v2.0"

Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextColor3 = Color3.fromRGB(0,220,120)
Title.TextSize = 10

Title.TextStrokeTransparency = 0.85
Title.TextStrokeColor3 = Color3.fromRGB(0,255,120)

-- BOTÃO FECHAR
Close.Parent = BG
Close.BackgroundColor3 = Color3.fromRGB(120,40,40)
Close.BackgroundTransparency = 0.1
Close.BorderSizePixel = 0

Close.Position = UDim2.new(1,-18,0,2)
Close.Size = UDim2.new(0,14,0,14)

Close.Font = Enum.Font.GothamBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.TextSize = 9

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1,0)
CloseCorner.Parent = Close

-- BORDA VERDE
ToggleHolder.Parent = BG
ToggleHolder.BackgroundColor3 = Color3.fromRGB(0,220,120)

-- COMEÇA INVISÍVEL
ToggleHolder.BackgroundTransparency = 1

ToggleHolder.BorderSizePixel = 0
ToggleHolder.Position = UDim2.new(0.13,0,0.40,0)
ToggleHolder.Size = UDim2.new(0,86,0,20)

local HolderCorner = Instance.new("UICorner")
HolderCorner.CornerRadius = UDim.new(1,0)
HolderCorner.Parent = ToggleHolder

-- BOTÃO
Toggle.Parent = ToggleHolder
Toggle.BackgroundColor3 = Color3.fromRGB(90,90,90)
Toggle.BorderSizePixel = 0

Toggle.Position = UDim2.new(0,1,0,1)
Toggle.Size = UDim2.new(1,-2,1,-2)

Toggle.Font = Enum.Font.GothamBold
Toggle.Text = "DISABLED"
Toggle.TextColor3 = Color3.fromRGB(255,255,255)
Toggle.TextSize = 9

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1,0)
ToggleCorner.Parent = Toggle

-- COPYRIGHT
Watermark.Parent = BG
Watermark.BackgroundTransparency = 1

Watermark.AnchorPoint = Vector2.new(0.5,0)
Watermark.Position = UDim2.new(0.5,0,0.78,0)

Watermark.Size = UDim2.new(0,80,0,10)

Watermark.Font = Enum.Font.Gotham
Watermark.Text = "© Copyright"

Watermark.TextTransparency = 0.55
Watermark.TextColor3 = Color3.fromRGB(255,255,255)
Watermark.TextSize = 8

-- FEEDBACK VISUAL
local function ButtonEffect()

	local shrink = TweenService:Create(
		ToggleHolder,
		TweenInfo.new(0.05),
		{
			Size = UDim2.new(0,82,0,18),
			Position = UDim2.new(0.145,0,0.42,0)
		}
	)

	local expand = TweenService:Create(
		ToggleHolder,
		TweenInfo.new(0.05),
		{
			Size = UDim2.new(0,86,0,20),
			Position = UDim2.new(0.13,0,0.40,0)
		}
	)

	shrink:Play()
	shrink.Completed:Wait()
	expand:Play()

end

-- FUNÇÃO PARA DESABILITAR COLISÃO
local function DisableCollisions()
	if Plr.Character then
		for _, v in pairs(Plr.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end

-- FUNÇÃO PARA HABILITAR COLISÃO
local function EnableCollisions()
	if Plr.Character then
		for _, v in pairs(Plr.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end
end

-- TOGGLE NOCLIP
Toggle.MouseButton1Click:Connect(function()

	ButtonEffect()

	if not Clipon then

		Clipon = true
		Toggle.Text = "ACTIVE"

		-- MOSTRA BORDA VERDE
		TweenService:Create(
			ToggleHolder,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 0
			}
		):Play()

		-- COR VERDE
		TweenService:Create(
			Toggle,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(0,145,95)
			}
		):Play()

		DisableCollisions()

		Stepped = RunService.Stepped:Connect(function()
			if Plr.Character then
				for _, v in pairs(Plr.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
						v.CustomPhysicalProperties = PhysicalProperties.new(0, 0.7, 0.5, 1, 1)
					end
				end
			end
		end)

	else

		Clipon = false
		Toggle.Text = "DISABLED"

		-- ESCONDE BORDA
		TweenService:Create(
			ToggleHolder,
			TweenInfo.new(0.15),
			{
				BackgroundTransparency = 1
			}
		):Play()

		-- VOLTA CINZA
		TweenService:Create(
			Toggle,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Color3.fromRGB(90,90,90)
			}
		):Play()

		if Stepped then
			Stepped:Disconnect()
		end

		EnableCollisions()
	end
end)

-- FECHAR GUI
Close.MouseButton1Click:Connect(function()

	Clipon = false

	if Stepped then
		Stepped:Disconnect()
	end

	EnableCollisions()
	Noclip:Destroy()

end)
