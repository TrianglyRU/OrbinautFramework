/// @function gamedata_load(slot)
function gamedata_load(slot)
{
	// Get out savedata file name
	var filename = "saveslot" + string(slot) + ".txt";
	
	// If datafile does not exists when we're trying to load it, create it and fill with zeros
	if !file_exists(filename)
	{
		var file = file_text_open_write(filename);
		for (var i = 0; i < 6; i++)
		{
			file_text_write_string(file, -1);
			file_text_writeln(file);
		}
		file_text_close(file);
	}
	
	// Else read the data from it
	else
	{	
		// Open file
		var file = file_text_open_read(filename);
		
		// Read data
		var data	
		for(var i = 0; i < 6; i++)
		{
		  data[i] = enigma_decode(file_text_read_string(file));
		  file_text_readln(file);
		}
		
		/* NOTE: it loads the data in next order (as saved):
		0 - Character;
		1 - Zone;
		2 - Act;
		3 - Score;
		4 - Lives;
		5 - Continues;
		*/
		
		// Close the file and return loaded data
		file_text_close(file);
		return data;
	}
}