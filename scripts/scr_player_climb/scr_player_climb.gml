/// @self obj_player
function scr_player_climb()
{
	if action != ACTION.CLIMB
	{
		return;
	}

	var _steps_per_climb_frame = 4;
	
	switch action_state
	{
		case CLIMB_STATE.NORMAL:
		
			if x != xprevious || vel_x != 0
			{
				release_glide(1);
				break;
			}
			
			var _max_animation_value = image_number * _steps_per_climb_frame;
			
			if input_down.up
			{
				if ++climb_value > _max_animation_value
				{
					climb_value = 0;
				}
				
				vel_y = -acc_climb;
			}
			else if input_down.down
			{
				if --climb_value < 0
				{
					climb_value = _max_animation_value;
				}
				
				vel_y = acc_climb;
			}
			else
			{
				vel_y = 0;
			}
			
			var _radius_x = facing >= 0 ? radius_x - 1 : -radius_x;		
			
			if vel_y < 0
			{
				var _wall_dist = tile_raycast_h(x + _radius_x, y - radius_y - 1, facing, secondary_layer)[0];
				
				if _wall_dist >= 4
				{
					animation = ANIM.CLIMB_LEDGE;
					action_state = CLIMB_STATE.LEDGE;
					vel_y = 0;
					grv = 0;
					
					x += 3 * facing;
					y -= 4;
					
					break;
				}
				
				if _wall_dist != 0
				{
					vel_y = 0;
				}
				
				// Original game adds 1 to y coordinate for some reason...
				var _ceil_dist = tile_raycast_v(x + _radius_x, y - radius_y_normal + 1, -1, secondary_layer)[0];
				
				if _ceil_dist < 0
				{
					y -= _ceil_dist;
					vel_y = 0;
				}
			}
			else
			{
				var _wall_dist = tile_raycast_h(x + _radius_x, y + radius_y, facing, secondary_layer)[0];
				
				if _wall_dist != 0
				{
					release_glide(1);
					break;
				}
				
				var _floor_data = tile_raycast_v(x + _radius_x, y + radius_y_normal - 1, 1, secondary_layer);
				var _floor_dist = _floor_data[0];
				var _floor_angle = _floor_data[1];
				
				if _floor_dist < 0
				{
					land();
					vel_y = 0;
					animation = ANIM.IDLE;
					angle = _floor_angle;
					y += _floor_dist + radius_y;
					
					break;
				}
			}
			
			if input_press_action_any()
			{
				animation = ANIM.SPIN;
				action = ACTION.NONE;
				is_jumping = true;		
				facing *= -1;
				vel_x = 3.5 * facing;
				vel_y = jump_min_vel;
				radius_x = radius_x_spin;
				radius_y = radius_y_spin;
				reset_gravity();
				
				audio_sfx_play(snd_jump);
				break;
			}
			
			if vel_y != 0
			{
				image_index = floor(climb_value / _steps_per_climb_frame);
			}
	
		break;
	
		case CLIMB_STATE.LEDGE:
			
			if animator.timer == animator.duration
			{
				switch image_index
				{
					case 1:
					
						x += 8 * facing;
						y -= 10;
						
					break;
				
					case 2:
					
						x -= 8 * facing;
						y -= 12;
						
					break;
				}
			}
			else if animator.timer < 0
			{
				land();
				animation = ANIM.IDLE;
				x += 8 * facing;
				y += 4;
			}
	
		break;
	}
}