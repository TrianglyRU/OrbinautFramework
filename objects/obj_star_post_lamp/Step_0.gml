if state == LAMP_STATE.ROTATE
{
	if angle < 720
	{
		angle += 22.5;
		x = math_oscillate_x(xstart, angle + 180, radius);
		y = math_oscillate_y(ystart + radius, angle + 180, radius);
	}
	else
	{
		activate();
	}
}