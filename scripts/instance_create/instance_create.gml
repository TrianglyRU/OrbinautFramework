/// @function instance_create(x,y,obj)
function instance_create(x, y, obj)
{
	return instance_create_depth(x, y, depth, obj);
}