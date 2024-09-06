// Spawn explostions
if c_framework.frame_counter % 6 == 0
{
	instance_create(x + random_range(-32, 32), y + random_range(-32, 32), obj_explosion);
}

if timer < 120
{
	if ++timer != 120
	{
		exit;
	}

	for (var i = 0; i < CAMERA_COUNT; i++)
	{
		c_stage.bound_right[i] = room_width;
	}

	vel_y = -3;
	
	audio_reset_bgm(c_stage.bgm_track, player_get(0));
	obj_set_culling(CULLING.REMOVE);
}

// Fall down
y += vel_y;
vel_y += 0.21875;