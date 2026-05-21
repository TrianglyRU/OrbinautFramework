// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESET);

enum CAPSULE_STATE
{
	IDLE,
	BREAK,
	SPAWN_ANIMALS,
	CHECK_RESULTS,
	RESULTS
}

obj_rm_stage.end_bound = x + camera_get_width(0) * 0.5;

depth = draw_depth(40);
state = CAPSULE_STATE.IDLE;
wait_timer = 0;
button_obj = instance_create(x, y - 39, obj_capsule_button);
lock_obj = instance_create(x, y - 23, obj_capsule_lock);
gate_obj = instance_create(x, y - 3, obj_capsule_gate);