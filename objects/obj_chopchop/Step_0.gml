// Inherit the parent event
event_inherited();

switch state
{
	case CHOPCHOP_STATE.ROAM:
		
	    // This does not work in S2 for some reason
	    if --bubble_timer == 0
	    {
	        bubble_timer = CHOPCHOP_DEFAULT_BUBBLE_TIMER;
	        instance_create(x + 20 * image_xscale, y + 6, obj_bubble, { bubble_type: BUBBLE.SMALL });
	    }
		
	    if --move_timer < 0
	    {
	        move_timer = CHOPCHOP_DEFAULT_MOVE_TIMER;
	        vel_x *= -1;
	        image_xscale *= -1;
	    }

	    x += vel_x;
		
	    var _player = instance_nearest(x, y, obj_player);
	    var _dist_x = floor(x) - floor(_player.x);
	    var _dist_y = floor(y) - floor(_player.y);
	    var _abs_dist_x = abs(_dist_x);
		
	    if _abs_dist_x >= 32 && _abs_dist_x < 160 && abs(_dist_y) + 32 < 64 && sign(vel_x) != sign(_dist_x)
	    {
	        state = CHOPCHOP_STATE.WAIT;
	        move_timer = 16;
	        vel_x = 0;
			animator.start(sprite_index, 1, 0, 5);
	    }
		
	break;

	case CHOPCHOP_STATE.WAIT:
		
	    if --move_timer >= 0
	    {
	        break;
	    }

	    var _player = instance_nearest(x, y, obj_player);
	    var _dist_x = floor(x) - floor(_player.x);
	    var _dist_y = floor(y) - floor(_player.y);

	    vel_x = sign(_dist_x) * -2;
		
	    if abs(_dist_y) + 16 >= 32
	    {
	        vel_y = 0.5;
	    }

	    state = CHOPCHOP_STATE.CHARGE;
	    image_xscale = sign(vel_x);
		
	break;

	case CHOPCHOP_STATE.CHARGE:
	
	    x += vel_x;
	    y += vel_y;
		
	break;
}
