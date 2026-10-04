--[[
    BF4X Premium - Blox Fruits Script
    Feito por Ewerton
    Versao: 2.0 Premium
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

-- ============ DETECCAO DE MAR ============
local function detectarMar()
    local nomeJogo = ""
    local sucesso, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)

    if sucesso and info then
        nomeJogo = info.Name or ""
    end

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

    local PlaceIds = {
        [2753915549] = 1,
        [4442272183] = 2,
        [7449423635] = 3,
        [920587237] = 2,
        [7909173265657] = 2,
        [7909174109773] = 2
    }

    if PlaceIds[game.PlaceId] then
        return PlaceIds[game.PlaceId]
    end

    local mapa = workspace:FindFirstChild("Map") or workspace

    local ilhasMar = {
        [1] = {"Jungle", "Pirate Village", "Magma Village", "Marine Ford", "Fountain City", "Colosseum", "Prison"},
        [2] = {"Kingdom of Rose", "Green Zone", "Cursed Ship", "Ice Castle", "Forgotten Island", "Graveyard", "Snow Mountain", "Cafe", "Mansion"},
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

    local marDetectado = 0
    local maiorContagem = 0

    for mar, qtd in pairs(contagem) do
        if qtd > maiorContagem then
            maiorContagem = qtd
            marDetectado = mar
        end
    end

    if maiorContagem >= 3 then
        return marDetectado
    end

    return 2
end

local MAR = detectarMar()

if not MAR then
    print("[BF4X] Voce nao esta no Blox Fruits!")
    return
end

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
        autoSword = "Auto Sword",
        autoGun = "Auto Gun",
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
        creditos = "BF4X Premium v2.0\n\nFeito por Ewerton\n\nUse com responsabilidade.",
        secaoFarm = "AUTO FARM",
        secaoCombate = "COMBATE",
        secaoColeta = "COLETA",
        secaoConfig = "CONFIGURACOES"
    },
    en = {
        farm = "FARM", tp = "TP", esp = "ESP", move = "MOVE", visual = "VISUAL", cfg = "CFG", info = "INFO",
        autoFarmLevel = "Auto Farm Level",
        autoFarmBoss = "Auto Farm Boss",
        autoFarmFruit = "Auto Farm Fruit",
        fastAttack = "Fast Attack",
        autoChest = "Auto Chest",
        autoHaki = "Auto Haki",
        autoSword = "Auto Sword",
        autoGun = "Auto Gun",
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
        creditos = "BF4X Premium v2.0\n\nMade by Ewerton\n\nUse responsibly.",
        secaoFarm = "AUTO FARM",
        secaoCombate = "COMBAT",
        secaoColeta = "COLLECT",
        secaoConfig = "SETTINGS"
    },
    es = {
        farm = "FARM", tp = "TP", esp = "ESP", move = "MOVE", visual = "VISUAL", cfg = "CFG", info = "INFO",
        autoFarmLevel = "Auto Farm Nivel",
        autoFarmBoss = "Auto Farm Jefe",
        autoFarmFruit = "Auto Farm Fruta",
        fastAttack = "Ataque Rapido",
        autoChest = "Auto Cofre",
        autoHaki = "Auto Haki",
        autoSword = "Auto Espada",
        autoGun = "Auto Pistola",
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
        creditos = "BF4X Premium v2.0\n\nHecho por Ewerton\n\nUsar con responsabilidad.",
        secaoFarm = "AUTO FARM",
        secaoCombate = "COMBATE",
        secaoColeta = "RECOLECCION",
        secaoConfig = "CONFIGURACION"
    }
}

local idiomaAtual = "pt"

local function T(chave)
    return Textos[idiomaAtual][chave] or chave
end

-- ============ CONFIG ============
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
    autoSword = false,
    autoGun = false,

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
    fpsBoost = false,

    distanciaFarm = 100,
    distanciaTp = 5
}

local Cores = {
    fundo = Color3.fromRGB(6, 6, 12),
    fundoPainel = Color3.fromRGB(14, 14, 24),
    fundoAba = Color3.fromRGB(22, 22, 36),
    fundoSecundario = Color3.fromRGB(30, 30, 48),
    card = Color3.fromRGB(20, 20, 32),
    azul = Color3.fromRGB(0, 163, 255),
    azulClaro = Color3.fromRGB(100, 210, 255),
    azulEscuro = Color3.fromRGB(0, 90, 170),
    roxo = Color3.fromRGB(140, 60, 220),
    dourado = Color3.fromRGB(255, 215, 0),
    douradoClaro = Color3.fromRGB(255, 235, 130),
    texto = Color3.fromRGB(240, 240, 255),
    cinza = Color3.fromRGB(140, 140, 170),
    cinzaEscuro = Color3.fromRGB(60, 60, 80),
    verde = Color3.fromRGB(0, 220, 100),
    vermelho = Color3.fromRGB(220, 50, 50),
    laranja = Color3.fromRGB(255, 140, 0)
}

-- ============ GUI ============
local gui = Instance.new("ScreenGui")
gui.Name = "BF4X"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local painel = Instance.new("Frame")
painel.Name = "Painel"
painel.Size = UDim2.new(0, 640, 0, 480)
painel.Position = UDim2.new(0.5, -320, 0.5, -240)
painel.BackgroundColor3 = Cores.fundoPainel
painel.BorderSizePixel = 0
painel.Active = true
painel.Draggable = true
painel.Parent = gui

local cantoPainel = Instance.new("UICorner")
cantoPainel.CornerRadius = UDim.new(0, 16)
cantoPainel.Parent = painel

local bordaPainel = Instance.new("UIStroke")
bordaPainel.Color = Cores.azul
bordaPainel.Thickness = 1.5
bordaPainel.Transparency = 0.4
bordaPainel.Parent = painel

local gradientePainel = Instance.new("UIGradient")
gradientePainel.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 16, 38)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 14, 24)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 16))
}
gradientePainel.Rotation = 135
gradientePainel.Parent = painel

-- ============ HEADER ============
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Cores.azul
header.BorderSizePixel = 0
header.Parent = painel

local cantoHeader = Instance.new("UICorner")
cantoHeader.CornerRadius = UDim.new(0, 16)
cantoHeader.Parent = header

local gradienteHeader = Instance.new("UIGradient")
gradienteHeader.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 220)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 90, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 40))
}
gradienteHeader.Rotation = 0
gradienteHeader.Parent = header

local botaoMinimizar = Instance.new("TextButton")
botaoMinimizar.Size = UDim2.new(0, 34, 0, 34)
botaoMinimizar.Position = UDim2.new(0, 10, 0, 8)
botaoMinimizar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
botaoMinimizar.BackgroundTransparency = 0.9
botaoMinimizar.BorderSizePixel = 0
botaoMinimizar.Text = "−"
botaoMinimizar.TextColor3 = Cores.texto
botaoMinimizar.TextSize = 20
botaoMinimizar.Font = Enum.Font.GothamBold
botaoMinimizar.Parent = header

local cantoMin = Instance.new("UICorner")
cantoMin.CornerRadius = UDim.new(1, 0)
cantoMin.Parent = botaoMinimizar

local logoIcone = Instance.new("TextLabel")
logoIcone.Size = UDim2.new(0, 40, 0, 40)
logoIcone.Position = UDim2.new(0, 52, 0, 5)
logoIcone.BackgroundTransparency = 1
logoIcone.Text = "⚡"
logoIcone.TextColor3 = Cores.dourado
logoIcone.TextSize = 24
logoIcone.Font = Enum.Font.GothamBold
logoIcone.Parent = header

local tituloHeader = Instance.new("TextLabel")
tituloHeader.Size = UDim2.new(0.3, 0, 1, 0)
tituloHeader.Position = UDim2.new(0.15, 0, 0, 0)
tituloHeader.BackgroundTransparency = 1
tituloHeader.Text = "BF4X"
tituloHeader.TextColor3 = Cores.texto
tituloHeader.TextSize = 22
tituloHeader.Font = Enum.Font.GothamBlack
tituloHeader.TextXAlignment = Enum.TextXAlignment.Left
tituloHeader.Parent = header

local badgePremium = Instance.new("Frame")
badgePremium.Size = UDim2.new(0, 80, 0, 22)
badgePremium.Position = UDim2.new(0.42, 0, 0.5, -11)
badgePremium.BackgroundColor3 = Cores.dourado
badgePremium.BackgroundTransparency = 0.15
badgePremium.BorderSizePixel = 0
badgePremium.Parent = header

local cantoBadge = Instance.new("UICorner")
cantoBadge.CornerRadius = UDim.new(1, 0)
cantoBadge.Parent = badgePremium

local badgeTexto = Instance.new("TextLabel")
badgeTexto.Size = UDim2.new(1, 0, 1, 0)
badgeTexto.BackgroundTransparency = 1
badgeTexto.Text = "PREMIUM"
badgeTexto.TextColor3 = Color3.fromRGB(30, 20, 0)
badgeTexto.TextSize = 11
badgeTexto.Font = Enum.Font.GothamBold
badgeTexto.Parent = badgePremium

local marBadge = Instance.new("Frame")
marBadge.Size = UDim2.new(0, 90, 0, 26)
marBadge.Position = UDim2.new(0.72, 0, 0.5, -13)
marBadge.BackgroundColor3 = Cores.fundoAba
marBadge.BackgroundTransparency = 0.3
marBadge.BorderSizePixel = 0
marBadge.Parent = header

local cantoMar = Instance.new("UICorner")
cantoMar.CornerRadius = UDim.new(1, 0)
cantoMar.Parent = marBadge

local marTexto = Instance.new("TextLabel")
marTexto.Size = UDim2.new(1, 0, 1, 0)
marTexto.BackgroundTransparency = 1
marTexto.Text = "SEA " .. MAR
marTexto.TextColor3 = Cores.azulClaro
marTexto.TextSize = 13
marTexto.Font = Enum.Font.GothamBold
marTexto.Parent = marBadge

local botaoFechar = Instance.new("TextButton")
botaoFechar.Size = UDim2.new(0, 34, 0, 34)
botaoFechar.Position = UDim2.new(1, -44, 0, 8)
botaoFechar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
botaoFechar.BackgroundTransparency = 0.3
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
sidebar.Size = UDim2.new(0, 150, 1, -50)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = Cores.fundo
sidebar.BorderSizePixel = 0
sidebar.Parent = painel

local abas = {
    {nome = "FARM", icone = "🎯", cor = Color3.fromRGB(0, 163, 255)},
    {nome = "TP", icone = "🌐", cor = Color3.fromRGB(140, 60, 220)},
    {nome = "ESP", icone = "👁", cor = Color3.fromRGB(255, 140, 0)},
    {nome = "MOVE", icone = "⚡", cor = Color3.fromRGB(0, 220, 100)},
    {nome = "VISUAL", icone = "🎨", cor = Color3.fromRGB(220, 50, 130)},
    {nome = "CFG", icone = "⚙", cor = Color3.fromRGB(160, 160, 180)},
    {nome = "INFO", icone = "ℹ", cor = Color3.fromRGB(0, 200, 200)}
}

local botoesAba = {}
local conteudosAba = {}

local areaConteudo = Instance.new("Frame")
areaConteudo.Size = UDim2.new(1, -150, 1, -78)
areaConteudo.Position = UDim2.new(0, 150, 0, 50)
areaConteudo.BackgroundTransparency = 1
areaConteudo.Parent = painel

for i, aba in ipairs(abas) do
    local botao = Instance.new("TextButton")
    botao.Name = "Aba_" .. aba.nome
    botao.Size = UDim2.new(1, -14, 0, 48)
    botao.Position = UDim2.new(0, 7, 0, (i - 1) * 52 + 10)
    botao.BackgroundColor3 = Cores.fundoAba
    botao.BackgroundTransparency = 0.6
    botao.BorderSizePixel = 0
    botao.Text = ""
    botao.AutoButtonColor = false
    botao.TextXAlignment = Enum.TextXAlignment.Left
    botao.Parent = sidebar
    botoesAba[aba.nome] = botao

    local cantoA = Instance.new("UICorner")
    cantoA.CornerRadius = UDim.new(0, 10)
    cantoA.Parent = botao

    local icone = Instance.new("TextLabel")
    icone.Size = UDim2.new(0, 32, 0, 32)
    icone.Position = UDim2.new(0, 10, 0.5, -16)
    icone.BackgroundTransparency = 1
    icone.Text = aba.icone
    icone.TextSize = 18
    icone.Font = Enum.Font.GothamBold
    icone.TextXAlignment = Enum.TextXAlignment.Center
    icone.Parent = botao

    local textoAba = Instance.new("TextLabel")
    textoAba.Size = UDim2.new(1, -50, 1, 0)
    textoAba.Position = UDim2.new(0, 48, 0, 0)
    textoAba.BackgroundTransparency = 1
    textoAba.Text = aba.nome
    textoAba.TextColor3 = Cores.cinza
    textoAba.TextSize = 14
    textoAba.Font = Enum.Font.GothamBold
    textoAba.TextXAlignment = Enum.TextXAlignment.Left
    textoAba.Parent = botao

    local indice = Instance.new("Frame")
    indice.Name = "Indice"
    indice.Size = UDim2.new(0, 4, 0.5, 0)
    indice.Position = UDim2.new(0, 0, 0.25, 0)
    indice.BackgroundColor3 = aba.cor
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
    conteudo.ScrollBarThickness = 3
    conteudo.ScrollBarImageColor3 = Cores.azul
    conteudo.CanvasSize = UDim2.new(0, 0, 0, 0)
    conteudo.AutomaticCanvasSize = Enum.AutomaticSize.Y
    conteudo.Visible = false
    conteudo.Parent = areaConteudo
    conteudosAba[aba.nome] = conteudo

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = conteudo

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 14)
    padding.PaddingLeft = UDim.new(0, 14)
    padding.PaddingRight = UDim.new(0, 14)
    padding.PaddingBottom = UDim.new(0, 14)
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
cantoFooter.CornerRadius = UDim.new(0, 16)
cantoFooter.Parent = footer

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 8, 0, 8)
statusDot.Position = UDim2.new(0, 16, 0.5, -4)
statusDot.BackgroundColor3 = Cores.verde
statusDot.BorderSizePixel = 0
statusDot.Parent = footer

local cantoDot = Instance.new("UICorner")
cantoDot.CornerRadius = UDim.new(1, 0)
cantoDot.Parent = statusDot

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 80, 1, 0)
statusLabel.Position = UDim2.new(0, 30, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Conectado"
statusLabel.TextColor3 = Cores.verde
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = footer

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 80, 1, 0)
fpsLabel.Position = UDim2.new(0.4, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 60"
fpsLabel.TextColor3 = Cores.cinza
fpsLabel.TextSize = 11
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.Parent = footer

local playersLabel = Instance.new("TextLabel")
playersLabel.Size = UDim2.new(0, 100, 1, 0)
playersLabel.Position = UDim2.new(0.6, 0, 0, 0)
playersLabel.BackgroundTransparency = 1
playersLabel.Text = "0 players"
playersLabel.TextColor3 = Cores.cinza
playersLabel.TextSize = 11
playersLabel.Font = Enum.Font.Gotham
playersLabel.Parent = footer

local versaoLabel = Instance.new("TextLabel")
versaoLabel.Size = UDim2.new(0, 100, 1, 0)
versaoLabel.Position = UDim2.new(0.85, 0, 0, 0)
versaoLabel.BackgroundTransparency = 1
versaoLabel.Text = "v2.0"
versaoLabel.TextColor3 = Cores.cinzaEscuro
versaoLabel.TextSize = 11
versaoLabel.Font = Enum.Font.Gotham
versaoLabel.TextXAlignment = Enum.TextXAlignment.Right
versaoLabel.Parent = footer

-- ============ RESIZE ============
local resizeHandle = Instance.new("TextButton")
resizeHandle.Size = UDim2.new(0, 22, 0, 22)
resizeHandle.Position = UDim2.new(1, -26, 1, -26)
resizeHandle.BackgroundColor3 = Cores.azul
resizeHandle.BackgroundTransparency = 0.4
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = "◢"
resizeHandle.TextColor3 = Cores.texto
resizeHandle.TextSize = 14
resizeHandle.Font = Enum.Font.GothamBold
resizeHandle.Parent = painel

local cantoResize = Instance.new("UICorner")
cantoResize.CornerRadius = UDim.new(0, 6)
cantoResize.Parent = resizeHandle

-- ============ NOTIFICACOES ============
local notificacoes = {}

local function notificar(titulo, texto, tipo)
    if not Config.notificacoes then return end

    local cor = Cores.azul
    local icone = "ℹ"
    if tipo == "sucesso" then cor = Cores.verde; icone = "✓"
    elseif tipo == "erro" then cor = Cores.vermelho; icone = "✕"
    elseif tipo == "aviso" then cor = Cores.dourado; icone = "!" end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 76)
    notif.Position = UDim2.new(1, 20, 0, 100 + (#notificacoes * 86))
    notif.BackgroundColor3 = Cores.fundoPainel
    notif.BorderSizePixel = 0
    notif.Parent = gui

    table.insert(notificacoes, notif)

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 12)
    canto.Parent = notif

    local stroke = Instance.new("UIStroke")
    stroke.Color = cor
    stroke.Thickness = 1.5
    stroke.Transparency = 0.4
    stroke.Parent = notif

    local barraCor = Instance.new("Frame")
    barraCor.Size = UDim2.new(0, 4, 1, 0)
    barraCor.BackgroundColor3 = cor
    barraCor.BorderSizePixel = 0
    barraCor.Parent = notif

    local cantoBarra = Instance.new("UICorner")
    cantoBarra.CornerRadius = UDim.new(0, 12)
    cantoBarra.Parent = barraCor

    local iconeFrame = Instance.new("Frame")
    iconeFrame.Size = UDim2.new(0, 28, 0, 28)
    iconeFrame.Position = UDim2.new(0, 14, 0, 10)
    iconeFrame.BackgroundColor3 = cor
    iconeFrame.BackgroundTransparency = 0.8
    iconeFrame.BorderSizePixel = 0
    iconeFrame.Parent = notif

    local cantoIcone = Instance.new("UICorner")
    cantoIcone.CornerRadius = UDim.new(1, 0)
    cantoIcone.Parent = iconeFrame

    local iconeLabel = Instance.new("TextLabel")
    iconeLabel.Size = UDim2.new(1, 0, 1, 0)
    iconeLabel.BackgroundTransparency = 1
    iconeLabel.Text = icone
    iconeLabel.TextColor3 = cor
    iconeLabel.TextSize = 16
    iconeLabel.Font = Enum.Font.GothamBold
    iconeLabel.Parent = iconeFrame

    local lblTitulo = Instance.new("TextLabel")
    lblTitulo.Size = UDim2.new(1, -55, 0, 20)
    lblTitulo.Position = UDim2.new(0, 50, 0, 10)
    lblTitulo.BackgroundTransparency = 1
    lblTitulo.Text = titulo
    lblTitulo.TextColor3 = cor
    lblTitulo.TextSize = 14
    lblTitulo.Font = Enum.Font.GothamBold
    lblTitulo.TextXAlignment = Enum.TextXAlignment.Left
    lblTitulo.Parent = notif

    local lblTexto = Instance.new("TextLabel")
    lblTexto.Size = UDim2.new(1, -55, 0, 30)
    lblTexto.Position = UDim2.new(0, 50, 0, 32)
    lblTexto.BackgroundTransparency = 1
    lblTexto.Text = texto
    lblTexto.TextColor3 = Cores.texto
    lblTexto.TextSize = 12
    lblTexto.Font = Enum.Font.Gotham
    lblTexto.TextXAlignment = Enum.TextXAlignment.Left
    lblTexto.TextWrapped = true
    lblTexto.Parent = notif

    local tweenIn = TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0, notif.Position.Y.Scale)
    })
    tweenIn:Play()

    task.delay(4, function()
        for i, v in ipairs(notificacoes) do
            if v == notif then
                table.remove(notificacoes, i)
                break
            end
        end
        local tweenOut = TweenService:Create(notif, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 20, 0, notif.Position.Y.Scale)
        })
        tweenOut:Play()
        task.wait(0.35)
        notif:Destroy()
    end)
end

-- ============ CRIAR SECAO ============
local function criarSecao(parent, titulo, icone)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 34)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local barra = Instance.new("Frame")
    barra.Size = UDim2.new(0, 3, 0, 22)
    barra.Position = UDim2.new(0, 0, 0.5, -11)
    barra.BackgroundColor3 = Cores.dourado
    barra.BorderSizePixel = 0
    barra.Parent = container

    local cantoBarra = Instance.new("UICorner")
    cantoBarra.CornerRadius = UDim.new(1, 0)
    cantoBarra.Parent = barra

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -15, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = (icone and icone .. "  " or "") .. titulo
    label.TextColor3 = Cores.dourado
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    return container
end

-- ============ CRIAR TOGGLE ============
local function criarToggle(parent, texto, callback, estadoInicial)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundColor3 = Cores.card
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = container

    local stroke = Instance.new("UIStroke")
    stroke.Color = Cores.cinzaEscuro
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local switchBG = Instance.new("Frame")
    switchBG.Size = UDim2.new(0, 44, 0, 24)
    switchBG.Position = UDim2.new(1, -58, 0.5, -12)
    switchBG.BackgroundColor3 = Cores.cinzaEscuro
    switchBG.BorderSizePixel = 0
    switchBG.Parent = container

    local cantoSwitch = Instance.new("UICorner")
    cantoSwitch.CornerRadius = UDim.new(1, 0)
    cantoSwitch.Parent = switchBG

    local switchBotao = Instance.new("TextButton")
    switchBotao.Size = UDim2.new(0, 20, 0, 20)
    switchBotao.Position = UDim2.new(0, 2, 0.5, -10)
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
        switchBotao.Position = UDim2.new(1, -22, 0.5, -10)
    end

    switchBotao.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            local t1 = TweenService:Create(switchBG, TweenInfo.new(0.2), {BackgroundColor3 = Cores.azul})
            t1:Play()
            local t2 = TweenService:Create(switchBotao, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -10)})
            t2:Play()
        else
            local t3 = TweenService:Create(switchBG, TweenInfo.new(0.2), {BackgroundColor3 = Cores.cinzaEscuro})
            t3:Play()
            local t4 = TweenService:Create(switchBotao, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10)})
            t4:Play()
        end
        if callback then callback(ativo) end
    end)

    return container
end

-- ============ CRIAR BOTAO ============
local function criarBotao(parent, texto, callback, cor)
    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 0, 38)
    botao.BackgroundColor3 = cor or Cores.card
    botao.BackgroundTransparency = 0.3
    botao.BorderSizePixel = 0
    botao.Text = texto
    botao.TextColor3 = Cores.texto
    botao.TextSize = 13
    botao.Font = Enum.Font.Gotham
    botao.AutoButtonColor = false
    botao.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = botao

    local stroke = Instance.new("UIStroke")
    stroke.Color = Cores.azul
    stroke.Thickness = 1
    stroke.Transparency = 0.8
    stroke.Parent = botao

    botao.MouseEnter:Connect(function()
        local t1 = TweenService:Create(botao, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.1
        })
        t1:Play()
        local t2 = TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.4})
        t2:Play()
    end)

    botao.MouseLeave:Connect(function()
        local t1 = TweenService:Create(botao, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.3
        })
        t1:Play()
        local t2 = TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.8})
        t2:Play()
    end)

    botao.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return botao
end

-- ============ CRIAR SLIDER ============
local function criarSlider(parent, texto, min, max, valorInicial, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 54)
    container.BackgroundColor3 = Cores.card
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 20)
    label.Position = UDim2.new(0, 14, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local valorLabel = Instance.new("TextLabel")
    valorLabel.Size = UDim2.new(0.3, 0, 0, 20)
    valorLabel.Position = UDim2.new(0.65, 0, 0, 8)
    valorLabel.BackgroundTransparency = 1
    valorLabel.Text = tostring(valorInicial)
    valorLabel.TextColor3 = Cores.azulClaro
    valorLabel.TextSize = 12
    valorLabel.Font = Enum.Font.GothamBold
    valorLabel.TextXAlignment = Enum.TextXAlignment.Right
    valorLabel.Parent = container

    local fundoSlider = Instance.new("Frame")
    fundoSlider.Size = UDim2.new(1, -28, 0, 8)
    fundoSlider.Position = UDim2.new(0, 14, 0, 36)
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
    botaoSlider.Size = UDim2.new(0, 18, 0, 18)
    botaoSlider.Position = UDim2.new((valorInicial - min) / (max - min), -9, 0.5, -9)
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
        botaoSlider.Position = UDim2.new(pct, -9, 0.5, -9)
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

-- ============ CRIAR DROPDOWN ============
local function criarDropdown(parent, texto, opcoes, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundColor3 = Cores.card
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.ClipsDescendants = false
    container.ZIndex = 10
    container.Parent = parent

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 8)
    canto.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(0.5, -14, 0, 28)
    botao.Position = UDim2.new(0.5, 0, 0.5, -14)
    botao.BackgroundColor3 = Cores.azulEscuro
    botao.BackgroundTransparency = 0.3
    botao.BorderSizePixel = 0
    botao.Text = opcoes[1] or "..."
    botao.TextColor3 = Cores.texto
    botao.TextSize = 12
    botao.Font = Enum.Font.GothamBold
    botao.ZIndex = 11
    botao.Parent = container

    local cantoBotao = Instance.new("UICorner")
    cantoBotao.CornerRadius = UDim.new(0, 6)
    cantoBotao.Parent = botao

    local lista = Instance.new("Frame")
    lista.Size = UDim2.new(0.5, -14, 0, #opcoes * 28)
    lista.Position = UDim2.new(0.5, 0, 1, 2)
    lista.BackgroundColor3 = Cores.fundoPainel
    lista.BorderSizePixel = 0
    lista.Visible = false
    lista.ZIndex = 12
    lista.Parent = container

    local cantoLista = Instance.new("UICorner")
    cantoLista.CornerRadius = UDim.new(0, 6)
    cantoLista.Parent = lista

    local strokeLista = Instance.new("UIStroke")
    strokeLista.Color = Cores.azul
    strokeLista.Thickness = 1
    strokeLista.Transparency = 0.3
    strokeLista.Parent = lista

    local aberto = false

    for i, opcao in ipairs(opcoes) do
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 28)
        item.Position = UDim2.new(0, 0, 0, (i - 1) * 28)
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

-- ============ CRIAR LABEL ============
local function criarLabel(parent, texto, cor)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 24)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = cor or Cores.cinza
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = parent
    return label
end

-- ============ TROCAR ABA ============
local function trocarAba(nomeAba)
    for nome, conteudo in pairs(conteudosAba) do
        conteudo.Visible = (nome == nomeAba)
    end
    for nome, botao in pairs(botoesAba) do
        local indice = botao:FindFirstChild("Indice")
        local texto = nil
        local icone = nil
        for _, filho in ipairs(botao:GetChildren()) do
            if filho:IsA("TextLabel") then
                if filho.TextSize == 18 then
                    icone = filho
                else
                    texto = filho
                end
            end
        end

        if nome == nomeAba then
            local t1 = TweenService:Create(botao, TweenInfo.new(0.2), {
                BackgroundColor3 = Cores.fundoAba,
                BackgroundTransparency = 0.2
            })
            t1:Play()
            if indice then indice.Visible = true end
            if texto then texto.TextColor3 = Cores.azulClaro end
        else
            local t2 = TweenService:Create(botao, TweenInfo.new(0.2), {
                BackgroundColor3 = Cores.fundoAba,
                BackgroundTransparency = 0.6
            })
            t2:Play()
            if indice then indice.Visible = false end
            if texto then texto.TextColor3 = Cores.cinza end
        end
    end
end

for nome, botao in pairs(botoesAba) do
    botao.MouseButton1Click:Connect(function() trocarAba(nome) end)
end

trocarAba("FARM")

-- ============ MINIMIZAR ============
local minimizado = false

botaoMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        sidebar.Visible = false
        areaConteudo.Visible = false
        footer.Visible = false
        resizeHandle.Visible = false
        local t = TweenService:Create(painel, TweenInfo.new(0.3), {Size = UDim2.new(0, 640, 0, 50)})
        t:Play()
        botaoMinimizar.Text = "+"
    else
        sidebar.Visible = true
        areaConteudo.Visible = true
        footer.Visible = true
        resizeHandle.Visible = true
        local t = TweenService:Create(painel, TweenInfo.new(0.3), {Size = UDim2.new(0, 640, 0, 480)})
        t:Play()
        botaoMinimizar.Text = "−"
    end
end)

botaoFechar.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ============ RESIZE ============
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
            local novaLargura = math.clamp(tamanhoInicial.X + delta.X, 420, 950)
            local novaAltura = math.clamp(tamanhoInicial.Y + delta.Y, 320, 750)
            painel.Size = UDim2.new(0, novaLargura, 0, novaAltura)
        end
    end
end)

-- ============ RAINBOW ============
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

-- =========== FPS COUNTER ============
local frames = 0
local ultimoTempo = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - ultimoTempo >= 1 then
        fpsLabel.Text = "FPS: " .. frames
        frames = 0
        ultimoTempo = tick()
        playersLabel.Text = #Players:GetPlayers() .. " jogadores"
    end
end)

-- ============ INICIALIZAR ============
notificar("BF4X Premium", "Carregado! Sea " .. MAR, "sucesso")
print("[BF4X] Premium v2.0 carregado! Sea " .. MAR)
