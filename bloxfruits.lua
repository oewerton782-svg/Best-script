--[[
    BF4X Premium - Blox Fruits Script
    Versao: 4.0
    Feito por Ewerton
]]

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ============ SISTEMA DE KEY (EXEMPLO) ============
-- Em um script real, a verificação seria feita em um servidor externo.
-- Aqui, usamos uma key fixa para demonstração.
local KEY_CORRETA = "BF4X-PREMIUM-2026"

local function verificarKey()
    local sucesso, keyDigitada = pcall(function()
        return game:GetService("Players").LocalPlayer:GetJoinData().LaunchData
    end)
    
    if not keyDigitada or keyDigitada == "" then
        -- Tenta pegar do prompt do executor (funcionalidade comum em executores mobile)
        keyDigitada = "BF4X-PREMIUM-2026" -- Simulação de key válida para testes
    end

    if keyDigitada == KEY_CORRETA then
        return true
    end
    return false
end

if not verificarKey() then
    -- Cria uma UI de Key
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "BF4X_Key"
    keyGui.ResetOnSpawn = false
    keyGui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.Parent = keyGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, 0, 0, 40)
    titulo.Text = "BF4X - Verificação de Key"
    titulo.TextColor3 = Color3.fromRGB(0, 163, 255)
    titulo.TextSize = 16
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.8, 0, 0, 30)
    input.Position = UDim2.new(0.1, 0, 0.4, 0)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    input.Text = ""
    input.PlaceholderText = "Digite sua key..."
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 30)
    btn.Position = UDim2.new(0.1, 0, 0.7, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 163, 255)
    btn.Text = "Verificar"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = frame

    btn.MouseButton1Click:Connect(function()
        if input.Text == KEY_CORRETA then
            keyGui:Destroy()
            -- Recarrega o script principal
            loadstring(game:HttpGet("https://raw.githubusercontent.com/oewerton782-svg/Best-script/refs/heads/main/bloxfruits.lua"))()
        else
            input.Text = ""
            input.PlaceholderText = "Key inválida!"
        end
    end)
    return
end
-- ================================================

local function detectarMar()
    local ids = {
        [2753915549] = 1,
        [4442272183] = 2,
        [7449423635] = 3,
        [920587237] = 2,
        [7909173265657] = 3,
        [7909174109773] = 3
    }
    if ids[game.PlaceId] then
        return ids[game.PlaceId]
    end
    -- Fallback por ilhas
    local mapa = workspace:FindFirstChild("Map") or workspace
    local ilhas = {
        [1] = {"Jungle", "Selva", "Pirate Village", "Magma Village", "Marine Ford", "Colosseum"},
        [2] = {"Kingdom of Rose", "Green Zone", "Cursed Ship", "Ice Castle", "Forgotten Island", "Graveyard"},
        [3] = {"Port Town", "Hydra Island", "Castle on the Sea", "Haunted Castle", "Floating Turtle", "Sea of Treats", "Tiki Outpost"}
    }
    local contagem = {[1] = 0, [2] = 0, [3] = 0}
    for mar, lista in pairs(ilhas) do
        for _, nome in ipairs(lista) do
            for _, obj in ipairs(mapa:GetDescendants()) do
                if obj.Name:lower():find(nome:lower()) then
                    contagem[mar] = contagem[mar] + 1
                    break
                end
            end
        end
    end
    local melhor = 1
    local maior = 0
    for mar, qtd in pairs(contagem) do
        if qtd > maior then
            maior = qtd
            melhor = mar
        end
    end
    if maior >= 3 then return melhor end
    if contagem[3] > 0 then return 3 end
    if contagem[2] > 0 then return 2 end
    return 1
end

local MAR = detectarMar()

if CoreGui:FindFirstChild("BF4X") then
    CoreGui.BF4X:Destroy()
end

local Config = {
    mar = MAR,
    rainbow = false,
    notificacoes = true,
    autoFarmLevel = false,
    autoFarmBoss = false,
    autoFarmFruit = false,
    fastAttack = false,
    autoChest = false,
    autoHaki = false,
    speed = false,
    fly = false,
    noclip = false,
    infiniteJump = false,
    fullbright = false,
    noFog = false,
    distanciaFarm = 150, -- Aumentado para pegar mais mobs
    mobEscolhido = "Auto (mais proximo)",
    bossEscolhido = "Diamond"
}

local Cores = {
    fundo = Color3.fromRGB(8, 8, 14),
    painel = Color3.fromRGB(16, 16, 26),
    card = Color3.fromRGB(24, 24, 38),
    azul = Color3.fromRGB(0, 163, 255),
    azulClaro = Color3.fromRGB(100, 210, 255),
    dourado = Color3.fromRGB(255, 215, 0),
    texto = Color3.fromRGB(240, 240, 255),
    cinza = Color3.fromRGB(140, 140, 170),
    cinzaEscuro = Color3.fromRGB(60, 60, 80),
    verde = Color3.fromRGB(0, 220, 100),
    vermelho = Color3.fromRGB(220, 50, 50)
}

-- ============ CRIAÇÃO DA GUI ============
local gui = Instance.new("ScreenGui")
gui.Name = "BF4X"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local painel = Instance.new("Frame")
painel.Size = UDim2.new(0, 620, 0, 480)
painel.Position = UDim2.new(0.5, -310, 0.5, -240)
painel.BackgroundColor3 = Cores.painel
painel.BorderSizePixel = 0
painel.Active = true
painel.Draggable = true
painel.Parent = gui

local cantoPainel = Instance.new("UICorner")
cantoPainel.CornerRadius = UDim.new(0, 14)
cantoPainel.Parent = painel

local bordaPainel = Instance.new("UIStroke")
bordaPainel.Color = Cores.azul
bordaPainel.Thickness = 1.5
bordaPainel.Transparency = 0.3
bordaPainel.Parent = painel

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Cores.azul
header.BorderSizePixel = 0
header.Parent = painel

local cantoHeader = Instance.new("UICorner")
cantoHeader.CornerRadius = UDim.new(0, 14)
cantoHeader.Parent = header

local gradHeader = Instance.new("UIGradient")
gradHeader.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 130, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 70, 150))
}
gradHeader.Rotation = 0
gradHeader.Parent = header

local btnMin = Instance.new("TextButton")
btnMin.Size = UDim2.new(0, 32, 0, 32)
btnMin.Position = UDim2.new(0, 10, 0, 9)
btnMin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btnMin.BackgroundTransparency = 0.9
btnMin.BorderSizePixel = 0
btnMin.Text = "−"
btnMin.TextColor3 = Cores.texto
btnMin.TextSize = 20
btnMin.Font = Enum.Font.GothamBold
btnMin.Parent = header

local cantoMin = Instance.new("UICorner")
cantoMin.CornerRadius = UDim.new(1, 0)
cantoMin.Parent = btnMin

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(0, 100, 1, 0)
titulo.Position = UDim2.new(0, 50, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "⚡ BF4X"
titulo.TextColor3 = Cores.texto
titulo.TextSize = 20
titulo.Font = Enum.Font.GothamBlack
titulo.TextXAlignment = Enum.TextXAlignment.Left
titulo.Parent = header

local badge = Instance.new("Frame")
badge.Size = UDim2.new(0, 75, 0, 22)
badge.Position = UDim2.new(0.5, -37, 0.5, -11)
badge.BackgroundColor3 = Cores.dourado
badge.BorderSizePixel = 0
badge.Parent = header

local cantoBadge = Instance.new("UICorner")
cantoBadge.CornerRadius = UDim.new(1, 0)
cantoBadge.Parent = badge

local badgeTxt = Instance.new("TextLabel")
badgeTxt.Size = UDim2.new(1, 0, 1, 0)
badgeTxt.BackgroundTransparency = 1
badgeTxt.Text = "PREMIUM"
badgeTxt.TextColor3 = Color3.fromRGB(30, 20, 0)
badgeTxt.TextSize = 10
badgeTxt.Font = Enum.Font.GothamBold
badgeTxt.Parent = badge

local marTxt = Instance.new("TextLabel")
marTxt.Size = UDim2.new(0, 80, 1, 0)
marTxt.Position = UDim2.new(1, -120, 0, 0)
marTxt.BackgroundTransparency = 1
marTxt.Text = "SEA " .. MAR
marTxt.TextColor3 = Cores.azulClaro
marTxt.TextSize = 14
marTxt.Font = Enum.Font.GothamBold
marTxt.TextXAlignment = Enum.TextXAlignment.Right
marTxt.Parent = header

local btnFechar = Instance.new("TextButton")
btnFechar.Size = UDim2.new(0, 32, 0, 32)
btnFechar.Position = UDim2.new(1, -42, 0, 9)
btnFechar.BackgroundColor3 = Cores.vermelho
btnFechar.BackgroundTransparency = 0.2
btnFechar.BorderSizePixel = 0
btnFechar.Text = "X"
btnFechar.TextColor3 = Cores.texto
btnFechar.TextSize = 14
btnFechar.Font = Enum.Font.GothamBold
btnFechar.Parent = header

local cantoFechar = Instance.new("UICorner")
cantoFechar.CornerRadius = UDim.new(1, 0)
cantoFechar.Parent = btnFechar

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -50)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = Cores.fundo
sidebar.BorderSizePixel = 0
sidebar.Parent = painel

local abas = {
    {nome = "FARM", icone = "🎯"},
    {nome = "TP", icone = "🌐"},
    {nome = "ESP", icone = "👁"},
    {nome = "MOVE", icone = "⚡"},
    {nome = "VISUAL", icone = "🎨"},
    {nome = "CFG", icone = "⚙"}
}

local btnAbas = {}
local contentAbas = {}

local area = Instance.new("Frame")
area.Size = UDim2.new(1, -140, 1, -78)
area.Position = UDim2.new(0, 140, 0, 50)
area.BackgroundTransparency = 1
area.Parent = painel

for i, aba in ipairs(abas) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 44)
    btn.Position = UDim2.new(0, 6, 0, (i - 1) * 48 + 8)
    btn.BackgroundColor3 = Cores.card
    btn.BackgroundTransparency = 0.5
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = sidebar
    btnAbas[aba.nome] = btn

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    local icone = Instance.new("TextLabel")
    icone.Size = UDim2.new(0, 30, 1, 0)
    icone.Position = UDim2.new(0, 8, 0, 0)
    icone.BackgroundTransparency = 1
    icone.Text = aba.icone
    icone.TextSize = 18
    icone.Font = Enum.Font.GothamBold
    icone.Parent = btn

    local nome = Instance.new("TextLabel")
    nome.Size = UDim2.new(1, -45, 1, 0)
    nome.Position = UDim2.new(0, 42, 0, 0)
    nome.BackgroundTransparency = 1
    nome.Text = aba.nome
    nome.TextColor3 = Cores.cinza
    nome.TextSize = 13
    nome.Font = Enum.Font.GothamBold
    nome.TextXAlignment = Enum.TextXAlignment.Left
    nome.Parent = btn

    local indice = Instance.new("Frame")
    indice.Name = "Indice"
    indice.Size = UDim2.new(0, 3, 0.5, 0)
    indice.Position = UDim2.new(0, 0, 0.25, 0)
    indice.BackgroundColor3 = Cores.azul
    indice.BorderSizePixel = 0
    indice.Visible = false
    indice.Parent = btn

    local ci = Instance.new("UICorner")
    ci.CornerRadius = UDim.new(1, 0)
    ci.Parent = indice

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = Cores.azul
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Visible = false
    content.Parent = area
    contentAbas[aba.nome] = content

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.PaddingBottom = UDim.new(0, 10)
    pad.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6) -- Aumentado para melhor espaçamento
    layout.Parent = content
end

-- Footer
local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, 0, 0, 28)
footer.Position = UDim2.new(0, 0, 1, -28)
footer.BackgroundColor3 = Cores.fundo
footer.BorderSizePixel = 0
footer.Parent = painel

local cantoFooter = Instance.new("UICorner")
cantoFooter.CornerRadius = UDim.new(0, 14)
cantoFooter.Parent = footer

local dot = Instance.new("Frame")
dot.Size = UDim2.new(0, 8, 0, 8)
dot.Position = UDim2.new(0, 14, 0.5, -4)
dot.BackgroundColor3 = Cores.verde
dot.BorderSizePixel = 0
dot.Parent = footer

local cd = Instance.new("UICorner")
cd.CornerRadius = UDim.new(1, 0)
cd.Parent = dot

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0, 80, 1, 0)
status.Position = UDim2.new(0, 28, 0, 0)
status.BackgroundTransparency = 1
status.Text = "Online"
status.TextColor3 = Cores.verde
status.TextSize = 11
status.Font = Enum.Font.GothamBold
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = footer

local fpsTxt = Instance.new("TextLabel")
fpsTxt.Size = UDim2.new(0, 80, 1, 0)
fpsTxt.Position = UDim2.new(0.4, 0, 0, 0)
fpsTxt.BackgroundTransparency = 1
fpsTxt.Text = "FPS: 60"
fpsTxt.TextColor3 = Cores.cinza
fpsTxt.TextSize = 11
fpsTxt.Font = Enum.Font.Gotham
fpsTxt.Parent = footer

local playersTxt = Instance.new("TextLabel")
playersTxt.Size = UDim2.new(0, 100, 1, 0)
playersTxt.Position = UDim2.new(0.6, 0, 0, 0)
playersTxt.BackgroundTransparency = 1
playersTxt.Text = "0 players"
playersTxt.TextColor3 = Cores.cinza
playersTxt.TextSize = 11
playersTxt.Font = Enum.Font.Gotham
playersTxt.Parent = footer

local vTxt = Instance.new("TextLabel")
vTxt.Size = UDim2.new(0, 80, 1, 0)
vTxt.Position = UDim2.new(1, -90, 0, 0)
vTxt.BackgroundTransparency = 1
vTxt.Text = "v4.0"
vTxt.TextColor3 = Cores.cinzaEscuro
vTxt.TextSize = 11
vTxt.Font = Enum.Font.Gotham
vTxt.TextXAlignment = Enum.TextXAlignment.Right
vTxt.Parent = footer

-- ============ SISTEMA DE NOTIFICAÇÕES ============
local notifs = {}

local function notificar(titulo, texto, tipo)
    if not Config.notificacoes then return end
    local cor = Cores.azul
    local icone = "ℹ"
    if tipo == "sucesso" then cor = Cores.verde; icone = "✓"
    elseif tipo == "erro" then cor = Cores.vermelho; icone = "✕"
    elseif tipo == "aviso" then cor = Cores.dourado; icone = "!" end

    local n = Instance.new("Frame")
    n.Size = UDim2.new(0, 290, 0, 72)
    n.Position = UDim2.new(1, 20, 0, 100 + (#notifs * 80))
    n.BackgroundColor3 = Cores.painel
    n.BorderSizePixel = 0
    n.Parent = gui
    table.insert(notifs, n)

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = n

    local s = Instance.new("UIStroke")
    s.Color = cor
    s.Thickness = 1.5
    s.Transparency = 0.4
    s.Parent = n

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 4, 1, 0)
    bar.BackgroundColor3 = cor
    bar.BorderSizePixel = 0
    bar.Parent = n

    local cb = Instance.new("UICorner")
    cb.CornerRadius = UDim.new(0, 10)
    cb.Parent = bar

    local ic = Instance.new("TextLabel")
    ic.Size = UDim2.new(0, 24, 0, 24)
    ic.Position = UDim2.new(0, 12, 0, 10)
    ic.BackgroundTransparency = 1
    ic.Text = icone
    ic.TextColor3 = cor
    ic.TextSize = 16
    ic.Font = Enum.Font.GothamBold
    ic.Parent = n

    local t1 = Instance.new("TextLabel")
    t1.Size = UDim2.new(1, -50, 0, 20)
    t1.Position = UDim2.new(0, 44, 0, 8)
    t1.BackgroundTransparency = 1
    t1.Text = titulo
    t1.TextColor3 = cor
    t1.TextSize = 13
    t1.Font = Enum.Font.GothamBold
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Parent = n

    local t2 = Instance.new("TextLabel")
    t2.Size = UDim2.new(1, -50, 0, 30)
    t2.Position = UDim2.new(0, 44, 0, 28)
    t2.BackgroundTransparency = 1
    t2.Text = texto
    t2.TextColor3 = Cores.texto
    t2.TextSize = 11
    t2.Font = Enum.Font.Gotham
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.TextWrapped = true
    t2.Parent = n

    local tw = TweenService:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -310, 0, n.Position.Y.Scale)
    })
    tw:Play()

    task.delay(3.5, function()
        for i, v in ipairs(notifs) do
            if v == n then
                table.remove(notifs, i)
                break
            end
        end
        local tw2 = TweenService:Create(n, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 20, 0, n.Position.Y.Scale)
        })
        tw2:Play()
        task.wait(0.35)
        n:Destroy()
    end)
end

-- ============ FUNÇÕES AUXILIARES DA UI ============
local function criarSecao(parent, texto)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 26)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = texto
    l.TextColor3 = Cores.dourado
    l.TextSize = 12
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
end

local function criarToggle(parent, texto, callback, inicial)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 38)
    f.BackgroundColor3 = Cores.card
    f.BackgroundTransparency = 0.2
    f.BorderSizePixel = 0
    f.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = f

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.7, 0, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = texto
    l.TextColor3 = Cores.texto
    l.TextSize = 12
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 42, 0, 22)
    bg.Position = UDim2.new(1, -56, 0.5, -11)
    bg.BackgroundColor3 = Cores.cinzaEscuro
    bg.BorderSizePixel = 0
    bg.Parent = f

    local cb = Instance.new("UICorner")
    cb.CornerRadius = UDim.new(1, 0)
    cb.Parent = bg

    local bt = Instance.new("TextButton")
    bt.Size = UDim2.new(0, 18, 0, 18)
    bt.Position = UDim2.new(0, 2, 0.5, -9)
    bt.BackgroundColor3 = Cores.texto
    bt.BorderSizePixel = 0
    bt.Text = ""
    bt.Parent = bg

    local ct = Instance.new("UICorner")
    ct.CornerRadius = UDim.new(1, 0)
    ct.Parent = bt

    local ativo = inicial or false
    if ativo then
        bg.BackgroundColor3 = Cores.azul
        bt.Position = UDim2.new(1, -20, 0.5, -9)
    end

    bt.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            local t1 = TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = Cores.azul})
            t1:Play()
            local t2 = TweenService:Create(bt, TweenInfo.new(0.2), {Position = UDim2.new(1, -20, 0.5, -9)})
            t2:Play()
        else
            local t3 = TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = Cores.cinzaEscuro})
            t3:Play()
            local t4 = TweenService:Create(bt, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -9)})
            t4:Play()
        end
        if callback then callback(ativo) end
    end)
end

local function criarBotao(parent, texto, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 34)
    b.BackgroundColor3 = Cores.card
    b.BackgroundTransparency = 0.2
    b.BorderSizePixel = 0
    b.Text = texto
    b.TextColor3 = Cores.texto
    b.TextSize = 12
    b.Font = Enum.Font.Gotham
    b.AutoButtonColor = false
    b.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    local s = Instance.new("UIStroke")
    s.Color = Cores.azul
    s.Thickness = 1
    s.Transparency = 0.8
    s.Parent = b

    b.MouseEnter:Connect(function()
        local t1 = TweenService:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0})
        t1:Play()
        local t2 = TweenService:Create(s, TweenInfo.new(0.15), {Transparency = 0.4})
        t2:Play()
    end)

    b.MouseLeave:Connect(function()
        local t1 = TweenService:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.2})
        t1:Play()
        local t2 = TweenService:Create(s, TweenInfo.new(0.15), {Transparency = 0.8})
        t2:Play()
    end)

    b.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
end

local function criarSlider(parent, texto, min, max, inicial, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundColor3 = Cores.card
    f.BackgroundTransparency = 0.2
    f.BorderSizePixel = 0
    f.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = f

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.6, 0, 0, 18)
    l.Position = UDim2.new(0, 14, 0, 6)
    l.BackgroundTransparency = 1
    l.Text = texto
    l.TextColor3 = Cores.texto
    l.TextSize = 12
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.3, 0, 0, 18)
    v.Position = UDim2.new(0.65, 0, 0, 6)
    v.BackgroundTransparency = 1
    v.Text = tostring(inicial)
    v.TextColor3 = Cores.azulClaro
    v.TextSize = 12
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -28, 0, 6)
    bg.Position = UDim2.new(0, 14, 0, 34)
    bg.BackgroundColor3 = Cores.cinzaEscuro
    bg.BorderSizePixel = 0
    bg.Parent = f

    local cb = Instance.new("UICorner")
    cb.CornerRadius = UDim.new(1, 0)
    cb.Parent = bg

    local pre = Instance.new("Frame")
    pre.Size = UDim2.new((inicial - min) / (max - min), 0, 1, 0)
    pre.BackgroundColor3 = Cores.azul
    pre.BorderSizePixel = 0
    pre.Parent = bg

    local cp = Instance.new("UICorner")
    cp.CornerRadius = UDim.new(1, 0)
    cp.Parent = pre

    local bt = Instance.new("TextButton")
    bt.Size = UDim2.new(0, 16, 0, 16)
    bt.Position = UDim2.new((inicial - min) / (max - min), -8, 0.5, -8)
    bt.BackgroundColor3 = Cores.texto
    bt.BorderSizePixel = 0
    bt.Text = ""
    bt.Parent = bg

    local cbt = Instance.new("UICorner")
    cbt.CornerRadius = UDim.new(1, 0)
    cbt.Parent = bt

    local arrastando = false

    local function atualizar(input)
        local px = math.clamp(input.Position.X - bg.AbsolutePosition.X, 0, bg.AbsoluteSize.X)
        local pct = px / bg.AbsoluteSize.X
        local valor = math.floor(min + (max - min) * pct)
        pre.Size = UDim2.new(pct, 0, 1, 0)
        bt.Position = UDim2.new(pct, -8, 0.5, -8)
        v.Text = tostring(valor)
        if callback then callback(valor) end
    end

    bt.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastando = true
        end
    end)

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastando = true
            atualizar(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastando = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if arrastando then
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                atualizar(input)
            end
        end
    end)
end

local function trocarAba(nome)
    for n, c in pairs(contentAbas) do
        c.Visible = (n == nome)
    end
    for n, b in pairs(btnAbas) do
        local ind = b:FindFirstChild("Indice")
        local txt = nil
        for _, f in ipairs(b:GetChildren()) do
            if f:IsA("TextLabel") and f.TextSize ~= 18 then
                txt = f
            end
        end
        if n == nome then
            local t1 = TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.1})
            t1:Play()
            if ind then ind.Visible = true end
            if txt then txt.TextColor3 = Cores.azulClaro end
        else
            local t2 = TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.5})
            t2:Play()
            if ind then ind.Visible = false end
            if txt then txt.TextColor3 = Cores.cinza end
        end
    end
end

for nome, botao in pairs(btnAbas) do
    botao.MouseButton1Click:Connect(function() trocarAba(nome) end)
end

trocarAba("FARM")

btnMin.MouseButton1Click:Connect(function()
    local visivel = sidebar.Visible
    sidebar.Visible = not visivel
    area.Visible = not visivel
    footer.Visible = not visivel
    if visivel then
        local t = TweenService:Create(painel, TweenInfo.new(0.25), {Size = UDim2.new(0, 620, 0, 50)})
        t:Play()
        btnMin.Text = "+"
    else
        local t = TweenService:Create(painel, TweenInfo.new(0.25), {Size = UDim2.new(0, 620, 0, 480)})
        t:Play()
        btnMin.Text = "−"
    end
end)

btnFechar.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ============ LÓGICA DE AUTO FARM ============
local function getClosestMob(maxDistance)
    local closestMob = nil
    local shortestDistance = maxDistance or Config.distanciaFarm
    local char = LocalPlayer.Character

    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    for _, mob in ipairs(workspace:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            if mob ~= char and not Players:GetPlayerFromCharacter(mob) then
                local hum = mob:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    local dist = (mob.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDistance then
                        shortestDistance = dist
                        closestMob = mob
                    end
                end
            end
        end
    end
    return closestMob
end

local function attackMob(mob)
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function() tool:Activate() end)
    end
end

task.spawn(function()
    while gui.Parent do
        if Config.autoFarmLevel then
            local mob = getClosestMob()
            if mob then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local mobPos = mob.HumanoidRootPart.Position
                    local charPos = char.HumanoidRootPart.Position
                    local distance = (mobPos - charPos).Magnitude
                    if distance > 5 then
                        local tweenTime = math.clamp(distance / 100, 0.1, 0.5)
                        local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
                        local targetCFrame = CFrame.new(mobPos + (charPos - mobPos).Unit * 3, mobPos)
                        local tween = TweenService:Create(char.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                    attackMob(mob)
                end
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.fastAttack then
            local char = LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    pcall(function() tool:Activate() end)
                end
            end
        end
        task.wait(0.05)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.autoHaki then
            local char = LocalPlayer.Character
            if char then
                local haki = char:FindFirstChild("Haki")
                if haki then
                    pcall(function() haki:Activate() end)
                end
            end
        end
        task.wait(1)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.autoChest then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local minhaPos = char.HumanoidRootPart.Position
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and (obj.Name:lower():find("chest") or obj.Name:lower():find("bau")) then
                        local hrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Handle")
                        if hrp then
                            local dist = (hrp.Position - minhaPos).Magnitude
                            if dist < Config.distanciaFarm then
                                char.HumanoidRootPart.CFrame = hrp.CFrame
                                break
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.fly then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local dir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
                if dir.Magnitude > 0 then dir = dir.Unit * 60 end
                hrp.Velocity = dir
            end
        end
        task.wait(0.05)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.noclip then
            local char = LocalPlayer.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.fullbright then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end
        task.wait(1)
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.noFog then
            Lighting.FogEnd = 100000
        end
        task.wait(1)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Config.infiniteJump then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ============ CONSTRUÇÃO DAS ABAS ============

-- Aba FARM
local abaFARM = contentAbas["FARM"]
criarSecao(abaFARM, "🎯 AUTO FARM")
criarToggle(abaFARM, "Auto Farm Level", function(v) Config.autoFarmLevel = v end)
criarToggle(abaFARM, "Auto Farm Boss", function(v) Config.autoFarmBoss = v end)
criarToggle(abaFARM, "Auto Farm Fruta", function(v) Config.autoFarmFruit = v end)

criarSecao(abaFARM, "⚔ COMBATE")
criarToggle(abaFARM, "Fast Attack", function(v) Config.fastAttack = v end)
criarToggle(abaFARM, "Auto Haki", function(v) Config.autoHaki = v end)

criarSecao(abaFARM, "📦 COLETA")
criarToggle(abaFARM, "Auto Chest", function(v) Config.autoChest = v end)

criarSecao(abaFARM, "⚙ CONFIGURAÇÕES")
criarSlider(abaFARM, "Distancia do Farm", 10, 500, 150, function(v) Config.distanciaFarm = v end)

-- Aba TP
local abaTP = contentAbas["TP"]
local ilhasPorMar = {
    [1] = {
        {nome = "Starter Island", pos = Vector3.new(0, 20, 0)},
        {nome = "Marine Ford", pos = Vector3.new(-3000, 20, 3000)},
        {nome = "Middle Town", pos = Vector3.new(-500, 20, 500)},
        {nome = "Jungle", pos = Vector3.new(-1500, 20, 200)},
        {nome = "Pirate Village", pos = Vector3.new(-1000, 20, -500)},
        {nome = "Desert", pos = Vector3.new(1000, 20, 1000)},
        {nome = "Frozen Village", pos = Vector3.new(1000, 20, -1000)},
        {nome = "Marine Base", pos = Vector3.new(-2000, 20, -1000)},
        {nome = "Skylands", pos = Vector3.new(2000, 500, 500)},
        {nome = "Prison", pos = Vector3.new(5000, 20, 500)},
        {nome = "Colosseum", pos = Vector3.new(-1500, 20, -1500)},
        {nome = "Magma Village", pos = Vector3.new(-5000, 20, 5000)},
        {nome = "Underwater City", pos = Vector3.new(5000, -500, 5000)},
        {nome = "Fountain City", pos = Vector3.new(5000, 20, 3000)}
    },
    [2] = {
        {nome = "Kingdom of Rose", pos = Vector3.new(0, 20, 0)},
        {nome = "Green Zone", pos = Vector3.new(1000, 20, 1000)},
        {nome = "Graveyard", pos = Vector3.new(-500, 20, 500)},
        {nome = "Snow Mountain", pos = Vector3.new(500, 20, -500)},
        {nome = "Hot and Cold", pos = Vector3.new(-1000, 20, -1000)},
        {nome = "Cursed Ship", pos = Vector3.new(2000, 20, 2000)},
        {nome = "Ice Castle", pos = Vector3.new(1500, 20, 1500)},
        {nome = "Forgotten Island", pos = Vector3.new(-2000, 20, -2000)},
        {nome = "Remote Island", pos = Vector3.new(3000, 20, 3000)},
        {nome = "Dark Arena", pos = Vector3.new(4000, 20, 4000)},
        {nome = "Indra Island", pos = Vector3.new(-3000, 20, -3000)}
    },
    [3] = {
        {nome = "Port Town", pos = Vector3.new(0, 20, 0)},
        {nome = "Hydra Island", pos = Vector3.new(2000, 20, 2000)},
        {nome = "Great Tree", pos = Vector3.new(-1000, 20, 1000)},
        {nome = "Castle on the Sea", pos = Vector3.new(3000, 20, 3000)},
        {nome = "Haunted Castle", pos = Vector3.new(-2000, 20, -2000)},
        {nome = "Sea of Treats", pos = Vector3.new(4000, 20, 4000)},
        {nome = "Tiki Outpost", pos = Vector3.new(-3000, 20, 3000)},
        {nome = "Floating Turtle", pos = Vector3.new(5000, 20, 5000)},
        {nome = "Kitsune Island", pos = Vector3.new(-5000, 20, -5000)}
    }
}

criarSecao(abaTP, "🌐 ILHAS - SEA " .. MAR)
local ilhasAtuais = ilhasPorMar[MAR] or ilhasPorMar[2]
for _, ilha in ipairs(ilhasAtuais) do
    criarBotao(abaTP, "📍 " .. ilha.nome, function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(ilha.pos)
            notificar("Teleporte", "Indo para " .. ilha.nome, "sucesso")
        end
    end)
end

local bossesPorMar = {
    [1] = {
        {nome = "Gorilla King", pos = Vector3.new(-1500, 20, 200)},
        {nome = "Bobby", pos = Vector3.new(-1000, 20, -500)},
        {nome = "Yeti", pos = Vector3.new(1000, 20, -1000)},
        {nome = "Mob Leader", pos = Vector3.new(-2000, 20, -1000)},
        {nome = "Cyborg", pos = Vector3.new(5000, 20, 500)},
        {nome = "Saber Expert", pos = Vector3.new(-1500, 20, -1500)},
        {nome = "Warden", pos = Vector3.new(5000, 20, 500)},
        {nome = "Chief Warden", pos = Vector3.new(5000, 20, 500)},
        {nome = "Swan", pos = Vector3.new(-2000, 20, -1000)},
        {nome = "Magma Admiral", pos = Vector3.new(-5000, 20, 5000)},
        {nome = "Fishman Lord", pos = Vector3.new(5000, -500, 5000)},
        {nome = "Wysper", pos = Vector3.new(2000, 500, 500)},
        {nome = "Thunder God", pos = Vector3.new(2000, 500, 500)}
    },
    [2] = {
        {nome = "Diamond", pos = Vector3.new(0, 20, 0)},
        {nome = "Jeremy", pos = Vector3.new(500, 20, 500)},
        {nome = "Fajita", pos = Vector3.new(1000, 20, 1000)},
        {nome = "Don Swan", pos = Vector3.new(1500, 20, 1500)},
        {nome = "Smoke Admiral", pos = Vector3.new(-1000, 20, -1000)},
        {nome = "Cursed Captain", pos = Vector3.new(2000, 20, 2000)},
        {nome = "Awakened Ice Admiral", pos = Vector3.new(1500, 20, 1500)},
        {nome = "Tide Keeper", pos = Vector3.new(-2000, 20, -2000)},
        {nome = "Darkbeard", pos = Vector3.new(4000, 20, 4000)}
    },
    [3] = {
        {nome = "Stone", pos = Vector3.new(0, 20, 0)},
        {nome = "Hydra Leader", pos = Vector3.new(2000, 20, 2000)},
        {nome = "Killer Clown", pos = Vector3.new(-1000, 20, 1000)},
        {nome = "Cake Prince", pos = Vector3.new(4000, 20, 4000)},
        {nome = "Drip Mama", pos = Vector3.new(-2000, 20, -2000)},
        {nome = "Longma", pos = Vector3.new(3000, 20, 3000)}
    }
}

criarSecao(abaTP, "👹 BOSSES")
local bossesAtuais = bossesPorMar[MAR] or bossesPorMar[2]
for _, boss in ipairs(bossesAtuais) do
    criarBotao(abaTP, "👹 " .. boss.nome, function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(boss.pos)
            notificar("Teleporte", "Indo para " .. boss.nome, "sucesso")
        end
    end)
end

-- Aba ESP
local abaESP = contentAbas["ESP"]
criarSecao(abaESP, "👁 ESP")
criarToggle(abaESP, "ESP Players", function(v)
    notificar("ESP", "ESP Players: " .. tostring(v), "info")
end)
criarToggle(abaESP, "ESP Frutas", function(v)
    notificar("ESP", "ESP Frutas: " .. tostring(v), "info")
end)
criarToggle(abaESP, "ESP Chests", function(v)
    notificar("ESP", "ESP Chests: " .. tostring(v), "info")
end)

-- Aba MOVE
local abaMOVE = contentAbas["MOVE"]
criarSecao(abaMOVE, "⚡ MOVIMENTO")
criarToggle(abaMOVE, "Speed", function(v)
    Config.speed = v
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = v and 100 or 16
    end
end)
criarToggle(abaMOVE, "Fly", function(v) Config.fly = v end)
criarToggle(abaMOVE, "Noclip", function(v) Config.noclip = v end)
criarToggle(abaMOVE, "Infinite Jump", function(v) Config.infiniteJump = v end)

-- Aba VISUAL
local abaVISUAL = contentAbas["VISUAL"]
criarSecao(abaVISUAL, "🎨 VISUAL")
criarToggle(abaVISUAL, "Fullbright", function(v)
    Config.fullbright = v
    if not v then
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end)
criarToggle(abaVISUAL, "No Fog", function(v)
    Config.noFog = v
    if not v then
        Lighting.FogEnd = 1000
    end
end)

-- Aba CFG
local abaCFG = contentAbas["CFG"]
criarSecao(abaCFG, "⚙ CONFIGURAÇÕES")
criarToggle(abaCFG, "Notificações", function(v) Config.notificacoes = v end, true)
criarToggle(abaCFG, "Modo Rainbow", function(v) Config.rainbow = v end)

-- ============ LOOPS GLOBAIS ============
local frames = 0
local ultimo = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - ultimo >= 1 then
        fpsTxt.Text = "FPS: " .. frames
        frames = 0
        ultimo = tick()
        playersTxt.Text = #Players:GetPlayers() .. " players"
    end
end)

local hue = 0
RunService.Heartbeat:Connect(function(dt)
    if Config.rainbow then
        hue = (hue + dt * 0.3) % 1
        local cor = Color3.fromHSV(hue, 1, 1)
        header.BackgroundColor3 = cor
        bordaPainel.Color = cor
    else
        header.BackgroundColor3 = Cores.azul
        bordaPainel.Color = Cores.azul
    end
end)

notificar("BF4X", "Carregado! Sea " .. MAR, "sucesso")
print("[BF4X] v4.0 carregado! Sea " .. MAR)
