/// @self
/// @description			This function can be used to add a single new value (real or string) to the list once, which will be added on at the end.
/// @param {Id.DsList} _id	The id of the list to add to.
/// @param {Any} _value		The value to add to the list.
/// @returns {Bool}
function ds_list_add_once(_id, _value)
{
	if ds_list_find_index(_id, _value) == -1
	{
		ds_list_add(_id, _value);
		return true;
	}
	
	return false;
}