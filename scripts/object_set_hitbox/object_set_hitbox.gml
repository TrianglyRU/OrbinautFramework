/// @function object_set_hitbox(xradius, yradius)
function object_set_hitbox(xradius, yradius)
{	
	// Get object centre
	var xcentre = sprite_get_width(sprite_index) / 2;
	var ycentre = sprite_get_height(sprite_index)/ 2;
	
	// Set sprite hotspot in the centre if it is not, and adjust its position
	if sprite_get_xoffset(sprite_index) != xcentre or sprite_get_yoffset(sprite_index) != ycentre
	{
		sprite_set_offset(sprite_index, sprite_width / 2, sprite_height / 2);
		x += xcentre - sprite_get_xoffset(sprite_index);
		y += ycentre - sprite_get_yoffset(sprite_index);
	}
	
	// Set our hitbox
	sprite_set_bbox(sprite_index, xcentre - xradius, ycentre - yradius, xcentre * 2 - (xcentre - xradius + 1), ycentre * 2 - (ycentre - yradius + 1));
}