/// @function data_read(name)
function data_read(name) 
{
	var File = file_bin_open(name, 0);				
	if  File 
	{														
		for (var i = 0; i < 147; i++) 
		{
			switch name 
			{
				case "anglemap.bin": 
				{
					Game.AngleValueOf[i] = (256 - file_bin_read_byte(File)) * 360 / 256;
				}
				break;
				case "heightmap.bin":
				{
					for (var j = 0; j < 16; j++) 
					{
						Game.HeightValueOf[i][j] = file_bin_read_byte(File);
					}
				}
				break;
				case "widthmap.bin":  
				{
					for (var j = 0; j < 16; j++) 
					{
						Game.WidthValueOf[i][j] = file_bin_read_byte(File);	 
					}
				}
				break;
			}
		}
		file_bin_close(File);									 
	}
}