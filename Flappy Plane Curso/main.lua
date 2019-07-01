display.setStatusBar( display.HiddenStatusBar );

local _w  = display.viewableContentWidth;
local _h  = display.viewableContentHeight;

-- Adicionando a Física
local fisica = require( "physics" ); -- Importar a biblioteca de Física
fisica.setDrawMode( "normal" ); -- Opcional: visualizar os corpos físicos
fisica.start(); -- Iniciar a física
fisica.setGravity(0, 9.8); -- Gravidade horizontal e vertical


-- Fundos (Backgrounds)
local bg = display.newImageRect("flappy/background_duplo.png", 1600, 480);
bg.anchorX = - bg.width / 2;
bg.anchorY = bg.height / 2;
bg.x = 0;
bg.y = _h;

-- Grupo Rochas
local rochas = {}; -- Armazenar as rochas criadas
local grupoRochas = display.newGroup();

-- Chão
local chao = display.newImageRect("flappy/groundGrass_duplo.png", 1600, 50);
chao.anchorX = - chao.width / 2;
chao.anchorY = chao.height / 2;
chao.x = 0;
chao.y = _h + 5;
fisica.addBody(chao, "static");

-- Avião
local opcoesSprite = {
	width = 88,
	height = 73,
	numFrames = 3
};
local sheet = graphics.newImageSheet( "flappy/Planes/planeRedSprite.png", opcoesSprite );

local seq = {
	{
		name = "voar",
		start = 1,
		count = 3,
		time = 150,
		loopCount = 0,
		loopDirection = "bounce"
	}
}

--local aviao = display.newImageRect("flappy/Planes/planeRed1.png", 44, 36);
local aviao = display.newSprite( sheet, seq );
aviao:scale(0.5, 0.5);
aviao.x = 50;
aviao.y = _h/2;

local shapeAviao = {22,-18, 22,18, -22,18, -22,-18};
fisica.addBody(aviao, "dynamic", {shape=shapeAviao});


aviao:setSequence( "voar" );
aviao:play();

-- Eventos
local gameOver = false;
local veloc = 5;
local tempoNovaRocha = 2500;


-- Movimenta o cenário para a esquerda
local function moveCenario (event)
	-- Se o jogo acabou, pára de movimentar
	if ( gameOver == true ) then
		return;
	end

	local metade = bg.width/2;

	-- Fundo
	bg.x = bg.x - (veloc * 0.5);
	if ( bg.x < -metade ) then
		bg.x = bg.x + metade;
	end

	-- Chão
	chao.x = chao.x - veloc;
	if ( chao.x < -metade ) then
		chao.x = chao.x + metade;
	end

	-- Rochas
	for i=#rochas, 1, -1 do
		local rocha = rochas[i];
		rocha.x = rocha.x - veloc;

		if ( rocha.x < -100 ) then
			table.remove( rochas, i );
			display.remove( rocha );
		end
	end
end
Runtime:addEventListener( "enterFrame", moveCenario );



-- Cria uma nova rocha de N em N segundos
local cima = true;
local function criaRocha (event)
	local rocha;

	if ( cima == true ) then
		rocha = display.newImageRect(grupoRochas, "flappy/rockGrassDown.png", 64, 144);
		rocha.anchorX = - rocha.width;
		rocha.anchorY = - rocha.height;
		rocha.x = _w + 100;
		rocha.y = 0;
		rocha.nome = "rocha";
		table.insert( rochas, rocha ); -- Adicionado à nossa lista

		-- Criando um corpo em formato de polígono (triângulo)
		local shapeRocha = {-32,-72, 32,-72, 7,72};
		fisica.addBody(rocha, "static", {shape=shapeRocha});
	else
		rocha = display.newImageRect(grupoRochas, "flappy/rockGrass.png", 64, 144);
		rocha.anchorX = - rocha.width;
		rocha.anchorY = rocha.height;
		rocha.x = _w + 100;
		rocha.y = _h;
		rocha.nome = "rocha";
		table.insert( rochas, rocha ); -- Adicionado à nossa lista

		-- Criando um corpo em formato de polígono (triângulo)
		local shapeRocha = {-32,72, 32,72, 7,-72};
		fisica.addBody(rocha, "static", {shape=shapeRocha});
	end

	cima = not cima; -- Garantindo que a próxima rocha estará em uma posição (cima ou baixo) diferente da anterior
end

-- Chamar uma função de tanto em tanto tempo (em milisegundos)
local timerRocha = timer.performWithDelay(tempoNovaRocha, criaRocha, 0);


-- Sobe o avião
local function tapTela (event)
	aviao:applyForce( 0, -4, aviao.x, aviao.y );
end
Runtime:addEventListener("tap", tapTela);


-- Explosão
local explosao;
local function explode (posX, posY)
	local opcoesSpriteExp = {
		width = 58,
		height = 51,
		numFrames = 12
	};
	local sheetExp = graphics.newImageSheet( "flappy/explosionSprite.png", opcoesSpriteExp );

	local seqExp = {
		{
			name = "explodir",
			start = 1,
			count = 12,
			time = 800,
			loopCount = 1,
			loopDirection = "forward"
		}
	}

	explosao = display.newSprite( sheetExp, seqExp );
	explosao.x = posX;
	explosao.y = posY;
	explosao:setSequence( "explodir" );
	explosao:play();

	aviao.isVisible = false;

end


-- Colisão
local function colide (event)
	if ( event.phase == "began" ) then
		if ( gameOver == false ) then
			explode(aviao.x, aviao.y);

			print( "Perdeu!" );
			timer.cancel( timerRocha ); -- Para de criar rochas

			gameOver = true;
			Runtime:removeEventListener( "tap", tapTela );
		end
	end
end
aviao:addEventListener( "collision", colide );
