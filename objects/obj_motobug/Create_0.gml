#macro MOTOBUG_STATE_INIT 0
#macro MOTOBUG_STATE_WAIT 1
#macro MOTOBUG_STATE_MOVE 2

// Inherit the parent event
event_inherited();

state = MOTOBUG_STATE_INIT;
move_timer = 0;
smoke_timer = 0;
vel_x = 0;
vel_y = 0;

// Motobug is invisible until it touches the floor for the first time
visible = false; 

obj_set_hitbox(20, 14);
obj_set_priority(5);
obj_set_culling(CULLING.RESPAWN);

ani_start(sprite_index, 8);
ani_stop();