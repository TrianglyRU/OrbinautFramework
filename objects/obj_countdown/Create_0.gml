// Inherit the parent event
event_inherited();

depth = RENDER_DEPTH_PRIORITY;

FOR_EACH_VIEW
{
	offset_x[_v] = undefined;
	offset_y[_v] = undefined;
}

display_timer = 0;