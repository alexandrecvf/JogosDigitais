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

    fundo = display.newImageRect(tela, "img/fundo_menu.png", _w, _h);
    fundo.x = _w/2;
    fundo.y = _h/2;

    menu_jogar = display.newRect(tela, _w/2, _h/2+65, 150, 40);
    menu_jogar:setFillColor( 65/255, 153/255, 186/255 );

    local txt_jogar = display.newText(tela, "JOGAR", _w/2, _h/2+65, 76, 22, native.systemFont, 20);
    txt_jogar:setFillColor( 1 );

    -- Funções no botão
    local function jogarTap(ev)
        composer.gotoScene("jogar2");
    end
    menu_jogar:addEventListener( "tap", jogarTap );
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