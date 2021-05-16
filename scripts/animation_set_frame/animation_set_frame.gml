/// @function animation_set_frame(spriteID, frameNumber)
function animation_set_frame(spriteID, frameNumber)
{
	// Set sprite for the instance
	id.sprite_index = spriteID;
	
	// Set subimage
	id.image_index  = frameNumber - 1;
}