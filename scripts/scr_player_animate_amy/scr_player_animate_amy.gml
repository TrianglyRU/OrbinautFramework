/// @self obj_player
function scr_player_animate_amy()
{
	switch animation
	{
		case ANIM.IDLE:
		
			if sprite_index != spr_amy_idle
			{
				animator.start(spr_amy_idle, 0, 0, 240);
			}
			else if animator.timer < 0
			{
				animation = ANIM.WAIT;
				animator.start(spr_amy_wait, 0, 0, 2);
			}
			
		break;
		
		case ANIM.WAIT:
			
			if sprite_index != spr_amy_wait_2 && animator.play_count == 16
			{
				animator.start(spr_amy_wait_2, 0, 18, 2);
			}
			
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite = spr_amy_walk;
			var _move_timing = floor(max(1, 9 - abs(spd)));
			
			if abs(spd) >= 6
			{
				_move_sprite = abs(spd) < 10 ? spr_amy_run : spr_amy_dash;
			}
			else
			{
				_move_sprite = spr_amy_walk;
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
		
			var _spin_timing = floor(max(1, 5 - abs(spd)));
			
			if sprite_index != spr_amy_spin && sprite_index != spr_amy_spin_hammer
			{
				animator.start(sprite_index, 0, 0, _spin_timing);
			}
			else
			{
				animator.duration = _spin_timing;
			}
			
			sprite_index = action == ACTION.HAMMER_SPIN ? spr_amy_spin_hammer : spr_amy_spin;
			
		break;
		
		case ANIM.SPIN_DASH:
		
			if sprite_index != spr_amy_spin_dash
			{
				animator.start(spr_amy_spin_dash, 0, 0, 1);
			}
			
		break;
		
		case ANIM.PUSH:
			
			var _push_timing = floor(max(1, 9 - abs(spd)) * 4);
			
			if sprite_index != spr_amy_push
			{
				animator.start(spr_amy_push, 0, 0, _push_timing);
			}
			else
			{
				animator.duration = _push_timing;
			}
			
		break;
		
		case ANIM.DUCK:	
		
			if sprite_index != spr_amy_duck
			{
				animator.start(spr_amy_duck, 0, 1, 4);
			}
			
		break;
		
		case ANIM.LOOKUP:
		
			if sprite_index != spr_amy_lookup
			{
				animator.start(spr_amy_lookup, 0, 1, 4);
			}
			
		break;
		
		case ANIM.GRAB:
		
			if sprite_index != spr_amy_grab
			{
				animator.start(spr_amy_grab, 0, 0, 20);
			}
			
		break;
		
		case ANIM.HURT:	
			sprite_index = spr_amy_hurt;
		break;
		
		case ANIM.DEATH:	
			sprite_index = spr_amy_death;
		break;
		
		case ANIM.DROWN:
			sprite_index = spr_amy_drown;
		break;
		
		case ANIM.SKID:
			
			if sprite_index != spr_amy_skid
			{
				animator.start(spr_amy_skid, 0, 3, 6);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.TRANSFORM:
			
			if sprite_index != spr_amy_transform
			{
				animator.start(spr_amy_transform, 0, 11, 3);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BREATHE:
		
			if sprite_index != spr_amy_breathe
			{
				animator.start(spr_amy_breathe, 0, 0, 24);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BOUNCE:
		
			if sprite_index != spr_amy_bounce
			{
				animator.start(spr_amy_bounce, 0, 11, 4);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.TWIRL:
			
			if sprite_index != spr_amy_twirl
			{
				animator.start(spr_amy_twirl, 0, 0, 4);
			}
			else if vel_y >= 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BALANCE:
		
			if sprite_index != spr_amy_balance
			{
				animator.start(spr_amy_balance, 0, 0, 8);
			}
			
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			if sprite_index != spr_amy_flip && sprite_index != spr_amy_flip_flipped
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
				
			sprite_index = facing >= 0 ? spr_amy_flip : spr_amy_flip_flipped;
			
		break;
		
		case ANIM.HAMMER_DASH:
			
			if sprite_index != spr_amy_hammer_dash
			{
				animator.start(spr_amy_hammer_dash, 0, 0, 3);
			}
		
		break;
		
		case ANIM.ACT_CLEAR:
		
			if sprite_index != spr_amy_act_clear
			{
				animator.start(spr_amy_act_clear, 0, 43, 1);
			}
		
		break;
	}
}