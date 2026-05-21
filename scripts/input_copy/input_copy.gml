/// @self
/// @description			Creates a duplicate of a given input struct.
/// @param {Struct} _struct	The input struct to copy.
/// @returns {Struct}
function input_copy(_struct)
{
	return
	{
		up: _struct.up,
		down: _struct.down,
		left: _struct.left,
		right: _struct.right,
		action1: _struct.action1,
		action2: _struct.action2,
		action3: _struct.action3,
		start: _struct.start
	};
}