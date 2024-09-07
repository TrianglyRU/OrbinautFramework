/// @self c_object
/// @description Sets the culling behavior for the specified object.
/// @param {Enum.CULLING} type The new culling behavior type to be set.
function obj_set_culling(_type)
{
	data_culling.behaviour = _type;
}