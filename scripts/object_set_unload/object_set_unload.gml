/// @function object_set_unload(unloadType)
function object_set_unload(unloadType)
{
	// Set object flags
	Obj_UnloadData   = [x, y, image_xscale, image_yscale, image_index, sprite_index, visible];
	Obj_UnloadStatus = unloadType;
	Obj_UnloadFlag   = false;
}