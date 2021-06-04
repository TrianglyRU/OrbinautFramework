/// @function animation_set_frame(spriteID, frameNumber)
function animation_set_frame(spriteID, frameNumber)
{
	// Set a sprite for the object
	id.sprite_index = spriteID;
	
	// Set the subimage for the specified sprite
	id.image_index  = frameNumber - 1;
}