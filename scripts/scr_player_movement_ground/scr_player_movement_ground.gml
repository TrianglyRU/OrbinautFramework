/// @function scr_player_movement_ground
function scr_player_movement_ground()
{
	if action == ACTION_SPINDASH || action == ACTION_DASH || action == ACTION_HAMMERDASH
	{
		exit;
	}

	// Allow Knuckles to Spin Dash
	if (animation == ANI_GLIDE_GROUND || animation == ANI_GLIDE_LAND) && (input_down.down || spd_ground != 0)
	{
		ground_lock_timer = 0;
	}
	
	if ground_lock_timer == 0
	{
		var _do_skid = false;

		// Handle movement to the left
		if input_down.left
		{	
			if spd_ground > 0
			{
				spd_ground -= dec;
				if spd_ground < 0
				{
					spd_ground = -0.5;
				}
				
				_do_skid = true;
			}
			else
			{
				if !global.no_speed_cap || spd_ground > -acc_top
				{
					spd_ground = max(spd_ground - acc, -acc_top);
				}
				
				if facing != DIRECTION.NEGATIVE
				{
					facing = DIRECTION.NEGATIVE;
					animation = ANI_MOVE;
					set_push_anim_by = noone;
					ani_update_frame(0);
				}
				
				if animation == ANI_SKID
				{
					animation = ANI_MOVE;
				}
			}
		}

		// Handle movement to the right
		if input_down.right
		{
			if spd_ground < 0 
			{
				spd_ground += dec;
				if spd_ground >= 0
				{
					spd_ground = 0.5;
				}
				
				_do_skid = true;
			} 
			else
			{
				if !global.no_speed_cap || spd_ground < acc_top
				{
					spd_ground = min(spd_ground + acc, acc_top);
				}
				
				if facing != DIRECTION.POSITIVE
				{
					facing = DIRECTION.POSITIVE;
					animation = ANI_MOVE;
					set_push_anim_by = noone;
					ani_update_frame(0);
				}
				
				if animation == ANI_SKID
				{
					animation = ANI_MOVE;
				}
			}
		}

		// Set push animation
		if set_push_anim_by != noone && ani_get_frame_change()
		{
			animation = ANI_PUSH;
		}

		var _angle_quad = math_get_quadrant(angle);

		// Handle skid or movement animation
		if _angle_quad > 0 || spd_ground != 0
		{
			if animation != ANI_SKID && animation != ANI_PUSH
			{
				animation = ANI_MOVE;
			}
			
			if _angle_quad == 0 && _do_skid && abs(spd_ground) >= PARAM_SKID_SPEED_THRESHOLD && animation != ANI_SKID
			{
				skid_timer = 0;
				animation = ANI_SKID;
				audio_play_sfx(sfx_skid);
			}
		}
		else
		{
			if input_down.up
			{
				animation = ANI_LOOKUP;
			}
			else if input_down.down
			{
				animation = ANI_DUCK;
			}
			else
			{
				animation = ANI_IDLE;
			}
			
			set_push_anim_by = noone;
		}
	}
	
	// Apply friction if no horizontal input is detected
	if !input_down.left && !input_down.right
	{
		if spd_ground > 0
		{
			spd_ground = max(spd_ground - frc, 0);
		}
		else if spd_ground < 0
		{
			spd_ground = min(spd_ground + frc, 0);
		}
	}

	m_player_set_velocity_from_speed();
}