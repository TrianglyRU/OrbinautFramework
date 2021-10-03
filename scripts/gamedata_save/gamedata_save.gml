/// @function gamedata_save(slot)
function gamedata_save(slot)
{
	/* It is not recommended to modify saveslot file to save/load additional data.
	You'd want to create additional file for that case, like saveextra */
	
	// Get savedata file name
	var Filename = "saveslot" + string(slot + 1) + ".bin";
	
	// Open the file
	var File = file_bin_open(Filename, 1);
	if  File
	{
		// Rewrite data
		file_bin_rewrite(File);
		
		/* The function saves the data in following order:
		- Version (used to check for savefile compatibility)
		- Character
		- Stage (ZoneID)
		- Emeralds
		- Lives
		- Continues
		- SaveState (game clear flag)
		- Score (split into 4 values)
		*/
		
		// Save data
		file_bin_write_byte(File, Game.Version);
		file_bin_write_byte(File, Game.Character); 
		file_bin_write_byte(File, Game.Stage);	  
		file_bin_write_byte(File, Game.Emeralds); 
		file_bin_write_byte(File, Game.Lives);
		file_bin_write_byte(File, Game.Continues); 
		file_bin_write_byte(File, Game.SaveState);
		file_bin_write_byte(File, Game.Score             mod 100);
		file_bin_write_byte(File, Game.Score div 100     mod 100);
		file_bin_write_byte(File, Game.Score div 10000   mod 100);
		file_bin_write_byte(File, Game.Score div 1000000 mod 100);
		
		// Close the file
		file_bin_close(File);
	}
	
	// Update slot
	Game.SaveData[slot] = gamedata_load(slot);
}