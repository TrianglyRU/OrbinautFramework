/// @function animation_set(spriteid,frame)
function animation_set(spriteid,frame)
{	
	// Update or set animation for the instance
	if sprite_index != spriteid or event_type == ev_create
	{
		Obj_AnimLoopframe = frame;
		Obj_AnimTimer     = 0;
		image_speed       = 0;
		sprite_index      = spriteid;
	}
	Obj_AnimDuration = 0;
	image_index	     = frame;
}