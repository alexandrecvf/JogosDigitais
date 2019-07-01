display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

-- Importando a biblioteca de Física
local fisica = require("physics");
fisica.start();
fisica.setGravity(0,20);

local velocidade = 1;

local fundo = display.newImageRect("images/Backgrounds/colored_desert.png", _h, _h);
fundo.x = _w/2;
fundo.y = _h/2;

local bola = display.newImageRect("images/Aliens/alienBeige_round.png", 30,30);
bola.x = _w/2;
bola.y = 160;
bola.nome = "bola";
fisica.addBody(bola, "dynamic", {radius = 15, bounce = velocidade, friction=5});

local teto = display.newRect(_w/2, 0, _w, 1 );
teto.nome = "teto";
fisica.addBody(teto, "static");

local chao = display.newRect(_w/2, _h, _w, 1 );
chao.nome = "chao";
fisica.addBody(chao, "static");

local paredeEsq = display.newRect(0, _h/2, 1, _h );
paredeEsq.nome = "paredeEsq";
fisica.addBody(paredeEsq, "static");

local paredeDir = display.newRect(_w, _h/2, 1, _h );
paredeDir.nome = "paredeDir";
fisica.addBody(paredeDir, "static");

local barra = display.newImageRect("images/Metal/elementMetal019.png", 33, 15);
barra.x = _w/2;
barra.y = _h-15;
barra.nome = "barra";
fisica.addBody(barra, "static", {friction = 5, bounce = velocidade});

local barraEsq = display.newImageRect("images/Metal/elementMetal019.png", 33, 15);
barraEsq.x = _w/2 - 33;
barraEsq.y = _h-15;
barraEsq.nome = "barraEsq";
fisica.addBody(barraEsq, "static", {friction = 5, bounce = velocidade});

local barraDir = display.newImageRect("images/Metal/elementMetal019.png", 33, 15);
barraDir.x = _w/2 + 33;
barraDir.y = _h-15;
barraDir.nome = "barraDir";
fisica.addBody(barraDir, "static", {friction = 5, bounce = velocidade});

for i=0,4 do
	local metal = display.newImageRect("images/Metal/elementMetal013.png", _w/4, 25);
	metal.x = (_w/4)/2 + (i * (_w/4));
	metal.y = 15;
	metal.nome = "bloco";
	metal.vida = 4;
	fisica.addBody(metal, "static");
end

for i=0,5 do
	local metal = display.newImageRect("images/Metal/elementMetal013.png", _w/5, 25);
	metal.x = (_w/5)/2 + (i * (_w/5));
	metal.y = 40;
	metal.nome = "bloco";
	metal.vida = 4;
	fisica.addBody(metal, "static");
end

for i=0,8 do
	local pedra = display.newImageRect("images/Stone/elementStone013.png", _w/8, 25);
	pedra.x = (_w/8)/2 + (i * (_w/8));
	pedra.y = 65;
	pedra.nome = "bloco";
	pedra.vida = 3;
	fisica.addBody(pedra, "static");
end

for i=0,8 do
	local madeira = display.newImageRect("images/Wood/elementWood010.png", _w/8, 25);
	madeira.x = (_w/8)/2 + (i * (_w/8));
	madeira.y = 90;
	madeira.nome = "bloco";
	madeira.vida = 2;
	fisica.addBody(madeira, "static");
end

for i=0,16 do
	local vidro = display.newImageRect("images/Glass/elementGlass012.png", _w/16, 25);
	vidro.x = (_w/16)/2 + (i * (_w/16));
	vidro.y = 115;
	vidro.nome = "bloco";
	vidro.vida = 1;
	fisica.addBody(vidro, "static");
end

function onTouch(event)
	if(event.phase=="began") then
		barra.x = event.x;
		barraEsq.x = event.x - 33;
		barraDir.x = event.x + 33;
	elseif (event.phase == "moved") then
		barra.x = event.x;
		barraEsq.x = event.x - 33;
		barraDir.x = event.x + 33;
	elseif(event.phase == "ended" or event.phase == "cancelled") then
	end
end
barra:addEventListener("touch", onTouch);
barraEsq:addEventListener("touch", onTouch);
barraDir:addEventListener("touch", onTouch);

function colisaoBola( eu, ev )
	local outro = ev.other;
	if(ev.phase == "began") then
		if(outro.nome == "bloco") then
			outro.vida = outro.vida - 1;
			if(outro.vida == 0) then
				outro:removeSelf();
			end
		end
	elseif (ev.phase == "ended") then
		if(outro.nome == "barra") then
			bola:applyForce( 0, -0.3, bola.x, bola.y );
		elseif(outro.nome == "barraEsq") then
			bola:applyForce( -1, -0.3, bola.x, bola.y );
		elseif(outro.nome == "barraDir") then
			bola:applyForce( 1, -0.3, bola.x, bola.y );
		end
	end
end
bola.collision = colisaoBola;
bola:addEventListener("collision");
