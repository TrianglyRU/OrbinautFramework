/// @description Collision & Instances Init.
// You can write your code in this editor
	
	// Setup Script
	CollisionSetup();
	
	#region Collision Load
	{
		// Clear tiledata
		global.TileAngle   = [];
		global.TileWidths  = [];
		global.TileHeights = [];
	
		if !array_length(global.TileData)
		{
			if instance_exists(Stage)
			{
				show_message("NO COLLISION TILEDATA FOUND! \nPlease, setup the collision in CollisionSetup() script");
			}
		}
		else
		{
			var AngleMap  = "anglemap"  + global.TileData[0] + ".bin";
			var HeightMap = "heightmap" + global.TileData[0] + ".bin";
			var WidthMap  = "widthmap"  + global.TileData[0] + ".bin";
	
			// Load data files
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
					for (var i = 0; i <= global.TileData[1]; i++) 
					{
						switch Name 
						{
							// Load anglemap
							case AngleMap:
							{	
								global.TileAngle[i] = i < Size ? (256 - file_bin_read_byte(File)) * 360 / 256 : 0;
							}
							break;
					
							// Load heightmap
							case HeightMap:
							{
								for (var j = 0; j < 16; j++) 
								{
									global.TileHeights[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;
								}
							}
							break;
					
							// Load widthmap
							case WidthMap:  
							{
								for (var j = 0; j < 16; j++) 
								{
									global.TileWidths[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;	 
								}
							}
							break;
						}
					}
					file_bin_close(File);									 
				}
			}
		}
	}
	#endregion
	
	#region Instances Startup
	{
		// Initalise system variables for all instances that do not have them at this moment
		with all
		{
			instance_initialise();
		}
	}
	#endregion