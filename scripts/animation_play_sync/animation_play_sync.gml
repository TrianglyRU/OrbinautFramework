// @function animation_play_sync(ind,speed)
function animation_play_sync(ind,speed)
{	
	// Ignore the animation method built into the IDE
	sprite_set_speed(ind, 0, spritespeed_framespergameframe);
	
	// Update sprite
	if sprite_index != ind
	{
		sprite_index = ind;
		image_index  = 0;
	}
	
	// Play animation
	image_index = Stage.AnimationTime div speed mod image_number;
}