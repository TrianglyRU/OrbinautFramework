/// @self obj_player
function scr_player_animate_tails()
{
	switch animation
	{
		case ANIM.IDLE:
			
			if sprite_index != spr_tails_idle
			{
				animator.start(spr_tails_idle, 0, 30, 8);
			}
			else if animator.timer < 0
			{
				animation = ANIM.WAIT;
				animator.start(spr_tails_wait, 0, 0, 8);
			}
			
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite = spr_tails_walk;	
			var _move_timing = floor(max(1, 9 - abs(spd)));
			
			if abs(spd) >= 6
			{
				_move_sprite = abs(spd) < 10 ? spr_tails_run : spr_tails_dash;
			}
			
			if sprite_index != _move_sprite
			{
				animator.start(_move_sprite, 0, 0, _move_timing);
			}
			else
			{
				animator.duration = _move_timing;
			}
			
		break;
		
		case ANIM.SPIN:
		
			if sprite_index != spr_tails_spin
			{
				animator.start(spr_tails_spin, 0, 0, 2);
			}
			
		break;
		
		case ANIM.SPIN_DASH:
		
			if sprite_index != spr_tails_spin_dash
			{
				animator.start(spr_tails_spin_dash, 0, 0, 1);
			}
			
		break;
		
		case ANIM.PUSH:
		
			var _push_timing = floor(max(1, 9 - abs(spd)) * 4);
		
			if sprite_index != spr_tails_push
			{
				animator.start(spr_tails_push, 0, 0, _push_timing);
			}
			else
			{
				animator.duration = _push_timing;
			}
			
		break;
		
		case ANIM.DUCK:
			sprite_index = spr_tails_duck;
		break;
		
		case ANIM.LOOK_UP:
			sprite_index = spr_tails_look_up;
		break;
		
		case ANIM.GRAB:
		
			if sprite_index != spr_tails_grab
			{
				animator.start(spr_tails_grab, 0, 0, 20);
			}
			
		break;
		
		case ANIM.HURT:
			sprite_index = spr_tails_hurt;
		break;
		
		case ANIM.DEATH:
		case ANIM.DROWN:
			sprite_index = spr_tails_death;
		break;
		
		case ANIM.SKID:
		
			if sprite_index != spr_tails_skid
			{
				animator.start(spr_tails_skid, 0, 2, 8);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
					
		break;
		
		case ANIM.TRANSFORM:
			
			if sprite_index != spr_tails_transform
			{
				animator.start(spr_tails_transform, 0, 11, 3);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BREATHE:
		
			if sprite_index != spr_tails_breathe
			{
				animator.start(spr_tails_breathe, 0, 0, 24);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BOUNCE:
		
			if sprite_index != spr_tails_bounce
			{
				animator.start(spr_tails_bounce, 0, 11, 4);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.TWIRL:
			
			if sprite_index != spr_tails_twirl
			{
				animator.start(spr_tails_twirl, 0, 0, 4);
			}
			else if vel_y >= 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BALANCE:
			
			if sprite_index != spr_tails_balance
			{
				animator.start(spr_tails_balance, 0, 0, 20);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			if sprite_index != spr_tails_flip && sprite_index != spr_tails_flip_flipped
			{
				animator.start(sprite_index, 0, 61, 1);
			}
			else if animator.timer < 0
			{
				if animation == ANIM.FLIP_EXTENDED && animator.play_count < 2
				{
					animator.restart(false);
				}
				else
				{
					animation = ANIM.MOVE;
				}
			}
				
			sprite_index = facing >= 0 ? spr_tails_flip : spr_tails_flip_flipped;
			
		break;
		
		case ANIM.FLY:
			
			if carry_target == noone
			{
				sprite_index = spr_tails_fly;
			}
			else
			{
				sprite_index = spr_tails_fly_carry;
				image_index = vel_y <= 0 ? 1 : 0;
				animator.timer = 0;
			}
			
		break;
		
		case ANIM.FLY_TIRED:
			
			if sprite_index != spr_tails_fly_tired && sprite_index != spr_tails_fly_carry_tired
			{
				animator.start(sprite_index, 0, 0, 8);
			}
			
			sprite_index = carry_target == noone ? spr_tails_fly_tired : spr_tails_fly_carry_tired;
			
		break;
		
		case ANIM.SWIM:
			
			if carry_target == noone
			{
				var _swim_timing = vel_y <= 0 ? 4 : 8;
				
				if sprite_index != spr_tails_swim
				{
					animator.start(spr_tails_swim, 0, 0, _swim_timing);	
				}
				else
				{
					animator.duration = _swim_timing;	
				}
			}
			else if sprite_index != spr_tails_swim_carry
			{
				animator.start(spr_tails_swim_carry, 0, 0, 8);
			}
			
		break;
		
		case ANIM.SWIM_TIRED:
			
			if sprite_index != spr_tails_swim_tired
			{
				animator.start(spr_tails_swim_tired, 0, 0, 8);
			}
			
		break;
		
		case ANIM.SWIM_CARRY:
		
			if sprite_index != spr_tails_swim_carry
			{
				animator.start(spr_tails_swim_carry, 0, 0, 8);
			}
			
		break;
		
		case ANIM.ACT_CLEAR:
		
			if sprite_index != spr_tails_act_clear
			{
				animator.start(spr_tails_act_clear, 0, 1, 16);
			}
		
		break;
	}
}