switch state
{
	case SIGNPOST_STATE.IDLE:
	
		var _player = player_get(0);
		var _dist = floor(_player.x) - x;
		
		if _dist < 0 || _dist >= 32
		{
			break;
		}
		
		if _player.super_timer > 0 && instance_exists(obj_rm_stage)
		{
			audio_bgm_play(obj_rm_stage.bgm_track);
		}
		
		with obj_player
		{
			super_timer = -1;
		}
		
		obj_gui_hud.update_timer = false;
		
		state = SIGNPOST_STATE.ROTATE;
		player = _player;
		
		audio_sfx_play(snd_sign_post);
		
	break;
	
	case SIGNPOST_STATE.ROTATE:
	
		if --sign_spin_timer < 0
		{
			sign_spin_timer = 60;
			
			switch ++sign_spin_cycle
			{
				case 1:
				
					if animator.timer == 0
					{
						animator.start(sprite_index, 1, 0, 2);
					}
					
				break;
				
				case 2:
					
					if sprite_index != spr_sign_post
					{
						break;
					}
					
					var _sign_sprite;
					
					switch player.player_type
					{
						case PLAYER.TAILS:
							_sign_sprite = spr_sign_post_tails;
						break;
						
						case PLAYER.KNUCKLES:
							_sign_sprite = spr_sign_post_knuckles;
						break;
						
						case PLAYER.AMY:
							_sign_sprite = spr_sign_post_amy;
						break;
						
						// PLAYER.SONIC, others
						default:
							_sign_sprite = spr_sign_post_sonic;
					}
					
					animator.start(_sign_sprite, 0, 0, 2);
					
				break;
				
				case 3:
					
					state = SIGNPOST_STATE.CHECK_RESULTS;
					animator.clear(0);
					
				break;
			}
		}
		
		if --ring_sparkle_timer < 0
		{
			var _off_x = ring_sparkle_pos[ring_sparkle_id];
			var _off_y = ring_sparkle_pos[ring_sparkle_id + 8];
		
			instance_create(x + _off_x, y + _off_y, obj_sparkle);
			
			if ++ring_sparkle_id > 7
			{
				ring_sparkle_id = 0;
			}
			
			ring_sparkle_timer = 12;
		}
		
	break;
	
	case SIGNPOST_STATE.CHECK_RESULTS:
	case SIGNPOST_STATE.RESULTS:
		
		var _is_transition = instance_exists(obj_transition_save);
		
		if !_is_transition
		{
			with obj_player
			{
			    if state >= PLAYER_STATE.DEBUG_MODE
				{
					continue;
				}
				
				cpu_control_timer = 0;
				
				if input_lock_control
				{
					continue;
				}
				
				input_lock_control = true;
				input_down = input_create();
				input_press = input_create();
				
				if player_index == camera_data.index
				{
					input_down.right = true;
				}
			}
		}
		else
		{
			var _results_state = state;
			var _lead_player = player;
			
			with obj_player
			{
			    if !is_grounded || state >= PLAYER_STATE.DEBUG_MODE
				{
					continue;
				}
				
				if _results_state == SIGNPOST_STATE.CHECK_RESULTS || _lead_player.animation == ANIM.ACT_CLEAR
				{
					set_victory_pose();
				}
			}
		}
		
		if state == SIGNPOST_STATE.CHECK_RESULTS
		{
			if !_is_transition
			{
				if player.x < obj_rm_stage.end_bound - 24
				{
					break;
				}	
			}
			else if !player.is_grounded
			{
				break;
			}
			
			instance_create(0, 0, obj_gui_results);
			
			// Do not run these checks anymore
			state = SIGNPOST_STATE.RESULTS;
		}
		
	break;
}