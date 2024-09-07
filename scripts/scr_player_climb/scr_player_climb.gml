/// @function scr_player_climb
function scr_player_climb()
{
	gml_pragma("forceinline");
	
	if action != ACTION_CLIMB
	{
		exit;
	}

	var STEPS_PER_CLIMB_VALUE = 4;
	
	// Handle climbing logic based on the current state
	switch action_state
	{
		case CLIMB_STATE_NORMAL:
	
			if x != xprevious || vel_x != 0
			{
				m_player_glide_release(1);
				break;
			}

			var _max_animation_value = image_number * STEPS_PER_CLIMB_VALUE;
		
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
		
			var _radius_x = radius_x;
			
			// If facing left, extend our horizontal radius by one pixel
			if facing == DIRECTION.NEGATIVE
			{
				_radius_x++;
			}
		
			if vel_y < 0
			{
				var _wall_dist = tile_find_h(x + _radius_x * facing, y - radius_y - 1, facing, tile_layer)[0];
			
				// If the wall is far away from Knuckles then he must have reached a ledge, make him climb up onto it
				if _wall_dist >= 4
				{
					action_state = CLIMB_STATE_LEDGE;
					vel_y = 0;
					grv = 0;
					break;
				}
				
				// If Knuckles has encountered a small dip in the wall, cancel climb movement
				if _wall_dist != 0
				{
					vel_y = 0;
				}
			
				var _ceil_dist = tile_find_v(x + _radius_x * facing, y - radius_y_normal + 1, DIRECTION.NEGATIVE, tile_layer)[0];
				
				// If Knuckles has bumped into the ceiling, cancel climb movement and push him out
				if _ceil_dist < 0
				{
					y -= _ceil_dist;
					vel_y = 0;
				}
			}
			else
			{
				var _wall_dist = tile_find_h(x + _radius_x * facing, y + radius_y + 1, facing, tile_layer)[0];
				
				// If Knuckles is no longer against the wall, make him let go
				if _wall_dist != 0
				{
					m_player_glide_release(1);
					break;
				}
				
				var _floor_data = tile_find_v(x + _radius_x * facing, y + radius_y_normal, DIRECTION.POSITIVE, tile_layer);
				var _floor_dist = _floor_data[0];
				var _floor_angle = _floor_data[1];
				
				// If Knuckles has reached the floor, make him land
				if _floor_dist < 0
				{
					m_player_land();
					
					y += _floor_dist + radius_y;
					angle = _floor_angle;
					animation = ANI_IDLE;
					vel_y = 0;
					break;
				}
			}
			
			// Jump
			if input_press.action_any
			{
				animation = ANI_SPIN;
				action = ACTION_NONE;
				is_jumping = true;		
				facing *= -1;
				vel_x = 3.5 * facing;
				vel_y = jump_min_vel;
				radius_x = radius_x_spin;
				radius_y = radius_y_spin;
				
				audio_play_sfx(sfx_jump);
				m_player_reset_gravity();
				break;
			}
			
			// Update animation frame if climbing
			if vel_y != 0
			{
				ani_update_frame(floor(climb_value / STEPS_PER_CLIMB_VALUE), false);
			}
	
		break;
	
		case CLIMB_STATE_LEDGE:
			
			if animation != ANI_CLIMB_LEDGE
			{
				animation = ANI_CLIMB_LEDGE;
				x += 3 * facing;
				y -= 3;
			}
			else if ani_get_frame_change()
			{
				switch ani_get_frame()
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
			else if ani_get_ended()
			{
				m_player_land();
				
				animation = ANI_IDLE;
				x += 8 * facing;
				y += 4;
				
				if facing == DIRECTION.NEGATIVE
				{
					x--;
				}
			}
	
		break;
	}
}
