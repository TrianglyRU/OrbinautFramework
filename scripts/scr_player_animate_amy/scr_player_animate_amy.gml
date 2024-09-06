/// @function scr_player_animate_amy
function scr_player_animate_amy()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANI_IDLE:
		case ANI_WAIT:
		
			var _order = 
			[
				0, 
				1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2,
				1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1, 2, 3, 2, 1,
				4, 5, 6,
				7, 8,
				9, 10, 11, 10, 9, 10, 11, 10, 9, 10, 11, 10, 9, 10, 11, 10,
				9, 8, 7, 8,
				9, 10, 11, 10, 9, 10, 11, 10, 9, 10, 11, 10, 9, 10, 11, 10, 
				9, 8, 7, 8, 9, 8, 7, 8
			];
			
			var _duration = 
			[
				240, 
				16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10,
				16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16, 10, 16,
				10, 5, 5,
				10, 10,
				10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
				10, 10, 10, 10,
				10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
				10, 10, 10, 10, 10, 10, 10, 10
			];
			
			ani_start(spr_amy_idle, _duration, 0, 71, _order);
			
			if ani_get_frame() > 0
			{
				animation = ANI_WAIT;
			}
			
		break;
			
		case ANI_MOVE:
		
			var _sprite = spr_amy_walk;
			
			if abs(spd_ground) >= 6
			{
				if abs(spd_ground) < 10
				{
					_sprite = spr_amy_run;
				}
				else
				{
					_sprite = spr_amy_dash;
				}
			}
			
			var _duration = floor(max(1, 9 - abs(spd_ground)));
			
			ani_start(_sprite);
			ani_update_duration(_duration);
			
		break;
			
		case ANI_SPIN:
		
			var _duration = floor(max(1, 5 - abs(spd_ground)));
			
			if action == ACTION_HAMMERSPIN
			{
				ani_start(spr_amy_spin_hammer, _duration, ani_get_frame());
			}
			else
			{
				ani_start(spr_amy_spin, 0, 0, 0, [0, 4, 1, 4, 2, 4, 3, 4]);
			}
			
			ani_update_duration(_duration);
			
		break;
		
		case ANI_SPINDASH:	
			ani_start(spr_amy_spindash, 1, 0, 0, [0, 5, 1, 5, 2, 5, 3, 5, 4, 5]);
		break;
		
		case ANI_PUSH:
		
			var _duration = floor(max(1, 9 - abs(spd_ground)) * 4);
			
			ani_start(spr_amy_push);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_DUCK:	
			ani_start(spr_amy_duck, 4, 0, 1);
		break;
		
		case ANI_LOOKUP:	
			ani_start(spr_amy_lookup, 4, 0, 1);
		break;
		
		case ANI_GRAB:	
			ani_start(spr_amy_grab, 20);
		break;
		
		case ANI_HURT:	
			ani_start(spr_amy_hurt);
		break;
		
		case ANI_DEATH:	
			ani_start(spr_amy_death);
		break;
		
		case ANI_DROWN:
			ani_start(spr_amy_drown);
		break;
		
		case ANI_SKID:
			ani_start(spr_amy_skid, 6, 0, 3);
		break;
		
		case ANI_TRANSFORM:
		
			var _order =
			[
				0, 1, 2, 3, 2, 3, 2, 3, 2, 3
			];
			
			var _duration =
			[
				6, 6, 3, 3, 3, 3, 3, 3, 3, 3
			];
			
			ani_start(spr_amy_transform, _duration, 0, 9, _order);
			
		break;
		
		case ANI_BREATHE:
			ani_start(spr_amy_breathe, 24);
		break;
		
		case ANI_BOUNCE:
			ani_start(spr_amy_bounce, 4, 0, 11, [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]);
		break;
		
		case ANI_BALANCE:
			ani_start(spr_amy_balance, 8);
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
			
			ani_start(spr_amy_flip, _duration, 0, 12, _order);
			
		break;
		
		case ANI_HAMMERDASH:
			ani_start(spr_amy_dash_hammer, 3);
		break;
	}
}