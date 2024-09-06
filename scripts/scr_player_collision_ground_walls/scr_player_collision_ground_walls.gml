/// @function scr_player_collision_ground_walls
function scr_player_collision_ground_walls()
{
	gml_pragma("forceinline");

	// Exit collision while on a left wall or a ceiling, unless angle is cardinal and S3K physics are enabled
	if angle > 90 && angle <= 270
	{
	    if global.player_physics < PHYSICS_SK || angle % 90 != 0
	    {
	        exit;
	    }
	}
	
	var _angle_quad = math_get_quadrant(angle);
	
	// Determine the direction of the cast based on the angle. These ranges are different
	// from the ones returned by math_get_quadrant()
	var _cast_dir = QUADRANT.DOWN;
	
	if angle >= 45 && angle <= 128
	{
	    _cast_dir = QUADRANT.RIGHT;
	}
	else if angle > 128 && angle < 225
	{
	    _cast_dir = QUADRANT.UP;
	}
	else if angle >= 225 && angle < 315
	{
	    _cast_dir = QUADRANT.LEFT;
	}

	var _wall_radius = radius_x_normal + 1;
	var _y_offset = 8 * (angle == 0);

	// Handle left wall collision
	if spd_ground < 0
	{
	    var _wall_dist = 0;
	    var _x = x + vel_x;
	    var _y = y + vel_y;
		
		// Cast the sensor
	    switch _cast_dir
	    {
	        case QUADRANT.DOWN:
	            _wall_dist = tile_find_h(_x - _wall_radius, _y + _y_offset, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];
	        break;
			
	        case QUADRANT.RIGHT:
	            _wall_dist = tile_find_v(_x, _y + _wall_radius, DIRECTION.POSITIVE, tile_layer, tile_behaviour)[0];
	        break;
			
	        case QUADRANT.UP:
	            _wall_dist = tile_find_h(_x + _wall_radius, _y, DIRECTION.POSITIVE, tile_layer, tile_behaviour)[0];
	        break;
			
	        case QUADRANT.LEFT:
	            _wall_dist = tile_find_v(_x, _y - _wall_radius, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];
	        break;
	    }

	    if _wall_dist >= 0
	    {
	        exit;
	    }
		
		// React to collision
	    switch _angle_quad
	    {
	        case QUADRANT.DOWN:
			
	            vel_x -= _wall_dist;
	            spd_ground = 0;
				
	            if facing == DIRECTION.NEGATIVE && animation != ANI_SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.RIGHT:
	            vel_y += _wall_dist;
	        break;
			
	        case QUADRANT.UP:
			
	            vel_x += _wall_dist;
	            spd_ground = 0;
				
	            if facing == DIRECTION.NEGATIVE && animation != ANI_SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.LEFT:
	            vel_y -= _wall_dist;
	        break;
	    }
	}
	
	// Handle right wall collision
	else if spd_ground > 0
	{
	    var _wall_dist = 0;
	    var _x = x + vel_x;
	    var _y = y + vel_y;
		
		// Cast the sensor
	    switch _cast_dir
	    {
	        case QUADRANT.DOWN:
	            _wall_dist = tile_find_h(_x + _wall_radius, _y + _y_offset, DIRECTION.POSITIVE, tile_layer, tile_behaviour)[0];
	        break;
			
	        case QUADRANT.RIGHT:
	            _wall_dist = tile_find_v(_x, _y - _wall_radius, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];
	        break;
			
	        case QUADRANT.UP:
	            _wall_dist = tile_find_h(_x - _wall_radius, _y, DIRECTION.NEGATIVE, tile_layer, tile_behaviour)[0];
	        break;
			
	        case QUADRANT.LEFT:
	            _wall_dist = tile_find_v(_x, _y + _wall_radius, DIRECTION.POSITIVE, tile_layer, tile_behaviour)[0];
	        break;
	    }

	    if _wall_dist >= 0
	    {
	        exit;
	    }

	    // React to collision
	    switch _angle_quad
	    {
	        case QUADRANT.DOWN:
			
	            vel_x += _wall_dist;
	            spd_ground = 0;
				
	            if facing == DIRECTION.POSITIVE && animation != ANI_SPIN
	            {
	                set_push_anim_by = id;
	            }
				
	        break;
			
	        case QUADRANT.RIGHT:
	            vel_y -= _wall_dist;
	        break;
			
	        case QUADRANT.UP:
			
	            vel_x -= _wall_dist;
	            spd_ground = 0;
				
	            if facing == DIRECTION.POSITIVE && animation != ANI_SPIN
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