/// @self
/// @description Resets the input data contained within the given structure.
/// @param {Struct} struct The structure containing the input data to be reset.
function input_reset(_struct)
{
	var _keys = variable_struct_get_names(_struct);
	var _length = array_length(_keys) - 1;
	
	for (var i = _length; i >= 0; i--) 
	{
		_struct[$ _keys[i]] = false;
	}
}