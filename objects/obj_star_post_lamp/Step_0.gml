if state == LAMP_STATE.ROTATE
{
	if angle < 720
	{
		angle += 22.5;
		x = math_oscillate_x(xstart, angle, radius, 1, 180);
		y = math_oscillate_y(ystart + radius, angle, radius, 1, 180);
	}
	else
	{
		activate();
	}
}