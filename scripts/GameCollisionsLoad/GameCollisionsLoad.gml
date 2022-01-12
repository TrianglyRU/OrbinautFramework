function GameCollisionsLoad()
{
	// Clear tiledata
	Game.TileAngle   = [];
	Game.TileWidths  = [];
	Game.TileHeights = [];
	
	// Exit if we do not need to load any tiledata
	if !array_length(Game.TileData)
	{
		exit;
	}
	
	// Get filenames
	var AngleMap  = "anglemap"  + Game.TileData[0] + ".bin";
	var HeightMap = "heightmap" + Game.TileData[0] + ".bin";
	var WidthMap  = "widthmap"  + Game.TileData[0] + ".bin";
	
	// Load 3 data files
	for (var k = 0; k < 3; k++)
	{
		switch k
		{
			case 0:
				var Name = AngleMap;
			break;
			case 1:
				var Name = HeightMap;
			break;
			case 2:
				var Name = WidthMap;
			break;
		}
		
		// Load data file
		var File = file_bin_open("tiledata/" + Name, 0);	
		var Size = file_bin_size(File);
		if  File 
		{
			for (var i = 0; i <= Game.TileData[1]; i++) 
			{
				switch Name 
				{
					// Load anglemap
					case AngleMap:
					{	
						Game.TileAngle[i] = i < Size ? (256 - file_bin_read_byte(File)) * 360 / 256 : 0;
					}
					break;
					
					// Load heightmap
					case HeightMap:
					{
						for (var j = 0; j < 16; j++) 
						{
							Game.TileHeights[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;
						}
					}
					break;
					
					// Load widthmap
					case WidthMap:  
					{
						for (var j = 0; j < 16; j++) 
						{
							Game.TileWidths[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;	 
						}
					}
					break;
				}
			}
			file_bin_close(File);									 
		}
	}
}