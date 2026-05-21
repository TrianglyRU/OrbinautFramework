// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

enum BOUND_RANGE
{
	ANY,
	ABOVE,
	BELOW
}

if sign(image_yscale) >= 0
{
	if iv_range == BOUND_RANGE.ABOVE
	{
		btop = 0;
		bbottom = y - 1;
	}
	else if iv_range == BOUND_RANGE.BELOW
	{
		btop = y + 1;
		bbottom = room_height - 1;
	}
	else
	{
		btop = 0;
		bbottom = room_height - 1;
	}
}
else
{
	if iv_range == BOUND_RANGE.ABOVE
	{
		btop = 0;
		bbottom = y - 2;
	}
	else if iv_range == BOUND_RANGE.BELOW
	{
		btop = y;
		bbottom = room_height - 1;
	}
	else
	{
		btop = 0;
		bbottom = room_height - 1;
	}
}

// A hack so we can load the object at any height
image_yscale *= 999;