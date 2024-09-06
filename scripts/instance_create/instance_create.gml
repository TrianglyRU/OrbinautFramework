/// @self
/// @description Creates a new instance of the specified object at the current depth, with optional variable definitions and parent object assignment.
/// @param {Real} x	The x-coordinate for the new instance.
/// @param {Real} y	The y-coordinate for the new instance.
/// @param {Asset.GMObject} obj	The object to create an instance of.
/// @param {Struct} [var_struct] A structure to initialise instance variables (optional, defaults to {}).
/// @param {Id.Instance} [parent] An instance to set as the parent for culling purposes (optional, defaults to noone).
/// @returns {Id.Instance}
function instance_create(_x, _y, _obj, _var_struct = {}, _parent = noone)
{
	var _new_obj = instance_create_depth(_x, _y, depth, _obj, _var_struct);
	 
	if _parent != noone
	{
		_new_obj.data_culling.behaviour = CULLING.ACTIVE;
		_new_obj.data_culling.parent_object = _parent;
	}
	
	return _new_obj;
}