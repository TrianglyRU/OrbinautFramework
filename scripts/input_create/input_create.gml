/// @self
/// @description Creates a new input structure.
/// @returns {Struct}
function input_create()
{
	return
	{
		up: false,
		down: false,
		left: false,
		right: false,
		action1: false,
		action2: false,
		action3: false,
		action_any: false,
		start: false
	};
}