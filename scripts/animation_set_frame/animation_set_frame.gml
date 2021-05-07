/// @function animation_set_frame(spriteID, frameNumber)
function animation_set_frame(spriteID, frameNumber)
{
	id.sprite_index = spriteID;
	id.image_index  = frameNumber - 1;
}