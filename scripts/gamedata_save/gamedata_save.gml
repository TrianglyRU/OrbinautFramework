/// @function gamedata_save(slot, character, zone, emeralds, score, lives, continues)
function gamedata_save(slot, character, zone, emeralds, score, lives, continues)
{
	// Get out savedata file name
	var filename = "saveslot" + string(slot) + ".txt";
	
	// Rewrite it
	if file_exists(filename)
	{
		file_delete(filename);
	}
	
	// Open the file and save data
	var file = file_text_open_write(filename);
	{
		// Save character
		file_text_write_string(file, enigma_encode(character));
		file_text_writeln(file);
	
		// Save zone
		file_text_write_string(file, enigma_encode(zone));
		file_text_writeln(file);
	
		// Save emeralds
		file_text_write_string(file, enigma_encode(emeralds));
		file_text_writeln(file);
	
		// Save score
		file_text_write_string(file, enigma_encode(score));
		file_text_writeln(file);
	
		// Save lives
		file_text_write_string(file, enigma_encode(lives));
		file_text_writeln(file);
	
		// Save conts
		file_text_write_string(file, enigma_encode(continues));
		file_text_writeln(file);
	
		// Close the file
		file_text_close(file);
	}
}