switch state
{
	case PUSHABLE_BLOCK_STATE_GROUND:
	
		// Handle player interaction with the pushable block
		for (var p = 0; p < PLAYER_COUNT; p++)
		{
			var _player = player_get(p);
			
			direction_x = _player.x < x ? DIRECTION.POSITIVE : DIRECTION.NEGATIVE;
			
			obj_act_solid(_player, SOLIDOBJECT.FULL);
			
			if _player.facing != direction_x || !obj_check_solid(_player, SOLIDCOLLISION.PUSH)
			{
				continue;
			}
			
			var _wall_dist = tile_find_h(x + (direction_x == DIRECTION.POSITIVE ? 15 : -16), y, direction_x, TILELAYER.MAIN)[0];
			if _wall_dist <= 0
			{
				continue;
			}
			
			// 0.25 is the default push force
			_player.spd_ground = 0.25 * direction_x;
			_player.vel_x = 0;
			_player.x += direction_x;
			
			x = floor(x + direction_x);
			
			if !audio_is_playing(sfx_push)
			{
				audio_play_sfx(sfx_push);
			}
			
			if NoGravity
			{
				continue;
			}
			
			var _floor_dist = tile_find_v(x, y + 15, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
			if _floor_dist <= 4
			{
				y += _floor_dist;
				continue;
			}
			
			vel_x = 4 * direction_x;
			state = PUSHABLE_BLOCK_STATE_LEDGE;
			
			// Since we no longer execute obj_act_solid(), make the player stop pushing the block manually
			obj_clear_player_push(_player);
		}
		
	break;
	
	case PUSHABLE_BLOCK_STATE_LEDGE:
	
		// Move the block and check if it should fall
		x += vel_x;
		
		if floor(x / vel_x) % vel_x == 0
		{
			x = round(x / solid_size) * solid_size; // Snap to grid
			state = PUSHABLE_BLOCK_STATE_FALL;
		}
		
	break;
	
	case PUSHABLE_BLOCK_STATE_FALL:
	
		// Handle falling behavior of the block
		y += vel_y;
		vel_y += 0.09375;
		
		var _floor_dist = tile_find_v(x, y + 15, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		if _floor_dist < 0
		{
			state = PUSHABLE_BLOCK_STATE_GROUND;
			vel_y = 0;
			
			y += _floor_dist;
		}
		
	break;
}