display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth; -- Width é largura
_h = display.viewableContentHeight; -- Height é altura

local options = {
	-- As dimensões de cada frame
};

local options = require("hulk"); -- hulk.lua

local sheet = graphics.newImageSheet("hulk.png", options.sheetData);

local seq = {
	{
		name = "idle", -- Idle: pose de descanso
		start = 1,
		count = 8,
		time = 800,
		loopCount = 0,
		loopDirection = "forward"
	}
};

local hulk = display.newSprite(sheet, seq);
hulk.x = _w/2;
hulk.y = _h/2;

hulk:setSequence("idle");
hulk:play();