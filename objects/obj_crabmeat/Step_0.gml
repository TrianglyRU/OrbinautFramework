// Inherit the parent event
event_inherited();

switch state
{
	case CRABMEAT_STATE.INIT:
	
		y += vel_y;
		vel_y += GLOBAL_PARAM_GRV;
		
		var _floor_data = tile_raycast_v(x, bbox_bottom - 1, 1);
		var _floor_dist = _floor_data[0];
		var _floor_angle = _floor_data[1];
		
		if _floor_dist < 0
		{
			y += _floor_dist;
			angle = _floor_angle;
			vel_y = 0;
			state = CRABMEAT_STATE.WAIT_OR_FIRE;
		}
		
	break;
	
	case CRABMEAT_STATE.WAIT_OR_FIRE:
		
		if --state_timer >= 0
		{
			break;
		}
		
		if instance_is_drawn()
		{
			shot_flag = !shot_flag;
			
			if shot_flag
			{
				sprite_index = spr_crabmeat_fire;
				state_timer = 59;
				
				for (var _i = -1; _i <= 1; _i += 2)
				{
					instance_create(x + 10 * _i, y, obj_crabmeat_projectile, { image_xscale: _i });
				}
				
				break;
			}
		}
		
		visible = true;
		state_timer = 127;
		vel_x *= -1;
		state = CRABMEAT_STATE.MOVE;
		
		update_sprite();
		animator.start(sprite_index, 0, 0, 16);
		
	break;
	
	case CRABMEAT_STATE.MOVE:
	
		if --state_timer >= 0
		{
			x += vel_x;
			
			var _check_x = x;
			var _check_side = state_timer % 2 == 0;
			
			if _check_side
			{
				_check_x = vel_x < 0 ? x - 16 : x + 15;
			}
			
			var _floor_data = tile_raycast_v(_check_x, bbox_bottom - 1, 1);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
			
			if !_check_side
			{
				y += _floor_dist;
				angle = _floor_angle;
				update_sprite();
				
				break;
			}
			
			if _floor_dist >= -8 && _floor_dist < 12
			{
				break;
			}
		}
		
		state = CRABMEAT_STATE.WAIT_OR_FIRE;
		state_timer = 59;
		animator.clear(0);
		sprite_index = spr_crabmeat_idle;
		image_index = is_on_slope() ? 1 : 0;
		
	break;
}