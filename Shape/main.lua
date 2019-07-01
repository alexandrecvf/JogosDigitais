display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth; -- Width é largura
_h = display.viewableContentHeight; -- Height é altura

local fisica = require("physics");
fisica.setDrawMode("hybrid");
fisica.start();

local chao = display.newRect(0,0,_w,30);
chao.x = _w / 2;
chao.y = _h - 15;
fisica.addBody(chao, "static");

local objetos = require("shapes").physicsData(1.0);

local cacto = display.newImageRect("cactus.png", 70,70);
cacto.x = _w/2;
cacto.y = 50;
fisica.addBody(cacto, "dynamic", objetos:get("cactus"));