display.setStatusBar(display.HiddenStatusBar);

local _w = display.viewableContentWidth;
local _h = display.viewableContentHeight;

local bg = display.newImageRect("img/Screens.jpg", 360, 570);
bg.x = _w/2;
bg.y = _h/2;

print(_w, _h);
print(display.pixelWidth, display.pixelHeight);