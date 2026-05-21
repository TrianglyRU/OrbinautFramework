// Inherit the parent event
event_inherited();

depth = RENDER_DEPTH_PRIORITY;

FOR_EACH_CAMERA
{
	offset_x[_c] = undefined;
	offset_y[_c] = undefined;
}

display_timer = 0;