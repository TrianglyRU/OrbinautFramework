#macro GIGAN_SPIKE_STATE_ROTATE 0
#macro GIGAN_SPIKE_STATE_LAUNCHED 1

// Inherit the parent event
event_inherited();

state = GIGAN_SPIKE_STATE_ROTATE;
vel_x = 0;
vel_y = 0;
fly_timer = 0;

obj_set_hitbox(10, 10);
obj_set_priority(3);