if global.debug_collision
{
	var _mask_index = mask_index;
	
	// Solidbox
	draw_rect_floored(x - radius_wall, y - radius_y, x + radius_wall, y + radius_y, true, c_yellow);
	
	// Hitbox
	draw_rect_floored(bbox_left, bbox_top, bbox_right, bbox_bottom, true, c_fuchsia);
	
	// Extra hitbox
	if is_extra_hitbox_active()
	{
		mask_index = extra_mask;
		draw_rect_floored(bbox_left, bbox_top, bbox_right, bbox_bottom, true, c_aqua);
		mask_index = _mask_index;
	}
	
	// Position
	draw_point_floored(x, y, c_aqua);
}