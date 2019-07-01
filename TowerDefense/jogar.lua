local composer = require( "composer" )
 
local scene = composer.newScene()

local tela, fundo, aux_arma, aux_caminho, aux_bala, aux_inimigo, aux_missil;
local moveArma1 = false;
local moveArma2 = false;
local moveArma3 = false;
local moveArma4 = false;
local armaA = {};
local armaB = {};
local armaC = {};
local armaD = {};
local caminho = {};
local torres = {};
local balas = {};
local inimigos = {};
local missil1, missil2, missil3;
local torre1 = false;
local torre2 = false;
local torre3 = false;
local contadorMortes = 0;
local dinheiro = 1000;
local txtMortes, txtDinheiro, qtdDinheiro, qtdMortes;
local perdeu = 0;
local perdeu2 = 0;
 
local fisica = require("physics");
--fisica.setDrawMode("hybrid"); -- Ver os contornos dos objetos
fisica.start();
fisica.setGravity(0,0);
 
-- Cria a cena
function scene:create( event )
    print (cor_personagem);
    contadorMortes = 0;
    dinheiro = 1000;
 
    tela = self.view
    fundo = display.newImageRect(tela, "img/fundo2.png", _w, _h);
    fundo.x = _w/2;
    fundo.y = _h/2;

    aux_arma = display.newImageRect( tela, "img/arma_1.png", 60, 60);
    aux_arma.x = 125;
    aux_arma.y = 35;
    aux_arma.rotation = -90;
    table.insert( armaA, aux_arma );

    aux_arma = display.newImageRect( tela, "img/arma_2.png", 60, 60);
    aux_arma.x = 200;
    aux_arma.y = 35;
    aux_arma.rotation = -90;
    table.insert( armaB, aux_arma );

    aux_arma = display.newImageRect( tela, "img/arma_3.png", 60, 60);
    aux_arma.x = 275;
    aux_arma.y = 30;
    table.insert( armaC, aux_arma );

    aux_arma = display.newImageRect( tela, "img/arma_4.png", 60, 60);
    aux_arma.x = 350;
    aux_arma.y = 30;
    table.insert( armaD, aux_arma );

    qtdDinheiro = "$ " .. tostring(dinheiro);
    txtDinheiro = display.newText( tela, qtdDinheiro, 440, 15, native.systemFont, 15 );
    txtDinheiro:setFillColor(0);

    qtdMortes = contadorMortes;
    txtMortes = display.newText( tela, qtdMortes, 440, 40, native.systemFont, 15 );
    txtMortes:setFillColor(0);

    local aux = 110;
    local auy = 100;

    for i=1,3 do
        for j=1,5 do
            aux_caminho = display.newRect(tela, aux, auy, 70, 70);
            aux_caminho: setFillColor(0,0,0,0.01);
            aux_caminho.centrox = aux;
            aux_caminho.centroy = auy;
            aux = aux + 70;
            aux_caminho.vazio = true;
            aux_caminho.nomeArma = "";
            table.insert( caminho, aux_caminho );

            function aux_caminho:tap(ev)
                if (moveArma1 == true and ev.target.vazio == true) then
                    armaA[table.maxn(armaA)].x = ev.target.centrox;
                    armaA[table.maxn(armaA)].y = ev.target.centroy;
                    moveArma1 = false;
                    ev.target.vazio = false;
                    ev.target.nomeArma = "armaA";
                elseif(moveArma2 == true and ev.target.vazio == true) then
                    armaB[table.maxn(armaB)].x = ev.target.centrox;
                    armaB[table.maxn(armaB)].y = ev.target.centroy;
                    moveArma2 = false;
                    ev.target.vazio = false;
                    ev.target.nomeArma = "armaB";
                elseif(moveArma3 == true and ev.target.vazio == true) then
                    armaC[table.maxn(armaC)].x = ev.target.centrox;
                    armaC[table.maxn(armaC)].y = ev.target.centroy;
                    moveArma3 = false;
                    ev.target.vazio = false;
                    ev.target.nomeArma = "armaC";
                elseif(moveArma4 == true and ev.target.vazio == true) then
                    armaD[table.maxn(armaD)].x = ev.target.centrox;
                    armaD[table.maxn(armaD)].y = ev.target.centroy;
                    moveArma4 = false;
                    ev.target.vazio = false;
                    ev.target.nomeArma = "armaD";
                end
            end
            aux_caminho:addEventListener( "tap" );
        end
        aux = 110;
        auy = auy + 87;
    end

    function posicaoTorre( nomeTorre  )
        for i=#torres, 1,-1 do
            if ( torres[i].nome == nomeTorre ) then
                return i;
            end
        end

        return 0;
    end

    function colisaoTorre(ev)
        local outro = ev.other;

        if(ev.phase == "began") then
            print(ev.target.nome);
            for i=#inimigos,1, -1 do
                local inimigo = inimigos[i];
                if (inimigo == outro) then
                    table.remove( inimigos, i );
                    display.remove( inimigo );
                    break;
                end
            end
            for i=#torres, 1,-1 do
                local torre = torres[i];
                if (ev.target.nome == "torre_1" and torre1 == false) then
                    print( "Entrou ", ev.target.nome);
                    torre1 = true;
                    break;
                elseif (ev.target.nome == "torre_2" and torre2 == false) then
                    print( "Entrou ", ev.target.nome);
                    torre2 = true;
                    break;
                elseif (ev.target.nome == "torre_3" and torre3 == false) then
                    print( "Entrou ", ev.target.nome);
                    torre3 = true;
                    break;
                end
            end
        end
    end

    function colisaoMissil(ev)
        local outro = ev.other;
        if (ev.phase == "began") then
            for i=#inimigos,1, -1 do
                local inimigo = inimigos[i];
                if (inimigo == outro) then
                    table.remove( inimigos, i );
                    display.remove( inimigo );
                    break;
                end
            end
        end
    end

    local posTorre = 100;

    for i=1,3 do
        aux_torre = display.newImageRect( tela, "img/torre.png", 70, 70);
        aux_torre.x = 50;
        aux_torre.y = posTorre + ((i*87)-87);
        aux_torre.rotation = 90;
        aux_torre.nome = "torre_" .. i;
        fisica.addBody(aux_torre, "static");
        aux_torre:addEventListener( "collision", colisaoTorre );
        table.insert( torres, aux_torre );
    end

    print( "TORRES:", #torres )
    function criaArma1( ev )
        if ((dinheiro - 200) >= 0) then
            aux_arma = display.newImageRect( tela, "img/arma_1.png", 60, 60);
            aux_arma.x = 125;
            aux_arma.y = 50;
            table.insert( armaA, aux_arma );
            moveArma1 = true;
            dinheiro = dinheiro - 150;
            txtDinheiro.text = "$ " .. tostring(dinheiro);
        end
    end

    function criaArma2( ev )
        if ((dinheiro - 400) >= 0) then
            aux_arma = display.newImageRect( tela, "img/arma_2.png", 60, 60);
            aux_arma.x = 200;
            aux_arma.y = 50;
            table.insert( armaB, aux_arma );
            moveArma2 = true;
            dinheiro = dinheiro - 350;
            txtDinheiro.text = "$ " .. tostring(dinheiro);
        end
    end

    function criaArma3( ev )
        if ((dinheiro - 600) >= 0) then
            aux_arma = display.newImageRect( tela, "img/arma_3.png", 60, 60);
            aux_arma.x = 275;
            aux_arma.y = 50;
            aux_arma.rotation = 90;
            table.insert( armaC, aux_arma );
            moveArma3 = true;
            dinheiro = dinheiro - 550;
            txtDinheiro.text = "$ " .. tostring(dinheiro);
        end
    end

    function criaArma4( ev )
        if ((dinheiro - 800) >= 0) then
            aux_arma = display.newImageRect( tela, "img/arma_4.png", 60, 60);
            aux_arma.x = 350;
            aux_arma.y = 50;
            aux_arma.rotation = 90;
            table.insert( armaD, aux_arma );
            moveArma4 = true;
            dinheiro = dinheiro - 750;
            txtDinheiro.text = "$ " .. tostring(dinheiro);
        end
    end

    armaA[1]:addEventListener("tap", criaArma1);
    armaB[1]:addEventListener("tap", criaArma2);
    armaC[1]:addEventListener("tap", criaArma3);
    armaD[1]:addEventListener("tap", criaArma4);
end
 
function scene:show( event )
    local tela = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        function colisaoTiro( ev )
            local outro = ev.other;
            if (ev.phase == "began") then
                print(outro.nome);
                if ((outro.nome == "Inimigo1" or outro.nome == "Inimigo2" or outro.nome == "Inimigo3")) then
                    for i=#inimigos,1, -1 do
                        local inimigo = inimigos[i];
                        if (inimigo == outro) then
                            inimigo.vida = inimigo.vida - ev.target.dano;
                            if (inimigo.vida <= 0) then
                                table.remove( inimigos, i );
                                display.remove(inimigo);
                                contadorMortes = contadorMortes + 1;
                                txtMortes.text = contadorMortes;
                                if (outro.nome == "Inimigo1") then
                                    dinheiro = dinheiro + 30;
                                    txtDinheiro.text = "$ " .. tostring(dinheiro);
                                elseif(outro.nome == "Inimigo2") then
                                    dinheiro = dinheiro + 50;
                                    txtDinheiro.text = "$ " .. tostring(dinheiro);
                                elseif(outro.nome == "Inimigo3") then
                                    dinheiro = dinheiro + 70;
                                    txtDinheiro.text = "$ " .. tostring(dinheiro);
                                end
                                break;
                            end
                        end
                    end

                    for i=#balas,1, -1 do
                        local bala = balas[i];
                        if (bala == ev.target) then
                            table.remove( balas, i );
                            display.remove(bala);
                            break;
                        end
                    end
                end
            end
        end

        function criaBala()
            for i =#caminho,1, -1 do
                if (caminho[i].vazio == false and caminho[i].nomeArma == "armaA") then
                    aux_bala = display.newImageRect( tela, "img/bala_1.png", 30, 30);
                    aux_bala.x = caminho[i].centrox + 15;
                    aux_bala.y = caminho[i].centroy;
                    aux_bala.rotation = 270;
                    aux_bala.dano = 1;
                    fisica.addBody(aux_bala, "dynamic");
                    aux_bala.isSensor = true;
                    aux_bala:setLinearVelocity(180,0);
                    aux_bala:addEventListener("collision", colisaoTiro);
                    table.insert( balas, aux_bala );
                elseif (caminho[i].vazio == false and caminho[i].nomeArma == "armaB") then
                    aux_bala = display.newImageRect( tela, "img/bala_2.png", 30, 30);
                    aux_bala.x = caminho[i].centrox + 15;
                    aux_bala.y = caminho[i].centroy;
                    aux_bala.rotation = 270;
                    aux_bala.dano = 2;
                    fisica.addBody(aux_bala, "dynamic");
                    aux_bala.isSensor = true;
                    aux_bala:setLinearVelocity(230,0);
                    aux_bala:addEventListener("collision", colisaoTiro);
                    table.insert( balas, aux_bala );
                elseif (caminho[i].vazio == false and caminho[i].nomeArma == "armaC") then
                    aux_bala = display.newImageRect( tela, "img/bala_3.png", 40, 40);
                    aux_bala.x = caminho[i].centrox + 15;
                    aux_bala.y = caminho[i].centroy;
                    aux_bala.rotation = 270;
                    aux_bala.dano = 3;
                    fisica.addBody(aux_bala, "dynamic");
                    aux_bala.isSensor = true;
                    aux_bala:setLinearVelocity(260,0);
                    aux_bala:addEventListener("collision", colisaoTiro);
                    table.insert( balas, aux_bala );
                elseif (caminho[i].vazio == false and caminho[i].nomeArma == "armaD") then
                    aux_bala = display.newImageRect( tela, "img/bala_4.png", 40, 40);
                    aux_bala.x = caminho[i].centrox + 15;
                    aux_bala.y = caminho[i].centroy;
                    aux_bala.rotation = 270;
                    aux_bala.dano = 4;
                    fisica.addBody(aux_bala, "dynamic");
                    aux_bala.isSensor = true;
                    aux_bala:setLinearVelocity(300,0);
                    aux_bala:addEventListener("collision", colisaoTiro);
                    table.insert( balas, aux_bala );
                end
            end
        end

        local timerTiro = timer.performWithDelay( 1000, criaBala, 0);

        function criaInimigo()
            local rotas;

            rotas = math.random(3);
            randInimigos = math.random( 3 );

            if (rotas == 1) then
                if (randInimigos == 1) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_1.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo1";
                    aux_inimigo.vida = 4;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                elseif(randInimigos == 2) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_2.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo2";
                    aux_inimigo.vida = 7;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                elseif(randInimigos == 3) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_3.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo3";
                    aux_inimigo.vida = 9;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                end
                
            elseif(rotas == 2) then
                if (randInimigos == 1) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_1.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100 + 85;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo1";
                    aux_inimigo.vida = 4;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                elseif(randInimigos == 2) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_2.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100 + 85;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo2";
                    aux_inimigo.vida = 7;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                elseif(randInimigos == 3) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_3.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100 + 85;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo3";
                    aux_inimigo.vida = 9;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                end

            elseif(rotas == 3) then
                if (randInimigos == 1) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_1.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100 + 174;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo1";
                    aux_inimigo.vida = 4;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                elseif(randInimigos == 2) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_2.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100 + 174;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo2";
                    aux_inimigo.vida = 7;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                elseif(randInimigos == 3) then
                    aux_inimigo = display.newImageRect( tela, "img/inimigo_3.png",40, 40);
                    aux_inimigo.x = _w;
                    aux_inimigo.y = 100 + 174;
                    aux_inimigo.rotation = 180;
                    aux_inimigo.nome = "Inimigo3";
                    aux_inimigo.vida = 9;
                    fisica.addBody(aux_inimigo, "dynamic");
                    table.insert( inimigos, aux_inimigo );
                end
            end
        end
        
        local timerInimigo = timer.performWithDelay( 2000, criaInimigo, 0);

        function mover(ev)
            for i=#inimigos,1, -1 do
                local inimigo = inimigos[i];
                if (perdeu == 0 and perdeu2 == 0) then
                    inimigo.x = inimigo.x - 1;
                end

                if (inimigo.x < -10 and perdeu == 0) then
                    table.remove( inimigos, i );
                    display.remove(inimigo);
                    physics.stop();
                    timer.cancel( timerInimigo );
                    timer.cancel( timerTiro );
                    perdeu = 1;
                    composer.showOverlay( "fimJogo2" );
                    break;
                end
            end

            for i=#balas, 1, -1 do
                local bala = balas[i];
                if (bala.x > _w + 30) then
                    table.remove( balas, i );
                    display.remove( bala );
                    break;
                end
            end

            if (contadorMortes == 1 and perdeu2 == 0) then
                perdeu2 = 1;
                physics.stop();
                timer.cancel( timerInimigo );
                timer.cancel( timerTiro );
                composer.showOverlay( "ganhou" );
            end

            if (torre1 == true) then
                local pos = posicaoTorre("torre_1");
                print( "Posicao", pos );
                torre1 = false;
                display.remove(torres[pos]);
                table.remove( torres, pos );
                missil1 = display.newImageRect( tela, "img/missil.png", 70, 70);
                missil1.rotation = 90;
                missil1.x = 50;
                missil1.y = 100;
                fisica.addBody(missil1, "dynamic");
                missil1:setLinearVelocity(1000,0);
                missil1:addEventListener( "collision", colisaoMissil );
            elseif (torre2 == true) then
                local pos = posicaoTorre("torre_2");
                print( "Posicao", pos );
                torre2 = false;
                display.remove(torres[pos]);
                table.remove( torres, pos );
                missil2 = display.newImageRect( tela, "img/missil.png", 70, 70);
                missil2.rotation = 90;
                missil2.x = 50;
                missil2.y = 187;
                fisica.addBody(missil2, "dynamic");
                missil2:setLinearVelocity(1000,0);
                missil2:addEventListener( "collision", colisaoMissil );
            elseif (torre3 == true) then
                local pos = posicaoTorre("torre_3");
                print( "Posicao", pos );
                torre3 = false;
                display.remove(torres[pos]);
                table.remove( torres, pos );
                missil3 = display.newImageRect( tela, "img/missil.png", 70, 70);
                missil3.rotation = 90;
                missil3.x = 50;
                missil3.y = 274;
                fisica.addBody(missil3, "dynamic");
                missil3:setLinearVelocity(1000,0);
                missil3:addEventListener( "collision", colisaoMissil );
            end
        end
        Runtime:addEventListener( "enterFrame", mover );
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