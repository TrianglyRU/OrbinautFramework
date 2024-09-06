/// @self
/// @description Retrieves the input data for the specified slot, which includes the held-down status of inputs.
/// @param {Real} slot The input slot number.
/// @returns {Struct}
function input_get(_slot)
{
	return c_framework.input.down[| _slot];
}