/// @function gamedata_load(slot)
function gamedata_load(slot)
{
	/* It is not recommended to modify saveslot file to save/load additional data.
	You'd want to create additional file for that case, like saveextra */
	
	// Get savedata file name
	var Filename = "saveslot" + string(slot + 1) + ".bin";
	
	// Check it if exists
	if file_exists(Filename)
	{	
		// Open the file
		var File = file_bin_open(Filename, 0);
		
		/* The function reads the data in following order:
		- Version (used to check for savefile compatibility)
		- Character
		- Stage (ZoneID)
		- Emeralds
		- Lives
		- Continues
		- SaveState (game clear flag)
		- Score (split into 4 values)
		*/
		
		// Read the data
		var Data;
		for (var i = 0; i <= 6; i++)
		{
			if i < 6
			{
				Data[i] = file_bin_read_byte(File);
			}
			
			// Score
			else
			{
				Data[i] = 0;
				for (var  j = 0; j < 4; j++) 
				{
					Data[i] += file_bin_read_byte(File) * power(100, j);
				}
			}
		}
		
		// Close the file
		file_bin_close(File);
		
		// Return data
		return Data;
	}
	
	// If not, return 0
	else
	{		
		return 0;
	}
}