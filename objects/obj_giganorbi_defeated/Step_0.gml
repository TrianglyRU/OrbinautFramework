if obj_game.frame_counter % 6 == 0
{
	instance_create(x + random_range(-32, 31), y + random_range(-32, 31), obj_explosion);
	audio_sfx_play(snd_explosion);
}

if timer < 120
{
	if ++timer != 120
	{
		return;
	}

	FOR_EACH_CAMERA
	{
		obj_rm_stage.right_bound[_c] = room_width;
	}

	vel_y = -3;
	culler.action = CULL_ACTION.DESTROY;
	
	player_get(0).restart_bgm(obj_rm_stage.bgm_track);
}

y += vel_y;
vel_y += 0.21875;