/// @function gamedata_load(slot)
function gamedata_load(slot)
{
	// Get out savedata file name
	var filename = "saveslot" + string(slot) + ".bin";
	
	// Check it if exists
	if file_exists(filename)
	{	
		// Open the file
		var file = file_bin_open(filename, 0);
		
		// Read the data
		var data	
		for(var i = 0; i < 5; i++)
		{
			data[i] = file_bin_read_byte(file);
		}
		
		data[5] = 0;
		for(i = 0; i < 4; i++) 
		{
			data[5] += file_bin_read_byte(file) * power(100, i);
		}
		
		/* NOTE: it loads the data in next order (as saved):
		0 - Character;
		1 - Zone;
		2 - Emeralds;
		3 - Lives;
		4 - Continues;
		5 - Score;
		*/
		
		// Close the file and return loaded data
		file_bin_close(file);
		return data;
	}
	
	// If not, return 0
	return 0;
}