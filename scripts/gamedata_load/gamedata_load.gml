function gamedata_load(slot)
{
	// Open the file
	var filename = "saveslot" + string(slot) + ".txt";
	if file_exists(filename)
	{
		file_delete(filename);
	}
	var file = file_text_open_read(filename), data;

	// Save character
	data[0] = enigma_decode(file_text_read_string(file));
	file_text_readln(file);
	
	// Save zone
	data[1] = enigma_decode(file_text_read_string(file));
	file_text_readln(file);
	
	// Save act
	data[2] = enigma_decode(file_text_read_string(file));
	file_text_readln(file);
	
	// Save character
	data[3] = enigma_decode(file_text_read_string(file));
	file_text_readln(file);
	
	// Save character
	data[4] = enigma_decode(file_text_read_string(file));
	file_text_readln(file);
	
	// Save character
	data[5] = enigma_decode(file_text_read_string(file));
	file_text_readln(file);
	
	// Close the file
	file_text_close(file);
	
	return data;
}