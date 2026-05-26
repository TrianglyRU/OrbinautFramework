if current_level < target_level
{
	current_level++;
}
else if current_level > target_level
{
	current_level--;
}

y = iv_oscillate ? math_oscillate_y(current_level, obj_game.oscillation_angle + 90, 10) : current_level;

obj_game.deformation_bound = y;
obj_game.palette_bound = y;

with obj_player
{
	var _water_run_level = other.y - radius_y;
	
	if !run_on_water
	{
		if vel_y == 0 && abs(vel_x) >= 7 && floor(y) == _water_run_level
		{
			run_on_water = true;
			facing = sign(vel_x);
			
			with instance_create(x, y + radius_y, obj_water_trail)
			{
				player = other.id;
			}
		}
	}	

	// S3K introduces a shortened version of the jump routine when the player is running on water
	// to account for cases where they're not actually on the ground
	else if input_press_action_any()
	{
		run_on_water = false;
		
		// S3K does not check whether we already successfully jumped while grounded. So even if we did,
		// it would still execute whatever comes next anyway (just uncomment this bruh)
		/*
		if is_jumping
		{
			return;
		}
		*/
		
		radius_x = radius_x_spin;
		radius_y = radius_y_spin;
		is_jumping = true;
		is_grounded = false;
		animation = ANIM.SPIN;
		vel_y = jump_vel;			// S3K sets vel_y directly to -6.5 (it doesn't care if the player is Knuckles, so he can jump as high as Sonic even while grounded)
		audio_sfx_play(snd_jump);	// S3K doesn't do this, so if the player actually jumped while running on water mid-air... no sound for you!
	}
	else if floor(y) >= _water_run_level && abs(vel_x) >= 7
	{
		y = _water_run_level;
		vel_y = 0;
		
		if !is_grounded && !input_press.left && !input_press.right
		{
			vel_x -= 0.046875 * sign(vel_x);
		}
	}
	else
	{
		run_on_water = false;
	}
}