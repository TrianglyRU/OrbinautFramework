/// @function animation_set(spriteid,frame)
function animation_set(spriteid,frame)
{
	// Update sprite and set frame index
	if sprite_index != spriteid
	{
		sprite_index = spriteid;
	}
	image_index = frame;
}