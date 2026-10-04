--[[
    BF4X Premium - Blox Fruits Script
    Feito por Ewerton
    Versao: 1.1 Premium
    Compatibilidade: Arceus X
]]

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

-- ============ DETECCAO DE MAR INTELIGENTE ============
local function detectarMar()
    local nomeJogo = ""
    local sucesso, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)

    if sucesso and info then
        nomeJogo = info.Name or ""
    end

    print("[BF4X] Nome do jogo: " .. nomeJogo)

    local eBloxFruits = nomeJogo:lower():find("blox") and nomeJogo:lower():find("fruit")

    if not eBloxFruits then
        local idsBloxFruits = {
            2753915549, 4442272183, 7449423635,
            920587237, 7909173265657, 7909174109773
        }
        for _, id in ipairs(idsBloxFruits) do
            if game.PlaceId == id then
                eBloxFruits = true
                break
            end
        end
    end

    if not eBloxFruits then
        return nil
    end

    local mapa = workspace:FindFirstChild("Map") or workspace

    local ilhasMar = {
        [1] = {"Jungle", "Pirate Village", "Magma Village", "Marine Ford", "Fountain City", "Colosseum", "Prison"},
        [2] = {"Kingdom of Rose", "Green Zone", "Cursed Ship", "Ice Castle", "Forgotten Island", "Graveyard", "Snow Mountain"},
        [3] = {"Port Town", "Hydra Island", "Castle on the Sea", "Haunted Castle", "Floating Turtle", "Sea of Treats", "Tiki Outpost"}
    }

    local contagem = {[1] = 0, [2] = 0, [3] = 0}

    if mapa then
        for mar, listaIlhas in pairs(ilhasMar) do
            for _, nomeIlha in ipairs(listaIlhas) do
                for _, filho in ipairs(mapa:GetDescendants()) do
                    if filho.Name:lower():find(nomeIlha:lower()) then
                        contagem[mar] = contagem[mar] + 1
                        break
                    end
                end
            end
        end
    end

    print("[BF4X] Ilhas - Sea 1: " .. contagem[1] .. " | Sea 2: " .. contagem[2] .. " | Sea 3: " .. contagem[3])

    local marDetectado = 0
    local maiorContagem = 0

    for mar, qtd in pairs(contagem) do
        if qtd > maiorContagem then
            maiorContagem = qtd
            marDetectado = mar
        end
    end

    if maiorContagem >= 1 then
        return marDetectado
    end

    local PlaceIds = {
        [2753915549] = 1,
        [4442272183] = 2,
        [7449423635] = 3,
        [920587237] = 2,
        [7909173265657] = 2
    }

    return PlaceIds[game.PlaceId]
end

local MAR = detectarMar()

if not MAR then
    print("[BF4X] Voce nao esta no Blox Fruits!")
    return
end

print("[BF4X] Blox Fruits detectado! Sea " .. MAR)

if CoreGui:FindFirstChild("BF4X") then
    CoreGui.BF4X:Destroy()
end

-- ============ TEXTOS ============
local Textos = {
    pt = {
        farm = "FARM", tp = "TP", esp = "ESP", move = "MOVE", visual = "VISUAL", cfg = "CFG", info = "INFO",
        autoFarmLevel = "Auto Farm Level",
        autoFarmBoss = "Auto Farm Boss",
        autoFarmFruit = "Auto Farm Fruta",
        fastAttack = "Fast Attack",
        autoChest = "Auto Chest",
        autoHaki = "Auto Haki",
        tpIslands = "Ilhas",
        tpBosses = "Bosses",
        tpSpecials = "Especiais",
        tpPlayers = "Jogadores",
        espPlayers = "ESP Players",
        espFruits = "ESP Frutas",
        espChests = "ESP Chests",
        espEnemies = "ESP Enemies",
        speed = "Speed",
        fly = "Fly",
        noclip = "Noclip",
        infiniteJump = "Infinite Jump",
        waterWalk = "Water Walk",
        fullbright = "Fullbright",
        noFog = "No Fog",
        fpsBoost = "FPS Boost",
        language = "Lingua",
        panelColor = "Cor do Painel",
        rainbow = "Modo Rainbow",
        notifications = "Notificacoes",
        watermark = "Watermark",
        creditos = "Feito por Ewerton\nVersao Premium 1.1\n\nUse com responsabilidade."
    },
    en = {
        farm = "FARM", tp = "TP", esp = "ESP", move = "MOVE", visual = "VISUAL", cfg = "CFG", info = "INFO",
        autoFarmLevel = "Auto Farm Level",
        autoFarmBoss = "Auto Farm Boss",
        autoFarmFruit = "Auto Farm Fruit",
        fastAttack = "Fast Attack",
        autoChest = "Auto Chest",
        autoHaki = "Auto Haki",
        tpIslands = "Islands",
        tpBosses = "Bosses",
        tpSpecials = "Specials",
        tpPlayers = "Players",
        espPlayers = "ESP Players",
        espFruits = "ESP Fruits",
        espChests = "ESP Chests",
        espEnemies = "ESP Enemies",
        speed = "Speed",
        fly = "Fly",
        noclip = "Noclip",
        infiniteJump = "Infinite Jump",
        waterWalk = "Water Walk",
        fullbright = "Fullbright",
        noFog = "No Fog",
        fpsBoost = "FPS Boost",
        language = "Language",
        panelColor = "Panel Color",
        rainbow = "Rainbow Mode",
        notifications = "Notifications",
        watermark = "Watermark",
        creditos = "Made by Ewerton\nPremium Version 1.1\n\nUse responsibly."
    },
    es = {
        farm = "FARM", tp = "TP", esp = "ESP", move = "MOVE", visual = "VISUAL", cfg = "CFG", info = "INFO",
        autoFarmLevel = "Auto Farm Nivel",
        autoFarmBoss = "Auto Farm Jefe",
        autoFarmFruit = "Auto Farm Fruta",
        fastAttack = "Ataque Rapido",
        autoChest = "Auto Cofre",
        autoHaki = "Auto Haki",
        tpIslands = "Islas",
        tpBosses = "Jefes",
        tpSpecials = "Especiales",
        tpPlayers = "Jugadores",
        espPlayers = "ESP Jugadores",
        espFruits = "ESP Frutas",
        espChests = "ESP Cofres",
        espEnemies = "ESP Enemigos",
        speed = "Velocidad",
        fly = "Volar",
        noclip = "Noclip",
        infiniteJump = "Salto Infinito",
        waterWalk = "Caminar en Agua",
        fullbright = "Brillo Total",
        noFog = "Sin Niebla",
        fpsBoost = "Boost FPS",
        language = "Idioma",
        panelColor = "Color del Panel",
        rainbow = "Modo Arcoiris",
        notifications = "Notificaciones",
        watermark = "Marca de Agua",
        creditos = "Hecho por Ewerton\nVersion Premium 1.1\n\nUsar con responsabilidad."
    }
}

local idiomaAtual = "pt"

local function T(chave)
    return Textos[idiomaAtual][chave] or chave
end

-- ============ CONFIG ============
local Config = {
    mar = MAR,
    panelSize = 1.0,
    rainbow = false,
    notificacoes = true,
    watermark = true,

    autoFarmLevel = false,
    autoFarmBoss = false,
    autoFarmFruit = false,
    fastAttack = false,
    autoChest = false,
    autoHaki = false,

    espPlayers = false,
    espFruits = false,
    espChests = false,
    espEnemies = false,

    speed = false,
    fly = false,
    noclip = false,
    infiniteJump = false,
    waterWalk = false,

    fullbright = false,
    noFog = false,
    fpsBoost = false
}

local Cores = {
    fundo = Color3.fromRGB(8, 8, 14),
    fundoPainel = Color3.fromRGB(18, 18, 28),
    fundoAba = Color3.fromRGB(26, 26, 40),
    fundoSecundario = Color3.fromRGB(32, 32, 48),
    azul = Color3.fromRGB(0, 163, 255),
    azulClaro = Color3.fromRGB(80, 200, 255),
    azulEscuro = Color3.fromRGB(0, 100, 180),
    roxo = Color3.fromRGB(120, 0, 200),
    dourado = Color3.fromRGB(255, 215, 0),
    douradoClaro = Color3.fromRGB(255, 235, 130),
    texto = Color3.fromRGB(255, 255, 255),
    cinza = Color3.fromRGB(160, 160, 180),
    cinzaEscuro = Color3.fromRGB(80, 80, 100),
    verde = Color3.fromRGB(0, 220, 100),
    vermelho = Color3.fromRGB(220, 50, 50)
}

-- ============ GUI PRINCIPAL ============
local gui = Instance.new("ScreenGui")
gui.Name = "BF4X"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local painel = Instance.new("Frame")
painel.Name = "Painel"
painel.Size = UDim2.new(0, 620, 0, 460)
painel.Position = UDim2.new(0.5, -310, 0.5, -230)
painel.BackgroundColor3 = Cores.fundoPainel
painel.BorderSizePixel = 0
painel.Active = true
painel.Draggable = true
painel.Parent = gui

local cantoPainel = Instance.new("UICorner")
cantoPainel.CornerRadius = UDim.new(0, 14)
cantoPainel.Parent = painel

local bordaPainel = Instance.new("UIStroke")
bordaPainel.Color = Cores.azul
bordaPainel.Thickness = 2
bordaPainel.Transparency = 0.2
bordaPainel.Parent = painel

local gradientPainel = Instance.new("UIGradient")
gradientPainel.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 15, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 18, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
}
gradientPainel.Rotation = 135
gradientPainel.Parent = painel

-- ============ HEADER ============
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = Cores.azul
header.BorderSizePixel = 0
header.Parent = painel

local cantoHeader = Instance.new("UICorner")
cantoHeader.CornerRadius = UDim.new(0, 14)
cantoHeader.Parent = header

local gradientHeader = Instance.new("UIGradient")
gradientHeader.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 163, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(120, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))
}
gradientHeader.Rotation = 0
gradientHeader.Parent = header

local botaoMinimizar = Instance.new("TextButton")
botaoMinimizar.Size = UDim2.new(0, 32, 0, 32)
botaoMinimizar.Position = UDim2.new(0, 8, 0, 6)
botaoMinimizar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
botaoMinimizar.BackgroundTransparency = 0.85
botaoMinimizar.BorderSizePixel = 0
botaoMinimizar.Text = "−"
botaoMinimizar.TextColor3 = Cores.texto
botaoMinimizar.TextSize = 20
botaoMinimizar.Font = Enum.Font.GothamBold
botaoMinimizar.Parent = header

local cantoMin = Instance.new("UICorner")
cantoMin.CornerRadius = UDim.new(1, 0)
cantoMin.Parent = botaoMinimizar

local tituloHeader = Instance.new("TextLabel")
tituloHeader.Size = UDim2.new(0.35, 0, 1, 0)
tituloHeader.Position = UDim2.new(0.08, 0, 0, 0)
tituloHeader.BackgroundTransparency = 1
tituloHeader.Text = "BF4X"
tituloHeader.TextColor3 = Cores.texto
tituloHeader.TextSize = 22
tituloHeader.Font = Enum.Font.GothamBlack
tituloHeader.TextXAlignment = Enum.TextXAlignment.Left
tituloHeader.Parent = header

local versaoHeader = Instance.new("TextLabel")
versaoHeader.Size = UDim2.new(0.25, 0, 1, 0)
versaoHeader.Position = UDim2.new(0.42, 0, 0, 0)
versaoHeader.BackgroundTransparency = 1
versaoHeader.Text = "PREMIUM"
versaoHeader.TextColor3 = Cores.dourado
versaoHeader.TextSize = 12
versaoHeader.Font = Enum.Font.GothamBold
versaoHeader.TextXAlignment = Enum.TextXAlignment.Left
versaoHeader.Parent = header

local marHeader = Instance.new("TextLabel")
marHeader.Size = UDim2.new(0.22, 0, 1, 0)
marHeader.Position = UDim2.new(0.65, 0, 0, 0)
marHeader.BackgroundTransparency = 1
marHeader.Text = "Sea " .. MAR
marHeader.TextColor3 = Cores.texto
marHeader.TextSize = 15
marHeader.Font = Enum.Font.GothamBold
marHeader.TextXAlignment = Enum.TextXAlignment.Right
marHeader.Parent = header

local botaoFechar = Instance.new("TextButton")
botaoFechar.Size = UDim2.new(0, 32, 0, 32)
botaoFechar.Position = UDim2.new(1, -40, 0, 6)
botaoFechar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
botaoFechar.BackgroundTransparency = 0.2
botaoFechar.BorderSizePixel = 0
botaoFechar.Text = "X"
botaoFechar.TextColor3 = Cores.texto
botaoFechar.TextSize = 15
botaoFechar.Font = Enum.Font.GothamBold
botaoFechar.Parent = header

local cantoFechar = Instance.new("UICorner")
cantoFechar.CornerRadius = UDim.new(1, 0)
cantoFechar.Parent = botaoFechar

-- ============ SIDEBAR ============
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 140, 1, -44)
sidebar.Position = UDim2.new(0, 0, 0, 44)
sidebar.BackgroundColor3 = Cores.fundo
sidebar.BorderSizePixel = 0
sidebar.Parent = painel

local abas = {
    {nome = "FARM", icone = "🎯"},
    {nome = "TP", icone = "🌐"},
    {nome = "ESP", icone = "👁"},
    {nome = "MOVE", icone = "⚡"},
    {nome = "VISUAL", icone = "🎨"},
    {nome = "CFG", icone = "⚙"},
    {nome = "INFO", icone = "ℹ"}
}

local botoesAba = {}
local conteudosAba = {}

local areaConteudo = Instance.new("Frame")
areaConteudo.Size = UDim2.new(1, -140, 1, -72)
areaConteudo.Position = UDim2.new(0, 140, 0, 44)
areaConteudo.BackgroundTransparency = 1
areaConteudo.Parent = painel

for i, aba in ipairs(abas) do
    local botao = Instance.new("TextButton")
    botao.Name = "Aba_" .. aba.nome
    botao.Size = UDim2.new(1, -10, 0, 46)
    botao.Position = UDim2.new(0, 5, 0, (i - 1) * 50 + 8)
    botao.BackgroundColor3 = Cores.fundoAba
    botao.BackgroundTransparency = 0.5
    botao.BorderSizePixel = 0
    botao.Text = aba.icone .. "  " .. aba.nome
    botao.TextColor3 = Cores.texto
    botao.TextSize = 14
    botao.Font = Enum.Font.GothamBold
    botao.AutoButtonColor = false
    botao.TextXAlignment = Enum.TextXAlignment.Left
    botao.Parent = sidebar
    botoesAba[aba.nome] = botao

    local cantoA = Instance.new("UICorner")
    cantoA.CornerRadius = UDim.new(0, 8)
    cantoA.Parent = botao

    local strokeA = Instance.new("UIStroke")
    strokeA.Color = Cores.azul
    strokeA.Thickness = 1
    strokeA.Transparency = 1
    strokeA.Parent = botao

    local indice = Instance.new("Frame")
    indice.Name = "Indice"
    indice.Size = UDim2.new(0, 3, 0.6, 0)
    indice.Position = UDim2.new(0, 0, 0.2, 0)
    indice.BackgroundColor3 = Cores.dourado
    indice.BorderSizePixel = 0
    indice.Visible = false
    indice.Parent = botao

    local cantoInd = Instance.new("UICorner")
    cantoInd.CornerRadius = UDim.new(1, 0)
    cantoInd.Parent = indice

    local conteudo = Instance.new("ScrollingFrame")
    conteudo.Name = "Conteudo_" .. aba.nome
    conteudo.Size = UDim2.new(1, 0, 1, 0)
    conteudo.BackgroundTransparency = 1
    conteudo.BorderSizePixel = 0
    conteudo.ScrollBarThickness = 4
    conteudo.ScrollBarImageColor3 = Cores.azul
    conteudo.CanvasSize = UDim2.new(0, 0, 0, 0)
    conteudo.AutomaticCanvasSize = Enum.AutomaticSize.Y
    conteudo.Visible = false
    conteudo.Parent = areaConteudo
    conteudosAba[aba.nome] = conteudo

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = conteudo

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = conteudo
end

-- ============ FOOTER ============
local footer = Instance.new("Frame")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 28)
footer.Position = UDim2.new(0, 0, 1, -28)
footer.BackgroundColor3 = Cores.fundo
footer.BorderSizePixel = 0
footer.Parent = painel

local cantoFooter = Instance.new("UICorner")
cantoFooter.CornerRadius = UDim.new(0, 14)
cantoFooter.Parent = footer

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.3, 0, 1, 0)
statusLabel.Position = UDim2.new(0, 15, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Online"
statusLabel.TextColor3 = Cores.verde
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = footer

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0.2, 0, 1, 0)
fpsLabel.Position = UDim2.new(0.4, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 60"
fpsLabel.TextColor3 = Cores.cinza
fpsLabel.TextSize = 11
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.Parent = footer

local marLabel = Instance.new("TextLabel")
marLabel.Size = UDim2.new(0.2, 0, 1, 0)
marLabel.Position = UDim2.new(0.6, 0, 0, 0)
marLabel.BackgroundTransparency = 1
marLabel.Text = "Mar: " .. MAR
marLabel.TextColor3 = Cores.cinza
marLabel.TextSize = 11
marLabel.Font = Enum.Font.Gotham
marLabel.Parent = footer

local playersLabel = Instance.new("TextLabel")
playersLabel.Size = UDim2.new(0.2, 0, 1, 0)
playersLabel.Position = UDim2.new(0.8, 0, 0, 0)
playersLabel.BackgroundTransparency = 1
playersLabel.Text = "0 players"
playersLabel.TextColor3 = Cores.cinza
playersLabel.TextSize = 11
playersLabel.Font = Enum.Font.Gotham
playersLabel.TextXAlignment = Enum.TextXAlignment.Right
playersLabel.Parent = footer

-- ============ RESIZE HANDLE ============
local resizeHandle = Instance.new("TextButton")
resizeHandle.Size = UDim2.new(0, 20, 0, 20)
resizeHandle.Position = UDim2.new(1, -20, 1, -20)
resizeHandle.BackgroundColor3 = Cores.azul
resizeHandle.BackgroundTransparency = 0.5
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = "◢"
resizeHandle.TextColor3 = Cores.texto
resizeHandle.TextSize = 14
resizeHandle.Font = Enum.Font.GothamBold
resizeHandle.Parent = painel

local cantoResize = Instance.new("UICorner")
cantoResize.CornerRadius = UDim.new(0, 4)
cantoResize.Parent = resizeHandle

-- ============ NOTIFICACOES ============
local notificacoes = {}

local function notificar(titulo, texto, tipo)
    if not Config.notificacoes then return end

    local cor = Cores.azul
    if tipo == "sucesso" then cor = Cores.verde
    elseif tipo == "erro" then cor = Cores.vermelho
    elseif tipo == "aviso" then cor = Cores.dourado end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 280, 0, 70)
    notif.Position = UDim2.new(1, 20, 0, 100 + (#notificacoes * 80))
    notif.BackgroundColor3 = Cores.fundoPainel
    notif.BorderSizePixel = 0
    notif.Parent = gui

    table.insert(notificacoes, notif)

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 10)
    canto.Parent = notif

    local stroke = Instance.new("UIStroke")
    stroke.Color = cor
    stroke.Thickness = 2
    stroke.Transparency = 0.2
    stroke.Parent = notif

    local barraCor = Instance.new("Frame")
    barraCor.Size = UDim2.new(0, 4, 1, 0)
    barraCor.BackgroundColor3 = cor
    barraCor.BorderSizePixel = 0
    barraCor.Parent = notif

    local cantoBarra = Instance.new("UICorner")
    cantoBarra.CornerRadius = UDim.new(0, 10)
    cantoBarra.Parent = barraCor

    local lblTitulo = Instance.new("TextLabel")
    lblTitulo.Size = UDim2.new(1, -25, 0, 24)
    lblTitulo.Position = UDim2.new(0, 15, 0, 6)
    lblTitulo.BackgroundTransparency = 1
    lblTitulo.Text = titulo
    lblTitulo.TextColor3 = cor
    lblTitulo.TextSize = 14
    lblTitulo.Font = Enum.Font.GothamBold
    lblTitulo.TextXAlignment = Enum.TextXAlignment.Left
    lblTitulo.Parent = notif

    local lblTexto = Instance.new("TextLabel")
    lblTexto.Size = UDim2.new(1, -25, 0, 32)
    lblTexto.Position = UDim2.new(0, 15, 0, 30)
    lblTexto.BackgroundTransparency = 1
    lblTexto.Text = texto
    lblTexto.TextColor3 = Cores.texto
    lblTexto.TextSize = 12
    lblTexto.Font = Enum.Font.Gotham
    lblTexto.TextXAlignment = Enum.TextXAlignment.Left
    lblTexto.TextWrapped = true
    lblTexto.Parent = notif

    TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -300, 0, notif.Position.Y.Scale)
    }):Play()

    task.delay(4, function()
        for i, v in ipairs(notificacoes) do
            if v == notif then
                table.remove(notificacoes, i)
                break
            end
        end
        TweenService:Create(notif, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 20, 0, notif.Position.Y.Scale)
        }):Play()
        task.wait(0.35)
        notif:Destroy()
    end)
end

local function criarSecao(parent, titulo, icone)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 30)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local barra = Instance.new("Frame")
    barra.Size = UDim2.new(0, 3, 0, 20)
    barra.Position = UDim2.new(0, 0, 0.5, -10)
    barra.BackgroundColor3 = Cores.dourado
    barra.BorderSizePixel = 0
    barra.Parent = container

    local cantoBarra = Instance.new("UICorner")
    cantoBarra.CornerRadius = UDim.new(1, 0)
    cantoBarra.Parent = barra

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -15, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = (icone and icone .. " " or "") .. titulo
    label.TextColor3 = Cores.dourado
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    return container
end

local function criarToggle(parent, texto, callback, estadoInicial)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 36)
    container.BackgroundColor3 = Cores.fundoAba
    container.BackgroundTransparency = 0.5
    container.BorderSizePixel = 0
    container.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local switchBG = Instance.new("Frame")
    switchBG.Size = UDim2.new(0, 42, 0, 22)
    switchBG.Position = UDim2.new(1, -54, 0.5, -11)
    switchBG.BackgroundColor3 = Cores.cinzaEscuro
    switchBG.BorderSizePixel = 0
    switchBG.Parent = container

    local cantoSwitch = Instance.new("UICorner")
    cantoSwitch.CornerRadius = UDim.new(1, 0)
    cantoSwitch.Parent = switchBG

    local switchBotao = Instance.new("TextButton")
    switchBotao.Size = UDim2.new(0, 18, 0, 18)
    switchBotao.Position = UDim2.new(0, 2, 0.5, -9)
    switchBotao.BackgroundColor3 = Cores.texto
    switchBotao.BorderSizePixel = 0
    switchBotao.Text = ""
    switchBotao.Parent = switchBG

    local cantoBotao = Instance.new("UICorner")
    cantoBotao.CornerRadius = UDim.new(1, 0)
    cantoBotao.Parent = switchBotao

    local ativo = estadoInicial or false

    if ativo then
        switchBG.BackgroundColor3 = Cores.azul
        switchBotao.Position = UDim2.new(1, -20, 0.5, -9)
    end

    switchBotao.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            TweenService:Create(switchBG, TweenInfo.new(0.2), {BackgroundColor3 = Cores.azul}):Play()
            TweenService:Create(switchBotao, TweenInfo.new(0.2), {Position = UDim2.new(1, -20, 0.5, -9)}):Play()
        else
            TweenService:Create(switchBG, TweenInfo.new(0.2), {BackgroundColor3 = Cores.cinzaEscuro}):Play()
            TweenService:Create(switchBotao, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
        end
        if callback then callback(ativo) end
    end)

    return container
end

local function criarBotao(parent, texto, callback)
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 0, 36)
    botao.BackgroundColor3 = Cores.fundoAba
    botao.BackgroundTransparency = 0.3
    botao.BorderSizePixel = 0
    botao.Text = texto
    botao.TextColor3 = Cores.texto
    botao.TextSize = 12
    botao.Font = Enum.Font.Gotham
    botao.AutoButtonColor = false
    botao.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = botao

    local stroke = Instance.new("UIStroke")
    stroke.Color = Cores.azul
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = botao

    botao.MouseEnter:Connect(function()
        TweenService:Create(botao, TweenInfo.new(0.15), {
            BackgroundColor3 = Cores.azulEscuro,
            BackgroundTransparency = 0.2
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.3}):Play()
    end)

    botao.MouseLeave:Connect(function()
        TweenService:Create(botao, TweenInfo.new(0.15), {
            BackgroundColor3 = Cores.fundoAba,
            BackgroundTransparency = 0.3
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.7}):Play()
    end)

    botao.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return botao
end

local function criarSlider(parent, texto, min, max, valorInicial, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 50)
    container.BackgroundColor3 = Cores.fundoAba
    container.BackgroundTransparency = 0.5
    container.BorderSizePixel = 0
    container.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 20)
    label.Position = UDim2.new(0, 12, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local valorLabel = Instance.new("TextLabel")
    valorLabel.Size = UDim2.new(0.3, 0, 0, 20)
    valorLabel.Position = UDim2.new(0.65, 0, 0, 5)
    valorLabel.BackgroundTransparency = 1
    valorLabel.Text = tostring(valorInicial)
    valorLabel.TextColor3 = Cores.azulClaro
    valorLabel.TextSize = 12
    valorLabel.Font = Enum.Font.GothamBold
    valorLabel.TextXAlignment = Enum.TextXAlignment.Right
    valorLabel.Parent = container

    local fundoSlider = Instance.new("Frame")
    fundoSlider.Size = UDim2.new(1, -24, 0, 8)
    fundoSlider.Position = UDim2.new(0, 12, 0, 32)
    fundoSlider.BackgroundColor3 = Cores.cinzaEscuro
    fundoSlider.BorderSizePixel = 0
    fundoSlider.Parent = container

    local cantoFundo = Instance.new("UICorner")
    cantoFundo.CornerRadius = UDim.new(1, 0)
    cantoFundo.Parent = fundoSlider

    local preench = Instance.new("Frame")
    preench.Size = UDim2.new((valorInicial - min) / (max - min), 0, 1, 0)
    preench.BackgroundColor3 = Cores.azul
    preench.BorderSizePixel = 0
    preench.Parent = fundoSlider

    local cantoPreench = Instance.new("UICorner")
    cantoPreench.CornerRadius = UDim.new(1, 0)
    cantoPreench.Parent = preench

    local botaoSlider = Instance.new("TextButton")
    botaoSlider.Size = UDim2.new(0, 16, 0, 16)
    botaoSlider.Position = UDim2.new((valorInicial - min) / (max - min), -8, 0.5, -8)
    botaoSlider.BackgroundColor3 = Cores.texto
    botaoSlider.BorderSizePixel = 0
    botaoSlider.Text = ""
    botaoSlider.Parent = fundoSlider

    local cantoBotao = Instance.new("UICorner")
    cantoBotao.CornerRadius = UDim.new(1, 0)
    cantoBotao.Parent = botaoSlider

    local arrastando = false

    local function atualizar(input)
        local posX = math.clamp(input.Position.X - fundoSlider.AbsolutePosition.X, 0, fundoSlider.AbsoluteSize.X)
        local pct = posX / fundoSlider.AbsoluteSize.X
        local valor = math.floor(min + (max - min) * pct)
        preench.Size = UDim2.new(pct, 0, 1, 0)
        botaoSlider.Position = UDim2.new(pct, -8, 0.5, -8)
        valorLabel.Text = tostring(valor)
        if callback then callback(valor) end
    end

    botaoSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            arrastando = true
        end
    end)

    fundoSlider.InputBegan:Connect(function(input)
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

    return container
end

local function criarDropdown(parent, texto, opcoes, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 36)
    container.BackgroundColor3 = Cores.fundoAba
    container.BackgroundTransparency = 0.5
    container.BorderSizePixel = 0
    container.ClipsDescendants = false
    container.ZIndex = 10
    container.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 6)
    canto.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(0.5, -12, 0, 26)
    botao.Position = UDim2.new(0.5, 0, 0.5, -13)
    botao.BackgroundColor3 = Cores.azulEscuro
    botao.BorderSizePixel = 0
    botao.Text = opcoes[1] or "..."
    botao.TextColor3 = Cores.texto
    botao.TextSize = 12
    botao.Font = Enum.Font.GothamBold
    botao.ZIndex = 11
    botao.Parent = container

    local cantoBotao = Instance.new("UICorner")
    cantoBotao.CornerRadius = UDim.new(0, 5)
    cantoBotao.Parent = botao

    local lista = Instance.new("Frame")
    lista.Size = UDim2.new(0.5, -12, 0, #opcoes * 26)
    lista.Position = UDim2.new(0.5, 0, 1, 2)
    lista.BackgroundColor3 = Cores.fundoPainel
    lista.BorderSizePixel = 0
    lista.Visible = false
    lista.ZIndex = 12
    lista.Parent = container

    local cantoLista = Instance.new("UICorner")
    cantoLista.CornerRadius = UDim.new(0, 5)
    cantoLista.Parent = lista

    local strokeLista = Instance.new("UIStroke")
    strokeLista.Color = Cores.azul
    strokeLista.Thickness = 1
    strokeLista.Transparency = 0.3
    strokeLista.Parent = lista

    local aberto = false

    for i, opcao in ipairs(opcoes) do
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 26)
        item.Position = UDim2.new(0, 0, 0, (i - 1) * 26)
        item.BackgroundTransparency = 1
        item.Text = opcao
        item.TextColor3 = Cores.texto
        item.TextSize = 12
        item.Font = Enum.Font.Gotham
        item.ZIndex = 13
        item.Parent = lista

        item.MouseButton1Click:Connect(function()
            botao.Text = opcao
            lista.Visible = false
            aberto = false
            if callback then callback(opcao) end
        end)

        item.MouseEnter:Connect(function()
            item.BackgroundTransparency = 0.7
            item.BackgroundColor3 = Cores.azul
        end)

        item.MouseLeave:Connect(function()
            item.BackgroundTransparency = 1
        end)
    end

    botao.MouseButton1Click:Connect(function()
        aberto = not aberto
        lista.Visible = aberto
    end)

    return container
end

local function trocarAba(nomeAba)
    for nome, conteudo in pairs(conteudosAba) do
        conteudo.Visible = (nome == nomeAba)
    end
    for nome, botao in pairs(botoesAba) do
        local indice = botao:FindFirstChild("Indice")
        if nome == nomeAba then
            TweenService:Create(botao, TweenInfo.new(0.2), {
                BackgroundColor3 = Cores.azulEscuro,
                BackgroundTransparency = 0.2
            }):Play()
            botao.TextColor3 = Cores.dourado
            if indice then indice.Visible = true end
        else
            TweenService:Create(botao, TweenInfo.new(0.2), {
                BackgroundColor3 = Cores.fundoAba,
                BackgroundTransparency = 0.5
            }):Play()
            botao.TextColor3 = Cores.texto
            if indice then indice.Visible = false end
        end
    end
end

for nome, botao in pairs(botoesAba) do
    botao.MouseButton1Click:Connect(function() trocarAba(nome) end)
end

trocarAba("FARM")

local minimizado = false

botaoMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        sidebar.Visible = false
        areaConteudo.Visible = false
        footer.Visible = false
        TweenService:Create(painel, TweenInfo.new(0.3), {Size = UDim2.new(0, 620, 0, 44)}):Play()
        botaoMinimizar.Text = "+"
    else
        sidebar.Visible = true
        areaConteudo.Visible = true
        footer.Visible = true
        TweenService:Create(painel, TweenInfo.new(0.3), {Size = UDim2.new(0, 620, 0, 460)}):Play()
        botaoMinimizar.Text = "−"
    end
end)

botaoFechar.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local redimensionando = false
local tamanhoInicial
local posicaoInicial

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        redimensionando = true
        tamanhoInicial = painel.AbsoluteSize
        posicaoInicial = input.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        redimensionando = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if redimensionando then
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - posicaoInicial
            local novaLargura = math.clamp(tamanhoInicial.X + delta.X, 400, 900)
            local novaAltura = math.clamp(tamanhoInicial.Y + delta.Y, 300, 700)
            painel.Size = UDim2.new(0, novaLargura, 0, novaAltura)
        end
    end
end)

local watermark = Instance.new("TextLabel")
watermark.Name = "Watermark"
watermark.Size = UDim2.new(0, 240, 0, 34)
watermark.Position = UDim2.new(0, 20, 0, 20)
watermark.BackgroundColor3 = Cores.fundoPainel
watermark.BackgroundTransparency = 0.3
watermark.BorderSizePixel = 0
watermark.Text = "⚡ BF4X PREMIUM  |  Sea " .. MAR
watermark.TextColor3 = Cores.dourado
watermark.TextSize = 13
watermark.Font = Enum.Font.GothamBold
watermark.Parent = gui

local cantoWM = Instance.new("UICorner")
cantoWM.CornerRadius = UDim.new(0, 8)
cantoWM.Parent = watermark

local strokeWM = Instance.new("UIStroke")
strokeWM.Color = Cores.azul
strokeWM.Thickness = 1
strokeWM.Transparency = 0.3
strokeWM.Parent = watermark

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

local frames = 0
local ultimoTempo = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - ultimoTempo >= 1 then
        fpsLabel.Text = "FPS: " .. frames
        frames = 0
        ultimoTempo = tick()
        playersLabel.Text = #Players:GetPlayers() .. " players"
    end
end)

notificar("BF4X Premium", "Carregado! Sea " .. MAR, "sucesso")
print("[BF4X] Premium v1.1 carregado! Sea " .. MAR)
