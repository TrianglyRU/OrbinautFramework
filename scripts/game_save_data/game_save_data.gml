/// @self
/// @description					Saves game data to the specified save slot.
/// @param {Real|Undefined} _slot	The slot index to save data to.
function game_save_data(_slot)
{
	if _slot == undefined || _slot < 0
	{
		return;
	}

	var _filename = "save" + string(_slot) + ".bin";
	var _file = file_bin_open(_filename, 1);
	
	file_bin_rewrite(_file);
	file_bin_write_byte(_file, global.game_progress_flag);
	file_bin_write_byte(_file, global.player_main);
	file_bin_write_byte(_file, global.player_cpu);
	file_bin_write_byte(_file, global.emerald_count);
	file_bin_write_byte(_file, global.continue_count);
	file_bin_write_byte(_file, global.life_count);
	file_bin_write_byte(_file, global.score_count % 100);
	file_bin_write_byte(_file, floor(global.score_count / 100) % 100);
	file_bin_write_byte(_file, floor(global.score_count / 10000) % 100);
	file_bin_write_byte(_file, floor(global.score_count / 1000000) % 100);
	file_bin_close(_file);
	
	instance_create(0, 0, obj_gui_save);
}
