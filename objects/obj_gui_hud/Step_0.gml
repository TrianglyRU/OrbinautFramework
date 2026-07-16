if update_timer
{
	local_timer = FRAME_COUNTER;
}

dynamic_frame = floor((FRAME_COUNTER - 1) / 8) % 2;

// Update timer string
update_string();