/// @function object_set_hitbox(width, height)
function object_set_hitbox(width, height)
{	
	// Set sprite hotspot in the centre
	sprite_set_offset(sprite_index, sprite_width / 2, sprite_height / 2);
	
	// Set our hitbox
	sprite_collision_mask(mask_index, false, 2, x - width, y - height, x + width, y + height, bboxkind_rectangular, 0);	
}