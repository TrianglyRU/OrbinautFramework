/// @function animation_set(objSprite, aniSpeed, doLoop) 
function animation_set(objSprite, aniSpeed, doLoop) 
{	
	// First check if correct speed type is set for the sprite we call
	if sprite_get_speed_type(objSprite) != spritespeed_framespergameframe || sprite_get_speed(objSprite) != 1
	{
		sprite_set_speed(objSprite, 1, spritespeed_framespergameframe);
	}
	
	// Then update the sprite for this instance and apply animation speed
	if sprite_index != objSprite
	{
		image_index  = 0;
		sprite_index = objSprite;
	}
	image_speed = aniSpeed > 0 ? 1 / aniSpeed : 0;	
	
	// Do not loop if doLoop is false
	if !doLoop
	{
		if image_index >= image_number - 1
		{
			image_speed = 0;
		}
	}
}