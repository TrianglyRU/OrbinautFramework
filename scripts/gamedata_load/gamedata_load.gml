/// @function gamedata_load(slot)
function gamedata_load(slot)
{
	// Get out savedata file name
	var filename = "saveslot" + string(slot) + ".txt";
	
	// Check it if exists
	if file_exists(filename)
	{	
		// Open the file
		var file = file_text_open_read(filename);
		
		// Read the data
		var data	
		for(var i = 0; i < 6; i++)
		{
		  data[i] = enigma_decode(file_text_read_string(file));
		  file_text_readln(file);
		}
		
		/* NOTE: it loads the data in next order (as saved):
		0 - Character;
		1 - Zone;
		2 - Emeralds;
		3 - Score;
		4 - Lives;
		5 - Continues;
		*/
		
		// Close the file and return loaded data
		file_text_close(file);
		return data;
	}
	
	// If not, return 0
	else
	{
		return 0;
	}
}