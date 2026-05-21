// Inherit the parent event
event_inherited();

switch state
{
	case BUZZ_BOMBER_STATE.HOVER:
	
		if --state_timer < 0
		{
			state = BUZZ_BOMBER_STATE.ROAM;
			state_timer = 127;
			animator.start(spr_buzz_bomber_roam, 0, 0, 2);
		}
		
	break;
	
	case BUZZ_BOMBER_STATE.FIRE:
	
		if --state_timer < 0
		{
			projectile = instance_create(x - 29 * image_xscale, y + 28, obj_buzz_bomber_projectile, { image_xscale: image_xscale });
			state = BUZZ_BOMBER_STATE.HOVER;
			state_timer = 59;
			shot_flag = true;
			animator.start(spr_buzz_bomber_fire, 0, 0, 2);
		}
		
	break;
	
	case BUZZ_BOMBER_STATE.ROAM:
	
		if --state_timer < 0
		{
			image_xscale *= -1;
			state = BUZZ_BOMBER_STATE.HOVER;
			shot_flag = false;
			state_timer = 59;
			animator.start(spr_buzz_bomber_hover, 0, 0, 2);
			
			break;
		}
		
		x -= 4 * sign(image_xscale);
		
		if !shot_flag
		{
			var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
			var _dist_x = x - floor(_player.x);
			
			if _dist_x < 0
			{
				_dist_x *= -1;
			}
			
			if _dist_x >= 0 && _dist_x < 96 && instance_is_drawn()
			{
				state = BUZZ_BOMBER_STATE.FIRE;
				state_timer = 29;
				animator.start(spr_buzz_bomber_hover, 0, 0, 2);
			}
		}
		
	break;
}

if instance_exists(projectile) && projectile.sprite_index != spr_buzz_bomber_projectile_flare
{
	projectile = noone;
}