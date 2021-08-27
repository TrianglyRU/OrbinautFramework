/// @function gamedata_load(slot)
function gamedata_load(slot)
{
	// Get savedata file name
	var filename = "saveslot" + string(slot + 1) + ".bin";
	
	// Check it if exists
	if file_exists(filename)
	{	
		// Open the file
		var file = file_bin_open(filename, 0);
		
		/* The function reads data in the following order (as saved):
		0 - Character
		1 - Zone
		2 - Emeralds
		3 - Lives
		4 - Continues
		5 - Game Clear flag
		6 - Score
		*/
		
		// Read the data
		var data;	
		for (var i = 0; i < 7; i++)
		{
			if i != 6
			{
				data[i] = file_bin_read_byte(file);
			}
			else
			{
				data[6] = 0;
				for (var j = 0; j < 4; j++) 
				{
					data[6] += file_bin_read_byte(file) * power(100, j);
				}
			}
		}
		
		// Close the file and return loaded data
		file_bin_close(file);
		return data;
	}
	
	// If not, return 0
	return 0;
}