/// @function data_read(name)
function data_read(name) 
{
	var File = file_bin_open(name, 0);	
	var Size = file_bin_size(File);
	if  File 
	{														
		for (var i = 0; i < TileAmount; i++) 
		{
			switch name 
			{
				case "anglemap.bin": 
				{	
					Game.AngleValueOf[i] = i < Size ? (256 - file_bin_read_byte(File)) * 360 / 256 : 0;
				}
				break;
				case "heightmap.bin":
				{
					for (var j = 0; j < 16; j++) 
					{
						Game.HeightValueOf[i][j] = (i * 16 < Size) ? file_bin_read_byte(File) : 0;
					}
				}
				break;
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