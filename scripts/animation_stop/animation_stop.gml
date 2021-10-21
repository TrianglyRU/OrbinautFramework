/// @function animation_stop(frame,time)
function animation_stop(frame,time)
{
	if time != 0
	{
		if !is_array(image_duration)
		{
			image_timer = image_duration;
		}
		else
		{
			image_timer    = image_duration[sprite_index];
		}
	}
	else
	{
		image_duration = 0;
		image_timer    = 0;
	}
	image_stoptime = time;
	image_index    = frame;
}