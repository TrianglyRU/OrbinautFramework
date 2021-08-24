function GameDataLoad()
{
	// Load game settings
	gamesettings_load("config");
	
	// Load random seed
	random_set_seed(randomise());
	
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
		
		// Open file
		var File = file_bin_open(Name, 0);	
		var Size = file_bin_size(File);
		if  File 
		{														
			for (var i = 0; i <= TileAmount; i++) 
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
			
			// Close file
			file_bin_close(File);									 
		}
	}
}