local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

if CoreGui:FindFirstChild("FFH4X") then
    CoreGui.FFH4X:Destroy()
end

local Textos = {
    pt = {
        aim = "AIM", esp = "ESP", cfg = "CFG", exploits = "HACKS", info = "INFO",
        ativarAimbot = "Ativar Aimbot",
        silentAim = "Silent Aim",
        aimVisible = "Aim Visible",
        aimTiro = "Aim Tiro",
        aimMira = "Aim Mira",
        mostrarFov = "Mostrar FOV",
        autoShoot = "Auto Shoot (PERIGOSO)",
        regularFov = "Regular FOV",
        parteAimbot = "Parte do Aimbot",
        parteSilent = "Parte do Silent Aim",
        espVida = "ESP Vida",
        espLinha = "ESP Linha",
        espCaixa = "ESP Caixa",
        espNome = "ESP Nome",
        espDistancia = "ESP Distância",
        espRainbow = "ESP Rainbow",
        corEsp = "Cor do ESP",
        posicaoLinha = "Posição da Linha",
        topoTela = "Topo",
        meioTela = "Meio",
        baixoTela = "Baixo",
        corPainel = "Cor do Painel",
        rainbow = "Modo Rainbow",
        rainbowOn = "ATIVADO",
        rainbowOff = "DESATIVADO",
        lingua = "Língua",
        spinbot = "Spinbot",
        speed = "Speed",
        fly = "Fly Mobile",
        ghost = "Ghost",
        teleport = "Teleport",
        fullbright = "Fullbright",
        nofog = "No Fog",
        infinitejump = "Infinite Jump",
        antiafk = "Anti-AFK",
        waterwalk = "Walk on Water",
        infoTexto = "FFH4X v6.0\nFeito por: Ewerton\n\nUse com responsabilidade."
    },
    en = {
        aim = "AIM", esp = "ESP", cfg = "CFG", exploits = "HACKS", info = "INFO",
        ativarAimbot = "Enable Aimbot",
        silentAim = "Silent Aim",
        aimVisible = "Aim Visible",
        aimTiro = "Aim Shot",
        aimMira = "Aim Scope",
        mostrarFov = "Show FOV",
        autoShoot = "Auto Shoot (DANGEROUS)",
        regularFov = "Adjust FOV",
        parteAimbot = "Aimbot Part",
        parteSilent = "Silent Aim Part",
        espVida = "ESP Health",
        espLinha = "ESP Line",
        espCaixa = "ESP Box",
        espNome = "ESP Name",
        espDistancia = "ESP Distance",
        espRainbow = "ESP Rainbow",
        corEsp = "ESP Color",
        posicaoLinha = "Line Position",
        topoTela = "Top",
        meioTela = "Middle",
        baixoTela = "Bottom",
        corPainel = "Panel Color",
        rainbow = "Rainbow Mode",
        rainbowOn = "ENABLED",
        rainbowOff = "DISABLED",
        lingua = "Language",
        spinbot = "Spinbot",
        speed = "Speed",
        fly = "Fly Mobile",
        ghost = "Ghost",
        teleport = "Teleport",
        fullbright = "Fullbright",
        nofog = "No Fog",
        infinitejump = "Infinite Jump",
        antiafk = "Anti-AFK",
        waterwalk = "Walk on Water",
        infoTexto = "FFH4X v6.0\nMade by: Ewerton\n\nUse responsibly."
    },
    es = {
        aim = "AIM", esp = "ESP", cfg = "CFG", exploits = "HACKS", info = "INFO",
        ativarAimbot = "Activar Aimbot",
        silentAim = "Silent Aim",
        aimVisible = "Aim Visible",
        aimTiro = "Aim Disparo",
        aimMira = "Aim Mira",
        mostrarFov = "Mostrar FOV",
        autoShoot = "Auto Shoot (PELIGROSO)",
        regularFov = "Ajustar FOV",
        parteAimbot = "Parte del Aimbot",
        parteSilent = "Parte del Silent Aim",
        espVida = "ESP Vida",
        espLinha = "ESP Línea",
        espCaixa = "ESP Caja",
        espNome = "ESP Nombre",
        espDistancia = "ESP Distancia",
        espRainbow = "ESP Arcoíris",
        corEsp = "Color del ESP",
        posicaoLinha = "Posición de Línea",
        topoTela = "Superior",
        meioTela = "Centro",
        baixoTela = "Inferior",
        corPainel = "Color del Panel",
        rainbow = "Modo Arcoíris",
        rainbowOn = "ACTIVADO",
        rainbowOff = "DESACTIVADO",
        lingua = "Idioma",
        spinbot = "Spinbot",
        speed = "Speed",
        fly = "Fly Mobile",
        ghost = "Ghost",
        teleport = "Teleport",
        fullbright = "Fullbright",
        nofog = "No Fog",
        infinitejump = "Infinite Jump",
        antiafk = "Anti-AFK",
        waterwalk = "Walk on Water",
        infoTexto = "FFH4X v6.0\nHecho por: Ewerton\n\nUsar con responsabilidad."
    }
}

local idiomaAtual = "pt"

local function T(chave)
    return Textos[idiomaAtual][chave] or chave
end

local Config = {
    aimbotAtivo = false,
    silentAimAtivo = false,
    aimVisible = false,
    aimTiro = false,
    aimMira = false,
    mostrarFov = false,
    autoShoot = false,
    aimFov = 90,
    parteAimbot = "Head",
    parteSilent = "Head",
    espAtivo = false,
    espVida = false,
    espLinha = false,
    espCaixa = false,
    espNome = true,
    espDistancia = true,
    espRainbow = false,
    corEsp = Color3.fromRGB(255, 0, 0),
    posicaoLinha = "Meio",
    corPainel = Color3.fromRGB(120, 0, 200),
    rainbow = false,
    spinbot = false,
    speed = false,
    fly = false,
    ghost = false,
    fullbright = false,
    nofog = false,
    infinitejump = false,
    antiafk = false,
    waterwalk = false
}

local Cores = {
    roxo = Config.corPainel,
    roxoEscuro = Color3.fromRGB(40, 5, 70),
    roxoClaro = Color3.fromRGB(160, 60, 220),
    fundo = Color3.fromRGB(25, 5, 45),
    fundoAba = Color3.fromRGB(45, 10, 75),
    texto = Color3.fromRGB(255, 255, 255),
    cinza = Color3.fromRGB(180, 180, 180),
    verde = Color3.fromRGB(0, 200, 0)
}

local gui = Instance.new("ScreenGui")
gui.Name = "FFH4X"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local painel = Instance.new("Frame")
painel.Name = "Painel"
painel.Size = UDim2.new(0, 520, 0, 380)
painel.Position = UDim2.new(0.5, -260, 0.5, -190)
painel.BackgroundColor3 = Cores.fundo
painel.BorderSizePixel = 0
painel.Active = true
painel.Draggable = true
painel.Parent = gui

local cantoPainel = Instance.new("UICorner")
cantoPainel.CornerRadius = UDim.new(0, 8)
cantoPainel.Parent = painel

local bordaPainel = Instance.new("UIStroke")
bordaPainel.Color = Cores.roxo
bordaPainel.Thickness = 2
bordaPainel.Parent = painel

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Cores.roxo
header.BorderSizePixel = 0
header.Parent = painel

local cantoHeader = Instance.new("UICorner")
cantoHeader.CornerRadius = UDim.new(0, 8)
cantoHeader.Parent = header

local botaoMinimizar = Instance.new("TextButton")
botaoMinimizar.Size = UDim2.new(0, 25, 0, 25)
botaoMinimizar.Position = UDim2.new(0, 5, 0, 2)
botaoMinimizar.BackgroundTransparency = 1
botaoMinimizar.Text = "▼"
botaoMinimizar.TextColor3 = Cores.texto
botaoMinimizar.TextSize = 14
botaoMinimizar.Font = Enum.Font.GothamBold
botaoMinimizar.Parent = header

local tituloHeader = Instance.new("TextLabel")
tituloHeader.Size = UDim2.new(0.5, 0, 1, 0)
tituloHeader.Position = UDim2.new(0.25, 0, 0, 0)
tituloHeader.BackgroundTransparency = 1
tituloHeader.Text = "FFH4X"
tituloHeader.TextColor3 = Cores.texto
tituloHeader.TextSize = 16
tituloHeader.Font = Enum.Font.GothamBold
tituloHeader.Parent = header

local autorHeader = Instance.new("TextLabel")
autorHeader.Size = UDim2.new(0.3, 0, 1, 0)
autorHeader.Position = UDim2.new(0.6, 0, 0, 0)
autorHeader.BackgroundTransparency = 1
autorHeader.Text = "Feito por Ewerton"
autorHeader.TextColor3 = Cores.cinza
autorHeader.TextSize = 11
autorHeader.Font = Enum.Font.Gotham
autorHeader.TextXAlignment = Enum.TextXAlignment.Right
autorHeader.Parent = header

local botaoFechar = Instance.new("TextButton")
botaoFechar.Size = UDim2.new(0, 25, 0, 25)
botaoFechar.Position = UDim2.new(1, -30, 0, 2)
botaoFechar.BackgroundTransparency = 1
botaoFechar.Text = "X"
botaoFechar.TextColor3 = Cores.texto
botaoFechar.TextSize = 14
botaoFechar.Font = Enum.Font.GothamBold
botaoFechar.Parent = header

local menuLateral = Instance.new("Frame")
menuLateral.Name = "MenuLateral"
menuLateral.Size = UDim2.new(0, 80, 1, -30)
menuLateral.Position = UDim2.new(0, 0, 0, 30)
menuLateral.BackgroundColor3 = Cores.roxoEscuro
menuLateral.BorderSizePixel = 0
menuLateral.Parent = painel

local abas = {"AIM", "ESP", "HACKS", "CFG", "INFO"}
local botoesAba = {}
local conteudosAba = {}

local areaConteudo = Instance.new("Frame")
areaConteudo.Size = UDim2.new(1, -80, 1, -30)
areaConteudo.Position = UDim2.new(0, 80, 0, 30)
areaConteudo.BackgroundTransparency = 1
areaConteudo.Parent = painel

for i, nomeAba in ipairs(abas) do
    local botao = Instance.new("TextButton")
    botao.Name = "Aba_" .. nomeAba
    botao.Size = UDim2.new(1, 0, 0, 40)
    botao.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
    botao.BackgroundColor3 = Cores.fundoAba
    botao.BackgroundTransparency = 0.3
    botao.BorderSizePixel = 0
    botao.Text = nomeAba
    botao.TextColor3 = Cores.texto
    botao.TextSize = 13
    botao.Font = Enum.Font.GothamBold
    botao.AutoButtonColor = false
    botao.Parent = menuLateral
    botoesAba[nomeAba] = botao

    local conteudo = Instance.new("Frame")
    conteudo.Name = "Conteudo_" .. nomeAba
    conteudo.Size = UDim2.new(1, 0, 1, 0)
    conteudo.BackgroundTransparency = 1
    conteudo.Visible = false
    conteudo.Parent = areaConteudo
    conteudosAba[nomeAba] = conteudo
end

local botoesFlutuantes = {}
local posicaoFlutuanteY = 100

local function criarBotaoFlutuante(nomeCurto, callback)
    if botoesFlutuantes[nomeCurto] then
        botoesFlutuantes[nomeCurto]:Destroy()
        botoesFlutuantes[nomeCurto] = nil
        return nil
    end

    local botao = Instance.new("TextButton")
    botao.Name = "Float_" .. nomeCurto
    botao.Size = UDim2.new(0, 55, 0, 55)
    botao.Position = UDim2.new(0, 20, 0, posicaoFlutuanteY)
    botao.BackgroundColor3 = Cores.roxo
    botao.BackgroundTransparency = 0.2
    botao.BorderSizePixel = 0
    botao.Text = nomeCurto
    botao.TextColor3 = Cores.texto
    botao.TextSize = 10
    botao.Font = Enum.Font.GothamBold
    botao.Active = true
    botao.Draggable = true
    botao.Parent = gui

    posicaoFlutuanteY = posicaoFlutuanteY + 65

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(1, 0)
    canto.Parent = botao

    local stroke = Instance.new("UIStroke")
    stroke.Color = Cores.texto
    stroke.Thickness = 2
    stroke.Transparency = 0.5
    stroke.Parent = botao

    local marcado = false
    botao.MouseButton1Click:Connect(function()
        marcado = not marcado
        if marcado then
            botao.BackgroundColor3 = Cores.verde
        else
            botao.BackgroundColor3 = Cores.roxo
        end
        if callback then callback(marcado) end
    end)

    botoesFlutuantes[nomeCurto] = botao
    return botao
end

local function criarCheckbox(parent, texto, posX, posY, largura, callback, botaoNome)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(largura or 0.5, -10, 0, 28)
    container.Position = UDim2.new(posX or 0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(0, 18, 0, 18)
    botao.Position = UDim2.new(0, 0, 0.5, -9)
    botao.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    botao.BorderSizePixel = 0
    botao.Text = ""
    botao.AutoButtonColor = false
    botao.Parent = container

    local canto = Instance.new("UICorner")
    canto.CornerRadius = UDim.new(0, 3)
    canto.Parent = botao

    local stroke = Instance.new("UIStroke")
    stroke.Color = Cores.roxo
    stroke.Thickness = 2
    stroke.Parent = botao

    local labelLargura = botaoNome and 0.7 or 1
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(labelLargura, -25, 1, 0)
    label.Position = UDim2.new(0, 25, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local marcado = false

    if botaoNome then
        local botaoFloat = Instance.new("TextButton")
        botaoFloat.Size = UDim2.new(0, 22, 0, 22)
        botaoFloat.Position = UDim2.new(1, -25, 0.5, -11)
        botaoFloat.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        botaoFloat.BorderSizePixel = 0
        botaoFloat.Text = "+"
        botaoFloat.TextColor3 = Cores.texto
        botaoFloat.TextSize = 14
        botaoFloat.Font = Enum.Font.GothamBold
        botaoFloat.Parent = container

        local cantoBF = Instance.new("UICorner")
        cantoBF.CornerRadius = UDim.new(0, 4)
        cantoBF.Parent = botaoFloat

        botaoFloat.MouseButton1Click:Connect(function()
            local float = criarBotaoFlutuante(botaoNome, function(estado)
                marcado = estado
                if marcado then
                    botao.BackgroundColor3 = Cores.roxo
                    botao.Text = "✓"
                    botao.TextSize = 14
                    botao.Font = Enum.Font.GothamBold
                else
                    botao.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    botao.Text = ""
                end
                if callback then callback(marcado) end
            end)
            if float then
                botaoFloat.Text = "−"
                botaoFloat.BackgroundColor3 = Cores.roxo
            else
                botaoFloat.Text = "+"
                botaoFloat.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            end
        end)
    end

    botao.MouseButton1Click:Connect(function()
        marcado = not marcado
        if marcado then
            botao.BackgroundColor3 = Cores.roxo
            botao.Text = "✓"
            botao.TextColor3 = Cores.texto
            botao.TextSize = 14
            botao.Font = Enum.Font.GothamBold
        else
            botao.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            botao.Text = ""
        end
        if callback then callback(marcado) end
    end)

    return {container = container, label = label, botao = botao}
end

local function criarSlider(parent, texto, posX, posY, largura, valorInicial, min, max, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(largura or 1, -20, 0, 45)
    container.Position = UDim2.new(posX or 0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = texto .. ": " .. valorInicial
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local fundoSlider = Instance.new("Frame")
    fundoSlider.Size = UDim2.new(1, 0, 0, 8)
    fundoSlider.Position = UDim2.new(0, 0, 0, 22)
    fundoSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    fundoSlider.BorderSizePixel = 0
    fundoSlider.Parent = container

    local cantoF = Instance.new("UICorner")
    cantoF.CornerRadius = UDim.new(1, 0)
    cantoF.Parent = fundoSlider

    local preench = Instance.new("Frame")
    preench.Size = UDim2.new((valorInicial - min) / (max - min), 0, 1, 0)
    preench.BackgroundColor3 = Cores.roxo
    preench.BorderSizePixel = 0
    preench.Parent = fundoSlider

    local cantoP = Instance.new("UICorner")
    cantoP.CornerRadius = UDim.new(1, 0)
    cantoP.Parent = preench

    local botaoSlider = Instance.new("TextButton")
    botaoSlider.Size = UDim2.new(0, 16, 0, 16)
    botaoSlider.Position = UDim2.new((valorInicial - min) / (max - min), -8, 0.5, -8)
    botaoSlider.BackgroundColor3 = Cores.texto
    botaoSlider.BorderSizePixel = 0
    botaoSlider.Text = ""
    botaoSlider.Parent = fundoSlider

    local cantoB = Instance.new("UICorner")
    cantoB.CornerRadius = UDim.new(1, 0)
    cantoB.Parent = botaoSlider

    local arrastando = false

    local function atualizar(input)
        local posX = math.clamp(input.Position.X - fundoSlider.AbsolutePosition.X, 0, fundoSlider.AbsoluteSize.X)
        local pct = posX / fundoSlider.AbsoluteSize.X
        local valor = math.floor(min + (max - min) * pct)
        preench.Size = UDim2.new(pct, 0, 1, 0)
        botaoSlider.Position = UDim2.new(pct, -8, 0.5, -8)
        label.Text = texto .. ": " .. valor
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

    return {label = label}
end

local function criarDropdown(parent, texto, posX, posY, largura, opcoes, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(largura or 1, -20, 0, 50)
    container.Position = UDim2.new(posX or 0, 10, 0, posY)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = false
    container.ZIndex = 10
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Cores.texto
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local botao = Instance.new("TextButton")
    botao.Size = UDim2.new(1, 0, 0, 25)
    botao.Position = UDim2.new(0, 0, 0, 20)
    botao.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    botao.BorderSizePixel = 0
    botao.Text = opcoes[1] or "..."
    botao.TextColor3 = Cores.texto
    botao.TextSize = 12
    botao.Font = Enum.Font.Gotham
    botao.ZIndex = 11
    botao.Parent = container

    local cantoB = Instance.new("UICorner")
    cantoB.CornerRadius = UDim.new(0, 4)
    cantoB.Parent = botao

    local lista = Instance.new("Frame")
    lista.Size = UDim2.new(1, 0, 0, #opcoes * 25)
    lista.Position = UDim2.new(0, 0, 1, 0)
    lista.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    lista.BorderSizePixel = 0
    lista.Visible = false
    lista.ZIndex = 12
    lista.Parent = container

    local cantoL = Instance.new("UICorner")
    cantoL.CornerRadius = UDim.new(0, 4)
    cantoL.Parent = lista

    local aberto = false

    for i, opcao in ipairs(opcoes) do
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 25)
        item.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
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
            item.BackgroundColor3 = Cores.roxo
        end)

        item.MouseLeave:Connect(function()
            item.BackgroundTransparency = 1
        end)
    end

    botao.MouseButton1Click:Connect(function()
        aberto = not aberto
        lista.Visible = aberto
    end)

    return {container = container, label = label}
end

local abaAIM = conteudosAba["AIM"]

criarCheckbox(abaAIM, T("ativarAimbot"), 0, 10, 0.5, function(m) Config.aimbotAtivo = m end, "AIM")
criarCheckbox(abaAIM, T("silentAim"), 0.5, 10, 0.5, function(m) Config.silentAimAtivo = m end, "SILENT")
criarCheckbox(abaAIM, T("aimVisible"), 0, 45, 0.5, function(m) Config.aimVisible = m end, "VISIVEL")
criarCheckbox(abaAIM, T("aimTiro"), 0.5, 45, 0.5, function(m) Config.aimTiro = m end, "TIRO")
criarCheckbox(abaAIM, T("aimMira"), 0, 80, 0.5, function(m) Config.aimMira = m end, "MIRA")
criarCheckbox(abaAIM, T("mostrarFov"), 0.5, 80, 0.5, function(m) Config.mostrarFov = m end, "FOV")
criarCheckbox(abaAIM, T("autoShoot"), 0, 115, 1, function(m) Config.autoShoot = m end, "SHOOT")

criarSlider(abaAIM, "FOV", 0, 150, 1, 90, 0, 180, function(v) Config.aimFov = v end)

criarDropdown(abaAIM, T("parteAimbot"), 0, 205, 0.5, {"Head", "Torso", "Random"}, function(v) Config.parteAimbot = v end)
criarDropdown(abaAIM, T("parteSilent"), 0.5, 205, 0.5, {"Head", "Torso", "Random"}, function(v) Config.parteSilent = v end)

local abaESP = conteudosAba["ESP"]

criarCheckbox(abaESP, "ESP", 0, 10, 0.5, function(m) Config.espAtivo = m end, "ESP")
criarCheckbox(abaESP, T("espVida"), 0.5, 10, 0.5, function(m) Config.espVida = m end, "VIDA")
criarCheckbox(abaESP, T("espLinha"), 0, 45, 0.5, function(m) Config.espLinha = m end, "LINHA")
criarCheckbox(abaESP, T("espCaixa"), 0.5, 45, 0.5, function(m) Config.espCaixa = m end, "CAIXA")
criarCheckbox(abaESP, T("espNome"), 0, 80, 0.5, function(m) Config.espNome = m end, "NOME")
criarCheckbox(abaESP, T("espDistancia"), 0.5, 80, 0.5, function(m) Config.espDistancia = m end, "DIST")
criarCheckbox(abaESP, T("espRainbow"), 0, 115, 0.5, function(m) Config.espRainbow = m end, "RBE")

criarDropdown(abaESP, T("posicaoLinha"), 0.5, 115, 0.5, {T("topoTela"), T("meioTela"), T("baixoTela")}, function(v)
    if v == T("topoTela") then Config.posicaoLinha = "Topo"
    elseif v == T("baixoTela") then Config.posicaoLinha = "Baixo"
    else Config.posicaoLinha = "Meio" end
end)

criarDropdown(abaESP, T("corEsp"), 0, 160, 0.5, {"Vermelho", "Verde", "Azul", "Amarelo", "Roxo", "Rosa", "Branco"}, function(v)
    if v == "Vermelho" then Config.corEsp = Color3.fromRGB(255, 0, 0)
    elseif v == "Verde" then Config.corEsp = Color3.fromRGB(0, 255, 0)
    elseif v == "Azul" then Config.corEsp = Color3.fromRGB(0, 150, 255)
    elseif v == "Amarelo" then Config.corEsp = Color3.fromRGB(255, 255, 0)
    elseif v == "Roxo" then Config.corEsp = Color3.fromRGB(150, 0, 255)
    elseif v == "Rosa" then Config.corEsp = Color3.fromRGB(255, 100, 200)
    elseif v == "Branco" then Config.corEsp = Color3.fromRGB(255, 255, 255) end
end)

local abaHACKS = conteudosAba["HACKS"]

criarCheckbox(abaHACKS, T("spinbot"), 0, 10, 0.5, function(m) Config.spinbot = m end, "SPIN")
criarCheckbox(abaHACKS, T("speed"), 0.5, 10, 0.5, function(m) 
    Config.speed = m
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = m and 100 or 16
    end
end, "SPEED")
criarCheckbox(abaHACKS, T("fly"), 0, 45, 0.5, function(m) Config.fly = m end, "FLY")
criarCheckbox(abaHACKS, T("ghost"), 0.5, 45, 0.5, function(m) Config.ghost = m end, "GHOST")
criarCheckbox(abaHACKS, T("teleport"), 0, 80, 0.5, function(m) 
    if m then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = Mouse.Hit
        end
    end
end, "TP")
criarCheckbox(abaHACKS, T("fullbright"), 0.5, 80, 0.5, function(m) 
    Config.fullbright = m
    if m then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
    else
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.Brightness = 1
    end
end, "FULL")
criarCheckbox(abaHACKS, T("nofog"), 0, 115, 0.5, function(m) 
    Config.nofog = m
    if m then
        Lighting.FogEnd = 100000
    else
        Lighting.FogEnd = 1000
    end
end, "NOFOG")
criarCheckbox(abaHACKS, T("infinitejump"), 0.5, 115, 0.5, function(m) Config.infinitejump = m end, "INFJ")
criarCheckbox(abaHACKS, T("antiafk"), 0, 150, 0.5, function(m) Config.antiafk = m end, "AFK")
criarCheckbox(abaHACKS, T("waterwalk"), 0.5, 150, 0.5, function(m) Config.waterwalk = m end, "AGUA")

local abaCFG = conteudosAba["CFG"]

criarDropdown(abaCFG, T("lingua"), 0, 10, 1, {"PT", "EN", "ES"}, function(v)
    if v == "PT" then idiomaAtual = "pt"
    elseif v == "EN" then idiomaAtual = "en"
    else idiomaAtual = "es" end
end)

criarDropdown(abaCFG, T("corPainel"), 0, 75, 1, {"Roxo", "Verde", "Azul", "Vermelho", "Laranja", "Rosa", "Ciano"}, function(v)
    if v == "Roxo" then Config.corPainel = Color3.fromRGB(120, 0, 200)
    elseif v == "Verde" then Config.corPainel = Color3.fromRGB(0, 180, 100)
    elseif v == "Azul" then Config.corPainel = Color3.fromRGB(0, 120, 220)
    elseif v == "Vermelho" then Config.corPainel = Color3.fromRGB(200, 30, 30)
    elseif v == "Laranja" then Config.corPainel = Color3.fromRGB(230, 120, 0)
    elseif v == "Rosa" then Config.corPainel = Color3.fromRGB(220, 50, 150)
    elseif v == "Ciano" then Config.corPainel = Color3.fromRGB(0, 200, 200) end
    header.BackgroundColor3 = Config.corPainel
    bordaPainel.Color = Config.corPainel
end)

criarCheckbox(abaCFG, T("rainbow"), 0, 140, 1, function(m) Config.rainbow = m end)

local abaINFO = conteudosAba["INFO"]

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 1, -20)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = T("infoTexto")
infoLabel.TextColor3 = Cores.texto
infoLabel.TextSize = 14
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Parent = abaINFO

local function trocarAba(nomeAba)
    for nome, conteudo in pairs(conteudosAba) do
        conteudo.Visible = (nome == nomeAba)
    end
    for nome, botao in pairs(botoesAba) do
        if nome == nomeAba then
            botao.BackgroundTransparency = 0.1
            botao.TextColor3 = Cores.roxoClaro
        else
            botao.BackgroundTransparency = 0.3
            botao.TextColor3 = Cores.texto
        end
    end
end

for nome, botao in pairs(botoesAba) do
    botao.MouseButton1Click:Connect(function() trocarAba(nome) end)
end

trocarAba("AIM")

botaoMinimizar.MouseButton1Click:Connect(function()
    if menuLateral.Visible then
        menuLateral.Visible = false
        areaConteudo.Visible = false
        painel.Size = UDim2.new(0, 520, 0, 30)
        botaoMinimizar.Text = "▲"
    else
        menuLateral.Visible = true
        areaConteudo.Visible = true
        painel.Size = UDim2.new(0, 520, 0, 380)
        botaoMinimizar.Text = "▼"
    end
end)

botaoFechar.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local hue = 0
RunService.Heartbeat:Connect(function(dt)
    if Config.rainbow then
        hue = (hue + dt * 0.3) % 1
        local cor = Color3.fromHSV(hue, 1, 1)
        header.BackgroundColor3 = cor
        bordaPainel.Color = cor
    else
        header.BackgroundColor3 = Config.corPainel
        bordaPainel.Color = Config.corPainel
    end
end)

local fovCircle = Instance.new("Frame")
fovCircle.Name = "FOVCircle"
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = false
fovCircle.ZIndex = 2
fovCircle.Parent = gui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Thickness = 2
fovStroke.Transparency = 0.3
fovStroke.Parent = fovCircle

local espCache = {}

local function criarESP(jogador)
    if jogador == LocalPlayer then return end
    if espCache[jogador] then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_HL"
    highlight.FillColor = Config.corEsp
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Config.corEsp
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = jogador.Character
    highlight.Parent = gui

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = jogador.Character and jogador.Character:FindFirstChild("Head")

    local nomeLabel = Instance.new("TextLabel")
    nomeLabel.Size = UDim2.new(1, 0, 0.33, 0)
    nomeLabel.BackgroundTransparency = 1
    nomeLabel.Text = jogador.Name
    nomeLabel.TextColor3 = Config.corEsp
    nomeLabel.TextStrokeTransparency = 0
    nomeLabel.TextSize = 14
    nomeLabel.Font = Enum.Font.GothamBold
    nomeLabel.Parent = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.33, 0)
    distLabel.Position = UDim2.new(0, 0, 0.33, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "0"
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = billboard

    local vidaLabel = Instance.new("TextLabel")
    vidaLabel.Size = UDim2.new(1, 0, 0.33, 0)
    vidaLabel.Position = UDim2.new(0, 0, 0.66, 0)
    vidaLabel.BackgroundTransparency = 1
    vidaLabel.Text = "100 HP"
    vidaLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    vidaLabel.TextStrokeTransparency = 0
    vidaLabel.TextSize = 12
    vidaLabel.Font = Enum.Font.Gotham
    vidaLabel.Parent = billboard

    billboard.Parent = gui

    espCache[jogador] = {
        highlight = highlight,
        billboard = billboard,
        nome = nomeLabel,
        distancia = distLabel,
        vida = vidaLabel
    }
end

local function removerESP(jogador)
    if espCache[jogador] then
        if espCache[jogador].highlight then espCache[jogador].highlight:Destroy() end
        if espCache[jogador].billboard then espCache[jogador].billboard:Destroy() end
        espCache[jogador] = nil
    end
end

local linhasCache = {}

local function atualizarLinhas()
    for jogador, linha in pairs(linhasCache) do
        if linha then linha:Destroy() end
        linhasCache[jogador] = nil
    end

    if not Config.espLinha then return end

    local camera = workspace.CurrentCamera
    local viewport = camera.ViewportSize
    local yPos = viewport.Y / 2
    if Config.posicaoLinha == "Topo" then yPos = 0
    elseif Config.posicaoLinha == "Baixo" then yPos = viewport.Y end

    for _, jogador in ipairs(Players:GetPlayers()) do
        if jogador ~= LocalPlayer and jogador.Character then
            local head = jogador.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local linha = Instance.new("Frame")
                    linha.Size = UDim2.new(0, 1, 0, math.abs(yPos - screenPos.Y))
                    linha.Position = UDim2.new(0, screenPos.X, 0, math.min(yPos, screenPos.Y))
                    linha.BackgroundColor3 = Config.corEsp
                    linha.BorderSizePixel = 0
                    linha.ZIndex = 5
                    linha.Parent = gui
                    linhasCache[jogador] = linha
                end
            end
        end
    end
end

local function temParede(posOrigem, posAlvo, personagemAlvo)
    local params = RaycastParams.new()
    local ignorar = {LocalPlayer.Character, Camera}
    if personagemAlvo then
        table.insert(ignorar, personagemAlvo)
    end
    params.FilterDescendantsInstances = ignorar
    params.FilterType = Enum.RaycastFilterType.Exclude
    local direcao = posAlvo - posOrigem
    local resultado = workspace:Raycast(posOrigem, direcao, params)
    if resultado then
        return true
    end
    return false
end

local function pegarAlvo(parte)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local camera = workspace.CurrentCamera
    local centroTela = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local maxDist = Config.aimFov
    local melhor = nil
    local menorDist = math.huge

    for _, jogador in ipairs(Players:GetPlayers()) do
        if jogador ~= LocalPlayer and jogador.Character then
            local humanoid = jogador.Character:FindFirstChild("Humanoid")
            local hrp = jogador.Character:FindFirstChild("HumanoidRootPart")
            local head = jogador.Character:FindFirstChild("Head")

            local parteAlvo = nil
            if parte == "Head" then parteAlvo = head
            elseif parte == "Torso" then parteAlvo = hrp
            else
                local partes = {head, hrp}
                parteAlvo = partes[math.random(1, #partes)]
            end

            if humanoid and hrp and parteAlvo and humanoid.Health > 0 then
                local screenPos, onScreen = camera:WorldToViewportPoint(parteAlvo.Position)
                if onScreen then
                    local distTela = (Vector2.new(screenPos.X, screenPos.Y) - centroTela).Magnitude
                    if distTela < menorDist and distTela < maxDist * 5 then
                        if Config.aimVisible then
                            if not temParede(camera.CFrame.Position, parteAlvo.Position, jogador.Character) then
                                menorDist = distTela
                                melhor = parteAlvo
                            end
                        else
                            menorDist = distTela
                            melhor = parteAlvo
                        end
                    end
                end
            end
        end
    end
    return melhor
end

local function ativarSilentAim()
    if not hookmetamethod or not getrawmetatable or not setreadonly or not newcclosure then
        print("[FFH4X] Silent Aim: hooks nao suportados.")
        return false
    end
    local sucesso = pcall(function()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if Config.silentAimAtivo and (method == "FireServer" or method == "InvokeServer") then
                if self and (self:IsA("Tool") or self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
                    local alvo = pegarAlvo(Config.parteSilent)
                    if alvo then
                        for i, arg in ipairs(args) do
                            if typeof(arg) == "Vector3" then
                                args[i] = alvo.Position
                            end
                        end
                        return oldNamecall(self, unpack(args))
                    end
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        return true
    end)
    return sucesso
end

local hookAtivo = ativarSilentAim()
if hookAtivo then
    print("[FFH4X] Silent Aim ativado")
end

local function autoShoot()
    local char = LocalPlayer.Character
    if not char then return end
    local ferramenta = char:FindFirstChildOfClass("Tool")
    if not ferramenta then return end
    for _, obj in ipairs(ferramenta:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local nome = obj.Name:lower()
            if nome:find("fire") or nome:find("shoot") or nome:find("attack") or nome:find("hit") then
                local alvo = pegarAlvo(Config.parteAimbot)
                if alvo then
                    pcall(function()
                        if obj:IsA("RemoteEvent") then
                            obj:FireServer(alvo.Position)
                        end
                    end)
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if Config.mostrarFov then
        fovCircle.Visible = true
        fovCircle.Size = UDim2.new(0, Config.aimFov * 10, 0, Config.aimFov * 10)
    else
        fovCircle.Visible = false
    end
    if Config.aimbotAtivo then
        local alvo = pegarAlvo(Config.parteAimbot)
        if alvo then
            local targetCF = CFrame.new(Camera.CFrame.Position, alvo.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, 0.2)
        end
    end
end)

task.spawn(function()
    while gui.Parent do
        if Config.autoShoot then
            pcall(autoShoot)
        end
        task.wait(0.1)
    end
end)

RunService.RenderStepped:Connect(function()
    local corAtual = Config.corEsp
    if Config.espRainbow then
        local h = (tick() * 0.5) % 1
        corAtual = Color3.fromHSV(h, 1, 1)
    end
    if Config.espAtivo then
        for _, jogador in ipairs(Players:GetPlayers()) do
            if jogador ~= LocalPlayer and jogador.Character and jogador.Character:FindFirstChild("HumanoidRootPart") then
                if not espCache[jogador] then
                    criarESP(jogador)
                end
                local cache = espCache[jogador]
                if cache then
                    cache.highlight.Adornee = jogador.Character
                    cache.highlight.FillColor = corAtual
                    cache.highlight.OutlineColor = corAtual
                    cache.billboard.Adornee = jogador.Character:FindFirstChild("Head")
                    cache.nome.Visible = Config.espNome
                    cache.nome.TextColor3 = corAtual
                    cache.distancia.Visible = Config.espDistancia
                    cache.vida.Visible = Config.espVida
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (jogador.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                        cache.distancia.Text = math.floor(dist) .. " studs"
                    end
                    local hum = jogador.Character:FindFirstChild("Humanoid")
                    if hum then
                        cache.vida.Text = math.floor(hum.Health) .. " HP"
                    end
                end
            end
        end
        atualizarLinhas()
    else
        for jogador, _ in pairs(espCache) do
            removerESP(jogador)
        end
        for jogador, linha in pairs(linhasCache) do
            if linha then linha:Destroy() end
            linhasCache[jogador] = nil
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if Config.spinbot then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if Config.fly then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local camera = workspace.CurrentCamera
            local direcao = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direcao = direcao + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direcao = direcao - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direcao = direcao - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direcao = direcao + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direcao = direcao + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direcao = direcao - Vector3.new(0, 1, 0) end
            if direcao.Magnitude > 0 then
                direcao = direcao.Unit * 50
            end
            hrp.Velocity = direcao
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Config.infinitejump then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

LocalPlayer.Idled:Connect(function()
    if Config.antiafk then
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end
end)

RunService.Heartbeat:Connect(function()
    if Config.waterwalk then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local ray = Ray.new(hrp.Position, Vector3.new(0, -10, 0))
            local hit, pos = workspace:FindPartOnRay(ray, char)
            if hit and hit.Material == Enum.Material.Water then
                hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(jogador)
    removerESP(jogador)
end)

print("[FFH4X] v6.0 carregado! Feito por Ewerton")
