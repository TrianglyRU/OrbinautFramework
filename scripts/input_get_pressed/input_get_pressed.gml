/// @self
/// @description Retrieves the input data for the specified slot, which includes the pressed status of inputs.
/// @param {Real} slot The input slot number.
/// @returns {Struct}
function input_get_pressed(_slot)
{
	return c_framework.input.press[| _slot];
}