/// @function gamedata_save(slot,character,zone,emeralds,lives,continues,score)
function gamedata_save(slot,character,zone,emeralds,lives,continues,score)
{
	// Get savedata file name
	var filename = "saveslot" + string(slot) + ".bin";
	
	// Open the file and save/rewrite data
	var file = file_bin_open(filename, 1);
	if  file
	{
		file_bin_rewrite(file);
		
		// Save basic data
		file_bin_write_byte(file, character); 
		file_bin_write_byte(file, zone);	  
		file_bin_write_byte(file, emeralds); 
		file_bin_write_byte(file, lives);
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