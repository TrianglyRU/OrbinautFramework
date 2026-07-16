switch state
{
	case NEWTRON_STATE.FIND_TARGET:
		
		var _player = player_get(FRAME_COUNTER % PLAYER_COUNT);
		var _dist_x = floor(_player.x) - x;
		
		if abs(_dist_x) >= 128
		{
			break;
		}
		
		if iv_type == NEWTRON_TYPE.FIRE
		{
			state = NEWTRON_STATE.FIRE;
			animator.start(image_index == 0 ? spr_newtron_fire_blue : spr_newtron_fire_green, 0, 6, 20);
		}
		else
		{
			state = NEWTRON_STATE.FALL;
			animator.start(image_index == 0 ? spr_newtron_fall_blue : spr_newtron_fall_green, 0, 4, 20);
		}
		
		visible = true;
		image_xscale = _dist_x < 0 ? 1 : -1;
		target_player = _player;
	
	break;
	
	case NEWTRON_STATE.FIRE:
		
		if animator.timer >= 0
		{
			if image_index == 3 && !shot_flag
			{
				shot_flag = true;
				instance_create(x - 20 * image_xscale, y - 8, obj_newtron_projectile, { image_xscale: image_xscale });
			}
		
			if image_index > 0
			{
				// Inherit the parent event
				event_inherited();
			}
		}
		else
		{
			instance_destroy();
		}
	
	break;
	
	case NEWTRON_STATE.FALL:
		
		if image_index < 3
		{
			image_xscale = floor(target_player.x) - x < 0 ? 1 : -1;
			break;
		}
		
		y += vel_y;
		vel_y += GLOBAL_PARAM_GRV;
		
		var _floor_dist = tile_raycast_v(x, bbox_bottom + 8 - 1, 1)[0];
		
		if _floor_dist < 0
		{			
			y += _floor_dist;
			state = NEWTRON_STATE.FLOOR;
			vel_y = 0;
			animator.start(sprite_index == spr_newtron_fall_blue ? spr_newtron_fly_blue : spr_newtron_fly_green, 0, 0, 3);	
			
			mask_index = spr_newtron_fly_blue;
		}
	
	break;
	
	case NEWTRON_STATE.FLOOR:
	case NEWTRON_STATE.FLY:
		
		// Inherit the parent event
		event_inherited();

		x -= 2 * sign(image_xscale);
		
		if state == NEWTRON_STATE.FLOOR
		{
			var _floor_dist = tile_raycast_v(x, bbox_bottom + 8 - 1, 1)[0];
			
			if _floor_dist < -8 || _floor_dist >= 12
			{
				state = NEWTRON_STATE.FLY;
			}
			else
			{
				y += _floor_dist;
			}
		}
		
	break;
}