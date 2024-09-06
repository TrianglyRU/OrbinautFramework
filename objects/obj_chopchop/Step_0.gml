// Act as an enemy and exit if destroyed
if !obj_act_enemy()
{
	exit;
}

switch state
{
	case CHOPCHOP_STATE_ROAM:
		
	    // Create a small bubble. It does not work in S2 for some reason
	    if --bubble_timer == 0
	    {
	        bubble_timer = CHOPCHOP_DEFAULT_BUBBLE_TIMER;
	        instance_create(x + 20 * image_xscale, y + 6, obj_bubble, { BubbleType: BUBBLE_TYPE_SMALL });
	    }

	    // Reverse movement direction when the move timer expires
	    if --move_timer < 0
	    {
	        move_timer = CHOPCHOP_DEFAULT_MOVE_TIMER;
	        vel_x *= -1;
	        image_xscale *= -1;
	    }

	    x += vel_x;

	    // Transition to WAIT state if close to the player
	    var _player = instance_nearest(x, y, obj_player);
	    var _dist_x = floor(x) - floor(_player.x);
	    var _dist_y = floor(y) - floor(_player.y);
	    var _abs_dist_x = abs(_dist_x);

	    if _abs_dist_x >= 32 && _abs_dist_x < 160 && abs(_dist_y) + 32 < 64 && sign(vel_x) != sign(_dist_x)
	    {
	        state = CHOPCHOP_STATE_WAIT;
	        move_timer = 16;
	        vel_x = 0;
	        ani_start(sprite_index, 5, 1);
	    }
		
	break;

	case CHOPCHOP_STATE_WAIT:
		
	    // Prepare to charge towards the player
	    if --move_timer >= 0
	    {
	        break;
	    }

	    var _player = instance_nearest(x, y, obj_player);
	    var _dist_x = floor(x) - floor(_player.x);
	    var _dist_y = floor(y) - floor(_player.y);

	    vel_x = sign(_dist_x) * -2;
		
		// Dash downwards
	    if abs(_dist_y) + 16 >= 32
	    {
	        vel_y = 0.5;
	    }

	    state = CHOPCHOP_STATE_CHARGE;
	    image_xscale = sign(vel_x);
		
	break;

	case CHOPCHOP_STATE_CHARGE:
	
	    x += vel_x;
	    y += vel_y;
		
	break;
}
