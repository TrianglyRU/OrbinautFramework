if !instance_exists(player) || player.player_type != PLAYER.TAILS
{
	instance_destroy();
	return;
}

tail_offset_x = 0;
tail_offset_y = 0;

switch player.animation
{
	case ANIM.IDLE:
	case ANIM.WAIT:
	case ANIM.DUCK:
	case ANIM.LOOK_UP:
		
		if sprite_index != spr_tails_tail_idle || animator.duration == 0
		{
			animator.start(spr_tails_tail_idle, 0, 0, 8);
		}
		
	break;
	
	case ANIM.FLY:
	case ANIM.FLY_TIRED:
	
		var _duration = player.vel_y < 0 && player.animation != ANIM.FLY_TIRED ? 1 : 2;
		
		if sprite_index != spr_tails_tail_fly
		{
			animator.start(spr_tails_tail_fly, 0, 0, _duration);
		}
		else
		{
			animator.duration = _duration;
		}
		
	break;
	
	case ANIM.PUSH:
	case ANIM.SKID:
	case ANIM.SPIN:
	case ANIM.GRAB:
	case ANIM.BALANCE:
	case ANIM.SPIN_DASH:
	
		if sprite_index != spr_tails_tail
		{
			animator.start(spr_tails_tail, 0, 0, 4);
		}
		
		if player.animation == ANIM.SPIN_DASH || player.animation == ANIM.GRAB
		{
			tail_offset_x = 5;
		}
		else if player.animation != ANIM.SPIN
		{
			tail_offset_x = 7;
			tail_offset_y = 5;
		}
		
	break;
	
	default:
		sprite_index = -1;
}

if player.animation != ANIM.SPIN
{
	image_angle = player.image_angle;
}
else if player.is_grounded
{
	image_angle = player.visual_angle;
}
else
{
	var _x = player.x;
	var _y = player.y;
	
	image_angle = point_direction(_x, _y, _x + player.vel_x, _y + player.vel_y);
	
	if player.image_xscale < 0
	{
		image_angle += 180;
	}
	
	if global.rotation_mode == ROTATION.CLASSIC
	{
		image_angle = ceil((image_angle - 22.5) / 45) * 45;
	}
}

if player.animation == ANIM.SPIN && player.is_grounded
{
	image_xscale = sign(player.spd);
}
else
{
	image_xscale = player.image_xscale;
}