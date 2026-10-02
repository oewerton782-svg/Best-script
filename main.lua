--[[
    Best Script GUI v1.1
    Feito por Ewerton
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- ============ JOGOS SUPORTADOS ============
local JogosSuportados = {
    [2753915549] = {
        nome = "Blox Fruits",
        funcoes = {
            {nome = "Auto Farm", acao = function() print("[Best Script] Auto Farm") end},
            {nome = "Infinite Money", acao = function() print("[Best Script] Money infinito") end},
            {nome = "Teleport Ilha 1", acao = function() print("[Best Script] TP Ilha 1") end}
        }
    },
    [2788229376] = {
        nome = "Da Hood",
        funcoes = {
            {nome = "Aimbot", acao = function() print("[Best Script] Aimbot") end},
            {nome = "Auto Rob", acao = function() print("[Best Script] Auto Rob") end},
            {nome = "God Mode", acao = function() print("[Best Script] God") end}
        }
    },
    [3260590327] = {
        nome = "Arsenal",
        funcoes = {
            {nome = "Silent Aim", acao = function() print("[Best Script] Silent Aim") end},
            {nome = "ESP", acao = function() print("[Best Script] ESP") end},
            {nome = "No Recoil", acao = function() print("[Best Script] No Recoil") end}
        }
    }
}

local FuncoesUniversais = {
    {nome = "Speed 100", acao = function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 100
        end
    end},
    {nome = "Jump 200", acao = function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 200
        end
    end},
    {nome = "Resetar", acao = function()
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
        end
    end}}
}

-- Limpa GUI antiga
if CoreGui:FindFirstChild("BestScriptGui") then
    CoreGui.BestScriptGui:Destroy()
end

-- ============ GUI ============
local gui = Instance.new("ScreenGui")
gui.Name = "BestScriptGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = CoreGui

local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 400, 0, 320)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.BackgroundTransparency = 1
container.Parent = gui

local fundo = Instance.new("Frame")
fundo.Name = "Fundo"
fundo.Size = UDim2.new(1, 0, 1, 0)
fundo.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
fundo.BackgroundTransparency = 0.05
fundo.BorderSizePixel = 0
fundo.Parent = container

local cantoFundo = Instance.new("UICorner")
cantoFundo.CornerRadius = UDim.new(0, 12)
cantoFundo.Parent = fundo

local bordaFundo = Instance.new("UIStroke")
bordaFundo.Color = Color3.fromRGB(0, 200, 120)
bordaFundo.Thickness = 2
bordaFundo.Transparency = 0.3
bordaFundo.Parent = fundo

-- Barra de título
local barraTitulo = Instance.new("Frame")
barraTitulo.Name = "BarraTitulo"
barraTitulo.Size = UDim2.new(1, 0, 0, 50)
barraTitulo.BackgroundColor3 = Color3.fromRGB(0, 200, 120)
barraTitulo.BackgroundTransparency = 0.15
barraTitulo.BorderSizePixel = 0
barraTitulo.Parent = fundo

local cantoBarra = Instance.new("UICorner")
cantoBarra.CornerRadius = UDim.new(0, 12)
cantoBarra.Parent = barraTitulo

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(0.7, 0, 1, 0)
titulo.Position = UDim2.new(0.05, 0, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "Best Script"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.TextSize = 22
titulo.Font = Enum.Font.GothamBold
titulo.TextXAlignment = Enum.TextXAlignment.Left
titulo.Parent = barraTitulo

local botaoFechar = Instance.new("TextButton")
botaoFechar.Size = UDim2.new(0, 30, 0, 30)
botaoFechar.Position = UDim2.new(1, -40, 0, 10)
botaoFechar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
botaoFechar.BorderSizePixel = 0
botaoFechar.Text = "X"
botaoFechar.TextColor3 = Color3.fromRGB(255, 255, 255)
botaoFechar.TextSize = 16
botaoFechar.Font = Enum.Font.GothamBold
botaoFechar.Parent = barraTitulo

local cantoFechar = Instance.new("UICorner")
cantoFechar.CornerRadius = UDim.new(1, 0)
cantoFechar.Parent = botaoFechar

local autor = Instance.new("TextLabel")
autor.Size = UDim2.new(1, 0, 0, 25)
autor.Position = UDim2.new(0, 0, 0, 55)
autor.BackgroundTransparency = 1
autor.Text = "Feito por Ewerton"
autor.TextColor3 = Color3.fromRGB(150, 150, 170)
autor.TextSize = 14
autor.Font = Enum.Font.Gotham
autor.Parent = fundo

-- ============ MENU PRINCIPAL ============
local menuPrincipal = Instance.new("Frame")
menuPrincipal.Size = UDim2.new(1, -40, 1, -110)
menuPrincipal.Position = UDim2.new(0, 20, 0, 95)
menuPrincipal.BackgroundTransparency = 1
menuPrincipal.Parent = fundo

local botoesInfo = {
    {nome = "Jogar", cor = Color3.fromRGB(0, 200, 120)},
    {nome = "Configurações", cor = Color3.fromRGB(0, 150, 200)},
    {nome = "Sair", cor = Color3.fromRGB(200, 60, 60)}
}

local botoes = {}

for i, info in ipairs(botoesInfo) do
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 0, 50)
    botao.Position = UDim2.new(0, 0, 0, (i - 1) * 60)
    botao.BackgroundColor3 = info.cor
    botao.BackgroundTransparency = 0.15
    botao.BorderSizePixel = 0
    botao.Text = info.nome
    botao.TextColor3 = Color3.fromRGB(255, 255, 255)
    botao.TextSize = 18
    botao.Font = Enum.Font.GothamBold
    botao.AutoButtonColor = false
    botao.Parent = menuPrincipal

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = botao

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = botao

    botao.MouseEnter:Connect(function()
        TweenService:Create(botao, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)

    botao.MouseLeave:Connect(function()
        TweenService:Create(botao, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
    end)

    botoes[i] = botao
end

-- ============ MENU JOGAR ============
local menuJogar = Instance.new("Frame")
menuJogar.Size = UDim2.new(1, -40, 1, -110)
menuJogar.Position = UDim2.new(0, 20, 0, 95)
menuJogar.BackgroundTransparency = 1
menuJogar.Visible = false
menuJogar.Parent = fundo

local labelJogoDetectado = Instance.new("TextLabel")
labelJogoDetectado.Size = UDim2.new(1, 0, 0, 25)
labelJogoDetectado.Position = UDim2.new(0, 0, 0, 0)
labelJogoDetectado.BackgroundTransparency = 1
labelJogoDetectado.Text = "🔍 Detectando..."
labelJogoDetectado.TextColor3 = Color3.fromRGB(0, 255, 150)
labelJogoDetectado.TextSize = 14
labelJogoDetectado.Font = Enum.Font.GothamBold
labelJogoDetectado.TextXAlignment = Enum.TextXAlignment.Left
labelJogoDetectado.Parent = menuJogar

local scrollFuncoes = Instance.new("ScrollingFrame")
scrollFuncoes.Size = UDim2.new(1, 0, 1, -80)
scrollFuncoes.Position = UDim2.new(0, 0, 0, 35)
scrollFuncoes.BackgroundTransparency = 1
scrollFuncoes.BorderSizePixel = 0
scrollFuncoes.ScrollBarThickness = 4
scrollFuncoes.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFuncoes.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFuncoes.Parent = menuJogar

local layoutFuncoes = Instance.new("UIListLayout")
layoutFuncoes.SortOrder = Enum.SortOrder.LayoutOrder
layoutFuncoes.Padding = UDim.new(0, 8)
layoutFuncoes.Parent = scrollFuncoes

local botaoVoltarJogar = Instance.new("TextButton")
botaoVoltarJogar.Size = UDim2.new(1, 0, 0, 40)
botaoVoltarJogar.Position = UDim2.new(0, 0, 1, -40)
botaoVoltarJogar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
botaoVoltarJogar.BorderSizePixel = 0
botaoVoltarJogar.Text = "← Voltar"
botaoVoltarJogar.TextColor3 = Color3.fromRGB(255, 255, 255)
botaoVoltarJogar.TextSize = 16
botaoVoltarJogar.Font = Enum.Font.GothamBold
botaoVoltarJogar.Parent = menuJogar

local cantoVoltarJogar = Instance.new("UICorner")
cantoVoltarJogar.CornerRadius = UDim.new(0, 8)
cantoVoltarJogar.Parent = botaoVoltarJogar

-- ============ FUNÇÕES ============
local function criarBotaoFuncao(info, index)
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 0, 45)
    botao.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
    botao.BackgroundTransparency = 0.15
    botao.BorderSizePixel = 0
    botao.Text = info.nome
    botao.TextColor3 = Color3.fromRGB(255, 255, 255)
    botao.TextSize = 16
    botao.Font = Enum.Font.GothamBold
    botao.AutoButtonColor = false
    botao.LayoutOrder = index
    botao.Parent = scrollFuncoes

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = botao

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = botao

    botao.MouseButton1Click:Connect(function()
        local sucesso, erro = pcall(info.acao)
        if not sucesso then
            print("[Best Script] Erro: " .. tostring(erro))
        end
    end)
end

local function carregarMenuJogar()
    for _, filho in ipairs(scrollFuncoes:GetChildren()) do
        if filho:IsA("TextButton") then
            filho:Destroy()
        end
    end

    local placeId = game.PlaceId
    local jogoInfo = JogosSuportados[placeId]
    local funcoes = {}

    if jogoInfo then
        labelJogoDetectado.Text = "🎮 " .. jogoInfo.nome .. " (ID: " .. placeId .. ")"
        labelJogoDetectado.TextColor3 = Color3.fromRGB(0, 255, 150)

        for _, funcao in ipairs(jogoInfo.funcoes) do
            table.insert(funcoes, funcao)
        end
    else
        labelJogoDetectado.Text = "⚠️ Jogo não reconhecido (ID: " .. placeId .. ")"
        labelJogoDetectado.TextColor3 = Color3.fromRGB(255, 180, 0)
    end

    for _, funcao in ipairs(FuncoesUniversais) do
        table.insert(funcoes, funcao)
    end

    for i, funcao in ipairs(funcoes) do
        criarBotaoFuncao(funcao, i)
    end
end

-- ============ NAVEGAÇÃO ============
local function mostrarPrincipal()
    menuJogar.Visible = false
    menuPrincipal.Visible = true
    menuPrincipal.Position = UDim2.new(0, 30, 0, 95)
    TweenService:Create(menuPrincipal, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 20, 0, 95)
    }):Play()
end

local function mostrarJogar()
    carregarMenuJogar()
    menuPrincipal.Visible = false
    menuJogar.Visible = true
    menuJogar.Position = UDim2.new(0, 30, 0, 95)
    TweenService:Create(menuJogar, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 20, 0, 95)
    }):Play()
end

-- ============ EVENTOS ============
botoes[1].MouseButton1Click:Connect(mostrarJogar)
botoes[2].MouseButton1Click:Connect(function()
    print("[Best Script] Config clicado")
end)

local function fecharGui()
    TweenService:Create(container, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, 0, 1.5, 0)
    }):Play()
    task.wait(0.45)
    gui:Destroy()
end

botoes[3].MouseButton1Click:Connect(fecharGui)
botaoFechar.MouseButton1Click:Connect(fecharGui)
botaoVoltarJogar.MouseButton1Click:Connect(mostrarPrincipal)

-- Arrastar
local arrastando = false
local offsetInicial

barraTitulo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        arrastando = true
        offsetInicial = input.Position - container.AbsolutePosition
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        arrastando = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if arrastando and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        container.Position = UDim2.new(0, input.Position.X - offsetInicial.X, 0, input.Position.Y - offsetInicial.Y)
    end
end)

-- ============ ANIMAÇÃO DE ENTRADA ============
container.Position = UDim2.new(0.5, 0, 1.5, 0)
fundo.BackgroundTransparency = 1
barraTitulo.BackgroundTransparency = 1
titulo.TextTransparency = 1
autor.TextTransparency = 1
botaoFechar.BackgroundTransparency = 1
botaoFechar.TextTransparency = 1

for _, b in ipairs(botoes) do
    b.BackgroundTransparency = 1
    b.TextTransparency = 1
end

task.wait(0.2)

TweenService:Create(container, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()

task.wait(0.4)

TweenService:Create(fundo, TweenInfo.new(0.4), {BackgroundTransparency = 0.05}):Play()
TweenService:Create(barraTitulo, TweenInfo.new(0.4), {BackgroundTransparency = 0.15}):Play()
TweenService:Create(titulo, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(botaoFechar, TweenInfo.new(0.4), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
TweenService:Create(autor, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

task.wait(0.3)

for _, b in ipairs(botoes) do
    TweenService:Create(b, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.15,
        TextTransparency = 0
    }):Play()
    task.wait(0.08)
end

print("[Best Script] GUI v1.1 carregada! Jogo: " .. game.PlaceId)
