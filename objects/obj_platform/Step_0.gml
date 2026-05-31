switch state
{
	case PLATFORM_STATE.MOVE:
	
		var _found_player = false;
		
		FOR_EACH_PLAYER
		{
			var _player = player_get(_p);
			
			if _player != noone && _player.on_object == id
			{
				_found_player = true; break;
			}
		}
		
		var _weight_inc = 5.625;
		
		if _found_player
		{
			if weight < 90
			{
				weight += _weight_inc;
			}
		}
		else if weight > 0
		{
			weight -= _weight_inc;
		}
		
		var _osc_angle = obj_game.oscillation_angle * iv_speed_multiplier + iv_angle_offset;
	
		switch iv_type
		{
			case PLATFORM_TYPE.DEFAULT:
				y = ystart;
			break;
			
			case PLATFORM_TYPE.HORIZONTAL:
			
				x = math_oscillate_x(xstart, _osc_angle , iv_radius);
				y = ystart;
				
			break;
			
			case PLATFORM_TYPE.VERTICAL:
				y = math_oscillate_y(ystart, _osc_angle - 90, iv_radius);
			break;
			
			case PLATFORM_TYPE.CIRCULAR:
			
				x = math_oscillate_x(xstart, _osc_angle, iv_radius);
				y = math_oscillate_y(ystart, _osc_angle - 180, iv_radius);
				
			break;
			
			case PLATFORM_TYPE.FALL:
				
				y = ystart;
				
				if wait_timer == 0
				{
					if _found_player
					{
						wait_timer = 30;
					}
				}
				else if --wait_timer == 0
				{
					state = PLATFORM_STATE.FALL;
					wait_timer = 32;
				}
				
			break;
		}
		
		y += dsin(weight) * 4;
		
		FOR_EACH_PLAYER
		{
			solid_object(player_get(_p), SOLID_TYPE.TOP);
		}

	break;
	
	case PLATFORM_STATE.FALL:
		
		if --wait_timer == 0
		{
			with obj_player
			{
				release_from_solid(other.id);
				vel_y = other.vel_y;
			}
		}
		
		y += vel_y;
		vel_y += GLOBAL_PARAM_GRV;
		
		if wait_timer > 0
		{
			FOR_EACH_PLAYER
			{
				solid_object(player_get(_p), SOLID_TYPE.TOP_NO_LAND);
			}
		}

	break;
}

// Sync objects
var _list_size = ds_list_size(synced_objects);

for (var _i = 0; _i < _list_size; _i++)
{
	var _obj = synced_objects[| _i];
		
	if !instance_exists(_obj)
	{
		continue;
	}
		
	// Do not sync fallen Item Box
	if _obj.object_index == obj_item_box && _obj.state != ITEM_BOX_STATE.IDLE
	{
		continue;
	}
		
	_obj.x = _obj.xstart + (x - xstart);
	_obj.y = _obj.ystart + (y - ystart);
}