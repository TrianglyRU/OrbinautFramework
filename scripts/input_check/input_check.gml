/// @self
/// @description		Retrieves the current input state (held down) for the specified slot.
/// @param {Real} _slot	The input slot number.
/// @returns {Struct}
function input_check(_slot)
{
	return obj_game.input_down[| _slot];
}