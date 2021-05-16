/// @function animation_get_frame(objectID)
function animation_get_frame(objectID)
{
	// Return actual frame index
	return objectID.image_index + 1;
}