/// @function animation_set(spriteid,frame)
function animation_set(spriteid,frame)
{	
	// Update or set animation
	if sprite_index != spriteid or event_type == ev_create
	{
		image_timer     = 0;
		image_framedata = 0;
		image_loopframe = frame;
		sprite_index    = spriteid;
	}
	image_duration = 0;
	image_index	   = frame;
}