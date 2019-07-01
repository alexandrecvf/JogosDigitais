display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth; -- Width é largura
_h = display.viewableContentHeight; -- Height é altura
_vel = 2; -- Velocidade do jogo

local grupo, fisica, background_1, background_2, chao_1, chao_2;
local opcoesSpritePersonagem,sheetPersonagem,animPersonagem;
local personagem, shapePersonagem, shapeAgachado, pulou, atira;
local obstaculos = {};
local obstaculo, timeObstaculo, setaCima, setaBaixo;
local grupoVida, vida1, vida2, vida3, vivo, perdeuVida;
local pontos, pontuacao, barreira, mensagem, missil, grupoMissil;
local qtdTiros, tiros, posObstaculo;
local somFundo, somDano, somMorte;
local musicaFundo, musicaDano, musicaFundo, musicaTiro;

grupo = display.newGroup();
grupoVida = display.newGroup();
grupoMissil = display.newGroup();

fisica = require("physics");
fisica.start();
fisica.setGravity(0, 10);

pontos = 0;
perdeuVida = 0;
qtdTiros = 0;

local function criaObstaculo()
	if (posObstaculo == "cima") then
		obstaculo = display.newImageRect(grupo, "images/Projeto/tnt-icon.png", 50, 50);
		obstaculo.x = _w + 100;
		obstaculo.y = obstaculo.height/2 + 220;
		obstaculo.nome = "obstaculo";
		table.insert(obstaculos, obstaculo);
		fisica.addBody(obstaculo, "static");
	elseif (posObstaculo == "baixo") then
		obstaculo = display.newImageRect(grupo, "images/Projeto/tnt-icon.png", 50, 50);
		obstaculo.x = _w + 100;
		obstaculo.y = obstaculo.height/2 + 170;
		obstaculo.nome = "obstaculo";
		table.insert(obstaculos, obstaculo);
		fisica.addBody(obstaculo, "static", {friction = 0});
	end

	local r = math.random(1,2);

	if(r == 1) then
		posObstaculo = "baixo"
	elseif(r == 2) then
		posObstaculo = "cima"
	end
	
	
end

function cenario()
	somFundo = audio.loadStream("musics/Gerudo_Valley.mp3");
	somDano = audio.loadStream("musics/Perde_Vida.mp3");
	somMorte = audio.loadStream("musics/Game_Over.mp3");
	
	audio.setVolume(0.3, {chanel = 1});
	musicaFundo = audio.play(somFundo, {loops = -1, chanel = 1});
	
	background_1 = display.newImageRect(grupo, "images/Projeto/background.png", 900, _h - 20);
	background_1.anchorX = -0.5;
	background_1.anchorY = -0.5;

	background_2 = display.newImageRect(grupo, "images/Projeto/background.png", 900, _h - 20);
	background_2.anchorX = -0.5;
	background_2.anchorY = -0.5;
	background_2.x = background_1.width;

	criaObstaculo();
	timeObstaculo = timer.performWithDelay(4000, criaObstaculo, 0);

	chao_1 = display.newImageRect(grupo, "images/Projeto/ground-grass-1.png", 700, 100);
	chao_1.anchorX = -0.5;
	chao_1.anchorY = -0.5;
	chao_1.y = 270;
	chao_1.nome = "chao_1"
	fisica.addBody(chao_1, "static", {bounce = 0});

	chao_2 = display.newImageRect(grupo, "images/Projeto/ground-grass-1.png", 700, 100);
	chao_2.anchorX = -0.5;
	chao_2.anchorY = -0.5;
	chao_2.x = chao_1.width;
	chao_2.y = 270;
	chao_2.nome = "chao_2";
	fisica.addBody(chao_2, "static", {bounce = 0});

	barreira = display.newRect(-20, _h/2, 10, _h);
	barreira.nome = "barreira";
	fisica.addBody(barreira, "static");
	grupo:insert(barreira);

	opcoesSpritePersonagem = {
		width = 126, 		-- Largura de cada quadro
		height = 85,		-- Altura de cada quadro
		numFrames = 112		-- Quantidade de quadros
	}

	sheetPersonagem = graphics.newImageSheet("images/Projeto/sheet_L.png", opcoesSpritePersonagem);

	animPersonagem = {
		{
			name = "correr",			-- Nome da animação
			start = 65,					-- Quadro inicial
			count = 8, 					-- Quantos quadros essa animação possui
			time = 800, 				-- O tempo de duração da animação
			loopCount = 0, 				-- Quantas vezes a animação será executada (0 é infinito)
			loopDirection = "foward"	-- Direção da animação ("bounce": vai e volta, "forward": vai até o final e reinicia)
		},

		{
			name = "pular",
			start = 55,
			count = 1,
			time = 800,
			loopCount = 0,
			loopDirection = "bounce"
		},

		{
			name = "atirar",
			start = 29,
			count = 2,
			time = 200,
			loopCount = 1,
			loopDirection = "bounce"
		},

		{
			name = "agachar",
			start = 13, 
			count = 1,
			time = 200,
			loopCount = 1,
			loopDirection = "bounce"

		}
	}

	personagem = display.newSprite(sheetPersonagem, animPersonagem);
	personagem.x = 80;
	personagem.y = 220;
	personagem:scale(0.8, 0.8);
	personagem.nome = "personagem";
	personagem.vida = 3;
	grupo:insert(personagem);

	personagem:setSequence("correr");
	personagem:play();

	shapePersonagem = {23,-30, 23,30, -23,30, -23,-30}
	fisica.addBody(personagem, "dynamic", {shape = shapePersonagem, bounce = 0, friction = 0});
	vivo = true;

	setaCima = display.newImageRect(grupo, "images/Projeto/Icons/arrowUp.png", 50, 50);
	setaCima.x = _w - 120;
	setaCima.y = _h - 300;
	setaCima.nome = "setaCima";

	setaBaixo = display.newImageRect(grupo, "images/Projeto/Icons/arrowDown.png", 50, 50);
	setaBaixo.x = _w - 120;
	setaBaixo.y = _h - 250;
	setaBaixo.nome = "setaBaixo";

	atira = display.newImageRect(grupo, "images/Projeto/Icons/buttonA.png", 75, 75);
	atira.x = _w - 50;
	atira.y = _h - 275;
	atira.nome = "atira";

	vida1 = display.newImageRect(grupoVida, "images/Projeto/heart-icon.png", 40, 40);
	vida1.x = _w/2 - 220;
	vida1.y = _h - 300;
	vida1.nome = "vida1";
	
	vida2 = display.newImageRect(grupoVida, "images/Projeto/heart-icon.png", 40, 40);
	vida2.x = _w/2 - 190;
	vida2.y = _h - 300;
	vida2.nome = "vida2";

	vida3 = display.newImageRect(grupoVida, "images/Projeto/heart-icon.png", 40, 40);
	vida3.x = _w/2 - 160;
	vida3.y = _h - 300;
	vida3.nome = "vida3";

	pontuacao = display.newText(grupo, "SCORE: "..pontos, _w/2 - 100, 15, native.systemFont, 15);
	pontuacao:setFillColor(0, 0, 0);

	tiros = display.newText(grupo, "BALAS: "..pontos, _w/2 - 100, 35, native.systemFont, 15);
	tiros:setFillColor(0, 0, 0);

	

	local opcoesSpriteExplosao = {
		width = 58, 	-- Largura de cada quadro
		height = 51,	-- Altura de cada quadro
		numFrames = 12 	-- Quantidade de quadros
	}

	local sheetExplosao = graphics.newImageSheet("images/Projeto/explosionSprite.png", opcoesSpriteExplosao);

	local animExplosao = {
		{
			name = "explodir",			-- Nome da animação
			start = 1,					-- Quadro inicial
			count = 12, 				-- Quantos quadros essa animação possui
			time = 1000, 				-- O tempo de duração da animação
			loopCount = 1, 				-- Quantas vezes a animação será executada (0 é infinito)
			loopDirection = "forward"	-- Direção da animação ("bounce": vai e volta, "forward": vai até o final e reinicia)
		}
	}

	function explodir()
		local explosao = display.newSprite(sheetExplosao, animExplosao);
		explosao.x = personagem.x;
		explosao.y = personagem.y;
		explosao:setSequence("explodir");
		explosao:play();
		personagem:removeSelf();
	end
end

cenario();

function moveObjetos(ev)
	background_1.x = background_1.x - _vel/4;
	background_2.x = background_2.x - _vel/4;
	if (background_1.x <= -(background_1.width)) then
		background_1.x = 0;
		background_2.x = background_1.width;
	end

	chao_1.x = chao_1.x - (_vel);
	chao_2.x = chao_2.x - (_vel);
	if (chao_1.x <= -(chao_1.width)) then
		chao_1.x = 0;
		chao_2.x = chao_1.width;
	end

	for i = #obstaculos, 1, -1 do
		local obstaculo = obstaculos[i];
		obstaculo.x = obstaculo.x - _vel;

		if (obstaculo.x < -100) then
			table.remove(obstaculos, i);
			display.remove(obstaculo);
		end

		if ((obstaculo.x > personagem.x - 1) and (obstaculo.x < personagem.x + 1)) then
			pontos = pontos + 1;
			if (math.fmod(pontos, 5) == 0) then
				qtdTiros = qtdTiros + 1;
				tiros.text = "TIROS: "..qtdTiros;
			end
			pontuacao:removeSelf();
			pontuacao = display.newText(grupo, "SCORE: "..pontos, _w/2 - 100, 15, native.systemFont, 15);
			pontuacao:setFillColor(0, 0, 0);
		end
	end


	if (vivo == true) then
		if (personagem.rotation < 0 or personagem.rotation > 0) then
			personagem.rotation = 0;
		end
	end

	personagem.velocity = 0;

end
Runtime:addEventListener("enterFrame", moveObjetos);

pulou = false;
local function correr(event)
	if (vivo == true) then
		shapePersonagem = {23,-30, 23,30, -23,30, -23,-30}
		fisica.removeBody(personagem);
		fisica.addBody(personagem, "dynamic", {shape = shapePersonagem, bounce = 0});
		personagem:setSequence("correr");
		personagem:play();
		_vel = 2;
		pulou = false;
	end
end

function colisaoMissil(eu, ev)
	local outro = ev.other;
	if (ev.phase == "began") then
		if (outro.nome == "obstaculo") then
			for i = #obstaculos, 1, -1 do
				local obstaculo = obstaculos[i];
				if(outro == obstaculo) then
					table.remove( obstaculos, i );
					display.remove( obstaculo );
				end
			end
			missil:removeSelf( );
		end
	end
end

local function bala()
	missil = display.newImageRect(grupo, "images/Projeto/spaceMissiles_006.png", 20, 10);
	missil.nome = "missil";
	missil.x = personagem.x + 2;
	missil.y = personagem.y + 2;
	fisica.addBody(missil, "dynamic");
	missil:setLinearVelocity(500, 0);
	missil:applyLinearImpulse(0.06, 0, missil.x, missil.y);
	missil.isBullet = true;
	missil.collision = colisaoMissil;
	missil:addEventListener("collision");
end

local function atirar(event)
	_vel = 0;
	personagem:setSequence("atirar");
	personagem:play();
	local delayAtirar = timer.performWithDelay(200, correr, 1);
	if (qtdTiros > 0) then
		bala();
		qtdTiros = qtdTiros - 1;
		tiros.text = "TIROS: "..qtdTiros;
	end
end

local function pular(event)
	if (pulou == false) then
		personagem:setSequence("pular");
		personagem:play();
		personagem:applyForce(0, -15, personagem.x, personagem.y);
		local delayPular = timer.performWithDelay(2000, correr, 1);
		pulou = true;
	end
end

local function agachar(event)
	shapeAgachado = {23,-16, 23,30, -23,30, -23,-16}
	fisica.removeBody(personagem);
	fisica.addBody(personagem, "dynamic", {shape = shapeAgachado, bounce = 0});
	personagem:setSequence("agachar");
	personagem:play();
	local delayAgachar = timer.performWithDelay(1200, correr, 1);
end

setaCima:addEventListener("tap", pular);
setaBaixo:addEventListener("tap", agachar);
atira:addEventListener("tap", atirar);

function pararJogo()
	vivo = false;
	explodir();
	Runtime:removeEventListener("enterFrame", moveObjetos);
	timer.cancel(timeObstaculo);
	setaCima:removeEventListener("tap", pular);
	setaBaixo:removeEventListener("tap", agachar);
	atira:removeEventListener("tap", atirar);
	audio.pause(musicaFundo);
end

function colisao(eu, ev)
	local outro = ev.other;
	if (ev.phase == "began") then
		if (outro.nome == "obstaculo") then
			personagem.vida = personagem.vida - 1;
			if (personagem.vida == 2) then
				grupoVida:remove(3);
				audio.setVolume(1, {channel = 2});
				musicaDano = audio.play(somDano, {channel = 2});
			end
			if (personagem.vida == 1) then
				grupoVida:remove(2);
				audio.setVolume(1, {channel = 2});
				musicaDano = audio.play(somDano, {channel = 2});
			end
			if (personagem.vida == 0) then
				grupoVida:remove(1);
				audio.setVolume(1, {channel = 3})
				musicaMorte = audio.play(somMorte, {channel = 3});
				pararJogo();
			end
		end

		if (outro.nome == "barreira") then
			personagem.vida = 0;
			audio.setVolume(1, {channel = 3})
			musicaMorte = audio.play(somMorte, {channel = 3});
			grupoVida:removeSelf();
			pararJogo();
		end
	end
end
personagem.collision = colisao;
personagem:addEventListener("collision");