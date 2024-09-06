var _parent = data_culling.parent_object;

// Destroy if parent is set but does not exist
if _parent != noone && !instance_exists(_parent)
{
	instance_destroy();
}