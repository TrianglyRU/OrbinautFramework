// Inherit the parent event
event_inherited();

// Don't cull if there's more than one player
if PLAYER_COUNT < 2
{
	event_culler(CULL_ACTION.PAUSE);
}

depth = RENDER_DEPTH_PRIORITY;
layer_data = [];

switch image_index % image_number
{
	case 0:
		layer_data = [COLLISION_LAYER.PATH_B, COLLISION_LAYER.PATH_A];
	break;
	
	case 1:
		layer_data = [COLLISION_LAYER.PATH_A, COLLISION_LAYER.PATH_B];
	break;
	
	case 2:
		layer_data = [COLLISION_LAYER.PATH_A, COLLISION_LAYER.PATH_A];
	break;
	
	case 3:
		layer_data = [COLLISION_LAYER.PATH_B, COLLISION_LAYER.PATH_B];
	break;
}