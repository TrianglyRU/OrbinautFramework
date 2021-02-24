/// @function data_load(slot)
function data_load(slot, action)
{	
	var filename = "saveslot" + string(slot) + ".txt", file, i;
	if file_exists(filename)
	{
		file = file_text_open_read(filename);
		for(i = 0; i < array_length(Game.SaveSlotX[slot]); i++)
		{
			Game.SaveSlotX[slot][i] = enigma(file_text_read_string(file), true);
			file_text_readln(file);
		}
		file_text_close(file);
	}
}