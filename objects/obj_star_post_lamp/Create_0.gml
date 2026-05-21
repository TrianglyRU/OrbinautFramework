// Inherit the parent event
event_inherited();
event_animator();

enum LAMP_STATE
{
	IDLE,
	ROTATE,
	ACTIVE
}

activate = function()
{
	state = LAMP_STATE.ACTIVE;
	animator.start(sprite_index, 0, 0, 4);
}

depth -= 1;
state = LAMP_STATE.IDLE;
angle = 0;
radius = sprite_height * 0.5 + 3;