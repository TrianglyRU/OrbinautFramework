/// @function object_set_unload(unloadFlag)
function object_set_unload(unloadFlag)
{
	if !variable_instance_exists(id, "Obj_UnloadState")
	{
		/* Initialise unload data only once, so we make sure it can't be overwritten. 
		This is mostly used for FlagReset unload type, which calls Create Event for the object once again */
		Obj_UnloadData  = [x, y, image_xscale, image_yscale, image_index, sprite_index, visible];
		Obj_UnloadState = true;
	}
	Obj_UnloadType = unloadFlag;
}