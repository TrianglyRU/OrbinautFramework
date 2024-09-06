if !instance_exists(TargetPlayer) || TargetPlayer.PlayerType != PLAYER_TAILS
{
	instance_destroy();
	exit;
}

tail_offset_x = 0;
tail_offset_y = 0;

switch TargetPlayer.animation
{
	case ANI_IDLE:
	case ANI_WAIT:
	case ANI_DUCK:
	case ANI_LOOKUP:
		ani_start(spr_tails_tail_idle, 8);
	break;
	
	case ANI_FLY:
	case ANI_FLY_TIRED:
	
		// Determine animation speed based on vertical velocity or tired state
		var _duration = 1;
		
		if TargetPlayer.vel_y >= 0 || TargetPlayer.animation == ANI_FLY_TIRED
		{
			_duration = 2;
		}
		
		ani_start(spr_tails_tail_fly);
		ani_update_duration(_duration);
		
	break;
	
	case ANI_PUSH:
	case ANI_SKID:
	case ANI_SPIN:
	case ANI_GRAB:
	case ANI_BALANCE:
	case ANI_SPINDASH:
	
		// Adjust tail offsets based on animation type
		if TargetPlayer.animation == ANI_SPINDASH || TargetPlayer.animation == ANI_GRAB
		{
			tail_offset_x += 5;
		}
		else if TargetPlayer.animation != ANI_SPIN
		{
			tail_offset_x += 7;
			tail_offset_y += 5;
		}
		
		ani_start(spr_tails_tail, 4);
		
	break;
	
	default:
		ani_start(spr_tails_tail_hidden);
}

if TargetPlayer.animation != ANI_SPIN
{
	image_angle = TargetPlayer.image_angle;
}
else if TargetPlayer.is_grounded
{
	image_angle = TargetPlayer.visual_angle;
}
else
{
	var _x = TargetPlayer.x;
	var _y = TargetPlayer.y;
	
	// Calculate image angle based on velocity direction
	image_angle = point_direction(_x, _y, _x + TargetPlayer.vel_x, _y + TargetPlayer.vel_y);
	
	if TargetPlayer.image_xscale == DIRECTION.NEGATIVE
	{
		image_angle += 180;
	}
	
	if global.rotation_mode == 0
	{
		image_angle = ceil((image_angle - 22.5) / 45) * 45;
	}
}

if TargetPlayer.animation == ANI_SPIN && TargetPlayer.is_grounded 
{
	image_xscale = sign(TargetPlayer.spd_ground);
}
else
{
	image_xscale = TargetPlayer.image_xscale;
}