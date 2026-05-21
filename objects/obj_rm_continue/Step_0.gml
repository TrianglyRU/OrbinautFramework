if obj_game.fade_state != FADE_STATE.NONE
{
	return;
}

if character_main.vel_charge != 0
{
    if continue_count > 1
	{
		var _last_icon = continue_icons[continue_count - 1];
	
	    _last_icon.animator.timer = -1;
	    _last_icon.visible = obj_game.frame_counter % 2 == 0;
	}

	var _bound = camera_get_width(0) + 64;

	if character_main.x < _bound || character_buddy != noone && character_buddy.x < _bound
	{
	    return;
	}

	if global.continue_count > 0
	{
	    global.continue_count--;
	}
}
else if --time_left > 0
{
	return;
}

audio_bgm_stop(1);
fade_perform_black(FADE_DIRECTION.OUT, 1, on_fade_load_next_room);