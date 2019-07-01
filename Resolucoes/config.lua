--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

if(string.sub(system.getInfo("model"), 1, 4) == "iPad") then
	application =
	{
		content =
		{
			width = 360,
			height = 480, 
			scale = "letterbox",
			fps = 60,
			
			xAlign = "center",
			yAlign = "center",

			imageSuffix =
			{
				    ["@2x"] = 1.5,
				    ["@4x"] = 3,
			},
			
		},
	}
elseif(string.sub(system.getInfo("model"), 1, 2) == "iP" and display.pixelHeight > 960) then -- iPhone 5 em diante
	application =
	{
		content =
		{
			width = 320,
			height = 568, 
			scale = "letterbox",
			fps = 60,
			
			xAlign = "center",
			yAlign = "center",

			imageSuffix =
			{
				    ["@2x"] = 1.5,
				    ["@4x"] = 3,
			},
			
		},
	}

elseif (string.sub(system.getInfo("model"), 1, 2) == "iP") then --iPhone 3, 4
	application =
	{
		content =
		{
			width = 320,
			height = 480, 
			scale = "letterbox",
			fps = 60,
			
			xAlign = "center",
			yAlign = "center",

			imageSuffix =
			{
				    ["@2x"] = 1.5,
				    ["@4x"] = 3,
			},
			
		},
	}
elseif(display.pixelHeight / display.pixelWidth > 1.72) then -- Android 16:9
	application =
	{
		content =
		{
			width = 320,
			height = 570, 
			scale = "letterbox",
			fps = 60,
			
			xAlign = "center",
			yAlign = "center",

			imageSuffix =
			{
				    ["@2x"] = 1.5,
				    ["@4x"] = 3,
			},
			
		},
	}
else
	application =
	{
		content =
		{
			width = 320,
			height = 480, 
			scale = "letterbox",
			fps = 60,
			
			xAlign = "center",
			yAlign = "center",

			imageSuffix =
			{
				    ["@2x"] = 1.5,
				    ["@4x"] = 3,
			},
			
		},
	}
end
