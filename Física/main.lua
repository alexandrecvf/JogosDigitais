display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

-- Importando a biblioteca de Física
local fisica = require("physics");
fisica.setDrawMode("hybrid"); -- Ver os contornos dos objetos
fisica.start();
fisica.setGravity(0,20);

local fundo = display.newImageRect("images/Backgrounds/blue_shroom.png", _h, _h);
fundo.x = _w/2;
fundo.y = _h/2;

local chao = display.newImageRect("images/Other/grass.png", _w, 30);
chao.x = _w/2;
chao.y = _h-15;
chao.nome = "chao";
fisica.addBody(chao, "static");

local pedra1 = display.newImageRect("images/Stone/elementStone012.png", 100, 30);
pedra1.x = 70;
pedra1.y = 250;
pedra1.rotation = 30;
pedra1.nome = "pedra1";
fisica.addBody(pedra1, "static");

local pedra2 = display.newImageRect("images/Stone/elementStone012.png", 100, 30);
pedra2.x = 220;
pedra2.y = 150;
pedra2.nome = "pedra2";
fisica.addBody(pedra2, "static");

local alien = display.newImageRect("images/Aliens/alienBlue_round.png", 50,50);
alien.x = 150;
alien.y = 30;
alien.nome = "alien1";
fisica.addBody(alien, "dynamic", {radius = 25, bounce = 1, friction=1});

local alien2 = display.newImageRect("images/Aliens/alienPink_round.png", 50,50);
alien2.x = 110;
alien2.y = 30;
alien2.nome = "alien2";
fisica.addBody(alien2, "dynamic", {radius = 25, bounce = 1.1, friction=1});

local madeiras = {
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

local linha1 = display.newRect(_w/2, 0, _w, 1 );
linha1.nome = "teto";
fisica.addBody(linha1, "static");

local linha2 = display.newRect(0, _h/2, 1, _h );
linha2.nome = "paredeEsq";
fisica.addBody(linha2, "static");

local linha3 = display.newRect(_w, _h/2, 1, _h );
linha3.nome = "paredeDir";
fisica.addBody(linha3, "static");

function tapAlien( ev )
	local alvo = ev.target;

	alvo:applyForce( 20, -20, alien.x, alien.y );
end
alien:addEventListener( "tap", tapAlien );
alien2:addEventListener( "tap", tapAlien );

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