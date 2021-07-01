/// @function gamedata_save(slot,character,zone,emeralds,lives,continues,score)
function gamedata_save(slot, character, zone, emeralds, lives, continues, score)
{
	// Get our savedata file name
	var filename = "saveslot" + string(slot) + ".bin";
	
	// Open the file and save data
	var file = file_bin_open(filename, 1);
	if  file
	{
		// Rewrite it
		file_bin_rewrite(file);
		
		// Save character
		file_bin_write_byte(file, character); 
		
		// Save zone
		file_bin_write_byte(file, zone);	  
		
		// Save emeralds
		file_bin_write_byte(file, emeralds); 
		
		// Save lives
		file_bin_write_byte(file, lives);
		
		// Save continues
		file_bin_write_byte(file, continues); 
		
		// Save score (it can be huge to save in bytes, so we split it)
		file_bin_write_byte(file, score             mod 100);
		file_bin_write_byte(file, score div 100     mod 100);
		file_bin_write_byte(file, score div 10000   mod 100);
		file_bin_write_byte(file, score div 1000000 mod 100);
		
		// Close the file
		file_bin_close(file);
	}
}