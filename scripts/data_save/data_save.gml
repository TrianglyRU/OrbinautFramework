/// @function data_save(slot)
function data_save(slot)
{	
	var filename = "saveslot" + string(slot) + ".txt", file, i;
	
	file = file_text_open_write(filename);
	var values = Game.SaveSlot[slot];
	for (i = 0; i < array_length(values); i++)
	{
		file_text_write_string(file, enigma_encode(values[i]));
		file_text_writeln(file);
	}
	file_text_close(file);
}