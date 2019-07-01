local composer = require( "composer" )
 
local scene = composer.newScene()

local tela, fundo, chao, pedra1, pedra2, alien, alien2, madeiras, linha1, linha2, linha3;
 
local fisica = require("physics");
        --fisica.setDrawMode("hybrid"); -- Ver os contornos dos objetos
        fisica.start();
        fisica.setGravity(0,20);
 
-- Cria a cena
function scene:create( event )
    print (cor_personagem);
 
    tela = self.view
    -- Executado quando a cena é variada, mas ainda não apareceu na tela
    fundo = display.newImageRect("images/Backgrounds/blue_shroom.png", _h, _h);
    fundo.x = _w/2;
    fundo.y = _h/2;

    chao = display.newImageRect("images/Other/grass.png", _w, 30);
    chao.x = _w/2;
    chao.y = _h-15;
    chao.nome = "chao";
    fisica.addBody(chao, "static");

    pedra1 = display.newImageRect("images/Stone/elementStone012.png", 100, 30);
    pedra1.x = 70;
    pedra1.y = 250;
    pedra1.rotation = 30;
    pedra1.nome = "pedra1";
    fisica.addBody(pedra1, "static");

    pedra2 = display.newImageRect("images/Stone/elementStone012.png", 100, 30);
    pedra2.x = 220;
    pedra2.y = 150;
    pedra2.nome = "pedra2";
    fisica.addBody(pedra2, "static");

    alien = display.newImageRect("images/Aliens/alien" .. cor_personagem .. "_round.png", 50,50);
    alien.x = 150;
    alien.y = 30;
    alien.nome = "alien1";
    fisica.addBody(alien, "dynamic", {radius = 25, bounce = 1, friction=1});

    alien2 = display.newImageRect("images/Aliens/alienPink_round.png", 50,50);
    alien2.x = 110;
    alien2.y = 30;
    alien2.nome = "alien2";
    fisica.addBody(alien2, "dynamic", {radius = 25, bounce = 1.1, friction=1});

    madeiras = {
        {x = 200, y = _h-80, rotation = 0},
        {x = 260, y = _h-80, rotation = 0},
        {x = 230, y = _h-138, rotation = 90}
    };

    for i, mad in ipairs(madeiras) do
        local madeira = display.newImageRect("images/Wood/elementWood019.png", 15, 100);
        madeira.x = mad.x;
        madeira.y = mad.y;
        madeira.rotation = mad.rotation;
        madeira.nome = "madeira";
        fisica.addBody(madeira, "dynamic");
    end

    linha1 = display.newRect(_w/2, 0, _w, 1 );
    linha1.nome = "teto";
    fisica.addBody(linha1, "static");

    linha2 = display.newRect(0, _h/2, 1, _h );
    linha2.nome = "paredeEsq";
    fisica.addBody(linha2, "static");

    linha3 = display.newRect(_w, _h/2, 1, _h );
    linha3.nome = "paredeDir";
    fisica.addBody(linha3, "static");
end
 
 
-- Momento de exibição da cena na tela()
function scene:show( event )
    local tela = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        function tapAlien( ev )
            alien:applyForce( 20, -20, alien.x, alien.y );
        end
        alien:addEventListener( "tap", tapAlien );

        function colisaoAlien( eu, ev )
            local outro = ev.other;
            if(ev.phase == "began") then
                print(eu.nome .. " iniciou colisão com " .. outro.nome);
                if(outro.nome == "madeira") then
                    ev.other: removeSelf( );
                end
            elseif (ev.phase == "ended") then
                print(eu.nome .. " terminou colisão com " .. outro.nome);
            end
        end
        alien.collision = colisaoAlien;
        alien:addEventListener("collision");

    elseif ( phase == "did" ) then
        -- A cena já está na tela

    end
end
 
 
-- A cena é ocultada (uma chamada no telefone, você vai pra outra cena, abrir outro aplicativo)
function scene:hide( event )
 
    local tela = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Está prestes a ser ocultado
 
    elseif ( phase == "did" ) then
        -- Acabou de ser ocultado
 
    end
end
 
 
-- A cena é destruída
function scene:destroy( event )
 
    local tela = self.view
    -- Executado antes da cena ser destruída
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene