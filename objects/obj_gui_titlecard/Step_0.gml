if timer <= 96
{
    if timer == 96
    {
        speed_x *= 2;
        speed_y *= 2;
		
		if obj_game.fade_state == FADE_STATE.PLAIN_COLOUR
		{
			fade_perform_black(FADE_DIRECTION.IN, 1);
			
			// Do not update during the fade transition
			max_allowed_game_state = GAME_STATE.STOP_OBJECTS;
		}
		else FOR_EACH_CAMERA
		{
			// Instantly adjust the camera bounds to the stage bounds
			obj_rm_stage.camera_bound_speed[_c] = ACT_TRANSITION_BOUND_SPEED;
			
			var _camera_data = view_data[_c];
			
			if _camera_data != undefined
			{
				_camera_data.allow_updates = true;
			}
		}
    }
    else if timer >= 8
    {
        offset_banner = min(offset_banner + speed_y, 0);
        offset_zonename = max(offset_zonename - speed_x, 0);
        offset_zone = max(offset_zone - speed_x, 0);
        offset_act = max(offset_act - speed_x, 0);
    }
}
else
{
    if timer == 152
    {
        instance_destroy(); obj_game.allow_pause = true;
    }
    else if timer >= 120
    {
        offset_zonename -= speed_x;
        offset_zone += speed_x;
        offset_act += speed_x;
    }
    else
    {
        offset_banner -= speed_y;
    }
}

timer++;