/// @function scr_player_animate_tails
function scr_player_animate_tails()
{
	gml_pragma("forceinline");
	
	switch animation
	{
		case ANI_IDLE:
		case ANI_WAIT:
		
			var _order =
			[
				0, 1, 2, 0, 1, 2, 0, 3, 4, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 4
			];
			
			var _duration =
			[
				128, 8, 8, 64, 8, 8, 72, 128, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
			];
			
			ani_start(spr_tails_idle, _duration, 0, 7, _order);
			
			if ani_get_frame() > 0
			{
				animation = ANI_WAIT;
			}
			
		break;
		
		case ANI_MOVE:
		
			var _sprite = spr_tails_walk;
			
			if abs(spd_ground) >= 6
			{
				if abs(spd_ground) < 10
				{
					_sprite = spr_tails_run;
				}
				else
				{
					_sprite = spr_tails_dash;
				}
			}
			
			var _duration = floor(max(1, 9 - abs(spd_ground)));
			
			ani_start(_sprite);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_SPIN:
			ani_start(spr_tails_spin, 2);
		break;
		
		case ANI_SPINDASH:
			ani_start(spr_tails_spindash, 1);
		break;
		
		case ANI_PUSH:
		
			var _duration = floor(max(1, 9 - abs(spd_ground)) * 4);
			
			ani_start(spr_tails_push);
			ani_update_duration(_duration);
			
		break;
		
		case ANI_DUCK:
			ani_start(spr_tails_duck);
		break;
		
		case ANI_LOOKUP:
			ani_start(spr_tails_lookup);
		break;
		
		case ANI_GRAB:
			ani_start(spr_tails_grab, 20);
		break;
		
		case ANI_HURT:
			ani_start(spr_tails_hurt);
		break;
		
		case ANI_DEATH:
		case ANI_DROWN:
			ani_start(spr_tails_death);
		break;
		
		case ANI_SKID:
			ani_start(spr_tails_skid, 8, 0, 1);
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
			
			ani_start(spr_tails_transform, _duration, 0, 10, _order);
			
		break;
		
		case ANI_BREATHE:
			ani_start(spr_tails_breathe, 24);
		break;
		
		case ANI_BOUNCE:
			ani_start(spr_tails_bounce, 4, 0, 11, [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]);
		break;
		
		case ANI_BALANCE:
			ani_start(spr_tails_balance, 20);
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
			
			ani_start(spr_tails_flip, _duration, 0, 12, _order);
			
		break;
		
		case ANI_FLY:
		
			var _sprite = spr_tails_fly;
			var _frame = 0;
			
			if carry_target != noone
			{
				_sprite = spr_tails_fly_carry;
				_frame = vel_y <= 0 ? 1 : 0;	
			}
			
			ani_start(_sprite);
			ani_update_frame(_frame);
			
		break;
		
		case ANI_FLY_TIRED:
			ani_start(carry_target == noone ? spr_tails_fly_tired : spr_tails_fly_carry_tired, 8);
		break;
		
		case ANI_SWIM:
		
			var _sprite = spr_tails_swim_carry;
			var	_duration = 8;
			
			if carry_target == noone
			{
				_sprite = spr_tails_swim;
				
				if vel_y <= 0
				{
					_duration = 4;
				}
			}
			
			ani_start(_sprite);
			ani_update_duration(_duration);
		
		break;
		
		case ANI_SWIM_TIRED:
			ani_start(spr_tails_swim_tired, 8);
		break;
		
		case ANI_SWIM_CARRY:
			ani_start(spr_tails_swim_carry, 8);
		break;
	}
}