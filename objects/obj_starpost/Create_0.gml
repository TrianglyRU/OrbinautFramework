#macro STARPOST_STATE_IDLE 0
#macro STARPOST_STATE_ACTIVE 1
	
// Inherit the parent event
event_inherited();
	
obj_set_priority(6);
obj_set_culling(CULLING.RESPAWN);

state = STARPOST_STATE_IDLE;
lamp_obj = instance_create(x, y - 32, obj_starpost_lamp, {}, id);