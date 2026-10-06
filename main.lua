-- Hitbox + Silent Aim + Extras | Delta Executor
-- Português BR | Versão Completa

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- ============ CONFIG ============
local HitboxEnabled = false
local HitboxSize = 25
local HitboxColor = Color3.fromRGB(255, 0, 0)
local HitboxTransparency = 0

local SilentAimEnabled = false
local FOVSize = 150

local ESPEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local FullBrightEnabled = false

local OriginalSizes = {}
local OriginalColors = {}
local OriginalTransparency = {}
local Dragging = false
local DraggingFOV = false
local ESPObjects = {}

-- ============ UI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HitboxGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 520)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "Hitbox + Silent Aim + Extras"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 16
MinimizeBtn.Parent = Title

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinimizeBtn

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ====== HITBOX ======
local HitboxLabel = Instance.new("TextLabel")
HitboxLabel.Size = UDim2.new(1, -20, 0, 20)
HitboxLabel.Position = UDim2.new(0, 10, 0, 5)
HitboxLabel.BackgroundTransparency = 1
HitboxLabel.Text = "— Hitbox Expander —"
HitboxLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
HitboxLabel.Font = Enum.Font.SourceSansBold
HitboxLabel.TextSize = 13
HitboxLabel.TextXAlignment = Enum.TextXAlignment.Left
HitboxLabel.Parent = ContentFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleButton.Text = "Hitbox OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 13
ToggleButton.Parent = ContentFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(0, 130, 0, 30)
ValueLabel.Position = UDim2.new(0, 120, 0, 30)
ValueLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ValueLabel.Text = "Size: 25"
ValueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ValueLabel.Font = Enum.Font.SourceSans
ValueLabel.TextSize = 13
ValueLabel.Parent = ContentFrame

local ValueCorner = Instance.new("UICorner")
ValueCorner.CornerRadius = UDim.new(0, 6)
ValueCorner.Parent = ValueLabel

local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(0, 250, 0, 18)
SliderFrame.Position = UDim2.new(0, 10, 0, 70)
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderFrame.Parent = ContentFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 4)
SliderCorner.Parent = SliderFrame

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.2, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.Parent = SliderFrame

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 4)
FillCorner.Parent = SliderFill

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 16, 0, 16)
SliderButton.Position = UDim2.new(0.2, -8, 0.5, -8)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.Text = ""
SliderButton.Parent = SliderFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = SliderButton

-- ====== COR ======
local ColorLabel = Instance.new("TextLabel")
ColorLabel.Size = UDim2.new(1, -20, 0, 18)
ColorLabel.Position = UDim2.new(0, 10, 0, 95)
ColorLabel.BackgroundTransparency = 1
ColorLabel.Text = "Cor da Hitbox:"
ColorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ColorLabel.Font = Enum.Font.SourceSans
ColorLabel.TextSize = 12
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
ColorLabel.Parent = ContentFrame

local ColorPreview = Instance.new("TextButton")
ColorPreview.Size = UDim2.new(0, 40, 0, 22)
ColorPreview.Position = UDim2.new(0, 100, 0, 93)
ColorPreview.BackgroundColor3 = HitboxColor
ColorPreview.Text = ""
ColorPreview.Parent = ContentFrame

local ColorPreviewCorner = Instance.new("UICorner")
ColorPreviewCorner.CornerRadius = UDim.new(0, 4)
ColorPreviewCorner.Parent = ColorPreview

local presetColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 100, 255),
    Color3.fromRGB(180, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 255, 255),
}
local selectedColorIndex = 1

local ColorBtn = Instance.new("TextButton")
ColorBtn.Size = UDim2.new(0, 80, 0, 22)
ColorBtn.Position = UDim2.new(0, 145, 0, 93)
ColorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ColorBtn.Text = "Trocar ▸"
ColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorBtn.Font = Enum.Font.SourceSans
ColorBtn.TextSize = 12
ColorBtn.Parent = ContentFrame

local ColorBtnCorner = Instance.new("UICorner")
ColorBtnCorner.CornerRadius = UDim.new(0, 4)
ColorBtnCorner.Parent = ColorBtn

ColorBtn.MouseButton1Click:Connect(function()
    selectedColorIndex = selectedColorIndex + 1
    if selectedColorIndex > #presetColors then selectedColorIndex = 1 end
    HitboxColor = presetColors[selectedColorIndex]
    ColorPreview.BackgroundColor3 = HitboxColor
    if HitboxEnabled then ApplyHitbox() end
end)

-- ====== SILENT AIM ======
local SilentLabel = Instance.new("TextLabel")
SilentLabel.Size = UDim2.new(1, -20, 0, 18)
SilentLabel.Position = UDim2.new(0, 10, 0, 125)
SilentLabel.BackgroundTransparency = 1
SilentLabel.Text = "— Silent Aim (FOV) —"
SilentLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
SilentLabel.Font = Enum.Font.SourceSansBold
SilentLabel.TextSize = 13
SilentLabel.TextXAlignment = Enum.TextXAlignment.Left
SilentLabel.Parent = ContentFrame

local SilentAimBtn = Instance.new("TextButton")
SilentAimBtn.Size = UDim2.new(0, 120, 0, 30)
SilentAimBtn.Position = UDim2.new(0, 10, 0, 148)
SilentAimBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
SilentAimBtn.Text = "Silent Aim OFF"
SilentAimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SilentAimBtn.Font = Enum.Font.SourceSansBold
SilentAimBtn.TextSize = 12
SilentAimBtn.Parent = ContentFrame

local SilentAimCorner = Instance.new("UICorner")
SilentAimCorner.CornerRadius = UDim.new(0, 6)
SilentAimCorner.Parent = SilentAimBtn

local FOVValueLabel = Instance.new("TextLabel")
FOVValueLabel.Size = UDim2.new(0, 100, 0, 30)
FOVValueLabel.Position = UDim2.new(0, 140, 0, 148)
FOVValueLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
FOVValueLabel.Text = "FOV: 150"
FOVValueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
FOVValueLabel.Font = Enum.Font.SourceSans
FOVValueLabel.TextSize = 12
FOVValueLabel.Parent = ContentFrame

local FOVValueCorner = Instance.new("UICorner")
FOVValueCorner.CornerRadius = UDim.new(0, 6)
FOVValueCorner.Parent = FOVValueLabel

local FOVSliderFrame = Instance.new("Frame")
FOVSliderFrame.Size = UDim2.new(0, 250, 0, 18)
FOVSliderFrame.Position = UDim2.new(0, 10, 0, 188)
FOVSliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FOVSliderFrame.Parent = ContentFrame

local FOVSliderCorner = Instance.new("UICorner")
FOVSliderCorner.CornerRadius = UDim.new(0, 4)
FOVSliderCorner.Parent = FOVSliderFrame

local FOVSliderFill = Instance.new("Frame")
FOVSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
FOVSliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
FOVSliderFill.Parent = FOVSliderFrame

local FOVFillCorner = Instance.new("UICorner")
FOVFillCorner.CornerRadius = UDim.new(0, 4)
FOVFillCorner.Parent = FOVSliderFill

local FOVSliderButton = Instance.new("TextButton")
FOVSliderButton.Size = UDim2.new(0, 16, 0, 16)
FOVSliderButton.Position = UDim2.new(0.5, -8, 0.5, -8)
FOVSliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FOVSliderButton.Text = ""
FOVSliderButton.Parent = FOVSliderFrame

local FOVBtnCorner = Instance.new("UICorner")
FOVBtnCorner.CornerRadius = UDim.new(1, 0)
FOVBtnCorner.Parent = FOVSliderButton

-- ====== EXTRAS ======
local ExtraLabel = Instance.new("TextLabel")
ExtraLabel.Size = UDim2.new(1, -20, 0, 18)
ExtraLabel.Position = UDim2.new(0, 10, 0, 215)
ExtraLabel.BackgroundTransparency = 1
ExtraLabel.Text = "— Extras —"
ExtraLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
ExtraLabel.Font = Enum.Font.SourceSansBold
ExtraLabel.TextSize = 13
ExtraLabel.TextXAlignment = Enum.TextXAlignment.Left
ExtraLabel.Parent = ContentFrame

local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(0, 80, 0, 28)
ESPBtn.Position = UDim2.new(0, 10, 0, 238)
ESPBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ESPBtn.Text = "ESP OFF"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.Font = Enum.Font.SourceSansBold
ESPBtn.TextSize = 11
ESPBtn.Parent = ContentFrame

local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 6)
ESPCorner.Parent = ESPBtn

local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(0, 80, 0, 28)
FlyBtn.Position = UDim2.new(0, 95, 0, 238)
FlyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
FlyBtn.Text = "Fly OFF"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSansBold
FlyBtn.TextSize = 11
FlyBtn.Parent = ContentFrame

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 6)
FlyCorner.Parent = FlyBtn

local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Size = UDim2.new(0, 80, 0, 28)
NoclipBtn.Position = UDim2.new(0, 180, 0, 238)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
NoclipBtn.Text = "Noclip OFF"
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.Font = Enum.Font.SourceSansBold
NoclipBtn.TextSize = 11
NoclipBtn.Parent = ContentFrame

local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0, 6)
NoclipCorner.Parent = NoclipBtn

local BrightBtn = Instance.new("TextButton")
BrightBtn.Size = UDim2.new(0, 80, 0, 28)
BrightBtn.Position = UDim2.new(0, 10, 0, 272)
BrightBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
BrightBtn.Text = "FullBright OFF"
BrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BrightBtn.Font = Enum.Font.SourceSansBold
BrightBtn.TextSize = 11
BrightBtn.Parent = ContentFrame

local BrightCorner = Instance.new("UICorner")
BrightCorner.CornerRadius = UDim.new(0, 6)
BrightCorner.Parent = BrightBtn

local TPBtn = Instance.new("TextButton")
TPBtn.Size = UDim2.new(0, 80, 0, 28)
TPBtn.Position = UDim2.new(0, 95, 0, 272)
TPBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TPBtn.Text = "Click TP"
TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBtn.Font = Enum.Font.SourceSansBold
TPBtn.TextSize = 11
TPBtn.Parent = ContentFrame

local TPCorner = Instance.new("UICorner")
TPCorner.CornerRadius = UDim.new(0, 6)
TPCorner.Parent = TPBtn

-- FOV Circle
local FOVCircle = Instance.new("Frame")
FOVCircle.Size = UDim2.new(0, FOVSize, 0, FOVSize)
FOVCircle.Position = UDim2.new(0.5, -FOVSize/2, 0.5, -FOVSize/2)
FOVCircle.BackgroundTransparency = 1
FOVCircle.BorderSizePixel = 0
FOVCircle.Parent = ScreenGui

local FOVCircleCorner = Instance.new("UICorner")
FOVCircleCorner.CornerRadius = UDim.new(1, 0)
FOVCircleCorner.Parent = FOVCircle

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = Color3.fromRGB(255, 100, 100)
FOVStroke.Thickness = 2
FOVStroke.Transparency = 0.3
FOVStroke.Parent = FOVCircle

-- ============ FUNÇÕES ============

function ApplyHitbox()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and hrp:IsA("Part") then
                if not OriginalSizes[player] then
                    OriginalSizes[player] = hrp.Size
                    OriginalColors[player] = hrp.Color
                    OriginalTransparency[player] = hrp.Transparency
                end
                hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                hrp.Transparency = HitboxTransparency
                hrp.Color = HitboxColor
                hrp.CanCollide = false
                hrp.Massless = true
                hrp.CastShadow = false
            end
        end
    end
end

function ResetHitbox()
    for player, originalSize in pairs(OriginalSizes) do
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = originalSize
                hrp.Color = OriginalColors[player] or Color3.fromRGB(255, 255, 255)
                hrp.Transparency = OriginalTransparency[player] or 0
                hrp.CanCollide = true
                hrp.Massless = false
                hrp.CastShadow = true
            end
        end
    end
    OriginalSizes = {}
    OriginalColors = {}
    OriginalTransparency = {}
end

-- Silent Aim: Encontra o jogador mais próximo do mouse dentro do FOV
local function GetClosestPlayerToMouse()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local camera = Workspace.CurrentCamera

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            if head and humanoid and humanoid.Health > 0 then
                local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                    
                    if dist <= (FOVSize / 2) and dist < shortestDistance then
                        shortestDistance = dist
                        closestPlayer = player
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Hook do Silent Aim no Mouse.Hit
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() and self == LocalPlayer:GetMouse() and (key == "Hit" or key == "Target") then
        if SilentAimEnabled then
            local target = GetClosestPlayerToMouse()
            if target and target.Character then
                local head = target.Character:FindFirstChild("Head")
                if head then
                    return CFrame.new(head.Position)
                end
            end
        end
    end
    return oldIndex(self, key)
end)

-- ESP
function CreateESP(player)
    if ESPObjects[player] then return end
    local box = Drawing.new("Square")
    box.Thickness = 1
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Filled = false
    box.Transparency = 1
    
    local nameTag = Drawing.new("Text")
    nameTag.Size = 14
    nameTag.Center = true
    nameTag.Outline = true
    nameTag.Color = Color3.fromRGB(255, 255, 255)
    nameTag.Transparency = 1
    
    ESPObjects[player] = {box = box, nameTag = nameTag}
end

function RemoveESP(player)
    if ESPObjects[player] then
        ESPObjects[player].box:Remove()
        ESPObjects[player].nameTag:Remove()
        ESPObjects[player] = nil
    end
end

-- Fly
local flyBV, flyBG
function ToggleFly(state)
    FlyEnabled = state
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if state then
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBV.Velocity = Vector3.new(0, 0, 0)
        flyBV.Parent = hrp
        
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBG.P = 9e4
        flyBG.Parent = hrp
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
    end
end

-- Noclip
function SetNoclip(state)
    NoclipEnabled = state
    if state then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- FullBright
local originalBrightness, originalFogEnd
function SetFullBright(state)
    FullBrightEnabled = state
    if state then
        originalBrightness = Lighting.Brightness
        originalFogEnd = Lighting.FogEnd
        Lighting.Brightness = 2
        Lighting.FogEnd = 100000
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = originalBrightness or 1
        Lighting.FogEnd = originalFogEnd or 500
    end
end

-- ============ EVENTOS ============

ToggleButton.MouseButton1Click:Connect(function()
    HitboxEnabled = not HitboxEnabled
    if HitboxEnabled then
        ToggleButton.Text = "Hitbox ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        ApplyHitbox()
    else
        ToggleButton.Text = "Hitbox OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        ResetHitbox()
    end
end)

SilentAimBtn.MouseButton1Click:Connect(function()
    SilentAimEnabled = not SilentAimEnabled
    SilentAimBtn.Text = SilentAimEnabled and "Silent Aim ON" or "Silent Aim OFF"
    SilentAimBtn.BackgroundColor3 = SilentAimEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    local min = not ContentFrame.Visible
    ContentFrame.Visible = not min
    MainFrame.Size = min and UDim2.new(0, 280, 0, 520) or UDim2.new(0, 280, 0, 35)
    MinimizeBtn.Text = min and "—" or "+"
end)

ESPBtn.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    ESPBtn.Text = ESPEnabled and "ESP ON" or "ESP OFF"
    ESPBtn.BackgroundColor3 = ESPEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    if ESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then CreateESP(p) end
        end
    else
        for p in pairs(ESPObjects) do RemoveESP(p) end
    end
end)

FlyBtn.MouseButton1Click:Connect(function()
    ToggleFly(not FlyEnabled)
    FlyBtn.Text = FlyEnabled and "Fly ON" or "Fly OFF"
    FlyBtn.BackgroundColor3 = FlyEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

NoclipBtn.MouseButton1Click:Connect(function()
    SetNoclip(not NoclipEnabled)
    NoclipBtn.Text = NoclipEnabled and "Noclip ON" or "Noclip OFF"
    NoclipBtn.BackgroundColor3 = NoclipEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

BrightBtn.MouseButton1Click:Connect(function()
    SetFullBright(not FullBrightEnabled)
    BrightBtn.Text = FullBrightEnabled and "FullBright ON" or "FullBright OFF"
    BrightBtn.BackgroundColor3 = FullBrightEnabled and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

TPBtn.MouseButton1Click:Connect(function()
    local mouse = LocalPlayer:GetMouse()
    if mouse.Hit then
        LocalPlayer.Character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3, 0))
    end
end)

-- Sliders
SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
    end
end)

FOVSliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        DraggingFOV = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
        DraggingFOV = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if Dragging then
            local percent = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
            HitboxSize = math.floor(5 + percent * 95)
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderButton.Position = UDim2.new(percent, -8, 0.5, -8)
            ValueLabel.Text = "Size: " .. HitboxSize
            if HitboxEnabled then ApplyHitbox() end
        end
        if DraggingFOV then
            local percent = math.clamp((input.Position.X - FOVSliderFrame.AbsolutePosition.X) / FOVSliderFrame.AbsoluteSize.X, 0, 1)
            FOVSize = math.floor(50 + percent * 450)
            FOVSliderFill.Size = UDim2.new(percent, 0, 1, 0)
            FOVSliderButton.Position = UDim2.new(percent, -8, 0.5, -8)
            FOVValueLabel.Text = "FOV: " .. FOVSize
            FOVCircle.Size = UDim2.new(0, FOVSize, 0, FOVSize)
            FOVCircle.Position = UDim2.new(0.5, -FOVSize/2, 0.5, -FOVSize/2)
        end
    end
end)

-- ============ LOOPS ============

-- Hitbox Loop
RunService.Heartbeat:Connect(function()
    if HitboxEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and hrp:IsA("Part") then
                    if hrp.Size ~= Vector3.new(HitboxSize, HitboxSize, HitboxSize) then
                        if not OriginalSizes[player] then
                            OriginalSizes[player] = Vector3.new(2, 2, 1)
                            OriginalColors[player] = hrp.Color
                            OriginalTransparency[player] = hrp.Transparency
                        end
                        hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        hrp.Transparency = HitboxTransparency
                        hrp.Color = HitboxColor
                        hrp.CanCollide = false
                        hrp.Massless = true
                        hrp.CastShadow = false
                    end
                end
            end
        end
    end
end)

-- ESP Loop
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then return end
    for player, obj in pairs(ESPObjects) do
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local head = player.Character:FindFirstChild("Head")
            if hrp and head then
                local hrpPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local headPos = Workspace.CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))
                    local height = math.abs(headPos.Y - hrpPos.Y) * 2.2
                    local width = height * 0.6

                    obj.box.Size = Vector2.new(width, height)
                    obj.box.Position = Vector2.new(hrpPos.X - width/2, hrpPos.Y - height/2)
                    obj.box.Visible = true

                    obj.nameTag.Position = Vector2.new(hrpPos.X, hrpPos.Y - height/2 - 15)
                    obj.nameTag.Text = player.Name
                    obj.nameTag.Visible = true
                else
                    obj.box.Visible = false
                    obj.nameTag.Visible = false
                end
            end
        end
    end
end)

-- Player added/removed para ESP
Players.PlayerAdded:Connect(function(p)
    if ESPEnabled and p ~= LocalPlayer then CreateESP(p) end
end)

Players.PlayerRemoving:Connect(function(p)
    RemoveESP(p)
end)

-- Fly Loop
RunService.RenderStepped:Connect(function()
    if FlyEnabled and flyBV and flyBG then
        local cam = Workspace.CurrentCamera
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end

        if moveDir.Magnitude > 0 then
            flyBV.Velocity = moveDir.Unit * 50
        else
            flyBV.Velocity = Vector3.new(0, 0, 0)
        end
        flyBG.CFrame = cam.CFrame
    end
end)

-- Noclip Loop
RunService.Stepped:Connect(function()
    if NoclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Notificação
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Hitbox + Silent Aim + Extras",
    Text = "Script carregado!",
    Duration = 5
})
