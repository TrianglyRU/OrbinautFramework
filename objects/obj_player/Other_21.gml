/// @description Begin Step (Post-Framework)
var _plc = global.precise_player_level_collision;

scr_player_input();

switch state
{
	case PLAYER_STATE.DEFAULT:
	case PLAYER_STATE.MANUAL_INTERACT:
	case PLAYER_STATE.MANUAL_NO_INTERACT:
		
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_parameters();
		scr_player_cpu();
		
		if state == PLAYER_STATE.DEFAULT
		{
			if action != ACTION.CARRIED
			{
				switch is_grounded
				{
					// Grounded
					case true:
				
						if scr_player_spin_dash() || scr_player_dash() || scr_player_jump_start()
						{
							break;
						}
					
						scr_player_hammer_dash();
						
						if animation == ANIM.SPIN
						{
							scr_player_slope_resist_roll();
							scr_player_movement_ground_roll();
						}
						else
						{
							scr_player_slope_resist();
							scr_player_movement_ground_regular();
							scr_player_balance();
						}
						
						var _substeps = _plc ? clamp(floor(abs(spd / TILE_SUB_SIZE)), 1, TILE_SUB_SIZE) : 1;
						var _substep = 1;
						
						repeat _substeps
						{
							scr_player_collision_ground_walls(_substeps, _substep++);
						}
						
						scr_player_roll_start();
						
						if scr_player_level_bound()
						{
							break;
						}
						
						_substep = 1;
						
						repeat _substeps
						{
							scr_player_position(_substeps);
							
							// Do not run floor collision if the player loses the ground during a substep
							if is_grounded 
							{
								scr_player_collision_ground_floor(_substeps, _substep++);
							}
						}
						
						scr_player_slope_repel();
				
					break;
					
					// Airborne
					case false:
						
						if scr_player_jump()
						{
							break;
						}
						
						scr_player_drop_dash();
						scr_player_flight();
						scr_player_climb();
						scr_player_glide();
						scr_player_hammer_spin();
						scr_player_hammer_dash();
                        
						scr_player_movement_air();
						
						if scr_player_level_bound()
						{
							break;
						}
						
						var _substeps = _plc ? clamp(floor(max(abs(vel_x / TILE_SUB_SIZE), abs(vel_y / TILE_SUB_SIZE))), 1, TILE_SUB_SIZE) : 1;
						var _substep = 1;
						
						repeat _substeps
						{
							scr_player_position(_substeps, _substep++);
							
							if action == ACTION.GLIDE 
							{
								scr_player_collision_air_glide();
							}
							else if action != ACTION.CLIMB
							{
								scr_player_collision_air_regular();
							}

							// Exit the substep loop once the player lands
							if is_grounded
							{
								break;
							}
						}
				
					break;
				}
			}
			
			scr_player_carry();
		}
		
		scr_player_water();
		scr_player_update_status();
		scr_player_animate();
		scr_player_update_hitbox();

		record_data(0);
		
	break;

	case PLAYER_STATE.HURT:
		
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_level_bound();
		
		var _substeps = _plc ? clamp(floor(max(abs(vel_x / TILE_SUB_SIZE), abs(vel_y / TILE_SUB_SIZE))), 1, TILE_SUB_SIZE) : 1;
		var _substep = 1;
		
		repeat _substeps
		{
			scr_player_position(_substeps, _substep++);
			scr_player_collision_air_regular();

			// Exit the substep loop once the player lands
			if is_grounded
			{
				break;
			}
		}
		
		scr_player_animate();
		scr_player_update_hitbox();
		
		record_data(0);
		
	break;

	case PLAYER_STATE.DEATH:
		
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_death();
		scr_player_position();
		scr_player_animate();
		scr_player_update_hitbox();
		
		record_data(0);
		
	break;

	case PLAYER_STATE.DEBUG_MODE:
		scr_player_debug_mode();
	break;
	
	case PLAYER_STATE.RESPAWN:
		
		// Don't do anything until the camera finds us
		if view_data_ref.vel_x == 0 && view_data_ref.vel_y == 0
		{
			state = PLAYER_STATE.DEFAULT;
		}
		
	break;
}

scr_player_palette();

// Reset flag
interact_flag = true;