/// @self
/// @description Loads the saved data for the specified slot.
/// @param {Real} slot The slot number of the saved data to load.
function game_load_data(_slot)
{
	// Check if the save file exists and handle invalid slot
	var _filename = "save" + string(_slot) + ".bin";

	if !file_exists(_filename) || _slot == -1
	{
		exit;
	}

	// Open the save file and read data
	var _file = file_bin_open(_filename, 0);

	global.stage_index = file_bin_read_byte(_file);
	global.player_main = file_bin_read_byte(_file);
	global.player_cpu = file_bin_read_byte(_file);
	global.emerald_count = file_bin_read_byte(_file);
	global.continue_count = file_bin_read_byte(_file);
	global.life_count = file_bin_read_byte(_file);

	// Calculate the total score from bytes read
	global.score_count = 0;

	for (var i = 0; i < 4; i++) 
	{
		global.score_count += file_bin_read_byte(_file) * power(100, i);
	}

	file_bin_close(_file);
}