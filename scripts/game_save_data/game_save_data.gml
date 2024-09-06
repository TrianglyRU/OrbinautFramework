/// @self
/// @description Saves game data to the specified save slot.
/// @param {Real} slot The number of the save slot to save data to.
function game_save_data(_slot)
{
	// Exit if the slot is invalid
	if _slot == -1
	{
		exit;
	}

	var _filename = "save" + string(_slot) + ".bin";

	// Open the file and prepare for writing
	var _file = file_bin_open(_filename, 1);
	file_bin_rewrite(_file);

	// Write game data to the file
	file_bin_write_byte(_file, global.stage_index);
	file_bin_write_byte(_file, global.player_main);
	file_bin_write_byte(_file, global.player_cpu);
	file_bin_write_byte(_file, global.emerald_count);
	file_bin_write_byte(_file, global.continue_count);
	file_bin_write_byte(_file, global.life_count);
	file_bin_write_byte(_file, global.score_count % 100);
	file_bin_write_byte(_file, floor(global.score_count / 100) % 100);
	file_bin_write_byte(_file, floor(global.score_count / 10000) % 100);
	file_bin_write_byte(_file, floor(global.score_count / 1000000) % 100);

	// Close the file and create a save confirmation object
	file_bin_close(_file);
	instance_create_depth(0, 0, 0, obj_gui_save);
}
