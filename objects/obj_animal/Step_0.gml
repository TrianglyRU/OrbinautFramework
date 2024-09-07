// ReleaseTimer must be set in order to trigger this state
if state == ANIMAL_STATE_CAPSULE
{
    if --ReleaseTimer == 0
    {
		state = ANIMAL_STATE_APPEAR;
		obj_set_priority(1);
    }
	
    exit;
}

x += vel_x;
y += vel_y;
vel_y += grv;

// Adjust animation based on movement and velocity
if state == ANIMAL_STATE_MOVE && ani_get_duration() == undefined
{
    image_index = 1 + (vel_y >= 0);
}

if vel_y < 0
{
    exit;
}

// Check for ground collision and adjust position if needed
var _floor_dist = tile_find_v(x, y + 12, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
if _floor_dist >= 0
{
    exit;
}

y += _floor_dist;
vel_y = vel_y_bounce;

// Prepare for movement if in the initial state
if state != ANIMAL_STATE_APPEAR
{
    exit;
}

image_index = 1;
image_xscale = RandomDirection ? choose(1, -1) : -1;

state = ANIMAL_STATE_MOVE;
vel_x = vel_x_bounce * image_xscale;

switch sprite_index
{
    case spr_obj_animal_flicky:
	
        grv = 0.09375;
        ani_start(sprite_index, 4, image_index, 1);
		
	break;

    case spr_obj_animal_cucky:
        ani_start(sprite_index, 2, image_index, 1);
    break;
}