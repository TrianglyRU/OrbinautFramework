/// @function gamedata_load(slot)
function gamedata_load(slot)
{
	// Get savedata file name
	var Filename = program_directory + "saveslot" + string(slot + 1) + ".bin";
	
	// Check it if exists
	if file_exists(Filename)
	{	
		// Open the file
		var File = file_bin_open(Filename, 0);
		
		/* The function reads the data in following order (as saved, score should be always last):
		- Character
		- Stage (ZoneID)
		- Emeralds
		- Lives
		- Continues
		- SaveState (game clear flag)
		- Score (split into 4 values)
		*/
		
		// Set amount of positions here, starting from 0:
		var DataPositions = 6;
		var Data;
		
		// Read the data
		for (var i = 0; i <= DataPositions; i++)
		{
			if i < DataPositions
			{
				Data[i] = file_bin_read_byte(File);
			}
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