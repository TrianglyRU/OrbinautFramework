/// @function scr_player_glide_collision
function scr_player_glide_collision()
{
	// This is a variation of the scr_player_collision_air()
	gml_pragma("forceinline");

	if action != ACTION_GLIDE
	{
	    exit;
	}
	
	var _climb_y = y;
	var _wall_radius = radius_x_normal + 1;
	var _move_quad = math_get_quadrant(math_get_vector_rounded(vel_x, vel_y));
	var _collision_flag_wall = false;
	var _collision_flag_floor = false;

	// Handle collisions with left walls
	if _move_quad != QUADRANT.RIGHT
	{
	    var _wall_dist = tile_find_h(x - _wall_radius, y, DIRECTION.NEGATIVE, tile_layer)[0];
	    if _wall_dist < 0
	    {
	        _collision_flag_wall = true;
	        x -= _wall_dist;
	        vel_x = 0;
	    }
	}

	// Handle collisions with right walls
	if _move_quad != QUADRANT.LEFT
	{
	    var _wall_dist = tile_find_h(x + _wall_radius, y, DIRECTION.POSITIVE, tile_layer)[0];	
	    if _wall_dist < 0
	    {
	        _collision_flag_wall = true;
	        x += _wall_dist;
	        vel_x = 0;
	    }
	}

	// Handle collisions with ceilings
	if _move_quad != QUADRANT.DOWN
	{
	    var _y = y - radius_y;
	    var _roof_dist = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.NEGATIVE, tile_layer)[0];
    
	    if _roof_dist <= -14 && _move_quad == QUADRANT.LEFT && global.player_physics >= PHYSICS_S3
	    {
			// Perform right wall collision instead if moving mostly left and too far into the ceiling
	        var _wall_dist = tile_find_h(x + _wall_radius, y, DIRECTION.POSITIVE, tile_layer)[0];	
	        if _wall_dist < 0
	        {
	            _collision_flag_wall = true;
	            x += _wall_dist;
	            vel_x = 0;
	        }
	    }
	    else if _roof_dist < 0
	    {
	        y -= _roof_dist;
			
			// Stop vertical movement if moving up
	        if vel_y < 0 || _move_quad == QUADRANT.UP
	        {
	            vel_y = 0;
	        }
	    }
	}

	// Handle collisions with floors
	if _move_quad != QUADRANT.UP
	{
	    var _y = y + radius_y;
	    var _floor_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.POSITIVE, tile_layer);
	    var _floor_dist = _floor_data[0];
	    var _floor_angle = _floor_data[1];
    
	    // Simply slide if already the ground
	    if action_state == GLIDE_STATE_GROUND
	    {
	        if _floor_dist > 14
	        {
	            m_player_glide_release(0);
	        }
	        else
	        {
	            y += _floor_dist;
	            angle = _floor_angle;
	        }
			
	        exit;
	    }
		
	    if _floor_dist < 0
	    {
	        _collision_flag_floor = true;
	        y += _floor_dist;
	        angle = _floor_angle; 
	        vel_y = 0;
	    }
	}

	// Handle results of collision checks
	if _collision_flag_floor
	{
		var _floor_quad = math_get_quadrant(angle);

		// Handle transitioning to ground state
		if action_state == GLIDE_STATE_AIR
		{
			if _floor_quad == QUADRANT.DOWN
			{
			    animation = ANI_GLIDE_GROUND;
			    action_state = GLIDE_STATE_GROUND;
			    grv = 0;
			}
			else
			{
			    spd_ground = angle < 180 ? vel_x : -vel_x;
			    m_player_land();
			}
		}
		else if action_state == GLIDE_STATE_FALL
		{
		    m_player_land();
		    audio_play_sfx(sfx_land);
			
		    if _floor_quad == QUADRANT.DOWN
		    {
		        animation = ANI_GLIDE_LAND;
		        ground_lock_timer = 16;
				spd_ground = 0;
		        vel_x = 0;
		    }
		    else
		    {
		        spd_ground = vel_x;
		    }
		}
	}
	else if _collision_flag_wall
	{
	    // Handle wall collisions only during glide
	    if action_state != GLIDE_STATE_AIR
	    {
	        exit;
	    }
		
		// First, the game casts a horizontal sensor just above Knuckles. If the returned distance is not 0, he is either 
		// inside the ceiling or above the floor edge
	    var _wall_dist = tile_find_h(x + _wall_radius * facing, _climb_y - radius_y, facing, tile_layer)[0];	
	    if _wall_dist != 0
	    {
			// Now the game casts a vertical sensor in front of Knuckles, facing downwards. If the distance returned is negative, Knuckles is inside the ceiling,
			// else he is above the floor edge. Note that we have tile behaviour set to TILEBEHAVIOUR.ROTATE_90, because we should NOT ignore LBR tiles
	        var _floor_dist = tile_find_v(x + (_wall_radius + 1) * facing, _climb_y - radius_y - 1, DIRECTION.POSITIVE, tile_layer, TILEBEHAVIOUR.ROTATE_90)[0];			
	        if _floor_dist < 0 || _floor_dist >= 12
	        {
	            m_player_glide_release(0);
	            exit;
	        }
			
	        y += _floor_dist;
	    }
		
		// Move right by one pixel if attached to the wall to the left
	    if facing == DIRECTION.NEGATIVE
	    {
	        x++;
	    }
		
	    action_state = CLIMB_STATE_NORMAL;
	    action = ACTION_CLIMB;
	    animation = ANI_CLIMB_WALL;
	    climb_value = 0;
		spd_ground = 0;
	    vel_y = 0;
	    grv = 0;
	    audio_play_sfx(sfx_grab);
	}
}