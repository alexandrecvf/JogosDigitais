-- Escondendo a barra de status do celular
display.setStatusBar( display.HiddenStatusBar );

_w = display.viewableContentWidth; -- Width (Largura)
_h = display.viewableContentHeight; -- Height (Altura)

print(_w, _h);

-- display.newLine(20,20, 20,220, 220,220, 220,20, 20,20);
-- display.newLine(20,20, 220,220, 220,20, 20,220);

-- Retângulo (xCenter, yCenter, largura, altura)
--[[ local quad = display.newRect(10,10, 200,200);
quad.x = _w/2;
quad.y = _h/2;
quad:setFillColor( 1,0.6,0.8 );
quad.width = 250;
quad.height = 100;
quad.rotation = 45; ]]--

-- Bandeira do Brasil
--[[
local quad = display.newRect(_w/2, _h/2, 300,225);
quad:setFillColor( 14/255,130/255,25/255 );
-- local circulo = display.newCircle(_w/2, _h/2, 60);
-- circulo:setFillColor(1,0,0);

local pontos = {-140,0,0,-100,140,0,0,100}
local tri = display.newPolygon( _w/2, _h/2, pontos );
tri: setFillColor(1,1,0);

local circulo = display.newCircle(_w/2, _h/2, 61);
circulo:setFillColor(0/255,36/255,130/255);]]--

local bola = display.newCircle(_w/2, _h/2, 30);
bola:setFillColor(1,0,0);

-- Evento Tap
local function onTap ( event )
	print("Tocou na bolinha");
	print(event.name);
	print(event.x, event.y);
	bola.x = event.x;
	bola.y = event.y;
end

-- bola/Runtime: Quem pode disparar o evento
-- Runtime vigia toda a tela
--"tap": Qual evento será vigiado
-- onTap: qual função chamar quando o evento ocorrer
-- Runtime: addEventListener( "tap", onTap )

-- Evento TOUCH
function onTouch(event)
	if(event.phase=="began") then
		print( "Inicio Touch" );
		bola.x = event.x;
		bola.y = event.y;
	elseif (event.phase == "moved") then
		print( "Move Touch" );
		bola.x = event.x;
		bola.y = event.y;
	elseif(event.phase == "ended" or event.phase == "cancelled") then
		print( "Termina Touch" );
	end
end

Runtime:addEventListener("touch", onTouch);


