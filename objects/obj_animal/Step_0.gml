if state == ANIMAL_STATE.CAPSULE
{
    if --state_timer == 0
    {
		state = ANIMAL_STATE.APPEAR;
		state_timer = -1;
		depth = draw_depth(10);
    }
	
    return;
}

x += vel_x;
y += vel_y;
vel_y += grv;

if state == ANIMAL_STATE.MOVE && animator.timer == 0
{
    image_index = 1 + (vel_y >= 0);
}

if vel_y < 0
{
    return;
}

var _floor_dist = tile_raycast_v(x, bbox_bottom - 1, 1)[0];

if _floor_dist < 0
{
    y += _floor_dist;
	vel_y = vel_y_bounce;
	
	if state != ANIMAL_STATE.APPEAR
	{
		return;
	}
	
	image_xscale = state_timer < 0 ? choose(1, -1) : -1;
	vel_x = vel_x_bounce * image_xscale;
	state = ANIMAL_STATE.MOVE;
	
	switch sprite_index
	{
		case spr_animal_flicky:
		
			grv = 0.09375;
			animator.start(sprite_index, 1, 1, 4);
			
		break;
		
		case spr_animal_cucky:
		    animator.start(sprite_index, 1, 1, 2);
		break;
	}
}