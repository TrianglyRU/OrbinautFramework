#macro EGGPRISON_STATE_IDLE 0
#macro EGGPRISON_STATE_BREAK 1
#macro EGGPRISON_STATE_SPAWN_ANIMALS 2
#macro EGGPRISON_STATE_WAIT_ANIMALS 3
	
// Inherit the parent event
event_inherited();
	
state = EGGPRISON_STATE_IDLE;
wait_timer = 0;
c_stage.bound_end = x + camera_get_width(0) / 2;

obj_set_solid(32, 24);
obj_set_priority(4);
obj_set_culling(CULLING.RESPAWN);
	
button_obj = instance_create(x, y - 39, obj_capsule_button, {}, id);
lock_obj = instance_create(x, y - 23, obj_capsule_lock, {}, id);
gate_obj = instance_create(x, y - 3, obj_capsule_gate, {}, id);