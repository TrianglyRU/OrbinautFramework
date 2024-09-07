/// @self c_object
/// @description Resets the specified object's depth (drawing priority) to its initial value.
function obj_reset_priority()
{
	depth = data_culling.priority;
}