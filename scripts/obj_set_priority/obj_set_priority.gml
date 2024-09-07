/// @self c_object
/// @description Adjusts the object's drawing priority based on the specified priority value from 0 to 8, inclusive.
/// @param {Real} priority The desired priority level.
function obj_set_priority(_priority)
{
	// Adjust priority and update depth based on it
	_priority = clamp(round(_priority) * 10, 0, 80);

	if depth % 100 != 0
	{
		depth = floor(depth / 100) * 100 + _priority;
	}
	else
	{
		depth += _priority;
	}
	
	data_culling.priority = depth;
}