// Called in c_framework -> Begin Step

// Handle player input
scr_player_input();

switch state
{
	case PLAYER_STATE_CONTROL:
	case PLAYER_STATE_NO_CONTROL:
		
		// Exit if entered Debug Mode
		if scr_player_debug_mode_enter()
		{
			break;  
		}
		
		scr_player_parameters();
		scr_player_cpu();
		
		if state != PLAYER_STATE_NO_CONTROL then switch is_grounded
		{
			// Grounded
			case true:
				
				// Exit if Dash or Spin Dash is released, or if a jump is initiated
				if scr_player_spindash() || scr_player_dash() || scr_player_jump_start()
				{
					break;
				}
				
				scr_player_hammerdash();
				
				if animation == ANI_SPIN
				{
					scr_player_slope_resist_roll();
					scr_player_movement_roll();
				}
				else
				{
					scr_player_slope_resist();
					scr_player_movement_ground();
					scr_player_balance();
				}
				
				scr_player_collision_ground_walls();
				
				if animation != ANI_SPIN
				{
					scr_player_roll_start();
				}
				
				scr_player_level_bound();
				scr_player_position();
				scr_player_collision_ground_floor();
				scr_player_slope_repel();
				
			break;
			
			// Airborne
			case false:
				
				// Exit if a Super transformation is initiated
				if scr_player_jump()
				{
					break;
				}
				
				scr_player_dropdash();
				scr_player_flight();
				scr_player_climb();
				scr_player_glide();
				scr_player_hammerspin();
				scr_player_hammerdash();
				scr_player_movement_air();
				scr_player_level_bound();
				
				// If carried, scr_player_collision_air() is called by the carrier's scr_player_carry()
				if action != ACTION_CARRIED
				{
					scr_player_position();
					scr_player_collision_air();
				}
				
				scr_player_glide_collision();
				
			break;
		}
		
		if state != PLAYER_STATE_DEATH
		{
			scr_player_carry();
			scr_player_water();
		}
		
		scr_player_update_status();
		scr_player_animate();
		m_player_record_data(0);
		
	break;

	case PLAYER_STATE_HURT:
		
		// Exit if entered Debug Mode
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_level_bound();
		scr_player_position();
		scr_player_collision_air();
		scr_player_animate();
		m_player_record_data(0);
		
	break;

	case PLAYER_STATE_DEATH:
		
		// Exit if entered Debug Mode
		if scr_player_debug_mode_enter()
		{
			break;
		}
		
		scr_player_death();
		scr_player_position();
		scr_player_animate();
		m_player_record_data(0);
		
	break;

	case PLAYER_STATE_DEBUG_MODE:
		scr_player_debug_mode();
	break;
	
	case PLAYER_STATE_MAIN_RESPAWN:
	
		if camera_data.vel_x == 0 && camera_data.vel_y == 0
		{
			state = PLAYER_STATE_CONTROL;
		}
		
	break;
}

// Update collision and palette
scr_player_update_collision();
scr_player_palette();