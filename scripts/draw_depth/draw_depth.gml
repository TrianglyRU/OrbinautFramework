/// @self
/// @description					Calculates a draw depth aligned to the nearest layer, with a custom priority offset.
/// @param {Real} _priority			The priority offset to add to the floored depth.
/// @param {Real} [_relative_depth]	The base depth to align (default is current depth).
/// @returns {Real}
function draw_depth(_priority, _relative_depth = depth)
{
	return floor(_relative_depth / 100) * 100 + _priority;
}