function gamedata_save(slot, charAddress, zoneAddress, actAddress, scoreAddress, livesAddress, contsAddress)
{
	// Open the file
	var filename = "saveslot" + string(slot) + ".txt";
	
	if file_exists(filename)
	{
		file_delete(filename);
	}
	var file = file_text_open_write(filename);
		
	// Save character
	file_text_write_string(file, enigma_encode(charAddress));
	file_text_writeln(file);
	
	// Save zone
	file_text_write_string(file, enigma_encode(zoneAddress));
	file_text_writeln(file);
	
	// Save act
	file_text_write_string(file, enigma_encode(actAddress));
	file_text_writeln(file);
	
	// Save score
	file_text_write_string(file, enigma_encode(scoreAddress));
	file_text_writeln(file);
	
	// Save lives
	file_text_write_string(file, enigma_encode(livesAddress));
	file_text_writeln(file);
	
	// Save conts
	file_text_write_string(file, enigma_encode(contsAddress));
	file_text_writeln(file);
	
	// Close the file
	file_text_close(file);
}