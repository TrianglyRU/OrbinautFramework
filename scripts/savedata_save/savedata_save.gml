/// @function savedata_save(slot)
function savedata_save(slot)
{
	/* It is not recommended to modify saveslot file to save/load additional data.
	You'd want to create additional file in that case */
	
	// Get savedata file name
	var Filename = "saveslot" + string(slot + 1) + ".bin";
	
	var File = file_bin_open(Filename, 1);
	if  File
	{
		file_bin_rewrite(File);
		
		/* The function saves data in the following order:
		- Character
		- Zone ID
		- Emeralds
		- Lives
		- Continues
		- SaveState (game clear flag)
		- Score (split into 4 values) */
		
		file_bin_write_byte(File, global.Character); 
		file_bin_write_byte(File, global.ZoneID);	  
		file_bin_write_byte(File, global.Emeralds); 
		file_bin_write_byte(File, global.Lives);
		file_bin_write_byte(File, global.Continues); 
		file_bin_write_byte(File, global.SaveState);
		file_bin_write_byte(File, global.Score             mod 100);
		file_bin_write_byte(File, global.Score div 100     mod 100);
		file_bin_write_byte(File, global.Score div 10000   mod 100);
		file_bin_write_byte(File, global.Score div 1000000 mod 100);
		
		file_bin_close(File);
	}
	
	// Update slot
	global.SaveData[slot] = savedata_load(slot);
}