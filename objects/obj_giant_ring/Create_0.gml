#macro GIANTRING_STATE_IDLE 0
#macro GIANTRING_STATE_ENTRY 1
#macro GIANTRING_STATE_TRANSITION 2
	
// Inherit the parent event
event_inherited();

// Do not initialise this Giant Ring if it was collected before
if ds_list_find_index(global.ds_giant_rings, id) != -1
{
	instance_destroy();
	exit;
}
	
state = GIANTRING_STATE_IDLE;
wait_timer = 32;
image_xscale = 1;
	
obj_set_hitbox(8, 16);
obj_set_priority(3);
obj_set_culling(CULLING.DISABLE);