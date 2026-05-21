// Inherit the parent event
event_inherited();

switch state
{
	case COCONUTS_STATE.IDLE:
		
		var _player = instance_nearest(x, y, obj_player);
		var _dist_x = x - floor(_player.x);
		var _total_dist_x = _dist_x + 96;
		
		image_xscale = sign(_dist_x);
		
		if _total_dist_x >= 0 && _total_dist_x < 192
		{
			if attack_timer == 0
			{
				state = COCONUTS_STATE.START_THROW;
				break;
			}
			
			attack_timer--;
		}
			
		if --state_timer < 0
		{
			state = COCONUTS_STATE.START_CLIMB;
		}
			
	break;
	
	case COCONUTS_STATE.START_CLIMB:
		
		if climb_table_index >= 12
		{
			climb_table_index = 0;
		}
		
		vel_y = climb_data[climb_table_index];
		state_timer = climb_data[climb_table_index + 1];		
		climb_table_index += 2;
		state = COCONUTS_STATE.CLIMB;
		animator.start(sprite_index, 0, 0, 6);

	break;
	
	case COCONUTS_STATE.CLIMB:
			
		if --state_timer == 0
		{
			state = COCONUTS_STATE.IDLE;
			state_timer = 16;
			animator.clear(0);
			
			break;
		}
		
		hand_frame = image_index;
		y += vel_y;
			
	break;
	
	case COCONUTS_STATE.START_THROW:
		
		state = COCONUTS_STATE.THROW;
		state_timer = 8;
		attack_timer = 32;	
		hand_frame = 2;
		
	break;
	
	case COCONUTS_STATE.THROW:
			
		if --state_timer >= 0
		{
			break;
		}
		
		if !attack_flag
		{
			attack_flag = true;
			state_timer = 8;
			hand_frame = image_index;
			instance_create(x + 11 * image_xscale, y - 13, obj_coconuts_projectile, { image_xscale: image_xscale });
		}
		else
		{
			state = COCONUTS_STATE.START_CLIMB;
			attack_flag = false;
		}
		
	break;
}