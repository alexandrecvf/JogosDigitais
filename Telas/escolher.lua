local composer = require( "composer" )
 
local scene = composer.newScene()

local fundo;
local personagens;
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- Cria a cena
function scene:create( event )
 
    local tela = self.view
    -- Executado quando a cena é variada, mas ainda não apareceu na tela

    fundo = display.newRect(tela, _w/2, _h/2, _w, _h);
    fundo:setFillColor( 1 );

    personagens = {
        {imagem = "alienGreen_suit.png", cor = "Green"},
        {imagem = "alienPink_suit.png", cor = "Pink"},
        {imagem = "alienYellow_suit.png", cor = "Yellow"},
    };

    local n = 0;
    for i,personagem in ipairs(personagens) do
        local pers = display.newImageRect(tela, "images/Aliens/" .. personagem.imagem, 50, 50);
        pers.y = _h/2;
        pers.x = (n*70) + 90;
        pers.cor = personagem.cor;
        n = n +1;

        function pers:tap( ev )
            -- Altera a cor do personagem
            cor_personagem = ev.target.cor;
            composer.removeScene("escolher");
            composer.gotoScene("jogar");
        end
        pers:addEventListener("tap", pers)
    end
end
 
 
-- Momento de exibição da cena na tela()
function scene:show( event )
 
    local tela = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- O código aqui é executado quando a cena ainda não foi exibida, mas está prestes a ser
 
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