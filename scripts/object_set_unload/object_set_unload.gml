/// @function object_set_unload(unload_type)
function object_set_unload(unload_type)
{
	// Set object flags
	Obj_UnloadData   = [x, y, image_xscale, image_yscale];
	Obj_UnloadStatus = unload_type;
	Obj_UnloadFlag   = false;
}