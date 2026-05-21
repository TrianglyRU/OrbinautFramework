/// @self
/// @description			With this function you can delete the value from the given list without retrieving its position within it.
/// @param {Id.DsList} _id	The id of the list to change.
/// @param {Any} _value		The value to delete from the list.
/// @returns {Bool}
function ds_list_delete_value(_id, _value)
{
	var _list_pos = ds_list_find_index(_id, _value);
	
	if _list_pos != -1
	{
		ds_list_delete(_id, _list_pos);
		return true;
	}
	
	return false;
}