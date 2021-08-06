/// @function animation_set_frame(spriteID, frameNumber)
function animation_set_frame(spriteID, frameNumber)
{
	// Set a sprite for the object
	if spriteID != false
	{
		sprite_index = spriteID;
	}
	
	// Ignore the animation method built into the IDE
	sprite_set_speed(spriteID, 0, spritespeed_framespergameframe);
	
	// Set the subimage for the specified sprite
	image_index = frameNumber - 1;
}