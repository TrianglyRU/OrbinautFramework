/// @self
/// @description Resets all input values in the provided structure to false.
/// @param {Struct} _struct
function input_reset(_struct)
{
	_struct.up = false;
	_struct.down = false;
	_struct.left = false;
	_struct.right = false;
	_struct.action1 = false;
	_struct.action2 = false;
	_struct.action3 = false;
	_struct.start = false;
}