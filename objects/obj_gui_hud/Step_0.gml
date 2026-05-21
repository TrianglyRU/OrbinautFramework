if update_timer
{
	local_timer = obj_game.frame_counter;
}

dynamic_frame = floor((obj_game.frame_counter - 1) / 8) % 2;

// Update timer string
update_string();