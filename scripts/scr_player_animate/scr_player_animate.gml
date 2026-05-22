/// @self obj_player
function scr_player_animate()
{
	var _use_mania = global.rotation_mode == ROTATION.MANIA;
	var _rotation_bounds = get_rotation_bounds();
	var _target_ground_angle = angle > _rotation_bounds[0] && angle < _rotation_bounds[1] ? angle : 0;
	
	if is_grounded
	{
		if _use_mania
		{
			if angle <= 5.625 || angle >= 354.375
			{
				visual_angle = 0;
			}
			else
			{
				var _diff = _target_ground_angle - visual_angle;
				var _delta = abs(_diff);
				var _cw_delta = abs(_diff + 360);
				var _ccw_delta = abs(_diff - 360);
			
				if _delta > _ccw_delta
				{
				    _diff -= 360;
				} 
				else if _delta > _cw_delta
				{
				    _diff += 360;
				}
			
				visual_angle += _diff / ((abs(spd) >= 6) ? 2 : 4);
				visual_angle %= 360;
				
				if visual_angle < 0
				{
				    visual_angle += 360;
				}
			}
		}
		else
		{
			visual_angle = _ceil_angle(_target_ground_angle);
		}
	}
	else if _use_mania
	{
		if visual_angle != 0 || _target_ground_angle != 0
		{
			visual_angle = angle;
		}
	}
	else
	{
		visual_angle = _ceil_angle(angle);
	}
	
	switch player_type
	{
		case PLAYER.SONIC:
			scr_player_animate_sonic();
		break;
		
		case PLAYER.TAILS:
			scr_player_animate_tails();
		break;
		
		case PLAYER.KNUCKLES:
			scr_player_animate_knuckles();
		break;
		
		case PLAYER.AMY:
			scr_player_animate_amy();
		break;
	}
	
	if animation != ANIM.SPIN || animator.timer == animator.duration
	{
		image_xscale = facing;
	}
}

/// @self scr_player_animate
function _ceil_angle(_angle)
{
	gml_pragma("forceinline");
	return ceil((_angle - 22.5) / 45) * 45;
}