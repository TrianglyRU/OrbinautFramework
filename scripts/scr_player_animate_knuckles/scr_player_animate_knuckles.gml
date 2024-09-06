/// @function scr_player_animate_knuckles
function scr_player_animate_knuckles()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANI_IDLE:
		case ANI_WAIT:
		
			var _order = 
			[
				0,
				1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2,
				3, 4,
				5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 8,
				9, 10, 9, 10, 9, 10,
				11, 5, 4
			];
			
			var _duration = 
			[
				300, 
				18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 
				30, 6, 
				6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 
				6, 6, 6, 6, 6, 6,
				12, 6, 6
			];
			
			ani_start(spr_knuckles_idle, _duration, 0, 0, _order);
			
			if ani_get_frame() > 0
			{
				animation = ANI_WAIT;
			}
			
		break;
		
		case ANI_MOVE:
		
			var _sprite = spr_knuckles_walk;
			
			if abs(spd_ground) >= 6
			{
				_sprite = spr_knuckles_run;
			}
			
			var _duration = floor(max(1, 9 - abs(spd_ground)));
			
			ani_start(_sprite);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_SPIN:
		
			var _duration = floor(max(1, 5 - abs(spd_ground)));
			
			ani_start(spr_knuckles_spin, 0, 0, 0, [0, 4, 1, 4, 2, 4, 3, 4]);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_SPINDASH:
			ani_start(spr_knuckles_spindash, 1, 0, 0, [0, 5, 1, 5, 2, 5, 3, 5, 4, 5]);
		break;
		
		case ANI_PUSH:
		
			var _duration = floor(max(1, 9 - abs(spd_ground)));
			
			ani_start(spr_knuckles_push); 
			ani_update_duration(_duration);
			
		break;
		
		case ANI_DUCK:
			ani_start(spr_knuckles_duck, 6, 0, 1);
		break;
		
		case ANI_LOOKUP:
			ani_start(spr_knuckles_lookup, 6, 0, 1);
		break;
		
		case ANI_GRAB:
			ani_start(spr_knuckles_grab);
		break;
		
		case ANI_HURT:
			ani_start(spr_knuckles_hurt);
		break;
		
		case ANI_DEATH:
			ani_start(spr_knuckles_death);
		break;
		
		case ANI_DROWN:
			ani_start(spr_knuckles_drown);
		break;
		
		case ANI_SKID:
			ani_start(spr_knuckles_skid, [4, 8, 4], 0, 2);
		break;
		
		case ANI_TRANSFORM:
		
			var _order =
			[
				0, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
			];
			
			var _duration =
			[
				6, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
			];
			
			ani_start(spr_knuckles_transform, _duration, 0, 10, _order);
			
		break;
		
		case ANI_BREATHE:
			ani_start(spr_knuckles_breathe, 24);
		break;
		
		case ANI_BOUNCE:
			ani_start(spr_knuckles_bounce, 48);
		break;
		
		case ANI_BALANCE:
		case ANI_BALANCE_FLIP:
			ani_start(spr_knuckles_balance, [8, 8, 8, 8, 8, 8, 60, 12, 12, 8, 8, 8], animation == ANI_BALANCE_FLIP ? 2 : 0, 9);
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
			
			ani_start(spr_knuckles_flip, _duration, 0, 12, _order);
			
		break;
		
		case ANI_GLIDE_AIR:
			ani_start(spr_knuckles_glide);
		break;
		
		case ANI_GLIDE_FALL:
			ani_start(spr_knuckles_glide_fall, 6, glide_value, 1);
		break;
		
		case ANI_GLIDE_GROUND:
			ani_start(spr_knuckles_slide);
		break;
		
		case ANI_GLIDE_LAND:
			ani_start(spr_knuckles_duck, 0, 1);
		break;
		
		case ANI_CLIMB_WALL:
			ani_start(spr_knuckles_climb);
		break;
		
		case ANI_CLIMB_LEDGE:
			ani_start(spr_knuckles_climb_ledge, 6, 0, 2);
		break;
	}
}