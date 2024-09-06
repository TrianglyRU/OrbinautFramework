// Act as an enemy and exit if destroyed
if !obj_act_enemy()
{
	exit;
}

switch state
{
	case MOTOBUG_STATE_INIT:
	
		// Handle initial falling behavior and landing
		y += vel_y;
		vel_y += 0.21875;
		
		var _floor_dist = tile_find_v(x, y + 14, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		if _floor_dist < 0
		{
			y += _floor_dist;
			vel_y = 0;
			state = MOTOBUG_STATE_WAIT;
			image_xscale *= -1;
		}
		
	break;
	
	case MOTOBUG_STATE_WAIT:
	
		// Prepare to start moving after a delay
		if --move_timer >= 0
		{
			break;
		}
		
		ani_resume();
		vel_x = sign(image_xscale);
		state = MOTOBUG_STATE_MOVE;
		image_xscale *= -1;
		visible = true;
		
	break;
	
	case MOTOBUG_STATE_MOVE:
	
		// Handle horizontal movement and floor interaction
		x += vel_x;
		
		var _floor_dist = tile_find_v(x, y + 14, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
		if _floor_dist > 11 || _floor_dist < -8
		{
			state = MOTOBUG_STATE_WAIT;
			move_timer = 59;
			vel_x *= -1;
			ani_update_frame(0);
			ani_stop();
			break;
		}
		
		y += _floor_dist;
		
		// Create smoke effect periodically
		if --smoke_timer < 0
		{
			smoke_timer = 15;
			instance_create(x + 19 * image_xscale, y, obj_motobug_smoke);
		}
		
	break;
}