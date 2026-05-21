/// @self obj_player
function scr_player_animate_sonic()
{
	switch animation
	{
		case ANIM.IDLE:
			
			if super_timer > 0
			{
				if sprite_index != spr_sonic_idle_super
				{
					animator.start(spr_sonic_idle_super, 0, 0, 8);
				}
			}
			else if sprite_index != spr_sonic_idle
			{
				animator.start(spr_sonic_idle, 0, 0, 180);
			}
			else if animator.timer < 0
			{
				animation = ANIM.WAIT;
				animator.start(spr_sonic_wait, 0, 6, 6);
			}
			
		break;
		
		case ANIM.MOVE:
		
			var _move_sprite;
			var _move_timing = floor(max(1, 9 - abs(spd)));
			
			if super_timer > 0
			{
				_move_sprite = abs(spd) < 8 ? spr_sonic_walk_super : spr_sonic_dash_super;
			}
			else if abs(spd) >= 6
			{
				_move_sprite = abs(spd) < 10 || !global.dash ? spr_sonic_run : spr_sonic_dash;
			}
			else
			{
				_move_sprite = spr_sonic_walk;
			}
			
			if sprite_index != _move_sprite && sprite_index != spr_sonic_walk_super_alt
			{
				animator.start(_move_sprite, 0, 0, _move_timing);
			}
			else
			{
				animator.duration = _move_timing;
			}
			
			if obj_game.frame_counter % 4 <= 1
			{
				if sprite_index == spr_sonic_walk_super
				{
					sprite_index = spr_sonic_walk_super_alt;
				}
			}
			else if sprite_index == spr_sonic_walk_super_alt
			{
				sprite_index = spr_sonic_walk_super;
			}
			
		break;
			
		case ANIM.SPIN:
		
			if action == ACTION.DROP_DASH && dropdash_charge >= PARAM_DROPDASH_CHARGE
			{
				if sprite_index != spr_sonic_dropdash
				{
					animator.start(spr_sonic_dropdash, 0, 0, 1);
				}
			}
			else 
			{
				var _spin_timing = floor(max(1, 5 - abs(spd)));
				
				if sprite_index != spr_sonic_spin
				{
					animator.start(spr_sonic_spin, 0, 0, _spin_timing);
				}
				else
				{
					animator.duration = _spin_timing;
				}
			}
			
		break;
		
		case ANIM.SPIN_DASH:
			
			if sprite_index != spr_sonic_spin_dash
			{
				animator.start(spr_sonic_spin_dash, 0, 0, 1);
			}
			
		break;
		
		case ANIM.PUSH:
			
			var _push_sprite = super_timer > 0 ? spr_sonic_push_super : spr_sonic_push;
			var _push_timing = floor(max(1, 9 - abs(spd)) * 4);
			
			if sprite_index != _push_sprite
			{
				animator.start(_push_sprite, 0, 0, _push_timing);
			}
			else
			{
				animator.duration = _push_timing;
			}
			
		break;
		
		case ANIM.DUCK:
			
			if super_timer > 0
			{
				sprite_index = spr_sonic_duck_super;
			}
			else if sprite_index != spr_sonic_duck
			{
				animator.start(spr_sonic_duck, 0, 1, 4);
			}
			
		break;
		
		case ANIM.LOOKUP:
		
			if sprite_index != spr_sonic_lookup
			{
				animator.start(spr_sonic_lookup, 0, 1, 4);
			}
			
		break;
		
		case ANIM.GRAB:
			
			if sprite_index != spr_sonic_grab
			{
				animator.start(spr_sonic_grab, 0, 0, 20);
			}
			
		break;
		
		case ANIM.HURT:
			sprite_index = spr_sonic_hurt;
		break;
		
		case ANIM.DEATH:
			sprite_index = spr_sonic_death;
		break;
		
		case ANIM.DROWN:
			sprite_index = spr_sonic_drown;	
		break;
		
		case ANIM.SKID:
		
			if sprite_index != spr_sonic_skid
			{
				animator.start(spr_sonic_skid, 0, 3, 6);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.TRANSFORM:
		
			if sprite_index != spr_sonic_transform
			{
				animator.start(spr_sonic_transform, 0, 12, 3);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BREATHE:
		
			if sprite_index != spr_sonic_breathe
			{
				animator.start(spr_sonic_breathe, 0, 0, 24);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.BOUNCE:
		
			if sprite_index != spr_sonic_bounce
			{
				animator.start(spr_sonic_bounce, 0, 0, 48);
			}
			else if animator.timer < 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
		
		case ANIM.TWIRL:
			
			if sprite_index != spr_sonic_twirl
			{
				animator.start(spr_sonic_twirl, 0, 0, 4);
			}
			else if vel_y >= 0
			{
				animation = ANIM.MOVE;
			}
			
		break;
			
		case ANIM.BALANCE:
			
			var _balance_sprite = super_timer > 0 ? spr_sonic_balance_super : spr_sonic_balance;
			
			if sprite_index != _balance_sprite
			{
				animator.start(_balance_sprite, 0, 0, 10);
			}
			
		break;
		
		case ANIM.BALANCE_FLIP:
			
			if sprite_index != spr_sonic_balance_flip
			{
				animator.start(spr_sonic_balance_flip, 0, 0, 20);
			}
			
		break;
		
		case ANIM.BALANCE_PANIC:
		
			if sprite_index != spr_sonic_balance_panic
			{
				animator.start(spr_sonic_balance_panic, 0, 0, 4);
			}
			
		break;
		
		case ANIM.BALANCE_TURN:
			sprite_index = spr_sonic_balance_turn;
		break;
		
		case ANIM.FLIP:
		case ANIM.FLIP_EXTENDED:
			
			if sprite_index != spr_sonic_flip && sprite_index != spr_sonic_flip_flipped
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
			
			sprite_index = facing >= 0 ? spr_sonic_flip : spr_sonic_flip_flipped;
			
		break;
		
		case ANIM.ACT_CLEAR:
		
			if sprite_index != spr_sonic_act_clear
			{
				animator.start(spr_sonic_act_clear, 0, 0, 12);
			}
		
		break;
	}
}