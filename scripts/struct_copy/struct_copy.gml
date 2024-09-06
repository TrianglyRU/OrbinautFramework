/// @self
/// @description Creates a duplicate of a given struct, preserving its properties.
/// @param {Struct} struct The struct object to copy.
/// @returns {Struct}
function struct_copy(_struct)
{
	// Get all the keys from the structure
    var _keys = variable_struct_get_names(_struct);
    var _length = array_length(_keys) - 1;
	
	var _new_struct = {};
    var _key, _value;
	
    // Copy values to the new structure
    for (var i = _length; i >= 0; --i) 
    {
        _key = _keys[i];
        _value = _struct[$ _key];
        _new_struct[$ _key] = _value;
    }
	
    return _new_struct;
}