/// @self
/// @description Checks if saved data exists for the specified slot.
/// @param {Real} slot The slot number to check for saved data.
/// @returns {Bool}	
function game_check_data(_slot)
{
	if _slot == -1
	{
		return false;
	}
	
	return file_exists("save" + string(_slot) + ".bin");
}