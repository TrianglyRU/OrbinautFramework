/// @function instance_create(x,y,obj)
function instance_create(x,y,obj)
{
	// A shortcut to the following function, as we set object depth via object_set_depth() function
	return instance_create_depth(x, y, depth, obj);
}