#macro PLATFORM_STATE_MOVE 0
#macro PLATFORM_STATE_FALL 1
	
// Inherit the parent event
event_inherited();
	
state = PLATFORM_STATE_MOVE;
player_touch = false;
wait_timer = 0;
weight = 0;
vel_y = 0;

obj_set_solid(floor(CollisionWidth / 2), floor(CollisionHeight / 2));
obj_set_priority(5);
obj_set_culling(CULLING.ORIGINRESPAWN);

// Set oscillation
event_perform(ev_step, ev_step_normal);