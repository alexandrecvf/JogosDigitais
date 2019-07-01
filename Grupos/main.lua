display.setStatusBar( display.HiddenStatusBar )

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

display.setDefault("anchorX", 0);
display.setDefault("anchorY", 0);

local quadVerm = display.newRect(110, 110, 200, 200);
quadVerm: setFillColor( 1,0,0 );

-- Criando um grupo
local grupo = display.newGroup( );
-- Colocando um objeto no grupo
grupo:insert(quadVerm);
-- grupo.x = 100;
grupo.x = 100;

local quadAmar = display.newRect(grupo, 110, 110, 100, 100);
quadAmar:setFillColor(1,1,0);		-- Cor Preenchimento
quadAmar.strokeWidth = 5;			-- Espessura do Contorno
quadAmar: setStrokeColor(0,0,1);	-- Cor do Contorno

--grupo: remove(1); -- Remover a primeira posição de um objeto do grupo
grupo:removeSelf( ); -- Remove o grupo e todo o seu conteudo da tela
grupo = nil;
