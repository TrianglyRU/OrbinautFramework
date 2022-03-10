/// @function object_set_unload(unloadFlag)
function object_set_unload(arg)
{
	Obj_UnloadData = [x, y, image_xscale, image_yscale, image_index, sprite_index, visible];
	Obj_UnloadType = arg;
}