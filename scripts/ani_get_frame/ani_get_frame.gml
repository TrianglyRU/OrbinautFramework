/// @self c_object
/// @description Returns the index of the current animation frame of the object. The index may differ from the built-in `image_index` if a custom frame sequence has been set.
/// @returns {Real}
function ani_get_frame()
{
	return data_ani.index;
}