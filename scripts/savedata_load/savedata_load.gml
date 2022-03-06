/// @function savedata_load(slot)
function savedata_load(slot)
{
	/* It is not recommended to modify saveslot file to save/load additional data.
	You'd want to create additional file in that case */
	
	// Get savedata file name
	var Filename = "saveslot" + string(slot + 1) + ".bin";
	
	if file_exists(Filename)
	{	
		var File = file_bin_open(Filename, 0);
		
		/* The function reads data in the following order:
		- Character
		- Stage
		- Emeralds
		- Lives
		- Continues
		- SaveState (game clear flag)
		- Score (split into 4 values) */
		
		// Read data
		var Data;
		for (var i = 0; i <= 6; i++)
		{
			if i < 6
			{
				Data[i] = file_bin_read_byte(File);
			}
			
			// Read score
			else
			{
				Data[i] = 0;
				for (var  j = 0; j < 4; j++) 
				{
					Data[i] += file_bin_read_byte(File) * power(100, j);
				}
			}
		}
		file_bin_close(File);
		
		return Data;
	}
	else
	{		
		return 0;
	}
}