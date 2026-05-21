/// @self
/// @description					Checks if saved data exists for the specified slot.
/// @param {Real|Undefined} _slot	The slot index to check for saved data.
/// @returns {Enum.SAVE_DATA_STATE}
function game_check_data(_slot)
{
	if _slot == undefined || _slot < 0
	{
		return SAVE_DATA_STATE.EMPTY;
	}
	
	var _filename = "save" + string(_slot) + ".bin";
	
	if !file_exists(_filename)
	{
		return SAVE_DATA_STATE.EMPTY;
	}
	
	var _file = file_bin_open(_filename, 0);
	var _progress_flag = file_bin_read_byte(_file);
	
	file_bin_close(_file);
		
	if _progress_flag == GAME_PROGRESS_MAX
	{
		return SAVE_DATA_STATE.CLEAR;
	}
		
	return SAVE_DATA_STATE.EXISTS;
}