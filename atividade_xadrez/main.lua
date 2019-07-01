display.setStatusBar(display.HiddenStatusBar);
_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

local largura = _w/8;
local altura = _h/largura;
local centro = largura/2;
local x = centro;
local y = centro;

for i=1,altura do
	for j=1,4 do
		if(i%2 == 1) then
			local quad1 = display.newRect(x, y, largura, largura);
			quad1: setFillColor( 1,1,1 );
			x = x + largura;

			local quad2 = display.newRect(x, y, largura, largura);
			quad2: setFillColor( 0,0,0 );
			x = x + largura;
		else
			local quad1 = display.newRect(x, y, largura, largura);
			quad1: setFillColor( 0,0,0 );
			x = x + largura;

			local quad2 = display.newRect(x, y, largura, largura);
			quad2: setFillColor( 1,1,1 );
			x = x + largura;
		end
	end
	x = centro;
	y = y + largura;
end

local bola = display.newCircle(centro, centro, 20);
bola:setFillColor(1,0,0);

function onTouch(event)
	if(event.phase=="began") then
		print( "Inicio Touch" );
	elseif (event.phase == "moved") then
		print( "Move Touch" );
		bola.x = event.x;
		bola.y = event.y;
		if (event.x < 0 or event.y < 0  or event.x > _w or event.y > _h) then
			bola.x = centro;
			bola.y = centro;
		end
	elseif(event.phase == "ended" or event.phase == "cancelled") then
		print( "Termina Touch" );

		if (bola.x%20 ~= 0) then
			local calc1 = math.floor( bola.x / 20);
			local calc2 = (bola.x / 20) - calc1;
			local calc3 = (calc2 * 20) + bola.x;

			if(calc3%20 ~= 0) then
				calc3 = bola.x - (calc2 * 20);
				if((calc3/20)%2==0) then
					calc3 = calc3 + 20;
				end
			end
			bola.x = calc3;
		end

		if (bola.y%20 ~= 0) then
			local calc1 = math.floor( bola.y / 20);
			local calc2 = (bola.y / 20) - calc1;
			local calc3 = (calc2 * 20) + bola.y;

			if(calc3%20 ~= 0) then
				calc3 = bola.y - (calc2 * 20);
				if((calc3/20)%2==0) then
					calc3 = calc3 + 20;
				end
			end
			bola.y = calc3;
		end
	end
end

bola:addEventListener("touch", onTouch);