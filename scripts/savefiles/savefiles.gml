/// @function savefiles(slot, action)
function savefiles(slot, action)
{
	var filename = "saveslot" + string(slot) + ".txt", file, i;
	if action = "save"
	{
		file = file_text_open_write(filename);
		var values = Game.SaveSlotX[slot];
		for(i = 0; i < array_length(values); i++)
		{
			file_text_write_string(file, enigma(values[i], false));
			file_text_writeln(file);
		}
		file_text_close(file);
	}
	else if file_exists(filename)
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