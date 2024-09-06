#macro CHOPCHOP_STATE_ROAM 0
#macro CHOPCHOP_STATE_WAIT 1
#macro CHOPCHOP_STATE_CHARGE 2
#macro CHOPCHOP_DEFAULT_MOVE_TIMER 512
#macro CHOPCHOP_DEFAULT_BUBBLE_TIMER 80
	
// Inherit the parent event
event_inherited();
	
state = CHOPCHOP_STATE_ROAM;
move_timer = CHOPCHOP_DEFAULT_MOVE_TIMER;
bubble_timer = CHOPCHOP_DEFAULT_BUBBLE_TIMER;
vel_x = 0.25 * image_xscale;
vel_y = 0;
	
obj_set_hitbox(20, 12);
obj_set_priority(4);
obj_set_culling(CULLING.RESPAWN);