#macro BUZZER_STATE_ROAM 0
#macro BUZZER_STATE_SHOOT 1
#macro BUZZER_DEFAULT_MOVE_TIMER 256

// Inherit the parent event
event_inherited();

state = BUZZER_STATE_ROAM;
move_timer = BUZZER_DEFAULT_MOVE_TIMER;
turn_delay = 0;
shot_timer = 0;
shooting_flag = true;
vel_x = -1 * image_xscale;
flame_obj = instance_create(x, y, obj_buzzer_flame, { image_xscale: image_xscale }, id);
	
obj_set_hitbox(16, 8);
obj_set_priority(4);
obj_set_culling(CULLING.RESPAWN);