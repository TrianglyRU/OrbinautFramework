/// @function scr_player_movement_air
function scr_player_movement_air()
{
	if action == ACTION_CARRIED || action == ACTION_CLIMB || action == ACTION_SPINDASH 
	|| action == ACTION_DASH || action == ACTION_GLIDE && action_state != GLIDE_STATE_FALL
	{
		exit;
	}
	
	// Adjust angle based on its value
	if angle != 0
	{
		if angle >= 180
		{
			angle += 2.8125;
		}
		else
		{
			angle -= 2.8125;
		}
		if angle < 0 || angle >= 360
		{
			angle = 0;
		}
	}

	// Adjust vertical velocity
	if !is_jumping && action != ACTION_SPINDASH && !forced_roll
	{
		vel_y = max(-15.75, vel_y);
	}

	if global.player_physics == PHYSICS_CD
	{
		vel_y = min(vel_y, 16);
	}
	
	if action == ACTION_HAMMERDASH
	{
		exit;
	}

	// Update horizontal velocity and facing direction
	if !air_lock_flag
	{
		if input_down.left
		{
			if vel_x > 0 
			{
				vel_x -= acc_air;
			}
			else if !global.no_speed_cap || vel_x > -acc_top
			{
				vel_x = max(vel_x - acc_air, -acc_top);
			}
			
			facing = DIRECTION.NEGATIVE;
		}
		
		if input_down.right
		{
			if vel_x < 0 
			{
				vel_x += acc_air;
			} 
			else if !global.no_speed_cap || vel_x < acc_top
			{
				vel_x = min(vel_x + acc_air, acc_top);
			}
			
			facing = DIRECTION.POSITIVE;
		}	
	}
	
	// Apply some kind of air drag when falling down slowly
	if vel_y < 0 && vel_y > -4
	{
		vel_x -= floor(vel_x / 0.125) / 256;
	}
}