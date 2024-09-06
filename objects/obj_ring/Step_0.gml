// Handle ring collection by players
for (var p = 0; p < PLAYER_COUNT; p++)
{
	if c_framework.ring_spill_counter >= 226
	{
		continue;
	}
	
	var _player = player_get(p);
	
	// Sonic can collect dropped rings using his Double Spin Attack
	var _use_target_ext = State == RING_STATE_DROP && _player.shield_state == SHIELD_STATE_DOUBLESPIN;
	
	if !obj_check_hitbox(_player, _use_target_ext)
	{
		continue;
	}
	
	if global.player_rings % 2 > 0
	{
		audio_play_sfx(sfx_ring_right);
	}
	else
	{
		audio_play_sfx(sfx_ring_left);
	}
	
	if global.player_rings < 999
	{
		global.player_rings++;
	}
	
	instance_create(x, y, obj_sparkle);
	instance_destroy();
	
	exit;
}

// Handle different ring states
switch State
{
	case RING_STATE_STATIC:
	case RING_STATE_ATTRACT:
	
		var _player = player_get(0);
		
		if State == RING_STATE_STATIC
		{
			if _player.shield != SHIELD_LIGHTNING || distance_to_object(_player) > 64
			{
				break;
			}
			
			State = RING_STATE_ATTRACT;
			
			// Remove the ring once it goes out of bounds
			obj_set_culling(CULLING.REMOVE);
		}
		
		if _player.shield == SHIELD_LIGHTNING
		{
			var ACC_FAST = 0.75;
			var ACC_SLOW = 0.1875;
		
			if floor(x) >= floor(_player.x)
			{
				VelocityX = VelocityX >= 0 ? VelocityX - ACC_FAST : VelocityX - ACC_SLOW;
			}
			else
			{
				VelocityX = VelocityX < 0 ? VelocityX + ACC_FAST : VelocityX + ACC_SLOW;
			}
		
			if floor(y) >= floor(_player.y)
			{
				VelocityY = VelocityY >= 0 ? VelocityY - ACC_FAST : VelocityY - ACC_SLOW;
			}
			else
			{
				VelocityY = VelocityY < 0 ? VelocityY + ACC_FAST : VelocityY + ACC_SLOW;
			}
		}
		
		x += VelocityX;
		y += VelocityY;
		
	break;
	
	case RING_STATE_DROP:
		
		var _spill_timer = c_framework.ring_spill_counter;
		
		if _spill_timer == 0
		{
			instance_destroy();
			break;
		}
		
		ani_update_duration(floor(512 / (_spill_timer)));
		
		x += VelocityX;
		y += VelocityY;
		VelocityY += 0.09375;
		
		if VelocityY < 0 || _spill_timer % 4 != 0
		{
			break;
		}
		
		var _floor_dist = tile_find_v(x, y + 8, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		if _floor_dist < 0
		{
			VelocityY *= -0.75;
			y += _floor_dist;
		}
		
	break;
}