local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

if CoreGui:FindFirstChild("BF4X_Update") then
    CoreGui.BF4X_Update:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "BF4X_Update"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local fundo = Instance.new("Frame")
fundo.Size = UDim2.new(0, 420, 0, 220)
fundo.Position = UDim2.new(0.5, -210, 0.5, -110)
fundo.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
fundo.BorderSizePixel = 0
fundo.Parent = gui

local canto = Instance.new("UICorner")
canto.CornerRadius = UDim.new(0, 16)
canto.Parent = fundo

local borda = Instance.new("UIStroke")
borda.Color = Color3.fromRGB(0, 163, 255)
borda.Thickness = 2
borda.Transparency = 0.2
borda.Parent = fundo

local gradiente = Instance.new("UIGradient")
gradiente.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 20, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 14, 24)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 16))
}
gradiente.Rotation = 135
gradiente.Parent = fundo

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
header.BorderSizePixel = 0
header.Parent = fundo

local cantoHeader = Instance.new("UICorner")
cantoHeader.CornerRadius = UDim.new(0, 16)
cantoHeader.Parent = header

local gradHeader = Instance.new("UIGradient")
gradHeader.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 130, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 70, 150))
}
gradHeader.Rotation = 0
gradHeader.Parent = header

local icone = Instance.new("TextLabel")
icone.Size = UDim2.new(0, 40, 0, 40)
icone.Position = UDim2.new(0, 14, 0, 5)
icone.BackgroundTransparency = 1
icone.Text = "⚡"
icone.TextColor3 = Color3.fromRGB(255, 215, 0)
icone.TextSize = 26
icone.Font = Enum.Font.GothamBold
icone.Parent = header

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, -60, 1, 0)
titulo.Position = UDim2.new(0, 56, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "BF4X"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.TextSize = 22
titulo.Font = Enum.Font.GothamBlack
titulo.TextXAlignment = Enum.TextXAlignment.Left
titulo.Parent = header

local emoji = Instance.new("TextLabel")
emoji.Size = UDim2.new(1, 0, 0, 50)
emoji.Position = UDim2.new(0, 0, 0, 60)
emoji.BackgroundTransparency = 1
emoji.Text = "🔧"
emoji.TextSize = 42
emoji.Font = Enum.Font.GothamBold
emoji.Parent = fundo

local tituloUpdate = Instance.new("TextLabel")
tituloUpdate.Size = UDim2.new(1, 0, 0, 30)
tituloUpdate.Position = UDim2.new(0, 0, 0, 115)
tituloUpdate.BackgroundTransparency = 1
tituloUpdate.Text = "EM ATUALIZACAO"
tituloUpdate.TextColor3 = Color3.fromRGB(255, 215, 0)
tituloUpdate.TextSize = 20
tituloUpdate.Font = Enum.Font.GothamBlack
tituloUpdate.Parent = fundo

local descricao = Instance.new("TextLabel")
descricao.Size = UDim2.new(1, -30, 0, 40)
descricao.Position = UDim2.new(0, 15, 0, 150)
descricao.BackgroundTransparency = 1
descricao.Text = "Estamos melhorando o script.\nVolte em alguns minutos!"
descricao.TextColor3 = Color3.fromRGB(180, 180, 200)
descricao.TextSize = 13
descricao.Font = Enum.Font.Gotham
descricao.TextWrapped = true
descricao.Parent = fundo

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -30, 0, 20)
footer.Position = UDim2.new(0, 15, 1, -25)
footer.BackgroundTransparency = 1
footer.Text = "BF4X Premium | Feito por Ewerton"
footer.TextColor3 = Color3.fromRGB(100, 100, 130)
footer.TextSize = 10
footer.Font = Enum.Font.Gotham
footer.Parent = fundo

local pontinhos = Instance.new("TextLabel")
pontinhos.Size = UDim2.new(1, 0, 0, 20)
pontinhos.Position = UDim2.new(0, 0, 1, -50)
pontinhos.BackgroundTransparency = 1
pontinhos.Text = "."
pontinhos.TextColor3 = Color3.fromRGB(255, 215, 0)
pontinhos.TextSize = 16
pontinhos.Font = Enum.Font.GothamBold
pontinhos.Parent = fundo

task.spawn(function()
    while gui.Parent do
        pontinhos.Text = "."
        task.wait(0.3)
        pontinhos.Text = ".."
        task.wait(0.3)
        pontinhos.Text = "..."
        task.wait(0.3)
    end
end)

fundo.Position = UDim2.new(0.5, -210, 1.5, -110)
local t = TweenService:Create(fundo, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -210, 0.5, -110)
})
t:Play()

print("[BF4X] Script em atualizacao!")
