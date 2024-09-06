switch state
{
	case SIGNPOST_STATE_IDLE:
	
		// Check if the player is within range and under control
		var _player = player_get(0);
		var _dist = _player.x - x;
		
		if _dist < 0 || _dist >= 32 || _player.state >= PLAYER_STATE_NO_CONTROL
		{
			break;
		}
		
		audio_play_sfx(sfx_signpost);
		
		obj_gui_hud.update_timer = false;
		
		with obj_player
		{
			if player_index == 0 && super_timer > 0
			{
				audio_play_bgm(c_stage.bgm_track);
			}
			
			super_timer = -1;
		}
		
		player_object = _player;
		player_object_type = _player.PlayerType;	
		sign_char_frame += player_object_type;
		state = SIGNPOST_STATE_ROTATE;
		
		break;
	
	case SIGNPOST_STATE_ROTATE:
	
		// Handle rotation and animation
		if --sign_spin_timer < 0
		{
			switch ++sign_spin_cycle
			{
				case 1:
					ani_start(sprite_index, 2, 1, 0, [0, 2, 1, 3]);
					break;
				
				case 2:
					ani_update(0, true, [sign_char_frame, 2, 1, 3], undefined, 0);
					break;
				
				case 3:
					state = SIGNPOST_STATE_MOVE_PLAYER;
					ani_update(sign_char_frame, true, [], 0, 0);
					ani_stop();
					
					// Clear input for all players
					with obj_player
					{
						cpu_timer_input = 0;
						input_no_control = true;
						input_down = input_create();
						input_press = input_create();
					}
					
					break;
			}
			
			sign_spin_timer = 60;
		}
		
		// Handle ring sparkle effects
		if --ring_sparkle_timer >= 0
		{
			break;
		}
		
		var _off_x = ring_sparkle_pos[ring_sparkle_id];
		var _off_y = ring_sparkle_pos[ring_sparkle_id + 8];
		
		instance_create(x + _off_x, y + _off_y, obj_sparkle);
		
		if ++ring_sparkle_id > 7
		{
			ring_sparkle_id = 0;
		}
		
		ring_sparkle_timer = 12;
		
	break;
	
	case SIGNPOST_STATE_MOVE_PLAYER:
	
		// Force player 1 to move
		if player_object.state < PLAYER_STATE_NO_CONTROL
		{
			player_object.input_down.right = true;
		}
		
		if player_object.x >= c_stage.bound_end - 24
		{
			instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_results);		
			state++;
		}
		
	break;
}