if wait_time > 0
{
    wait_time--;
}
else
{
	visible = flicker ? FRAME_COUNTER % 2 == 0 : true;
	x += vel_x;
	y += vel_y;
	vel_y += GLOBAL_PARAM_GRV;
}