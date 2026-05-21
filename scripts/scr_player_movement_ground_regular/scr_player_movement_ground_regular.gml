/// @self obj_player
function scr_player_movement_ground_regular()
{
	if action == ACTION.SPIN_DASH || action == ACTION.DASH || action == ACTION.HAMMER_DASH
	{
		return;
	}
	
	if (animation == ANIM.GLIDE_GROUND || animation == ANIM.GLIDE_LAND) && (input_down.down || spd != 0)
	{
		ground_lock_timer = 0;
	}
	
	if ground_lock_timer == 0
	{
		var _is_braking = false;
		
		if input_down.left
		{
			if spd > 0
			{
				spd -= dec;
				
				if spd < 0
				{
					spd = -0.5;
				}
				
				_is_braking = true;
			}
			else
			{
				if global.speed_cap || spd > -acc_top
				{
					spd = max(spd - acc, -acc_top);
				}
				
				if facing != -1
				{
					facing = -1;
					animation = ANIM.MOVE;
					set_push_anim_by = noone;
					animator.restart();
				}
				
				if animation == ANIM.SKID
				{
					animation = ANIM.MOVE;
				}
			}
		}
		
		if input_down.right
		{
			if spd < 0
			{
				spd += dec;
				
				if spd >= 0
				{
					spd = 0.5;
				}
				
				_is_braking = true;
			} 
			else
			{
				if global.speed_cap || spd < acc_top
				{
					spd = min(spd + acc, acc_top);
				}
				
				if facing != 1
				{
					facing = 1;
					animation = ANIM.MOVE;
					set_push_anim_by = noone;
					animator.restart();
				}
				
				if animation == ANIM.SKID
				{
					animation = ANIM.MOVE;
				}
			}
		}
		
		if set_push_anim_by != noone && animation == ANIM.MOVE && animator.timer == animator.duration
		{
            animation = ANIM.PUSH;
		}
		
		var _angle_quad = math_get_quadrant(angle);
		var _running_fast = abs(spd) >= PARAM_SKID_SPEED_THRESHOLD;
		
		if _angle_quad == QUADRANT.DOWN && spd == 0
		{
			if input_down.up
			{
				animation = ANIM.LOOKUP;
			}
			else if input_down.down
			{
				animation = ANIM.DUCK;
			}
			else if animation != ANIM.WAIT
			{
				animation = ANIM.IDLE;
			}
			
			set_push_anim_by = noone;
		}
		else if animation != ANIM.SKID
		{
			// Due to a "state race", SKID may be selected logically and displayed before MOVE has been visually applied
            // animator.timer > 0 prevents this code from triggering endlessly while MOVE is applying its sprite
            
			if _is_braking && _running_fast && _angle_quad == QUADRANT.DOWN && animator.timer > 0
			{
				animation = ANIM.SKID;
				skid_timer = 0;
				
				audio_sfx_play(snd_skid);
			}
			else if animation != ANIM.PUSH && animation != ANIM.FLIP
			{
				animation = ANIM.MOVE;
			}
		}
        
        // Keep displaying the animation while braking continuously
		else if animator.timer < 0 && _is_braking && _running_fast
		{
			animator.timer = 1;
		}
	}
	
	if !input_down.left && !input_down.right
	{
		if spd > 0
		{
			spd = max(spd - frc, 0);
		}
		else if spd < 0
		{
			spd = min(spd + frc, 0);
		}
	}
    
	set_velocity();
}