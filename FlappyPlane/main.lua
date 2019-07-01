display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

_vel = 2; -- Velocidade do jogo

local fisica = require("physics");
fisica.start();

-- Background
local bg1 = display.newImageRect("flappy/background.png", 800, _h);
bg1.anchorX = -0.5;
bg1.anchorY = -0.5;

local bg2 = display.newImageRect("flappy/background.png", 800, _h);
bg2.anchorX = -0.5;
bg2.anchorY = -0.5;
bg2.x = bg1.width;

-- Rochas
local rochas = {}; -- Lista de rochas criadas
local grupoRochas = display.newGroup( ); -- Grupo onde as rochas serão inseridas
local posRocha = "baixo";

local chao1 = display.newImageRect("flappy/groundGrass.png", 800, 60);
chao1.anchorX = -0.5;
chao1.anchorY = -0.5;
chao1.y = _h-60;
fisica.addBody(chao1, "static");

-- Chão
local chao2 = display.newImageRect("flappy/groundGrass.png", 800, 60);
chao2.anchorX = -0.5;
chao2.anchorY = -0.5;
chao2.y = _h-60;
chao2.x = chao1.width;
fisica.addBody(chao2, "static");

-- Avião
-- local aviao = display.newImageRect("flappy/Planes/planeBlue1.png", 44, 36);
-- aviao.x = 50;
-- aviao.y = _h/2;
--fisica.addBody(aviao, "dynamic");

local opcoesSprite = {
	width = 88, -- Largura de cada quadro
	height = 73, -- Altura de cada quadro
	numFrames = 3 -- Quantidade de quadros
}
-- Imagem contendo os quadros que serão animados
local sheet = graphics.newImageSheet("flappy/Planes/planeRedSprite.png", opcoesSprite);

local anim = {
	{
		name = "voar", 				-- Nome da animação
		start = 1, 					-- Quadro inicial desta animação
		count = 3, 					-- Quantos quadros esta animação possui
		time = 100, 				-- O tempo de duração da animação
		loopCount = 0 ,				-- Quantas vezes a animação será executada (0 é infinito)
		loopDirection = "bounce"	-- Direção da animação ("bounce": vai e volta, "foward": vai até o final e reinicia)
	}
};

-- Explosão do avião ao chocar em algo
local opcoesExplosao = {
	width = 58,
	height = 51,
	numFrames = 12
}

local sheetExplosao = graphics.newImageSheet("flappy/explosionSprite.png", opcoesExplosao);

local animExplosao = {
	{
		name = "explosao",
		start = 1,
		count = 12,
		time = 800,
		loopCount = 1,
		loopDirection = "forward"
	}
}

local aviao = display.newSprite(sheet, anim);
aviao.x = 50;
aviao.y = _h/2;
aviao: scale(0.6, 0.6); -- Escala do objeto (horizontal, vertical)

-- Iniciar a animação do avião
aviao:setSequence("voar");
aviao:play();

local shapeAviao = {22,-18, 22,18, -22,18, -22,-18};
fisica.addBody(aviao, "dynamic", {shape = shapeAviao});

-- Funções 
local function criaRocha( ... )
	local rocha;

	if (posRocha == "cima") then
		rocha = display.newImageRect(grupoRochas, "flappy/rockGrassDown.png", 64, 144);
		rocha.x = _w + 100;
		rocha.y = rocha.height/2;
		rocha.nome = "rocha";

		table.insert( rochas, rocha );
		local shapeRocha = {-32, -72, 32, -72, 7,72}
		fisica.addBody(rocha, "static", {shape = shapeRocha});
	else
		rocha = display.newImageRect(grupoRochas, "flappy/rockGrass.png", 64, 144);
		rocha.x = _w + 100;
		rocha.y = _h - rocha.height/2;
		rocha.nome = "rocha";

		table.insert( rochas, rocha );
		local shapeRocha = {-32,72,32,72,7,-72};

		fisica.addBody(rocha, "static", {shape = shapeRocha});
	end

	if (posRocha == "cima") then
		posRocha = "baixo";
	else
		posRocha = "cima";
	end
end

function moveObjetos( ev )
	bg1.x = bg1.x- _vel/4;
	bg2.x = bg2.x- _vel/4;

	chao1.x = chao1.x - _vel;
	chao2.x = chao2.x - _vel;

	if (bg1.x <= -bg1.width) then
		bg1.x = 0;
		bg2.x = bg1.width;
	end

	if (chao1.x <= -chao1.width) then
		chao1.x = 0;
		chao2.x = chao1.width;
	end

	-- Rochas
	for i= #rochas, 1, -1 do
		local rocha = rochas[i];
		rocha.x = rocha.x - _vel;

		if (rocha.x < -100) then
			table.remove( rochas, i );
			display.remove( rocha );
		end
	end
end

-- Cria um Timer que chama a função "criaRocha" a cada 2500 milissegundos
-- 0 significa que chamará eternamente
local timerRocha = timer.performWithDelay(2500, criaRocha, 0);

function tapTela( ev )
	aviao:applyForce(0, -5, aviao.x, aviao.y);
end

function colisaoAviao(ev)
	if(ev.phase == "began") then
		aviao:removeSelf( );

		local explosaoImg = display.newSprite(sheetExplosao, animExplosao);
		explosaoImg.x = aviao.x;
		explosaoImg.y = aviao.y;

		-- Iniciar a animação de explosão avião
		explosaoImg:setSequence("explosao");
		explosaoImg:play();

		gameOver();
	end
end

function gameOver( ... )
	Runtime:removeEventListener( "enterFrame", moveObjetos );
	Runtime:removeEventListener("tap", tapTela);
	timer.cancel( timerRocha );
end

Runtime:addEventListener( "enterFrame", moveObjetos );
Runtime:addEventListener("tap", tapTela);
aviao:addEventListener("collision", colisaoAviao);
