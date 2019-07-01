display.setStatusBar(display.HiddenStatusBar);

_w = display.viewableContentWidth;
_h = display.viewableContentHeight;

contadorMortes = 0;
dinheiro = 1000;

local composer = require("composer");
composer.gotoScene( "menu" );