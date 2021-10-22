/// @function animation_reset(frame)
function animation_reset(frame)
{
	// Reset animation
	if variable_instance_exists(id, "image_duration")
	{
		image_index = frame;
		image_timer = image_duration;
	}
}