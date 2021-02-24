/// @function data_save(slot)
function data_save(slot)
{	
	var filename = "saveslot" + string(slot) + ".txt", file, i;
	
	file = file_text_open_write(filename);
	var values = Game.SaveSlotX[slot];
	for (i = 0; i < array_length(values); i++)
	{
		file_text_write_string(file, enigma(values[i], false));
		file_text_writeln(file);
	}
	file_text_close(file);
}