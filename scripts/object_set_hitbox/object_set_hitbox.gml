/// @function object_set_hitbox(xradius, yradius)
function object_set_hitbox(xradius, yradius)
{	
	// Check if object's origin is its centre
	if sprite_get_xoffset(sprite_index) != sprite_get_width(sprite_index)  / 2
	or sprite_get_yoffset(sprite_index) != sprite_get_height(sprite_index) / 2
	{
		show_message("Offset of " + sprite_get_name(sprite_index) + " is not the centre of the sprite. Please, check if object's sprite has origin placed at 'middle centre'");
		game_end();
	}
	
	// Set hitbox radiusess
	objXRadiusHit = xradius;
	objYRadiusHit = yradius;
}