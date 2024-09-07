/// @function scr_player_jump
function scr_player_jump()
{
	gml_pragma("forceinline");
	
	if !is_jumping
	{
		exit;
	}

	if !input_down.action_any
	{
		vel_y = max(vel_y, jump_min_vel);
	}

	if vel_y < jump_min_vel || player_index > 0 && cpu_timer_input == 0
	{
		exit;
	}

	// Handle transformation if conditions are met
	if input_press.action3 && super_timer == 0 && global.player_rings >= 50 && global.emerald_count == 7
	{
		m_player_reset();
		audio_play_sfx(sfx_transform);
		audio_play_bgm(bgm_super);
		state = PLAYER_STATE_NO_CONTROL;
		animation = ANI_TRANSFORM;
		action = ACTION_TRANSFORM;
		inv_frames = 0;
		item_inv_timer = 0;
		super_timer = 1;
		transform_timer = global.player_physics >= PHYSICS_S3 ? 26 : 36;
		image_alpha = 1.0;
		
		// Exit the player control routine
		return true;
	}

	// Handle actions based on PlayerType
	switch PlayerType
	{
		case PLAYER_SONIC:
			
			// Drop Dash initiation
			if global.drop_dash && action == ACTION_NONE && shield_state == SHIELD_STATE_NONE && !input_down.action_any
			{
				if shield <= SHIELD_NORMAL || super_timer > 0 || item_inv_timer > 0
				{
					action = ACTION_DROPDASH;
					dropdash_charge = 0;
				}
			}
			
			if !input_press.action_any || shield_state != SHIELD_STATE_NONE || super_timer > 0 || item_inv_timer > 0
			{
				break;
			}

			shield_state = SHIELD_STATE_ACTIVE;
			air_lock_flag = false;
			
			// Barrier action
			switch shield
			{
				case SHIELD_NONE:
				
					if !global.double_spin
					{
						break;
					}

					with obj_double_spin if TargetPlayer == other.id
					{
						instance_destroy();
					}
					
					shield_state = SHIELD_STATE_DOUBLESPIN;
					instance_create(0, 0, obj_double_spin, { TargetPlayer: id });
					audio_play_sfx(sfx_double_spin);
					
				break;

				case SHIELD_BUBBLE:
				
					vel_x = 0;
					vel_y = 8;
					
					with obj_shield if TargetPlayer == other.id
					{
						ani_update(0, true, [1, 2], [6, 18], 1);
					}
					
					audio_play_sfx(sfx_shield_bubble2);
					
				break;

				case SHIELD_FIRE:
				
					m_player_set_camera_delay(16);
					
					air_lock_flag = true;
					vel_x = 8 * facing;
					vel_y = 0;
					
					with obj_shield if TargetPlayer == other.id
					{
						var _order = 
						[
							0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3
						];
						
						var _dash_sprite = spr_obj_shield_fire_dash;
						
						if sprite_index == _dash_sprite
						{
							ani_update_frame(0);
						}
						else
						{
							ani_start(_dash_sprite, 2, 0, 11, _order);
						}
						
						obj_set_priority(1);
					}
					
					audio_play_sfx(sfx_shield_fire2);
					
				break;

				case SHIELD_LIGHTNING:
				
					shield_state = SHIELD_STATE_DISABLED;
					vel_y = -5.5;
					
					for (var i = 0; i < 4; i++)
					{
						instance_create(x, y, obj_shield_sparkle, { SparkleID: i });
					}
					
					audio_play_sfx(sfx_shield_lightning2);
					
				break;
			}
			
		break;
	
		// Flight initiation
		case PLAYER_TAILS:
		
			if action != ACTION_NONE || !input_press.action_any
			{
				break;
			}
			
			carry_target = noone;
			air_lock_flag = false;
			is_jumping = false;
			grv = PARAM_GRV_TAILS_DOWN;
			action = ACTION_FLIGHT;
			flight_timer = 480;
			ascend_timer = 0;
			radius_x = radius_x_normal;
			radius_y = radius_y_normal;
			
			if !is_underwater
			{
				audio_play_sfx(sfx_flight);
			}
			
			input_down.action_any = false;
			input_press.action_any = false;
			
		break;
	
		// Glide initiation
		case PLAYER_KNUCKLES:
		
			if action != ACTION_NONE || !input_press.action_any
			{
				break;
			}
			
			animation = ANI_GLIDE_AIR;	
			action = ACTION_GLIDE;
			action_state = GLIDE_STATE_AIR;
			air_lock_flag = false;
			is_jumping = false;
			spd_ground = 4;
			glide_value = 0;
			glide_angle = facing == DIRECTION.NEGATIVE ? 0 : 180;
			radius_x = 10;
			radius_y = 10;
			vel_x = 0;
			vel_y = max(0, vel_y + 2);
			
		break;
		
		// Hammer Spin initiation
		case PLAYER_AMY:
		
			if action != ACTION_NONE || !input_press.action_any
			{
				break;
			}
			
			if global.no_roll_lock
			{
				air_lock_flag = false;
			}
			
			action = ACTION_HAMMERSPIN;
			dropdash_charge = 0;
			audio_play_sfx(sfx_hammer);
			
		break;
	}
}