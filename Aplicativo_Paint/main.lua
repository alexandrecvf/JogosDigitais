display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

local espessura = 1;
local cor = 1;
local quad, circ, ferramenta, x, y;
local grupo2 = display.newGroup( ); -- Área onde posso desenhar

local retangulo = display.newRect(160,25, _w,50);
retangulo:setFillColor(175/255,181/255,191/255);

local retangulo3 = display.newRect(160,455, _w,50);
retangulo3:setFillColor(175/255,181/255,191/255);

local folha = display.newRect(grupo2, 160, 240, _w, 378);
folha: setFillColor(1, 1, 1);

local cor1 = display.newCircle( 240, 455, 20 );
cor1: setFillColor( 1,0,0 );

local cor3 = display.newCircle( 290, 455, 20 );
cor3: setFillColor( 0,0,1 );

local cor2 = display.newCircle( 190, 455, 20 );
cor2: setFillColor( 0,1,0 );

local tamanho1 = display.newCircle( 20, 455, 5 );
tamanho1: setFillColor( 0,0,0 );

local tamanho2 = display.newCircle( 45, 455, 10 );
tamanho2: setFillColor( 0,0,0 );

local tamanho3 = display.newCircle( 78, 455, 15 );
tamanho3: setFillColor( 0,0,0 );

-- Ícones da Barra superior
local iconePincel = display.newImage("pincel.png");
iconePincel.width=40;
iconePincel.height=40;
iconePincel.x = 40;-- X da imagem
iconePincel.y = 25 ;-- Y da imagem

local iconeQuadrado = display.newImage("quadrado.png");
iconeQuadrado.width=40;
iconeQuadrado.height=40;
iconeQuadrado.x = 110;-- X da imagem
iconeQuadrado.y = 25 ;-- Y da imagem

local iconeCirculo = display.newImage("circulo.png");
iconeCirculo.width=40;
iconeCirculo.height=40;
iconeCirculo.x = 190;-- X da imagem
iconeCirculo.y = 25 ;-- Y da imagem

local iconeBorracha = display.newImage("borracha.png");
iconeBorracha.width=40;
iconeBorracha.height=40;
iconeBorracha.x = 270;-- X da imagem
iconeBorracha.y = 25 ;-- Y da imagem


local function tap_Espessura1( evento )
	print( "Espessura 1" );
	espessura = 1;
end

local function tap_Espessura2( evento )
	print( "Espessura 2" );
	espessura = 2;
end

local function tap_Espessura3( evento )
	print( "Espessura 3" );
	espessura = 3;
end

local function tap_Pincel( ... )
	print( "Pincel" );
	ferramenta = 1;
end

local function tap_Quadrado( ... )
	print( "Quadrado" );
	ferramenta = 2;
end

local function tap_Circulo( ... )
	print( "Circulo" );
	ferramenta = 3;
end

local function tapVermelho( evento )
	print( "Cor vermelha selecionada" );
	cor = 1;
	tamanho1: setFillColor( 1,0,0 );
	tamanho2: setFillColor( 1,0,0 );
	tamanho3: setFillColor( 1,0,0 );
end

local function tapVerde( evento )
	print( "Cor verde selecionada" );
	cor = 2;
	tamanho1: setFillColor( 0,1,0 );
	tamanho2: setFillColor( 0,1,0 );
	tamanho3: setFillColor( 0,1,0 );
end

local function tapAzul( evento )
	print( "Cor azul selecionada" );
	cor = 3;
	tamanho1: setFillColor( 0,0,1 );
	tamanho2: setFillColor( 0,0,1 );
	tamanho3: setFillColor( 0,0,1 );
end

function touchFolha(event)
	if(event.phase=="began") then
		print( "Inicio Touch" );
		if (ferramenta == 1) then
			local bola = display.newCircle(grupo2, event.x, event.y, espessura*5);

			if(cor == 1) then
				bola: setFillColor( 1,0,0 );
			elseif (cor == 2) then
				bola: setFillColor( 0,1,0 );
			elseif (cor == 3) then
				bola: setFillColor( 0,0,1 );
			end

		elseif(ferramenta == 2) then
			quad = display.newRect( grupo2, event.x, event.y, 0, 0 );

			if(cor == 1) then
				quad: setFillColor( 1,0,0 );
			elseif (cor == 2) then
				quad: setFillColor( 0,1,0 );
			elseif (cor == 3) then
				quad: setFillColor( 0,0,1 );
			end

			x = event.x;
			y = event.y;

		elseif(ferramenta == 3) then
			circ = display.newCircle(grupo2, event.x, event.y, 0);

			if(cor == 1) then
				circ: setFillColor( 1,0,0 );
			elseif(cor == 2) then
				circ: setFillColor( 0,1,0 );
			elseif(cor == 3) then
				circ: setFillColor( 0,0,1 );
			end

			x = event.x;
			y = event.y;
		end
		
	elseif (event.phase == "moved") then
		print( "Move Touch" );
		if (ferramenta == 1) then
			local bola = display.newCircle(grupo2, event.x, event.y, espessura*5);
			
			if(cor == 1) then
				bola: setFillColor( 1,0,0 );
			elseif (cor == 2) then
				bola: setFillColor( 0,1,0 );
			elseif (cor == 3) then
				bola: setFillColor( 0,0,1 );
			end
		elseif (ferramenta == 2) then
			quad: removeSelf();
			quad = display.newRect( grupo2, x, y, event.x - x, event.y - y );
			quad.anchorX = 0;
			quad.anchorY = 0;

			if(cor == 1) then
				quad: setFillColor( 1,0,0 );
			elseif (cor == 2) then
				quad: setFillColor( 0,1,0 );
			elseif (cor == 3) then
				quad: setFillColor( 0,0,1 );
			end
			
		elseif (ferramenta == 3) then
			circ: removeSelf();
			circ = display.newCircle( grupo2, x, y, event.x - x);
			circ.anchorX = 0;
			circ.anchorY = 0;

			if(cor == 1) then
				circ: setFillColor( 1,0,0 );
			elseif (cor == 2) then
				circ: setFillColor( 0,1,0 );
			elseif (cor == 3) then
				circ: setFillColor( 0,0,1 );
			end
		end
		
		elseif(event.phase == "ended" or event.phase == "cancelled") then
	end
end

local function tap_Borracha( ... )
	print( "borracha" );
	grupo2: removeSelf( );
	grupo2 = nil;
	grupo2 = display.newGroup( );

	grupo2.parent: insert( 1, grupo2 );

	folha = display.newRect(grupo2, 160, 240, _w, 378);

	folha: addEventListener("touch", touchFolha);
end

folha: addEventListener("touch", touchFolha);

-- Eventos para determinar a cor do desenho
cor1: addEventListener( "tap", tapVermelho );
cor2: addEventListener( "tap", tapVerde );
cor3: addEventListener( "tap", tapAzul );

-- Eventos para determinar a espessura do pincel
tamanho1: addEventListener( "tap", tap_Espessura1 );
tamanho2: addEventListener( "tap", tap_Espessura2 );
tamanho3: addEventListener( "tap", tap_Espessura3 );

-- Eventos das ferramentas de desenho
iconePincel: addEventListener( "tap", tap_Pincel );
iconeQuadrado: addEventListener( "tap", tap_Quadrado );
iconeCirculo: addEventListener( "tap", tap_Circulo );
iconeBorracha: addEventListener( "tap", tap_Borracha );