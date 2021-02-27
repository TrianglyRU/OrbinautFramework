/// @function data_save(slot)
function data_save(slot)
{	
	var filename = "saveslot" + string(slot) + ".txt", file, i;
	if (file_exists(filename)) file_delete(filename);
	file = file_text_open_write(filename);
	for (i = 0; i < 4; i++)
	{
		file_text_write_string(file, enigma_encode(Game.SaveSlot[slot][i]));
		file_text_writeln(file);
	}
	file_text_close(file);
}