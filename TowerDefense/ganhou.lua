local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local fundo;
 local menu_jogar;
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- Cria a cena
function scene:create( event )
 
    local tela = self.view
    -- Executado quando a cena é variada, mas ainda não apareceu na tela

    fundo = display.newRect(tela, _w/2, _h/2, _w-100, _h-100);

    local ret2 = display.newRect(tela, _w/2, _h/2+50, 75, 30);
    ret2:setFillColor(0);

    local txtProxima = display.newText( tela, "Recomeçar", _w/2, _h/2+50, native.systemFont, 15 );

    local txtGanhou = display.newText( tela, "Você ganhou!!", _w/2, _h/2-50, native.systemFont, 15 );
    txtGanhou:setFillColor(0);

    local txtDinheiro = display.newText( tela, "$ "..dinheiro, _w/2, _h/2-20, native.systemFont, 15 );
    txtDinheiro:setFillColor(0);

    local txtMortes = display.newText( tela, "Mortes " .. contadorMortes, _w/2, _h/2+10, native.systemFont, 15 );
    txtMortes:setFillColor(0);


    function tapBotao( ev )
        composer.hideOverlay("fade", 100);
        composer.removeScene("jogar");
        composer.gotoScene("menu");
    end

    ret2:addEventListener("tap", tapBotao);
    
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