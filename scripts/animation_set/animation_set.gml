/// @function animation_set(spriteid,frame)
function animation_set(spriteid,frame)
{	
	// Update or set animation
	if sprite_index != spriteid or event_type == ev_create
	{
		image_loopframe = frame;
		image_timer     = 0;
		image_speed     = 0;
		sprite_index    = spriteid;
	}
	image_duration = 0;
	image_index	   = frame;
}