/// @self obj_player
function scr_player_collision_air_regular()
{
	if action == ACTION.GLIDE || action == ACTION.CLIMB
	{
		return;
	}
	
	var _vector = math_get_vector_rounded(vel_x, vel_y);
	var _move_quad = math_get_quadrant(_vector);
	
	if _move_quad != QUADRANT.RIGHT
	{
		var _wall_dist = tile_raycast_h(x - radius_wall, y, -1, secondary_layer)[0];
		
		if _wall_dist < 0
		{
			x -= _wall_dist;
			vel_x = 0;
			
			if _move_quad == QUADRANT.LEFT
			{
				spd = vel_y;
				return;
			}
		}
	}
	
	if _move_quad != QUADRANT.LEFT
	{
		var _wall_dist = tile_raycast_h(x + radius_wall - 1, y, 1, secondary_layer)[0];
		
		if _wall_dist < 0
		{
			x += _wall_dist;
			vel_x = 0;
		
			if _move_quad == QUADRANT.RIGHT
			{
				spd = vel_y;
				return;
			}
		}
	}
	
	if _move_quad != QUADRANT.DOWN
	{
		var _roof_data = tile_raycast_2v(x - radius_x, y - radius_y, x + radius_x - 1, y - radius_y, -1, secondary_layer);
		var _roof_dist = _roof_data[0];
		var _roof_angle = _roof_data[1];
	
		if _roof_dist <= -14 && _move_quad == QUADRANT.LEFT && global.player_physics >= PHYSICS.S3
		{	
			var _wall_dist = tile_raycast_h(x + radius_wall - 1, y, 1, secondary_layer)[0];
			
			if _wall_dist < 0
			{
				x += _wall_dist;
				vel_x = 0;
				
				return;
			}
		}
		else if _roof_dist < 0
		{
			y -= _roof_dist;
			
			var _roof_quad = math_get_quadrant(_roof_angle);
			
			if _move_quad == QUADRANT.UP && (_roof_quad == QUADRANT.LEFT || _roof_quad == QUADRANT.RIGHT) && action != ACTION.FLIGHT
			{
				angle = _roof_angle;
				
				land();
				spd = _roof_angle < 180 ? -vel_y : vel_y;
				vel_y = 0;	
				
				return;
			}
		
			if vel_y < 0
			{
				vel_y = 0;
			}
			
			if action == ACTION.FLIGHT
			{
				grv = PARAM_GRV_TAILS_DOWN;
			}
			
			return;
		}
	}
	
	if _move_quad != QUADRANT.UP
	{
		var _floor_dist;
		var _floor_angle;
		
		if _move_quad == QUADRANT.DOWN
		{
			var _floor_data_l = tile_raycast_v(x - radius_x,     y + radius_y - 1, 1, secondary_layer);
			var _floor_data_r = tile_raycast_v(x + radius_x - 1, y + radius_y - 1, 1, secondary_layer);
		
			if _floor_data_l[0] > _floor_data_r[0]
			{
				_floor_dist = _floor_data_r[0];
				_floor_angle = _floor_data_r[1];
			}
			else
			{
				_floor_dist = _floor_data_l[0];
				_floor_angle = _floor_data_l[1];
			}
			
			var _min_clip = -(vel_y + 8);
			
			if _floor_dist >= 0 || _floor_data_l[0] < _min_clip && _floor_data_r[0] < _min_clip
			{
				return;
			}
			
			if math_get_quadrant(_floor_angle) != QUADRANT.DOWN
			{
				if vel_y > 15.75
				{
					vel_y = 15.75;
				}
				
				spd = _floor_angle < 180 ? -vel_y : vel_y;
				vel_x = 0;
			}
			else if _floor_angle > 22.5 && _floor_angle <= 337.5
			{
				spd = _floor_angle < 180 ? -vel_y : vel_y;
				spd *= 0.5;
			}
			else 
			{
				spd = vel_x;
				vel_y = 0;
			}
		}
		else if vel_y >= 0
		{
			var _floor_data = tile_raycast_2v(x - radius_x, y + radius_y - 1, x + radius_x - 1, y + radius_y - 1, 1, secondary_layer);
			
			_floor_dist = _floor_data[0];
			_floor_angle = _floor_data[1];
			
			if _floor_dist >= 0
			{
				return;
			}
			
			spd = vel_x;
			vel_y = 0;
		}
		else
		{
			return;
		}
		
		y += _floor_dist;
		angle = _floor_angle;
		
		land();
	}
}