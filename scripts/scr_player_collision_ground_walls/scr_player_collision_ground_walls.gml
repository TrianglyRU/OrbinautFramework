/// @self obj_player
function scr_player_collision_ground_walls()
{
	if angle > 90 && angle <= 270
	{
	    if global.player_physics < PHYSICS.SK || angle % 90 != 0
	    {
	        return;
	    }
	}
	
	var _y_offset = angle == 0 ? 8 : 0;
	var _angle_quad = math_get_quadrant(angle);
	var _wall_quad;
	
	// _wall_quad's angle ranges differ from those used by math_get_quadrant()
	if angle >= 45 && angle <= 128
	{
	    _wall_quad = QUADRANT.RIGHT;
	}
	else if angle > 128 && angle < 225
	{
	    _wall_quad = QUADRANT.UP;
	}
	else if angle >= 225 && angle < 315
	{
	    _wall_quad = QUADRANT.LEFT;
	}
	else
	{
		_wall_quad = QUADRANT.DOWN;
	}

	if spd < 0
	{
	    var _wall_dist;
	    var _x = x + vel_x;
	    var _y = y + vel_y;
		
	    switch _wall_quad
	    {
			case QUADRANT.DOWN:
				_wall_dist = tile_raycast_h(_x - radius_wall, _y + _y_offset - 1, -1, secondary_layer, _wall_quad)[0];
			break;
			
	        case QUADRANT.RIGHT:
	            _wall_dist = tile_raycast_v(_x, _y + radius_wall - 1, 1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.UP:
	            _wall_dist = tile_raycast_h(_x + radius_wall - 1, _y, 1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.LEFT:
	            _wall_dist = tile_raycast_v(_x, _y - radius_wall, -1, secondary_layer, _wall_quad)[0];
	        break;	
	    }

	    if _wall_dist >= 0
	    {
	        return;
	    }
		
	    switch _angle_quad
	    {
	        case QUADRANT.DOWN:
			
	            vel_x -= _wall_dist;
	            spd = 0;
				
	            if facing == -1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.RIGHT:
	            vel_y += _wall_dist;
	        break;
			
	        case QUADRANT.UP:
			
	            vel_x += _wall_dist;
	            spd = 0;
				
	            if facing == -1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.LEFT:
	            vel_y -= _wall_dist;
	        break;
	    }
	}
	else if spd > 0
	{
	    var _wall_dist;
	    var _x = x + vel_x;
	    var _y = y + vel_y;
		
	    switch _wall_quad
	    {
			case QUADRANT.DOWN:
				_wall_dist = tile_raycast_h(_x + radius_wall - 1, _y + _y_offset - 1, 1, secondary_layer, _wall_quad)[0];
			break;
			
	        case QUADRANT.RIGHT:
	            _wall_dist = tile_raycast_v(_x, _y - radius_wall, -1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.UP:
	            _wall_dist = tile_raycast_h(_x - radius_wall, _y, -1, secondary_layer, _wall_quad)[0];
	        break;
			
	        case QUADRANT.LEFT:
	            _wall_dist = tile_raycast_v(_x, _y + radius_wall - 1, 1, secondary_layer, _wall_quad)[0];
	        break;     
	    }
		
	    if _wall_dist >= 0
	    {
	        return;
	    }
		
	    switch _angle_quad
	    {
	        case QUADRANT.DOWN:
			
	            vel_x += _wall_dist;
	            spd = 0;
				
	            if facing == 1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.RIGHT:
	            vel_y -= _wall_dist;
	        break;
			
	        case QUADRANT.UP:
			
	            vel_x -= _wall_dist;
	            spd = 0;
				
	            if facing == 1 && animation != ANIM.SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.LEFT:
	            vel_y += _wall_dist;
	        break;
	    }
	}
}