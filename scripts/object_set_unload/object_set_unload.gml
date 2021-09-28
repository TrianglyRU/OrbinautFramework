/// @function object_set_unload(type)
function object_set_unload(type)
{
	// Set object flags
	Obj_UnloadData   = [x, y, image_xscale, image_yscale];
	Obj_UnloadStatus = type;
	Obj_UnloadFlag   = false;
}