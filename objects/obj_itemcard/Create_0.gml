#macro ITEMCARD_STATE_MOVE 0
#macro ITEMCARD_STATE_IDLE 1
	
// Inherit the parent event
event_inherited();
	
state = ITEMCARD_STATE_MOVE;
wait_timer = 0;
vel_y = -3;