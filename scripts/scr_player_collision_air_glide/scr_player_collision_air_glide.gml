/// @self obj_player
function scr_player_collision_air_glide()
{
	if action != ACTION.GLIDE
	{
	    return;
	}
	
	var _vector = math_get_vector_rounded(vel_x, vel_y);
	var _move_quad = math_get_quadrant(_vector);
	var _climb_y = y;
	
	var _collision_flag_wall = false;
	var _collision_flag_floor = false;
	
	if _move_quad != QUADRANT.RIGHT
	{
	    var _wall_dist = tile_raycast_h(x - radius_x, y, -1, secondary_layer)[0];
		
	    if _wall_dist < 0
	    {
	        x -= _wall_dist;
	        vel_x = 0;
			
			_collision_flag_wall = true;
	    }
	}
	
	if _move_quad != QUADRANT.LEFT
	{
	    var _wall_dist = tile_raycast_h(x + radius_x - 1, y, 1, secondary_layer)[0];
		
	    if _wall_dist < 0
	    {
	        x += _wall_dist;
	        vel_x = 0;
			
			_collision_flag_wall = true;
	    }
	}
	
	if _move_quad != QUADRANT.DOWN
	{
	    var _roof_dist = tile_raycast_2v(x - radius_x,  y - radius_y, x + radius_x - 1,  y - radius_y, -1, secondary_layer)[0];
    
	    if _roof_dist <= -14 && _move_quad == QUADRANT.LEFT && global.player_physics >= PHYSICS.S3
	    {
	        var _wall_dist = tile_raycast_h(x + radius_wall - 1, y, 1, secondary_layer)[0];
			
	        if _wall_dist < 0
	        {
	            x += _wall_dist;
	            vel_x = 0;
				
				_collision_flag_wall = true;
	        }
	    }
	    else if _roof_dist < 0
	    {
	        y -= _roof_dist;
			
	        if vel_y < 0 || _move_quad == QUADRANT.UP
	        {
	            vel_y = 0;
	        }
	    }
	}

	if _move_quad != QUADRANT.UP
	{
	    var _floor_data = tile_raycast_2v(x - radius_x, y + radius_y - 1, x + radius_x - 1, y + radius_y - 1, 1, secondary_layer);
	    var _floor_dist = _floor_data[0];
	    var _floor_angle = _floor_data[1];
    
	    if action_state == GLIDE_STATE.GROUND
	    {
	        if _floor_dist > 14
	        {
	            release_glide(0);
	        }
	        else
	        {
	            y += _floor_dist;
	            angle = _floor_angle;
	        }
			
	        return;
	    }
		
	    if _floor_dist < 0
	    {
	        y += _floor_dist;
	        angle = _floor_angle; 
	        vel_y = 0;
			
			_collision_flag_floor = true;
	    }
	}

	if _collision_flag_floor
	{
		var _floor_quad = math_get_quadrant(angle);
		
		if action_state == GLIDE_STATE.AIR
		{
			if _floor_quad == QUADRANT.DOWN
			{
			    animation = ANIM.GLIDE_GROUND;
			    action_state = GLIDE_STATE.GROUND;
			    grv = 0;
			}
			else
			{
				spd = angle < 180 ? vel_x : -vel_x; 
				land();
			}
		}
		else if action_state == GLIDE_STATE.FALL
		{
		    land();
			
		    if _floor_quad == QUADRANT.DOWN
		    {
		        animation = ANIM.GLIDE_LAND;
		        ground_lock_timer = 16;
				spd = 0;
		        vel_x = 0;
		    }
		    else
		    {
		        spd = vel_x;
		    }
			
			audio_sfx_play(snd_land);
		}
	}
	else if _collision_flag_wall && action_state == GLIDE_STATE.AIR
	{
		// First, the game casts a horizontal sensor just above Knuckles. If the returned distance is not 0, he is either 
		// inside the ceiling or above the floor edge
		
		var _radius_x = facing >= 0 ? radius_x - 1 : -radius_x;
	    var _wall_dist = tile_raycast_h(x + _radius_x, _climb_y - radius_y, facing, secondary_layer)[0];	
		
	    if _wall_dist != 0
	    {
			// Now the game casts a vertical sensor in front and above of Knuckles, facing downwards. If the distance returned is negative, he's inside
			// the ceiling, else he is above the floor edge. Note that we use QUADRANT.UP because we should NOT ignore LBR tiles
			
			var _front_offset = sign(_radius_x);
	        var _floor_dist = tile_raycast_v(x + _radius_x + _front_offset, _climb_y - radius_y - 1, 1, secondary_layer, QUADRANT.UP)[0];
			
	        if  _floor_dist < 0 || _floor_dist >= 12
	        {
	            release_glide(0);
	            return;
	        }
			
	        y += _floor_dist;
	    }
		
	    action = ACTION.CLIMB;
		action_state = CLIMB_STATE.NORMAL;
	    animation = ANIM.CLIMB_WALL;
	    climb_value = 0;
		spd = 0;
	    vel_y = 0;
	    grv = 0;
		
	    audio_sfx_play(snd_grab);
	}
}