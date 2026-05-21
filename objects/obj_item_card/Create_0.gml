// Inherit the parent event
event_inherited();

enum ITEMCARD_STATE
{
	MOVE,
	IDLE
}

state = ITEMCARD_STATE.MOVE;
wait_timer = 0;
vel_y = -3;
depth -= 1;