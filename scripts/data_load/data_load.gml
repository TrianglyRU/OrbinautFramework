/// @function data_load(slot)
function data_load(slot)
{	
	var filename = "saveslot" + string(slot) + ".txt", file, i;
	if file_exists(filename)
	{
		file = file_text_open_read(filename);
		for(i = 0; i < 4; i++)
		{
			Game.SaveSlot[slot][i] = enigma_decode(file_text_read_string(file));
			file_text_readln(file);
		}
		file_text_close(file);
	}
}