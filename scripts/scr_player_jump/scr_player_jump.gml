/// @self obj_player
function scr_player_jump()
{
	if !is_jumping
	{
		return false;
	}
	
	if !input_down_action_any()
	{
		vel_y = max(vel_y, jump_min_vel);
	}
	
	if vel_y < jump_min_vel || player_index > 0 && cpu_control_timer == 0
	{
		return false;
	}
	
	if input_press.action3 && super_timer == 0 && global.player_rings >= 50 && global.emerald_count == 7
	{
		audio_sfx_play(snd_transform);
		audio_bgm_play(snd_bgm_super_character);
		
		reset_substate();
		state = PLAYER_STATE.NO_INTERACT;
		animation = ANIM.TRANSFORM;
		action = ACTION.TRANSFORM;
		inv_frames = 0;
		item_inv_timer = 0;
		super_timer = 1;
		transform_timer = global.player_physics >= PHYSICS.S3 ? 26 : 36;
		image_alpha = 1;
		
		// Exit the player control routine
		return true;
	}

	switch player_type
	{
		case PLAYER.SONIC:
			
			var _shield = global.player_shields[player_index];
			
			if global.drop_dash && action == ACTION.NONE && shield_state == SHIELD_STATE.NONE && !input_down_action_any()
			{
				if super_timer > 0 || item_inv_timer > 0 || _shield <= SHIELD.NORMAL
				{
					action = ACTION.DROP_DASH;
					dropdash_charge = 0;
				}
			}
			
			if !input_press_action_any() || shield_state != SHIELD_STATE.NONE || super_timer > 0 || item_inv_timer > 0
			{
				break;
			}
			
			switch _shield
			{
				case SHIELD.NONE:
				
					if !global.double_spin
					{
						break;
					}
					
					with obj_double_spin
					{
						if player == other.id
						{
							instance_destroy();
						}
					}
					
					shield_state = SHIELD_STATE.DOUBLE_SPIN;
					air_lock_flag = false;
					
					with instance_create(x, y, obj_double_spin)
					{
						player = other.id;
					}
					
					audio_sfx_play(snd_double_spin);
					
				break;

				case SHIELD.BUBBLE:
				
					shield_state = SHIELD_STATE.ACTIVE;
					air_lock_flag = false;
					vel_x = 0;
					vel_y = 8;
					
					with obj_shield
					{
						if player == other.id
						{
							bubble_shield_drop_animation();
						}
					}
					
					audio_sfx_play(snd_shield_bubble_2);
					
				break;

				case SHIELD.FIRE:
					
					set_camera_delay(16);
					shield_state = SHIELD_STATE.ACTIVE;
					air_lock_flag = true;
					vel_x = 8 * facing;
					vel_y = 0;
					
					with obj_shield
					{
						if player == other.id
						{
							var _dash_sprite = spr_shield_fire_dash;
							
							if sprite_index != _dash_sprite
							{
								animator.start(_dash_sprite, 0, 11, 2);
							}
							else
							{
								animator.restart();
							}
							
							depth = draw_depth(10);
						}
					}
					
					audio_sfx_play(snd_shield_fire_2);
					
				break;

				case SHIELD.LIGHTNING:
				
					shield_state = SHIELD_STATE.DISABLED;
					air_lock_flag = false;
					vel_y = -5.5;
					
					for (var _i = 0; _i < 4; _i++)
					{
						with instance_create(x, y, obj_shield_sparkle)
						{
							sparkle_index = _i;
						}
					}
					
					audio_sfx_play(snd_shield_lightning_2);
					
				break;
			}
			
		break;
		
		case PLAYER.TAILS:
		
			if action != ACTION.NONE || !input_press_action_any()
			{
				break;
			}
			
			grv = PARAM_GRV_TAILS_DOWN;
			carry_target = noone;
			air_lock_flag = false;
			is_jumping = false;
			action = ACTION.FLIGHT;
			flight_timer = 480;
			ascend_timer = 0;
			radius_x = radius_x_normal;
			radius_y = radius_y_normal;
			
			input_down.action1 = false;
			input_down.action2 = false;
			input_down.action3 = false;
			input_press.action1 = false;
			input_press.action2 = false;
			input_press.action3 = false;
			
		break;
		
		case PLAYER.KNUCKLES:
		
			if action != ACTION.NONE || !input_press_action_any()
			{
				break;
			}
			
			animation = ANIM.GLIDE_AIR;	
			action = ACTION.GLIDE;
			action_state = GLIDE_STATE.AIR;
			air_lock_flag = false;
			is_jumping = false;
			spd = 4;
			glide_value = 0;
			glide_angle = facing < 0 ? 0 : 180;
			radius_x = radius_x_normal + 1;
			radius_y = radius_x;
			vel_x = 0;
			vel_y = max(0, vel_y + 2);
			
		break;
		
		case PLAYER.AMY:
		
			if action != ACTION.NONE || !input_press_action_any()
			{
				break;
			}
			
			if !global.roll_lock
			{
				air_lock_flag = false;
			}
			
			action = ACTION.HAMMER_SPIN;
			dropdash_charge = 0;
			
			audio_sfx_play(snd_hammer);
			
		break;
	}
	
	return false;
}