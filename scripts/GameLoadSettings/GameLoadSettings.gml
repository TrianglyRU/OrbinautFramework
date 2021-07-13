function GameLoadSettings()
{
	if !Game.DevMode
	{
	
		ini_open("config.ini");
		
		// Gameplay
		Game.SpindashEnabled   = ini_read_real("Gameplay", "Spindash",    true);
		Game.DropdashEnabled   = ini_read_real("Gameplay", "Dropdash",    false);
		Game.PeeloutEnabled	   = ini_read_real("Gameplay", "Peelout",     false);
		Game.GroundSpeedcap	   = ini_read_real("Gameplay", "GndSpeedcap", false);
		Game.AirSpeedcap	   = ini_read_real("Gameplay", "AirSpeedcap", false);
		Game.RolljumpControl   = ini_read_real("Gameplay", "RlljmpCtrl",  true);	 
		Game.ExtendedCamera	   = ini_read_real("Gameplay", "CDCamera",    false);
		Game.OriginalRollLimit = ini_read_real("Gameplay", "OgRollLimit", true);	
		Game.FlyingCancel	   = ini_read_real("Gameplay", "FlyCancel",   true); 
	
		// Video
		Game.ResolutionWidth  = ini_read_real("Video", "ResWidth",  400);
		Game.ResolutionHeight = ini_read_real("Video", "ResHeight", 224);
		Game.WindowSize		  = ini_read_real("Video", "WindowSize",  2);
		Game.WindowFullscreen = ini_read_real("Video", "Fullscreen",  0);
	
		// Music
		Game.MusicVolume = ini_read_real("Music", "MusicVolume", 0.3);
		Game.SoundVolume = ini_read_real("Music", "SoundVolume", 0.3);
	
		// Control
		Game.KeyboardControl[0] = ini_read_real("Control", "Up",	   vk_up);
		Game.KeyboardControl[1] = ini_read_real("Control", "Down",	 vk_down);
		Game.KeyboardControl[2] = ini_read_real("Control", "Left",	 vk_left);
		Game.KeyboardControl[3] = ini_read_real("Control", "Right", vk_right);
		Game.KeyboardControl[4] = ini_read_real("Control", "A",		ord("A"));
		Game.KeyboardControl[5] = ini_read_real("Control", "B",		ord("S"));
		Game.KeyboardControl[6] = ini_read_real("Control", "C",		ord("D"));
		Game.KeyboardControl[7] = ini_read_real("Control", "Mode",	vk_space);
		Game.KeyboardControl[8] = ini_read_real("Control", "Start", vk_enter);
	
		ini_close();
	
	}
	
	// Load collision tiles binary data
	for (var k = 0; k < 3; k++)
	{
		// Define datafile to load
		switch k
		{
			case 0:
				var Name = "anglemap.bin";
			break;
			case 1:
				var Name = "heightmap.bin";
			break;
			case 2:
				var Name = "widthmap.bin";
			break;
		}
		
		// Open datafile
		var File = file_bin_open(Name, 0);	
		var Size = file_bin_size(File);
		if  File 
		{														
			for (var i = 0; i < TileAmount; i++) 
			{
				switch Name 
				{
					// Load anglemap
					case "anglemap.bin": 
					{	
						Game.AngleValueOf[i] = i < Size ? (256 - file_bin_read_byte(File)) * 360 / 256 : 0;
					}
					break;
					
					// Load heightmap
					case "heightmap.bin":
					{
						for (var j = 0; j < 16; j++) 
						{
							Game.HeightValueOf[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;
						}
					}
					break;
					
					// Load widthmap
					case "widthmap.bin":  
					{
						for (var j = 0; j < 16; j++) 
						{
							Game.WidthValueOf[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;	 
						}
					}
					break;
				}
			}
			file_bin_close(File);									 
		}
	}
}