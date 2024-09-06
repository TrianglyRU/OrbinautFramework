/// @function scr_player_animate
function scr_player_animate()
{
	gml_pragma("forceinline");

	/// @method m_local_ceil_angle
	var m_local_ceil_angle = function(_angle)
	{
		return ceil((_angle - 22.5) / 45) * 45;
	}

	var _smooth_rotation = global.rotation_mode > 0;

	// Update visual angle based on grounded state
	if is_grounded
	{
		var _target_angle = (angle > 22.5 && angle < 337.5) ? angle : 0;
		
		if _smooth_rotation
		{
			var _diff = _target_angle - visual_angle;
			var _delta = abs(_diff);
			var _cw_delta = abs(_diff + ENGINE_ANGLE_MAX_DEC);
			var _ccw_delta = abs(_diff - ENGINE_ANGLE_MAX_DEC);
			
			if _delta > _ccw_delta
			{
			    _diff -= ENGINE_ANGLE_MAX_DEC;
			} 
			else if _delta > _cw_delta
			{
			    _diff += ENGINE_ANGLE_MAX_DEC;
			}
			
			visual_angle += _diff / ((abs(spd_ground) >= 6) ? 2 : 4);
			visual_angle %= ENGINE_ANGLE_MAX_DEC;
			
			if visual_angle < 0
			{
			    visual_angle += ENGINE_ANGLE_MAX_DEC;
			}
		}
		else
		{
			visual_angle = m_local_ceil_angle(_target_angle);
		}
	}
	else
	{
		visual_angle = _smooth_rotation ? angle : m_local_ceil_angle(angle);
	}

	// Update image angle based on animation state
	if animation == ANI_MOVE || animation == ANI_HAMMERDASH
	{
		image_angle = visual_angle;
	}
	else
	{
		image_angle = 0;
	}

	// Call player-specific animation functions
	switch PlayerType
	{
		case PLAYER_SONIC:
			scr_player_animate_sonic();
		break;
		case PLAYER_TAILS:
			scr_player_animate_tails();
		break;
		case PLAYER_KNUCKLES:
			scr_player_animate_knuckles();
		break;
		case PLAYER_AMY:
			scr_player_animate_amy();
		break;
	}

	// Handle animation ending
	if ani_get_ended()
	{
		switch animation
		{
			case ANI_BOUNCE: 
			case ANI_BREATHE: 
			case ANI_FLIP:
			case ANI_TRANSFORM: 
				animation = ANI_MOVE;
			break;
			
			case ANI_SKID:
			
				if !input_down.left && !input_down.right || abs(spd_ground) < PARAM_SKID_SPEED_THRESHOLD || !is_grounded
				{
					animation = ANI_MOVE;
				}
				
			break;
		}
	}
	
	// Always update image scale based on facing direction except during ANI_SPIN, where it updates only on frame change
	if animation != ANI_SPIN || ani_get_frame_change()
	{
		image_xscale = facing;
	}
}