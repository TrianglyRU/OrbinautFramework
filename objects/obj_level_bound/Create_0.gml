// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

enum BOUND_RANGE
{
	ANY,
	ABOVE,
	BELOW
}

// A hack so we can load the object at any height
image_yscale *= 999;