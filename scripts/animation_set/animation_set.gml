/// @function animation_set(ind,frame)
function animation_set(ind,frame)
{
	// Set a sprite for the object
	if sprite_index != ind
	{
		sprite_index = ind;
	}
	
	// Ignore the animation method built into the IDE
	sprite_set_speed(ind, 0, spritespeed_framespergameframe);
	
	// Set the subimage for the specified sprite
	image_index = frame - 1;
}