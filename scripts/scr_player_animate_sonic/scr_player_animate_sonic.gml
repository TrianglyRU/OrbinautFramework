/// @function scr_player_animate_sonic
function scr_player_animate_sonic()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANI_IDLE:
		case ANI_WAIT:
		
			if super_timer > 0
			{
				ani_start(spr_sonic_idle_super, 8, 0, 0, [0, 1, 2, 1]);
				break;
			}
			
			var _order =
			[
				0, 1, 2, 3, 4, 3, 4, 3, 4, 3, 4, 5
			];
			
			var _duration =
			[
				180, 6, 30, 18, 18, 18, 18, 18, 18, 18, 18, 60
			];
			
			ani_start(spr_sonic_idle, _duration, 0, 3, _order);
			
			if ani_get_frame() > 0
			{
				animation = ANI_WAIT;
			}
			
		break;
		
		case ANI_MOVE:
		
			var _sprite = spr_sonic_walk;
			
			if super_timer > 0
			{
				if abs(spd_ground) >= 8
				{
					_sprite = spr_sonic_dash_super;
				}
				else
				{
					_sprite = spr_sonic_walk_super;
				}
			}
			else if abs(spd_ground) >= 6
			{
				if !global.dash || abs(spd_ground) < 10
				{
					_sprite = spr_sonic_run;
				}
				else
				{
					_sprite = spr_sonic_dash;
				}
			}
			
			var _duration = floor(max(1, 9 - abs(spd_ground)));
			
			ani_start(_sprite);
			ani_update_duration(_duration);
			
			// Swap between frames if Super Sonic's walk animation is playing
			if _sprite == spr_sonic_walk_super && c_framework.frame_counter % 4 <= 1
			{
				var _frames = floor(image_number / 2);
				var _next_frame = (ani_get_frame() + _frames) % image_number;
				
				ani_update_frame(_next_frame, false);
			}
			
		break;
		
		case ANI_SPIN:
		
			if action == ACTION_DROPDASH && dropdash_charge >= PARAM_DROPDASH_CHARGE
			{
				ani_start(spr_sonic_dropdash, 1, 0, 0, [0, 2, 1, 3, 0, 4, 1, 5, 0, 6, 1, 7, 0, 8, 1, 9]);
				break;
			}
			
			var _duration = floor(max(1, 5 - abs(spd_ground)));
			
			ani_start(spr_sonic_spin, _duration, 0, 0, [0, 4, 1, 4, 2, 4, 3, 4]);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_SPINDASH:
			ani_start(spr_sonic_spindash, 1, 0, 0, [0, 5, 1, 5, 2, 5, 3, 5, 4, 5]);
		break;
		
		case ANI_PUSH:
		
			var _duration = floor(max(1, 9 - abs(spd_ground)) * 4);
			var _sprite = super_timer > 0 ? spr_sonic_push_super : spr_sonic_push;
			
			ani_start(_sprite);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_DUCK:
		
			if super_timer > 0
			{
				ani_start(spr_sonic_duck_super);
				break;
			}
			
			ani_start(spr_sonic_duck, 4, 0, 1);
			
		break;
		
		case ANI_LOOKUP:
			ani_start(spr_sonic_lookup, 4, 0, 1);
		break;
		
		case ANI_GRAB:
			ani_start(spr_sonic_grab, 20);
		break;
		
		case ANI_HURT:
			ani_start(spr_sonic_hurt);
		break;
		
		case ANI_DEATH:
			ani_start(spr_sonic_death);
		break;
		
		case ANI_DROWN:
			ani_start(spr_sonic_drown);
		break;
		
		case ANI_SKID:
			ani_start(spr_sonic_skid, 6, 0, 3);
		break;
		
		case ANI_TRANSFORM:
		
			var _order =
			[
				0, 1, 2, 3, 4, 3, 4, 3, 4, 3, 4
			];
			
			var _duration =
			[
				6, 6, 3, 3, 3, 3, 3, 3, 3, 3, 3
			];
			
			ani_start(spr_sonic_transform, _duration, 0, 10, _order);
			
		break;
		
		case ANI_BREATHE:
			ani_start(spr_sonic_breathe, 24);
		break;
		
		case ANI_BOUNCE:
			ani_start(spr_sonic_bounce, 48);
		break;
		
		case ANI_BALANCE:
		
			if super_timer > 0
			{
				ani_start(spr_sonic_balance_super, 10, 0, 0, [0, 1, 2, 1, 3, 4, 5, 4]);
				break;
			}
			
			ani_start(spr_sonic_balance, 10, 0, 0, [0, 1, 2, 1]);
		break;
		
		case ANI_BALANCE_FLIP:
			ani_start(spr_sonic_balance_flip, 20);
		break;
		
		case ANI_BALANCE_PANIC:
			ani_start(spr_sonic_balance_panic, 4);
		break;
		
		case ANI_BALANCE_TURN:
			ani_start(spr_sonic_balance_turn);
		break;
		
		case ANI_FLIP:
			
			var _order =
			[
				0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0
			];
			
			var _duration =
			[
				2, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 3, 2
			];
			
			ani_start(spr_sonic_flip, _duration, 0, 12, _order);
			
		break;
	}
}