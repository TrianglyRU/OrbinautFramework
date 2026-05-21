FOR_EACH_PLAYER
{
	if global.ring_spill_counter >= 226
	{
		continue;
	}
	
	var _player = player_get(_p);
	var _use_extra_mask = state == RING_STATE.DROPPED && (_player.shield_state == SHIELD_STATE.DOUBLE_SPIN || _player.action == ACTION.HAMMER_SPIN);
	
	if !collision_player(_player, _use_extra_mask)
	{
		continue;
	}
	
	if global.player_rings < 999
	{
		global.player_rings++;
	}
	
	audio_sfx_play_ring();
	instance_create(x, y, obj_sparkle);
	instance_destroy();
	
	return;
}

switch state
{
	case RING_STATE.STATIC:
	case RING_STATE.ATTRACTED:
		
		var _player = player_get(0);
		var _x = floor(x);
		var _y = floor(y);
		var _px = floor(_player.x);
		var _py = floor(_player.y);
		
		var _shield = global.player_shields[0];
		
		if state == RING_STATE.STATIC
		{
			if _shield != SHIELD.LIGHTNING || point_distance(_x, _y, _px, _py) >= 64
			{
				break;
			}
			
			state = RING_STATE.ATTRACTED;
			culler.action = CULL_ACTION.DESTROY;
		}
		
		if _shield == SHIELD.LIGHTNING
		{
			var _acc_fast = 0.75;
			var _acc_slow = 0.1875;
		
			if _x >= _px
			{
				vel_x = vel_x >= 0 ? vel_x - _acc_fast : vel_x - _acc_slow;
			}
			else
			{
				vel_x = vel_x < 0 ? vel_x + _acc_fast : vel_x + _acc_slow;
			}
			
			if _y >= _py
			{
				vel_y = vel_y >= 0 ? vel_y - _acc_fast : vel_y - _acc_slow;
			}
			else
			{
				vel_y = vel_y < 0 ? vel_y + _acc_fast : vel_y + _acc_slow;
			}
		}
		
		x += vel_x;
		y += vel_y;
		
	break;
	
	case RING_STATE.DROPPED:
		
		var _spill_timer = global.ring_spill_counter;
		
		if _spill_timer == 0
		{
			instance_destroy();
			break;
		}
		
		var _target_duration = floor(512 / (_spill_timer));
		
		if animator.timer == 0
		{
			animator.start(sprite_index, 0, 0, _target_duration);
		}
		else
		{
			animator.duration = _target_duration;
		}
		
		x += vel_x;
		y += vel_y;
		vel_y += 0.09375;
	
		if vel_y >= 0 && _spill_timer % 4 == 0
		{
			var _floor_dist = tile_raycast_v(x, bbox_bottom + 2 - 1, 1)[0];
			
			if _floor_dist < 0
			{
				y += _floor_dist; vel_y *= -0.75;
			}
		}
		
	break;
}