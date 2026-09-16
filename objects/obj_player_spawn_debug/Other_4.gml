instance_destroy();

if !global.dev_mode
{
	return;
}

with obj_player
{
	x = other.x;
	y = other.y - radius_y;
	
	// Re-init some stuff from the obj_player's Create Event
	for (var _i = 0; _i < recorded_data_length; _i++)
	{
		record_data(_i);
	}
	
	if view_data_ref.index == player_index
	{
		view_data_ref.raw_x = x - camera_get_width(view_data_ref.index) * 0.5;
		view_data_ref.raw_y = y - camera_get_height(view_data_ref.index) * 0.5 + 16;
		
		obj_game.update_view_camera_pos(player_index);
	}
}