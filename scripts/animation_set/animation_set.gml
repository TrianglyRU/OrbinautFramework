/// @function animation_set(spriteid,frame)
function animation_set(spriteid,frame)
{	
	// Update animation
	if sprite_index != spriteid or !variable_instance_exists(id, "image_duration")
	{
		image_timer     = 0;
		image_loopframe = 0;
		sprite_index    = spriteid;
	}
	image_index	    = frame;
	image_duration  = 0;	
}