/// @function scr_player_collision_ground_floor
function scr_player_collision_ground_floor()
{
	gml_pragma("forceinline");

	// Exit if the player is on an object
	if on_object != noone
	{
		exit;
	}

	/// @method m_local_snap_floor_angle
	var m_local_snap_floor_angle = function(_floor_angle)
	{
		var _diff = abs(angle % 180 - _floor_angle % 180);			
		if _diff >= 45 && _diff <= 135
		{
			// Snap to the nearest 90-degree angle
			_floor_angle = round(angle / 90) % 4 * 90;
		}
	
		return _floor_angle;
	}
	
	// Determine the tile behavior based on the player's angle, which will also act as the player's "collision mode"
	// This ensures that the player's interaction with tiles is correct based on their orientation
	if angle <= 45 || angle >= 315
	{
		tile_behaviour = TILEBEHAVIOUR.DEFAULT;
	}
	else if angle > 45 && angle < 135
	{
		tile_behaviour = TILEBEHAVIOUR.ROTATE_90;
	}
	else if angle >= 135 && angle <= 225
	{
		tile_behaviour = TILEBEHAVIOUR.ROTATE_180;
	}
	else
	{
		tile_behaviour = TILEBEHAVIOUR.ROTATE_270;
	}
	
	var MIN_TOLERANCE = 4;
	var MAX_TOLERANCE = 14;
	
	var _player_physics = global.player_physics;

	switch tile_behaviour
	{
		// Check the floor directly below the player (mode 0)
		case TILEBEHAVIOUR.DEFAULT:
			
			var _y = y + radius_y;
			var _floor_data = tile_find_2v(x - radius_x, _y, x + radius_x, _y, DIRECTION.POSITIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if !stick_to_convex
			{
				var _tolerance = _player_physics < PHYSICS_S2 ? MAX_TOLERANCE : min(MIN_TOLERANCE + abs(floor(vel_x)), MAX_TOLERANCE);

				if _floor_dist > _tolerance
				{
					set_push_anim_by = noone;
					is_grounded = false;
					ani_update_frame(0);
					break;
				}
			}
		
			if _floor_dist < -MAX_TOLERANCE
			{
				break;
			}
		
			if _player_physics >= PHYSICS_S2
			{
				_floor_angle = m_local_snap_floor_angle(_floor_angle);
			}
		
			y += _floor_dist;
			angle = _floor_angle;
		
		break;
		
		// Check the wall to the right of the player (mode 1)
		case TILEBEHAVIOUR.ROTATE_90:
			
			var _x = x + radius_y;
			var _floor_data = tile_find_2h(_x, y + radius_x, _x, y - radius_x, DIRECTION.POSITIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if !stick_to_convex
			{
				var _tolerance = _player_physics < PHYSICS_S2 ? MAX_TOLERANCE : min(MIN_TOLERANCE + abs(floor(vel_y)), MAX_TOLERANCE);
			
				if _floor_dist > _tolerance
				{
					set_push_anim_by = noone;
					is_grounded = false;
					ani_update_frame(0);
					break;
				}
			}
		
			if _floor_dist < -MAX_TOLERANCE
			{
				break;
			}
		
			if _player_physics >= PHYSICS_S2
			{
				_floor_angle = m_local_snap_floor_angle(_floor_angle);
			}
		
			x += _floor_dist;
			angle = _floor_angle;
		
		break;
		
		// Check the floor directly above the player (mode 2)
		case TILEBEHAVIOUR.ROTATE_180:
			
			var _y = y - radius_y;
			var _floor_data = tile_find_2v(x + radius_x, _y, x - radius_x, _y, DIRECTION.NEGATIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if !stick_to_convex
			{
				var _tolerance = _player_physics ? MAX_TOLERANCE : min(MIN_TOLERANCE + abs(floor(vel_x)), MAX_TOLERANCE);
			
				if _floor_dist > _tolerance
				{
					set_push_anim_by = noone;
					is_grounded = false;
					ani_update_frame(0);
					break;
				}
			}
		
			if _floor_dist < -MAX_TOLERANCE
			{
				break;
			}
		
			if _player_physics >= PHYSICS_S2
			{
				_floor_angle = m_local_snap_floor_angle(_floor_angle);
			}
		
			y -= _floor_dist;
			angle = _floor_angle;
		
		break;
		
		// Check the wall to the left of the player (mode 3)
		case TILEBEHAVIOUR.ROTATE_270:
			
			var _x = x - radius_y;
			var _floor_data = tile_find_2h(_x, y - radius_x, _x, y + radius_x, DIRECTION.NEGATIVE, tile_layer, tile_behaviour);
			var _floor_dist = _floor_data[0];
			var _floor_angle = _floor_data[1];
		
			if !stick_to_convex
			{
				var _tolerance = _player_physics < PHYSICS_S2 ? MAX_TOLERANCE : min(MIN_TOLERANCE + abs(floor(vel_y)), MAX_TOLERANCE);
			
				if _floor_dist > _tolerance
				{
					set_push_anim_by = noone;
					is_grounded = false;
					ani_update_frame(0);
					break;
				}
			}
		
			if _floor_dist < -MAX_TOLERANCE
			{
				break;
			}
		
			if _player_physics >= PHYSICS_S2
			{
				_floor_angle = m_local_snap_floor_angle(_floor_angle);
			}
		
			x -= _floor_dist;
			angle = _floor_angle;
		
		break;
	}
}